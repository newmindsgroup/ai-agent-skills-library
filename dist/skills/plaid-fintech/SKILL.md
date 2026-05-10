---
name: plaid-fintech
description: 'Expert patterns for Plaid API integration including Link token'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/plaid-fintech/SKILL.md'
  imported_at: '2026-05-09'
---

# Plaid Fintech

Expert patterns for Plaid API integration including Link token flows, transactions sync, identity verification, Auth for ACH, balance checks, webhook handling, and fintech compliance best practices.

## When to Use
- User mentions or implies: plaid
- User mentions or implies: bank account linking
- User mentions or implies: bank connection
- User mentions or implies: ach
- User mentions or implies: account aggregation
- User mentions or implies: bank transactions
- User mentions or implies: open banking
- User mentions or implies: fintech
- User mentions or implies: identity verification banking

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Patterns
- Link Token Creation and Exchange
- Context
- Transactions Sync
- Item Error Handling and Update Mode
- Auth for ACH Transfers
- Real-Time Balance Check
- Webhook Verification
- Sharp Edges
- Access Tokens Never Expire But Are Highly Sensitive
- accounts/get Returns Cached Balances, Not Real-Time
- Webhooks May Arrive Out of Order or Duplicated
- Items Enter Error States That Require User Action
- Sandbox Does Not Reflect Production Complexity
- TRANSACTIONS_SYNC_MUTATION_DURING_PAGINATION Requires Restart
- Link Tokens Are Short-Lived and Single-Use
- Recurring Transactions Need 180+ Days of History
- Validation Checks

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
