---
name: segment-cdp
description: 'Expert patterns for Segment Customer Data Platform including'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/segment-cdp/SKILL.md'
  imported_at: '2026-05-09'
---

# Segment CDP

Expert patterns for Segment Customer Data Platform including Analytics.js, server-side tracking, tracking plans with Protocols, identity resolution, destinations configuration, and data governance best practices.

## When to Use
- User mentions or implies: segment
- User mentions or implies: analytics.js
- User mentions or implies: customer data platform
- User mentions or implies: cdp
- User mentions or implies: tracking plan
- User mentions or implies: event tracking
- User mentions or implies: identify track page
- User mentions or implies: data routing

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Patterns
- Analytics.js Browser Integration
- Context
- Server-Side Tracking with Node.js
- Tracking Plan Design
- Identity Resolution
- Destinations Configuration
- HTTP Tracking API
- Sharp Edges
- Anonymous ID Persists Until Explicit Reset
- Device Mode Bypasses Protocols Blocking
- HTTP API Has Strict Size Limits
- Track Calls Without Identify Are Anonymous
- Write Key in Client is Visible (But Intentional)
- Events May Be Lost on Page Navigation
- Timestamps Without Timezone Cause Analytics Issues
- Tracking Before Consent Violates GDPR
- Validation Checks

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
