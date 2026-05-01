# The 4-Gate Deploy Pattern

**Failure mode this prevents:** autonomous deploys silently doing the wrong thing because no human had a chance to see what was about to happen at the points where seeing it mattered most.

**Validated end-to-end:** Mission Control v2.20.0+ deploy chain.

## The pattern

Any deploy that runs without continuous human supervision (autonomous, scheduled, or "run it overnight") MUST pause at four explicit gates. At each gate the deploy script displays a state summary and waits for explicit `continue` / `abort` input.

```
┌─────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  PREFLIGHT  │ →   │ POST-SMOKE   │ →   │  PRE-COMMIT  │ →   │ POST-DEPLOY  │
│    GATE     │     │ VISUAL GATE  │     │     GATE     │     │     GATE     │
└─────────────┘     └──────────────┘     └──────────────┘     └──────────────┘
       │                   │                    │                    │
       ▼                   ▼                    ▼                    ▼
  "everything I'm   "the code I just     "this is what     "this is what
   about to do      changed actually     I'm about to       just shipped.
   is sane"         works"                commit"            still healthy?"
```

### Gate 1 — PREFLIGHT

Display before any change is made:

- Target environment + version
- What files will change
- What services will restart
- Estimated downtime
- Rollback command (must exist before the deploy starts)

Wait for explicit `continue` or `abort`.

**The bug this catches:** wrong target, missing rollback path, drift between local and remote.

### Gate 2 — POST-SMOKE-VISUAL

Display after the change is made and the test suite passes, BEFORE anything is committed or pushed:

- Test results (which suites ran, which passed)
- Visual diff of any UI changes — screenshots side-by-side, or at minimum URLs to compare
- Logs from the local test run
- The exact `git diff` that's about to be committed

Wait for explicit `continue` or `abort`.

**The bug this catches:** tests pass but the actual UI is broken; tests pass but the wrong files were touched; tests pass but a console error nobody noticed is now spammed in production.

### Gate 3 — PRE-COMMIT

Display before `git commit` and `git push`:

- The commit message you're about to write
- The list of files staged
- Any pre-commit hook output

Wait for explicit `continue` or `abort`.

**The bug this catches:** committing secrets, committing build artifacts, committing the wrong message that misrepresents the change.

### Gate 4 — POST-DEPLOY

Display after the deploy is live:

- Health-check results (each endpoint that was exercised, each service that was restarted)
- First 60 seconds of post-deploy logs
- Telemetry deltas (error rate before/after, latency p95 before/after, request volume)
- A 1-line summary: "shipped vX.Y.Z, all green" OR "shipped vX.Y.Z, anomaly in {service}, recommend rollback"

Wait for explicit `acknowledge`. The deploy is not complete until the operator sees this.

**The bug this catches:** silent regressions where the deploy "succeeded" but the system is degraded.

## Implementation notes

- Each gate is enforced by the deploy script, not by convention. If `continue` is not received within {N} minutes, the script should auto-abort with a notification (don't auto-continue on timeout).
- The display at each gate must fit on one screen. If it doesn't, the operator can't actually see it before deciding.
- Gates can be acknowledged by Telegram / Slack reply (e.g., `/deploy continue`), email, or terminal stdin. Whatever the medium, it must be explicit and traceable.
- Don't add a 5th gate. More than 4 and operators start auto-acknowledging without reading.

## Anti-pattern: the silent-success deploy

A "successful" deploy that didn't pause anywhere is suspicious. If you can't say what each gate confirmed, the deploy didn't really succeed — it just didn't fail noisily.
