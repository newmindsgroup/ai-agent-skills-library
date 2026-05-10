---
name: clerk-auth
description: 'Expert patterns for Clerk auth implementation, middleware,'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/clerk-auth/SKILL.md'
  imported_at: '2026-05-09'
---

# Clerk Authentication

Expert patterns for Clerk auth implementation, middleware, organizations, webhooks, and user sync

## When to Use
- User mentions or implies: adding authentication
- User mentions or implies: clerk auth
- User mentions or implies: user authentication
- User mentions or implies: sign in
- User mentions or implies: sign up
- User mentions or implies: user management
- User mentions or implies: multi-tenancy
- User mentions or implies: organizations
- User mentions or implies: sso
- User mentions or implies: single sign-on

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Patterns
- Next.js App Router Setup
- Code_example
- Anti_patterns
- References
- Middleware Route Protection
- Server Component Authentication
- Client Component Hooks
- Organizations and Multi-Tenancy
- Webhook User Sync
- API Route Protection
- Sharp Edges
- CVE-2025-29927 Middleware Bypass Vulnerability
- Multiple Middleware Files Cause Conflicts
- 4KB Session Token Cookie Limit
- auth() Requires clerkMiddleware Configuration
- Webhook Race Conditions
- auth() is Async in App Router

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
