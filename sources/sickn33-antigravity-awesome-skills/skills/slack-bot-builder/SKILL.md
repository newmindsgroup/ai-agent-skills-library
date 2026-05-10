---
name: slack-bot-builder
description: 'Build Slack apps using the Bolt framework across Python,'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/slack-bot-builder/SKILL.md'
  imported_at: '2026-05-09'
---

# Slack Bot Builder

Build Slack apps using the Bolt framework across Python, JavaScript, and Java. Covers Block Kit for rich UIs, interactive components, slash commands, event handling, OAuth installation flows, and Workflow Builder integration. Focus on best practices for production-ready Slack apps.

## When to Use
- User mentions or implies: slack bot
- User mentions or implies: slack app
- User mentions or implies: bolt framework
- User mentions or implies: block kit
- User mentions or implies: slash command
- User mentions or implies: slack webhook
- User mentions or implies: slack workflow
- User mentions or implies: slack interactive
- User mentions or implies: slack oauth

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Patterns
- Bolt App Foundation Pattern
- Anti_patterns
- Block Kit UI Pattern
- OAuth Installation Pattern
- Socket Mode Pattern
- Workflow Builder Step Pattern
- Sharp Edges
- Missing 3-Second Acknowledgment (Timeout)
- Acknowledge immediately, process later
- For Bolt framework - use lazy listeners
- Not Validating OAuth State Parameter (CSRF)
- Proper state validation
- Exposing Bot/User Tokens
- Never hardcode or log tokens
- Encrypt tokens in database
- Rotate tokens if exposed
- Requesting Unnecessary OAuth Scopes

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
