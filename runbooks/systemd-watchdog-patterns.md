# systemd Watchdog Patterns

**Failure mode this prevents:** a watchdog unit that's so eager to restart its target service that it crashes-loops the system, OR a watchdog that fails silent and never actually does its job.

## Rule 1 — `After=`, not `Requisite=`, for the watchdog→service relationship

A watchdog's job is to restart the service when the service is unhealthy. So:

```ini
# WRONG
[Unit]
Description=Foo Watchdog
Requisite=foo.service        ← watchdog won't start if foo is down

# RIGHT
[Unit]
Description=Foo Watchdog
After=foo.service            ← watchdog starts after foo, but doesn't depend on foo being up
```

**Why:** `Requisite=` means "if this unit is not active, abort." A watchdog whose entire purpose is to handle the case where its target is down cannot itself depend on the target being up. `After=` declares ordering only — the watchdog will start after the target was tried, and will do its job whether the target succeeded or not.

## Rule 2 — Every watchdog has a circuit breaker

A watchdog without a circuit breaker is a fork bomb. If the service is fundamentally broken (bad config, missing dependency, persistent permission error), the watchdog will restart it forever.

Required pattern:

```bash
#!/bin/bash
# foo-watchdog.sh

CIRCUIT_BREAKER_FILE=/var/lib/foo-watchdog/restart-attempts
WINDOW_SECONDS=1800   # 30 minutes
MAX_RESTARTS=3

# Read recent attempts
if [[ -f "$CIRCUIT_BREAKER_FILE" ]]; then
  attempts=$(awk -v cutoff=$(($(date +%s) - WINDOW_SECONDS)) '$1 > cutoff' "$CIRCUIT_BREAKER_FILE" | wc -l)
else
  attempts=0
fi

if (( attempts >= MAX_RESTARTS )); then
  # Tripped — escalate to human
  /usr/local/bin/notify-human.sh "foo.service has tripped the watchdog circuit breaker — $attempts restarts in $WINDOW_SECONDS seconds. Watchdog backing off until human intervention."
  exit 0
fi

# Record this attempt
mkdir -p "$(dirname "$CIRCUIT_BREAKER_FILE")"
echo "$(date +%s) restart" >> "$CIRCUIT_BREAKER_FILE"

# Do the restart
systemctl restart foo.service
```

**The threshold "3 in 30 minutes" is field-tested.** Less aggressive (e.g., 5 in an hour) hides problems. More aggressive (1 in 10 minutes) is too sensitive and spams human escalations on minor flaps.

## Rule 3 — Health check OUTSIDE systemd's view

systemd's "service is running" check is misleading. A service can be running while wedged. The watchdog must run an explicit health check that exercises the actual code path:

- HTTP service → `curl -fsS --max-time 5 http://localhost:PORT/health`
- Database service → `psql -c 'SELECT 1' --no-psqlrc -t`
- Worker service → check that the most recent successful job is within {timeout}

Don't trust `systemctl is-active`. It tells you "the process is alive," not "the service is healthy."

## Rule 4 — Watchdog logs are first-class

The watchdog must log every check (pass or fail) to a known location, not just on failures. When the system goes wrong, you need the watchdog's view of "what was healthy when" — silent watchdogs that only log failures are useless during root-cause investigations.

```bash
log() {
  echo "$(date -u +%Y-%m-%dT%H:%M:%SZ) [foo-watchdog] $*" >> /var/log/foo-watchdog.log
}
```

## Rule 5 — Don't watchdog the watchdog

Two-layer watchdogs ("a watchdog watching the watchdog") are an anti-pattern. The reliability gain is marginal and the failure surface is enormous. Either:

- Trust systemd to restart your watchdog (`Restart=on-failure`, `RestartSec=10s`), OR
- Trust an external monitoring system (Datadog, Healthchecks.io) to alert if the watchdog stops checking in.

## Anti-pattern: the eager watchdog

The most common failure mode is a watchdog that:

- Has no circuit breaker
- Trusts `systemctl is-active` (no real health check)
- Restarts the target on the first sign of trouble

Result: a small flap (transient network blip, slow disk for 30 seconds) triggers a restart. The restart takes longer than the flap. Now the service is "down" longer than it would have been if the watchdog had done nothing. Repeat until the watchdog has restarted the service 200 times and the system is unrecoverable.

The fix is structural: real health check + circuit breaker + log everything.
