---
name: laravel-delivery-safety-pack
description: "Apply safe Laravel delivery patterns for RBAC, audit logging, soft deletion, admin data tables, maintenance mode, runtime AI settings, provider fallback, OCR features, environment hygiene, and deployment recovery. Use for Laravel client applications, shared-hosting constraints, admin portals, and production hardening without introducing public rescue endpoints by default."
category: Backend, Laravel, Security
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Original New Minds Group Laravel delivery workflow created from Laravel capability analysis; no third-party skill text copied
---

# Laravel Delivery Safety Pack

Version-Timestamp: 2026-08-04 13:10:00 AST

Use this skill for Laravel work where delivery speed must not compromise security, data integrity, or operational recoverability.

## Non-Negotiables

- Never commit `.env`, live API keys, private keys, database dumps, runtime settings with secrets, or public rescue scripts.
- Do not add public cache-clear, setup, debug, or recovery endpoints by default.
- If a temporary recovery endpoint is unavoidable, require explicit approval, no fallback static key, IP restriction where possible, short-lived secret, minimal output, and delete-after-use evidence.
- Do not push to external remotes, client repos, or production branches without explicit authorization.
- Keep authorization server-side. UI hiding is not access control.

## Delivery Areas

### RBAC and Admin Modules

- Define roles, permissions, policies, gates, middleware, and route groups.
- Test direct URL access and object-level authorization.
- Verify list, detail, create, update, delete, restore, export, and bulk actions for every role.

### Audit Logging

- Log who changed what, when, and from which trusted context.
- Exclude secrets, passwords, tokens, raw files, and unnecessary personal data.
- Keep logs queryable and retention-aware.

### Soft Delete and Restore

- Use soft deletion for recoverable business objects.
- Test active list exclusion, trash list inclusion, restore, relationship integrity, audit trail, and permanent deletion only when authorized.
- Define retention and cleanup policy.

### Data Tables and Forms

- Validate server-side filters, sorting, pagination, search, exports, and tenant scoping.
- Keep Select2, date inputs, and reusable form controls visually consistent and keyboard-usable.
- Prevent duplicate submission and stale modal state.

### Runtime AI Settings

- Store provider keys only in encrypted storage or approved server secret stores.
- Mask keys in admin UI.
- Restrict settings to authorized admins.
- Do not log decrypted values.
- Make fallback providers explicit and cost-aware.

### Vision and OCR Features

- Treat uploaded images and extracted text as sensitive unless proven otherwise.
- Record provider, model, retention, confidence, and human-review path.
- Avoid sending customer images to external providers without approval.

### Maintenance and Deployment

- Prefer Laravel-native maintenance mode, queue controls, scheduler checks, config cache discipline, and platform-native deploy hooks.
- Verify storage permissions, cache state, queue workers, logs, mail, scheduled tasks, backups, and rollback before release.

## Completion Criteria

- Authorization and tenant boundaries are tested.
- Secrets and runtime settings are excluded from source and public paths.
- Data mutations have tests or manual evidence.
- Deployment recovery does not depend on a permanent public utility endpoint.
- Open risks are documented with owner and next action.
