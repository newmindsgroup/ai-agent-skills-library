---
name: trigger-dev
description: 'Trigger.dev expert for background jobs, AI workflows, and reliable'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/trigger-dev/SKILL.md'
  imported_at: '2026-05-09'
---

# Trigger.dev Integration

Trigger.dev expert for background jobs, AI workflows, and reliable async execution with excellent developer experience and TypeScript-first design.

## When to Use
- User mentions or implies: trigger.dev
- User mentions or implies: trigger dev
- User mentions or implies: background task
- User mentions or implies: ai background job
- User mentions or implies: long running task
- User mentions or implies: integration task
- User mentions or implies: scheduled task

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
- Integrations
- Deployment
- Patterns
- Basic Task Setup
- AI Task with OpenAI Integration
- Scheduled Task with Cron
- Batch Processing
- Webhook Handler
- Sharp Edges
- Task timeout kills execution without clear error
- Non-serializable payload causes silent task failure
- Environment variables not synced to Trigger.dev cloud

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
