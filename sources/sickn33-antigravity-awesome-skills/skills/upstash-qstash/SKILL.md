---
name: upstash-qstash
description: 'Upstash QStash expert for serverless message queues, scheduled'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/upstash-qstash/SKILL.md'
  imported_at: '2026-05-09'
---

# Upstash QStash

Upstash QStash expert for serverless message queues, scheduled jobs, and reliable HTTP-based task delivery without managing infrastructure.

## When to Use
- User mentions or implies: qstash
- User mentions or implies: upstash queue
- User mentions or implies: serverless cron
- User mentions or implies: scheduled http
- User mentions or implies: message queue serverless
- User mentions or implies: vercel cron
- User mentions or implies: delayed message

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Principles
- Capabilities
- Scope
- Tooling
- Core
- Frameworks
- Patterns
- Related
- Basic Message Publishing
- Scheduled Cron Jobs
- Signature Verification
- Callback for Delivery Status
- URL Groups (Fan-out)
- Message Deduplication
- Sharp Edges
- Not verifying QStash webhook signatures
- Callback endpoint taking too long to respond
- Hitting QStash rate limits unexpectedly

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
