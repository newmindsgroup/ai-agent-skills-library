# Agent Operating Principles

**Context:** these principles were captured from a multi-hotfix deploy chain — one night, ten releases, five hotfixes. They apply to any production-impacting work an agent (or human) does on infrastructure, deploys, or any system where a wrong move ships before anyone notices.

These are commitments — both for human operators and for any agent running in autonomous mode.

## The core lesson

**Every bug in the chain was discoverable by running the new code in the production runtime context BEFORE pushing.** The chain happened because each fix was committed and shipped without a check that it actually worked under the conditions the production code path runs in: as the deploy user, with the production cwd, with no key for SSH-self, with no traversal access to restricted paths.

The fix is structural (`dry-run` mode + `health.sh` + CI), not heroic ("be more careful"). But the discipline still matters between commits.

---

## The seven principles

### 1. Run the change in the production runtime context before commit

For any change to a script that runs as the deploy / agent user on production:

```bash
# After editing the script + rendering, but BEFORE git add:
ssh root@$HOST "sudo -u $DEPLOY_USER -H bash <THE_SCRIPT> <args>"
# OR (for deploy.sh specifically):
ssh root@$HOST "sudo -u $DEPLOY_USER -H bash /opt/$TENANT/agents/scripts/deploy.sh dry-run vX.Y.Z"
```

The `-H` flag matters — it sets `$HOME` to the user's home, which mirrors how systemd invokes scripts.

If the change involves a systemd unit, the equivalent is `systemctl daemon-reload && systemd-analyze verify <unit>` followed by a controlled restart with `journalctl -fu` watching live.

**Why:** bugs that worked under the developer's context (Mac, root SSH, full sudo) but failed under the production context (deploy user, restricted environment) are the most painful kind to debug after the fact.

### 2. Use `dry-run` before every real start

```bash
bash /opt/$TENANT/agents/scripts/deploy.sh dry-run vX.Y.Z
# If green → ship for real:
bash /opt/$TENANT/agents/scripts/deploy.sh start vX.Y.Z
```

`dry-run` exercises the FULL validation pipeline (git pull + preflight + smoke) without writing state files, posting approvals, or pushing anything. It's the mechanical version of principle #1.

### 3. No force-push, ever

If a test commit needs reverting, use `git revert <sha>` (which creates a NEW commit that undoes the test). Force-push (`--force`, `--force-with-lease`) is reserved for catastrophic recovery scenarios where the human has explicitly authorized it in chat.

This is not arbitrary — force-push to `main` overwrites history. If anyone (a teammate, a CI bot, another agent session) has based work on the overwritten commits, that work silently disappears. `git revert` makes the operation auditable.

### 4. Health-check IS the deploy, not a separate step

A deploy that "succeeded" by `git push` is not a deploy that succeeded. The deploy succeeded only when health-check confirms every service that should be healthy IS healthy.

The deploy script must run health-check at the end. If health-check fails, the deploy reports FAILED, not SUCCESS. The auto-rollback path is engaged.

### 5. Logs over assumption

When something is wrong, the first move is `journalctl` or `tail -f`, not "let me think about what could be wrong." Logs are cheap. Speculation is expensive.

This applies recursively — if a log says "permission denied," the next move is to check what permission was actually denied (which path? which user? which capability?), not to guess.

### 6. The deploy is not done until you've watched it for 5 minutes

After the deploy "succeeds":

- Watch logs for 5 minutes
- Check telemetry deltas (error rate, latency)
- Send a probe request through the system
- Confirm the most recent customer-visible flow still works

Many deploys "succeed" at minute 0 and break at minute 3 when traffic catches up to the change. The last 5 minutes of supervision catch them.

### 7. Document the lesson, not the fix

When a deploy chain happens (5 hotfixes in one night), write down what you learned, not what you fixed. The fix is in git. The lesson is the operating principle that prevents the next chain.

This file is the example. Each principle here is a lesson, not a fix.

---

## Anti-pattern: the heroic deploy

A deploy that requires the operator to "be careful" is broken. If a script can be run wrong, it will be run wrong. The fix is always structural (a flag, a guard, a dry-run, a CI check), not procedural ("we'll be more careful next time").

If you find yourself writing a runbook step like "MAKE SURE you run X before Y" — that's a sign the script needs to enforce the order itself.
