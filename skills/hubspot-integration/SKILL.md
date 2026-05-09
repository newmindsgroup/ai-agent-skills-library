---
name: hubspot-integration
description: 'Expert patterns for HubSpot CRM integration including OAuth'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/hubspot-integration/SKILL.md'
  imported_at: '2026-05-09'
---

# HubSpot Integration

Expert patterns for HubSpot CRM integration including OAuth authentication, CRM objects, associations, batch operations, webhooks, and custom objects. Covers Node.js and Python SDKs.

## When to Use
- User mentions or implies: hubspot
- User mentions or implies: hubspot api
- User mentions or implies: hubspot crm
- User mentions or implies: hubspot integration
- User mentions or implies: contacts api

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Patterns
- OAuth 2.0 Authentication
- Template
- Notes
- Private App Token
- CRM Object CRUD Operations
- Batch Operations
- Associations v4 API
- Webhook Handling
- Custom Objects
- Sharp Edges
- Rate Limits Vary by App Type and Hub Tier
- 5% Error Rate Threshold for Marketplace Apps
- API Keys Deprecated - Use OAuth or Private App Tokens
- OAuth Access Tokens Expire in 30 Minutes
- Webhook Requests Must Be Validated
- All List Endpoints Require Pagination
- Associations v4 API Has Breaking Changes

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
