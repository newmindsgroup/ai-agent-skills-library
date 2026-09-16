---
name: application-release-audit
description: "Profile, test, fix when authorized, and report application release readiness across user workflows, data integrity, roles, tenant isolation, integrations, security, accessibility, reliability, deployment readiness, and evidence-backed verdicts. Use for pre-go-live audits, customer-facing releases, internal systems, portals, SaaS products, and high-risk feature launches."
category: QA, Testing, Release
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Original New Minds Group application audit workflow created from QA capability-gap analysis; no third-party skill text copied
---

# Application Release Audit

Version-Timestamp: 2026-08-04 13:10:00 AST

Use this skill when the user needs to know whether an application is ready to ship, safe to hand to a client, or reliable enough for a defined release.

## Authorization Boundary

Start by classifying the engagement:

- `audit-only`: inspect, test, and report without source or data changes.
- `audit-and-fix`: make scoped fixes, then retest.
- `deployment`: touch production or external infrastructure only with explicit authorization.

Record database scope separately. Permission to test a UI does not imply permission to run migrations, alter schema, truncate records, delete QA data, or mutate production.

## App Profile

Discover before asking:

- App name, version, environment, URL, repository, framework, runtime, database, auth model, user roles, tenancy model, integrations, background jobs, mail path, storage, scheduler, deployment target, rollback path, and data sensitivity.
- Required standards or targets, such as OWASP, WCAG, privacy requirements, client acceptance criteria, or internal release gates.
- Explicit exclusions and risk acceptance.

## Audit Depth

Choose the depth based on blast radius:

| Depth | Use for | Minimum output |
|---|---|---|
| 3-stage | Prototype or narrow feature | Discover, test, report |
| 4-stage | Internal app or bounded release | Discover, prepare, test, report |
| 5-stage | Customer-facing release | Scope, baseline, workflows, risk/regression, release report |
| 6-stage | Pre-go-live, multi-role, sensitive, payment, tenant, or system-of-record app | Full evidence register and release verdict |

Do not label a production app ready from a low-depth audit without stating the coverage gap.

## Test Model

Build one traceable QA record chain when mutation is authorized. Use a unique prefix and reuse the same connected records across roles and workflows.

Test:

- Login, logout, routing, and direct URL access for every role.
- Create, read, update, archive, restore, and duplicate prevention.
- Search, sort, filters, pagination, exports, reports, and timezone behavior.
- Object-level authorization, tenant isolation, field visibility, attachments, comments, messages, and guessed IDs.
- Email, notifications, webhooks, retries, idempotency, and failure states.
- Responsive behavior, keyboard behavior, focus, errors, empty states, and loading states.
- Logs, backups, queues, scheduler, TLS, cookies, storage, and deployment configuration.

## Fix Rules

When fixes are authorized:

- Trace the smallest credible cause.
- Preserve unrelated work.
- Add server-side authorization and validation even when the UI restricts choices.
- Prefer scoped queries, allowlists, transactions, idempotency, clear failures, and focused tests.
- Retest the original finding and neighboring behavior.

## Evidence Register

Every material finding needs:

```markdown
ID:
Severity:
Status:
Role:
Surface:
Scenario:
Observed:
Expected:
Business impact:
Evidence:
Cause:
Fix:
Files changed:
Retest:
Owner:
```

Do not include passwords, tokens, customer records, private messages, or unnecessary personal information.

## Verdict

- `Pass`: all scoped release gates pass and no critical or high blocker remains.
- `Conditional pass`: app behavior passes, but a named external, hosting, client, deployment, or evidence condition remains.
- `Fail`: a critical or high blocker remains, data cannot be trusted, tenant isolation fails, rollback is unsafe, or evidence is insufficient.

Never claim certification, compliance, or independent penetration testing beyond the performed scope.
