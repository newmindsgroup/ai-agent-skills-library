---
name: api-contract-release-gate
description: "Validate HTTP APIs against contracts, authorization rules, data invariants, malformed inputs, compatibility expectations, pagination, idempotency, rate limits, and failure behavior before release. Use for OpenAPI-backed services, integrations, webhooks, client SDKs, and API regression checks."
category: Engineering, APIs, Testing
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Original New Minds Group API release workflow created from contract-testing capability analysis; no third-party skill text copied
---

# API Contract Release Gate

Version-Timestamp: 2026-08-04 13:10:00 AST

Use this skill when an API contract, integration boundary, webhook, SDK, or backend endpoint must be trusted before release.

## Inputs

Collect:

- Contract source, such as OpenAPI, AsyncAPI, protobuf, typed routes, or documented examples.
- Environment and base URL.
- Auth model and role matrix.
- Supported clients and compatibility requirements.
- Mutation boundary and test-data policy.
- Rate limits, idempotency keys, retries, and timeout expectations.

## Test Classes

Validate:

- Contract shape: paths, methods, parameters, headers, request bodies, response bodies, status codes, examples, and error schema.
- Authentication: missing, expired, malformed, wrong role, wrong tenant, and direct object access.
- Data invariants: required fields, enum values, numeric ranges, dates, Unicode, long strings, nulls, and duplicate prevention.
- Pagination and filtering: limits, offsets, cursors, sort order, empty states, and stable ordering.
- Compatibility: additive changes, breaking changes, deprecated fields, and client expectations.
- Reliability: retries, idempotency, concurrency, partial failures, and timeout behavior.
- Observability: correlation IDs, useful errors, no secret leakage, and log redaction.

## Mutation Safety

- Use isolated test tenants or controlled QA records.
- Do not run destructive API tests against production without explicit authorization.
- Prefer dry-run endpoints or sandbox environments.
- Clean up test data only when cleanup is authorized and recoverability is clear.

## Evidence

Report each failure with:

```markdown
Endpoint:
Method:
Role:
Scenario:
Expected contract:
Observed response:
Status:
Risk:
Reproduction:
Owner:
```

Redact tokens and private payload values.

## Completion Criteria

- Contract and implementation agree for the scoped endpoints.
- Authorization and tenant isolation are verified for material surfaces.
- Failure responses are predictable and safe.
- Compatibility risks are named before release.
- Remaining gaps are marked as excluded, deferred, or blocking.
