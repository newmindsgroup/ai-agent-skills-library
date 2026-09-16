---
name: deployment-secret-exposure-gate
description: "Run a strict pre-deploy and post-deploy safety gate that prevents secrets, environment files, repository internals, debug utilities, credential artifacts, build outputs, or private operational files from becoming public. Use before any production or client deployment, after hosting changes, after adding rescue scripts or admin utilities, and whenever the user asks whether a deployment is safe."
category: Security, Compliance, Reliability
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Original New Minds Group workflow created from deployment-safety capability analysis; no third-party skill text copied
---

# Deployment Secret Exposure Gate

Version-Timestamp: 2026-08-04 13:10:00 AST

Use this skill before deployment work where source files, runtime config, build artifacts, or operational utilities can become reachable on a public URL.

## Operating Rules

- Treat the deployment target as sensitive until verified.
- Do not deploy, publish, rotate secrets, change hosting settings, or alter permissions without explicit authorization.
- Never print full credentials, tokens, cookies, private keys, database URLs, or secret values in the terminal, report, screenshots, commit messages, or issue comments.
- Use redacted evidence. Show file path, risk, and remediation, not the secret value.
- Prefer server environment variables, platform secret stores, and files outside the document root.

## Pre-Deploy Checks

Run the smallest safe check set that fits the project:

1. Inspect repository layout, framework, hosting target, build output, and public document root.
2. Confirm `.env`, `.env.*`, private keys, database dumps, backups, logs, config exports, local prompt archives, and deploy notes are ignored or excluded.
3. Confirm Git remotes do not contain embedded credentials.
4. Search deploy-facing paths for high-confidence secret patterns.
5. Verify public bundles do not contain server-only API keys or service-role credentials.
6. Check that debug flags, stack traces, setup wizards, admin routes, and rescue utilities are disabled or access-controlled in production.
7. Confirm the rollback path and responsible human owner.

## Public Surface Checks

After deployment, verify sensitive paths return `404`, `403`, or an equivalent denial:

```text
/.env
/.git/config
/storage/logs/
/vendor/
/node_modules/
/composer.json
/package-lock.json
/debug
/phpinfo.php
```

Adapt the list to the actual stack and hosting model.

## Rescue and Admin Utilities

Operational utilities are high-risk because scanners look for them continuously.

- Prefer SSH, platform console jobs, or authenticated admin tasks over public rescue scripts.
- If a temporary public utility is unavoidable, require explicit approval, unique time-limited secret, IP allowlist where possible, no fallback static key, minimal output, and delete-after-use.
- Do not commit live utility files. Commit templates only.
- Record the utility path, activation window, owner, and removal evidence.

## Evidence Report

Return a concise table:

| Check | Status | Evidence | Next action |
|---|---|---|---|
| Secret files excluded | pass/fail | redacted path evidence | owner |
| Public sensitive paths blocked | pass/fail | status codes | owner |
| Debug disabled | pass/fail | config or response evidence | owner |
| Utility files controlled | pass/fail/not applicable | path and controls | owner |

## Completion Criteria

- No known secret or private operational file is reachable from the public URL.
- No secret is stored in committed source or public build output.
- Any warning has an owner and explicit sign-off.
- Any live rescue utility has a removal plan and evidence path.
- The final response separates verified facts from assumptions.
