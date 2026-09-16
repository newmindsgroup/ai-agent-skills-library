# Proactive Watcher Pattern

**Failure mode this prevents:** an agent that only RESPONDS to messages, never PROACTIVELY surfaces what matters. Or a "proactive" system that spams the user with low-value pings, double-charges for LLM calls on data the agent already had, or sends duplicate alerts as state oscillates.

A proactive watcher is a small systemd-timer-driven script that polls one source of state, detects a change worth flagging, and pings the user via Telegram — once. Deterministic dedup. Cheap to run. No LLM in the common case.

## Rule 1 — One source per watcher

A watcher polls EXACTLY ONE source. Mixing sources couples failures (one source goes down → the whole watcher dies) and bloats dedup logic.

```
✓ stalled-deal-watcher    →  GHL /opportunities/search
✓ goal-deadline-watcher   →  goals/active.json
✓ disk-space-watcher      →  df local
✗ "pipeline+inbox" watcher →  GHL + Gmail + a custom dedup matrix
```

If you need cross-referencing (e.g. hot-lead = sender in Gmail AND in GHL contacts), do it in bash AFTER the single-source LLM step. See `split-llm-bash-design.md`.

## Rule 2 — Dedup at an append-only JSONL log

Every watcher maintains its own `notifications/<watcher-name>-nudges.jsonl`. One JSON object per line. The dedup KEY is whatever uniquely identifies the (entity, window) pair you don't want to re-fire:

```bash
# task-deadline-watcher: dedup per task per window
nudge_key="$task_id:$window"   # e.g. "t-20260515-abcd:4h"

# stalled-deal-watcher: dedup per deal per ISO week
nudge_key="$opp_id:$iso_week"  # e.g. "opp-xyz:2026-W21"

# disk-space-watcher: dedup per mount per threshold per window
nudge_key="$mount:$threshold:$today"
```

Before sending, `grep -q "\"$nudge_key\"" "$NUDGE_LOG"` — already there means skip. After sending, append the JSON. This is O(1) on a small file and survives restarts.

**Don't use a database.** A JSONL append-only log is faster, audit-friendly, restart-safe, and trivially inspectable by humans. SQLite/PostgreSQL is overkill for state that's <10MB.

## Rule 3 — Plain text, not MarkdownV2

Telegram MarkdownV2 requires escaping `_*[]()~`>#+-=|{}.!`. One unescaped character in a URL → "Bad Request: can't parse entities". This bug class haunted every previous iteration of every watcher in this stack.

Use plain text:

```bash
bash {{TENANT_AGENT_HOME}}/scripts/tg-send.sh send --text "$msg"
```

NOT `--md`. Plain text accepts every character. If you need bold/links, render the message as HTML via `--html` (also escape-safer than MarkdownV2 because only `< > &` are reserved).

## Rule 4 — Idempotent timer + service

Every watcher is a oneshot systemd service triggered by a timer. The timer is `Persistent=true` so missed runs (e.g. server reboot) fire on next start. RandomizedDelaySec ≥ 60 to avoid thundering herd.

```ini
# foo-watcher.service.tmpl
[Unit]
Description=Foo proactive watcher
After=network.target

[Service]
Type=oneshot
User={{TENANT_LINUX_USER}}
ExecStart={{TENANT_AGENT_HOME}}/scripts/foo-watcher.sh
StandardOutput=append:{{TENANT_AGENT_HOME}}/logs/foo-watcher.log
StandardError=append:{{TENANT_AGENT_HOME}}/logs/foo-watcher.log
TimeoutStartSec=300

# foo-watcher.timer.tmpl
[Unit]
Description=Run foo-watcher every 4 hours

[Timer]
OnCalendar=*-*-* 00,04,08,12,16,20:00:00 {{TENANT_TIMEZONE}}
Persistent=true
RandomizedDelaySec=120
Unit=foo-watcher.service

[Install]
WantedBy=timers.target
```

The watcher script itself uses `set -euo pipefail` so any bash error exits non-zero, which systemd logs as a failure.

## Rule 5 — Cost-aware design

Tally cost-per-run in your head before adding a watcher. Three classes:

| Class | Cost-per-run | Examples |
|---|---|---|
| **Local-only** | $0 | task-deadline-watcher (reads tasks/active.json), disk-space-watcher (df), graphify-rebuild (AST-only) |
| **One REST call** | $0 (free-tier APIs) or sub-cent | stalled-deal-watcher (GHL REST), hot-lead-inbox-watcher's HTTP probe |
| **claude --print** | ~$0.01–$0.05 per invocation | hot-lead-inbox-watcher (Gmail MCP), calendar-conflict-watcher (Calendar MCP) |

Multiply by daily frequency. A `claude --print` watcher running hourly = ~$0.50/day = ~$15/mo per tenant. Acceptable IF the value matches; otherwise compress to fewer runs per day OR switch to direct REST (see `split-llm-bash-design.md`).

## Rule 6 — Inline slash-command shortcuts in the nudge

Every nudge ends with one-tap actions the user can take:

```
💼 Stalled deal — 14 days idle

ACME Corp Q3 retainer
Value: $8,500
Contact: Sarah Chen

Last touched: 2026-05-04

Tap or type: /research opp-xyz  ·  /draft email opp-xyz re-engagement
```

The slash commands are the contract between the watcher and the agent's CLAUDE.md — when the user taps `/draft email opp-xyz re-engagement`, the agent looks up `opp-xyz` in GHL and delegates to comms-agent. Don't put long-form details in the nudge; let the slash command pull them.

## Rule 7 — Smoke-test coverage

Every new watcher gets a check in the stack's smoke-test.sh:

- timer is active + scheduled
- script is present + executable
- recent dedup log file exists (or is gracefully absent if never fired)

See `smoke-test-recipe.md` for the structure.

## Anti-patterns

❌ **One watcher polling everything**. Split into focused watchers — debugging "why didn't I get pinged?" is 10x harder when one script reads four sources.

❌ **Dedup in memory only**. A restart wipes it; you spam the user the next day.

❌ **Re-running the LLM to decide whether to send**. The LLM should produce data; the BASH decides whether to send. See `split-llm-bash-design.md`.

❌ **Watchers that need user-input flags**. A watcher must be fully autonomous when triggered by systemd. If it needs a flag, the flag goes in env-var defaults or the systemd unit Environment= block.

❌ **Watchers that mutate state**. A watcher polls + nudges. It NEVER changes pipeline records, archives email, etc. — those are the agent's job after the user taps an approval button.
