---
name: azure-functions
description: 'Expert patterns for Azure Functions development including isolated'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/azure-functions/SKILL.md'
  imported_at: '2026-05-09'
---

# Azure Functions

Expert patterns for Azure Functions development including isolated worker model, Durable Functions orchestration, cold start optimization, and production patterns. Covers .NET, Python, and Node.js programming models.

## When to Use
- User mentions or implies: azure function
- User mentions or implies: azure functions
- User mentions or implies: durable functions
- User mentions or implies: azure serverless
- User mentions or implies: function app

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Patterns
- Isolated Worker Model (.NET)
- Template
- Notes
- Node.js v4 Programming Model
- Python v2 Programming Model
- Durable Functions - Function Chaining
- Durable Functions - Fan-Out/Fan-In
- Cold Start Optimization
- Queue Trigger with Error Handling
- HTTP Trigger with Long-Running Pattern
- Sharp Edges
- HTTP Timeout is 230 Seconds Regardless of Plan
- Use async pattern with Durable Functions
- Use queue-based async pattern
- Use webhook callback pattern
- Socket Exhaustion from HttpClient Instantiation
- Use IHttpClientFactory (Recommended)

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
