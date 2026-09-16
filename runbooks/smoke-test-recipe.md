# Smoke Test Recipe — End-to-End Stack Health Check

**Failure mode this prevents:** an agent stack that's "running" (systemd reports green) but actually broken in a way the user only discovers when the morning brief fails to fire. Or a deploy that breaks an obscure dependency you don't notice until 3 days later.

A smoke test is a single script that exercises every critical surface of the stack and reports pass/fail/warn. Re-runnable any time. Used after deploys, as a cron health check, or by the user when "something feels off."

## The 12-section template

Adapt to your stack. Each section is independent — a failure in section 4 doesn't prevent sections 5–12 from running.

```
1.  CORE SERVICES               (systemctl is-active for each)
2.  ALL SCHEDULED TIMERS        (systemctl list-timers + expected list)
3.  SCRIPTS PRESENT + EXECUTABLE (the agent's CLI surface)
4.  CHANNELS PLUGIN PATCHES     (sentinel grep + ts compile)
5.  BOT IDENTITY                (commands menu count, descriptions set)
6.  CONFIG FILES + STATE        (preferences.json, access.json, tenant.yml tz)
7.  WATCHER DEDUP LOGS          (notifications/*.jsonl present)
8.  WATCHDOG STATE              (circuit-breaker not tripped, poller alive)
9.  DATA SOURCES REACHABLE      (weather API, verse API, CRM API auth)
10. VOICE STACK                 (whisper-cli + multilingual model + edge-tts)
11. PROPOSAL FILES              (today's <DATE>.json exists with proposals)
12. KNOWLEDGE GRAPH             (graphify CLI + skill + project graph nodes>0)
```

## Rules

### Rule 1 — One file, runnable as a single command

```bash
bash /opt/<tenant>/agents/scripts/smoke-test.sh
```

Not a multi-step procedure, not a Makefile target, not 12 separate scripts. ONE file. The user must be able to run it cold with no context.

### Rule 2 — Three outcomes per check: ✓ pass / ✗ fail / ⚠ warn

```bash
PASS=0
FAIL=0
WARN=0
ISSUES=()

ok()   { echo "  ✓ $1"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL+1)); ISSUES+=("FAIL: $1"); }
warn() { echo "  ⚠ $1"; WARN=$((WARN+1)); ISSUES+=("WARN: $1"); }
```

- **Pass** — green, nothing to do.
- **Fail** — red, blocks "stack is healthy" conclusion.
- **Warn** — yellow, informational. Common warns: "today's proposals not yet generated at 7am" (auto-clears at 9am).

Section header pattern:

```bash
section() {
  echo
  echo "═══════════════════════════════════════════════════════════"
  echo " $1"
  echo "═══════════════════════════════════════════════════════════"
}
```

### Rule 3 — Exit code = success/fail signal for cron

```bash
echo "Passed: $PASS    Failed: $FAIL    Warnings: $WARN"
[[ $FAIL -eq 0 ]] && exit 0 || exit 1
```

Wraps cleanly into a cron-monitored health check. Warns don't fail the smoke test; only hard fails do.

### Rule 4 — Tolerate state-dependent transients

Some checks WILL warn at certain times of day. For example: "today's proposal file" doesn't exist until the morning brief fires. The smoke test should distinguish this from "the proposal generator is broken":

```bash
today_props=/opt/<tenant>/agents/proposals/$(date -u +%Y-%m-%d).json
if [[ -f "$today_props" ]]; then
  n=$(jq -r '.proposals | length' "$today_props")
  ok "Today's proposals file exists with $n proposals"
else
  warn "Today's proposals file not yet generated (auto-creates at 09:00 tenant-TZ)"
fi
```

The warn is informational. A user running smoke-test at 6am should NOT see a red failure.

### Rule 5 — Each section <30 lines

If a section is getting long, split it into two sections. The smoke test is read top-to-bottom when something's wrong; long sections hide failures.

### Rule 6 — Use the most reliable check per surface

For systemd timers: `systemctl is-active --quiet <timer>` is the canonical "is this scheduled" check. Don't grep `list-timers` output (fragile to format changes).

For scripts: `[[ -x "$path" ]]` checks both presence AND executable bit. Catches "I forgot to chmod +x" failures.

For plugin patches: grep for the sentinel string. Plus a TS-compile check to catch syntax breakage:

```bash
if command -v bun >/dev/null 2>&1; then
  bun build "$PLUGIN" --target=bun --outfile /tmp/smoke-test-server-$$.js >/dev/null 2>&1 \
    && { ok "TypeScript still compiles"; rm -f /tmp/smoke-test-server-$$.js; } \
    || fail "TypeScript BROKEN"
fi
```

For data-source reachability: timeout-bounded curl with `jq -e` to validate the response is real JSON, not a 5xx HTML page:

```bash
if curl -s --max-time 5 'https://api.open-meteo.com/v1/forecast?...' | jq -e .current >/dev/null 2>&1; then
  ok "Open-Meteo reachable"
else
  fail "Open-Meteo unreachable"
fi
```

### Rule 7 — Update expected-lists after every stack change

If you add a new timer, update the `expected_timers` array. If you add a new ops wrapper, update the `expected_scripts` array. Make the test break loudly when reality drifts from documentation.

```bash
expected_timers=(
  "morning-brief.timer"
  "task-deadline-watcher.timer"
  "goal-deadline-watcher.timer"
  "stalled-deal-watcher.timer"
  "disk-space-watcher.timer"
  "hot-lead-inbox-watcher.timer"
  "calendar-conflict-watcher.timer"
  "graphify-rebuild.timer"
  # ← add new ones here
)
```

### Rule 8 — Final block surfaces every failure for copy-paste

```bash
echo
echo "Passed: $PASS    Failed: $FAIL    Warnings: $WARN"
echo
if [[ $FAIL -gt 0 || $WARN -gt 0 ]]; then
  echo "Issues:"
  for i in "${ISSUES[@]}"; do echo "  - $i"; done
fi
```

When a user pastes the output into a chat for help, the issues are pre-aggregated.

## Where to wire it

1. **After deploys.** Every wrapper that touches the stack (ops-claude-update.sh, ops-website-deploy.sh) should run the smoke test at the end and ping Telegram with the result.

2. **As a cron health check.** Daily 06:00 tenant-TZ. If it fails, ping the user.

3. **In the new-client deployment runbook.** The bootstrap script's last step is `bash scripts/smoke-test.sh` — green = done, red = investigate.

4. **In CI/CD if applicable.** Smoke against a staging tenant before promoting to production.

## Anti-patterns

❌ **A smoke test that doesn't actually exercise anything.** "Is the service file present?" is not a smoke test. "Did the service respond to a probe?" is.

❌ **A smoke test that takes more than 60 seconds.** If it's slow, people won't run it. Mock external dependencies (or accept warns when they're unreachable) instead of waiting on long timeouts.

❌ **A smoke test that requires external state to pass.** Don't fail when the morning-brief hasn't fired yet at 06:00. Use warn.

❌ **Per-component scripts that you have to run in sequence.** ONE file. Always.

❌ **A smoke test that grows to 500 lines without sections.** Sections + emoji checkpoints + ISSUES aggregation. Make it skimmable.

❌ **No documentation of what each section checks.** Future-you (or future-collaborators) need to know WHY each check exists, not just WHAT it does.
