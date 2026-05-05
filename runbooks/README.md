# Runbooks & Patterns

This directory contains patterns and runbooks that aren't loadable as Agent Skills, but encode hard-won lessons that are worth carrying across projects.

Skills in `skills/` are *behaviors* the agent picks up and applies. Runbooks here are *operating principles* the human (and any agent) should read once, internalize, and apply judgement against.

## What's here

| File | What it teaches |
|---|---|
| [`gate-pattern.md`](gate-pattern.md) | Autonomous deploys should pause at 4 explicit gates: preflight, post-smoke-visual, pre-commit, post-deploy. Validated end-to-end across multiple production releases. |
| [`systemd-watchdog-patterns.md`](systemd-watchdog-patterns.md) | Watchdog units must NOT `Requisite=` the service they restart (use `After=` only). Every watchdog needs a circuit breaker — 3 retries in 30 min then escalate. |
| [`drive-clone-handoff.md`](drive-clone-handoff.md) | Cowork sessions write to Drive; next Claude Code session reads from `~/code` clone. Must give explicit `cp` / `rsync` commands per new file at session close. |
| [`defensive-api-bindings.md`](defensive-api-bindings.md) | UI helpers must tolerate multiple shapes, render missing fields as `—`. Substitute for TypeScript in single-file vanilla-JS dashboards. |
| [`read-before-escalating.md`](read-before-escalating.md) | When an agent flags an "architectural question," check if the answer is already in the codebase first. Most "decisions" are unread code. |
| [`agent-operating-principles.md`](agent-operating-principles.md) | The 7 non-negotiable discipline commitments captured from a multi-hotfix deploy chain. Production-runtime context, dry-run before start, no force-push, etc. |
| [`tool-leverage-heuristics.md`](tool-leverage-heuristics.md) | The autonomy playbook. Maps natural-language triggers ("AI-search visibility", "production is down", "ready to ship?") to specific tool/agent combos that should fire together. Drop the table into your project's CLAUDE.md so the agent reaches for the right tools without being told. |

## How to use

Read the runbook before doing the work it covers. If you're shipping deploy infrastructure → read `agent-operating-principles.md` and `gate-pattern.md` first. If you're wiring up a watchdog → read `systemd-watchdog-patterns.md` first.

These aren't theoretical. Each runbook starts with the failure mode that produced the lesson. If you skip the runbook, you're betting that you'll re-discover the lesson the same way the original author did, which is usually a bad bet.

## Adding a runbook

1. The pattern must have produced a tangible outcome (an outage avoided, a bug not re-introduced, a deploy that didn't break) — not just opinion.
2. Lead with the failure mode. The reader needs the *why* before the *what*.
3. Make the rule concrete and testable. "Be careful" is not a runbook. "Always run `dry-run` before `start`" is.
4. Add the file + a row to the table above.
5. Open a PR.
