# Agent Self-Service Ops Pattern

**Failure mode this prevents:** an agent that asks the human for sudo every time it needs to restart a service, OR an agent with `NOPASSWD: ALL` that can `rm -rf /` on a bad prompt injection.

This pattern lets the agent perform privileged operations (npm install -g, systemctl restart, nginx reload, install new systemd units) WITHOUT human password prompts, while keeping the blast radius auditable and bounded.

## The core idea

```
┌─────────────────────────────────────────────────┐
│  /etc/sudoers.d/<tenant>-agent-ops              │
│                                                  │
│  {linux_user} ALL=(root) NOPASSWD:               │
│    /opt/{linux_user}/agents/scripts/ops/        │
└──────────────────┬───────────────────────────────┘
                   │
                   │ trailing slash = "any executable in this dir,
                   │ NOT subdirs, NOT arbitrary commands elsewhere"
                   ▼
┌─────────────────────────────────────────────────┐
│  /opt/{linux_user}/agents/scripts/ops/          │
│  ├── ops-claude-update.sh                       │
│  ├── ops-website-deploy.sh                      │
│  ├── ops-service-restart.sh                     │
│  ├── ops-nginx-reload.sh                        │
│  └── ops-systemd-install-unit.sh                │
└─────────────────────────────────────────────────┘
```

The sudoers grant is DIRECTORY-WIDE on a single, owned-by-root, executable-only directory. Adding a capability = adding a wrapper. Auditing capabilities = `ls scripts/ops/`. Revoking everything = `rm /etc/sudoers.d/<tenant>-agent-ops`.

## Why a wrapper allowlist (not raw command grants)

You COULD write sudoers entries like:

```
# DON'T DO THIS
{linux_user} ALL=(root) NOPASSWD: /usr/bin/systemctl restart foo
{linux_user} ALL=(root) NOPASSWD: /usr/bin/systemctl reload nginx
{linux_user} ALL=(root) NOPASSWD: /usr/local/bin/npm install -g @anthropic-ai/claude-code@*
```

This is more granular BUT:
- Every new capability = sudoers edit + visudo + sudo reload. Painful, error-prone.
- Inputs are inline; no validation, no audit log, no failure handling.
- If the agent calls `systemctl restart sshd` accidentally, that "works" (still allowed by the grant).

The wrapper approach:
- Every capability is a script you READ before granting access.
- Every wrapper validates inputs (e.g. `ops-service-restart.sh` has a strict allowlist of service names — refuses sshd).
- Every wrapper logs to a single audit file (`/var/log/<tenant>-agent-ops.log`).
- Every wrapper notifies the user (Telegram) on success/failure.

The wrapper IS the security boundary, not the sudoers file.

## Rules

### Rule 1 — Sudoers entry is exactly one line

```
{linux_user} ALL=(root) NOPASSWD: /opt/{linux_user}/agents/scripts/ops/
```

Trailing slash matters. It means "any executable in this directory" — NOT subdirectories, NOT shell expansion. `sudo /opt/.../ops/ops-foo.sh` works. `sudo /opt/.../ops/subdir/ops-bar.sh` does NOT. `sudo /opt/.../ops/ops-foo.sh; rm -rf /` doesn't either (the `;` ends the sudo'd command).

File permissions: `mode 0440 root:root`. Validate with `visudo -c -f /etc/sudoers.d/<tenant>-agent-ops` before deploying.

### Rule 2 — Wrapper scripts are owned by root, mode 0755

```bash
sudo chown root:root /opt/<tenant>/agents/scripts/ops/*.sh
sudo chmod 0755 /opt/<tenant>/agents/scripts/ops/*.sh
```

If the agent could WRITE to the wrappers, it could escalate. Root-owned + non-writable means the agent can EXECUTE them via sudo but cannot MODIFY them.

### Rule 3 — Every wrapper validates its inputs

Strict allowlist matching, not regex. Example from `ops-service-restart.sh`:

```bash
ALLOWED=(
  claude-agent
  dashboard-chat
  danielgonell-web
  nginx
  morning-brief
  # ...
)

NORM="${SVC%.service}"
NORM="${NORM%.timer}"

OK=0
for a in "${ALLOWED[@]}"; do
  if [[ "$NORM" == "$a" ]]; then OK=1; break; fi
done

if [[ $OK -eq 0 ]]; then
  echo "ERROR: service '$SVC' not in allowlist" >&2
  exit 2
fi
```

For path arguments, validate they live UNDER an expected prefix:

```bash
case "$SRC" in
  /opt/<tenant>/agents/*) ;;
  *) echo "ERROR: src must be under /opt/<tenant>/agents/ (got: $SRC)" >&2; exit 2 ;;
esac
```

### Rule 4 — Every wrapper logs to a single audit file

```bash
AUDIT_LOG=/var/log/<tenant>-agent-ops.log
audit() { echo "[$(date -u +%FT%TZ)] [wrapper-name] $*" | tee -a "$AUDIT_LOG"; }

audit "=== STARTED (invoked by $(logname 2>/dev/null || echo unknown)) ==="
audit "before version: $BEFORE"
audit "running: npm install -g ..."
# ...
audit "=== DONE ==="
```

One file, one format. Searchable. Auditable. If the agent ever does something unexpected, `grep` is your friend.

### Rule 5 — Every wrapper pings the user on completion

Visibility is the safety net. If the agent did something significant, the user finds out via Telegram immediately:

```bash
sudo -u <tenant> $TG_SEND send --text "✅ Claude Code updated: $BEFORE → $AFTER" || true
```

`|| true` because we never let a Telegram failure cascade into a wrapper failure. The operation succeeded; the user might just need to check logs.

### Rule 6 — Wrappers handle their own failure modes

Each wrapper has explicit exit codes and rollback semantics. Example from `ops-nginx-reload.sh`:

```bash
TEST_OUT=$(nginx -t 2>&1)
if [[ $? -ne 0 ]]; then
  audit "FATAL: nginx -t failed: $TEST_OUT"
  sudo -u <tenant> $TG_SEND send --text "🚨 nginx config INVALID — refusing to reload. Error: ${TEST_OUT:0:200}"
  exit 1
fi
# safe to reload
```

`nginx -t` first, REFUSE on bad config, reload only when validated. The wrapper IS the safety mechanism.

### Rule 7 — Settings.json deny list stays strict

The wrapper grant doesn't lift the deny list. The agent still can't:
- Run `rm -rf /` or any catastrophic flavor
- Edit `/etc/`, `/var/www/`, `~/.ssh/`, `~/.claude.json`
- Run `reboot`, `shutdown`, `passwd`, `useradd`, `chown`, `chmod 777`

Those stay in settings.json. The wrapper grant is ADDITIVE — it adds specific powers, it doesn't remove existing restrictions.

## Adding a new capability

1. Write the script at `/opt/<tenant>/agents/scripts/ops/ops-<thing>.sh`.
2. Validate inputs strictly (allowlist for service names, prefix-check for paths).
3. Log via the `audit() { ... }` pattern (matches every other wrapper).
4. Ping Telegram on success/failure.
5. Test as the agent user: `sudo -u <tenant> sudo -n /opt/.../ops/ops-<thing>.sh ...`
6. No sudoers changes needed — the directory-wide grant covers it.

## Emergency lockdown

```bash
sudo rm /etc/sudoers.d/<tenant>-agent-ops
```

Instant. Agent loses ALL privileged ops capability. The wrappers are still there but `sudo` will prompt for a password it doesn't have.

For partial lockdown (revoke ONE wrapper without disabling all):

```bash
sudo chmod 0644 /opt/<tenant>/agents/scripts/ops/ops-<thing>.sh   # drop +x
```

The sudoers grant only matches executables.

## Anti-patterns

❌ `NOPASSWD: ALL` — game over the first time a prompt-injected input flows into the agent's Bash tool.

❌ Wrapper that takes free-form bash as input — accidentally an arbitrary-code-execution surface.

❌ Wrapper that doesn't log — you'll never know what happened when something goes wrong.

❌ Wrapper that needs sudo INSIDE its body to work — defeats the point. The whole script runs as root via sudoers; don't nest sudo.

❌ Putting wrapper scripts in a directory the agent user can write to — escalation.

❌ Lifting too many settings.json deny rules to "make ops easier" — the wrapper IS how the agent does ops. The deny list is the perimeter.
