---
name: fp-backend
description: 'Functional programming patterns for Node.js/Deno backend development using fp-ts, ReaderTaskEither, and functional dependency injection'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/fp-backend/SKILL.md'
  imported_at: '2026-05-09'
---

# fp-ts Backend Patterns

Functional programming patterns for building type-safe, testable backend services using fp-ts.

## When to Use
- You are building or refactoring a Node.js or Deno backend with fp-ts.
- The task involves dependency injection, service composition, or typed backend errors with `ReaderTaskEither`.
- You need functional backend architecture patterns rather than isolated utility snippets.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Core Concepts
- ReaderTaskEither (RTE)
- Service Layer Patterns
- Defining Service Modules
- Composing Services
- Functional Dependency Injection
- Building the Dependency Container
- Running Programs with Dependencies
- Database Operations
- Prisma Wrappers
- Transaction Handling
- Middleware Patterns
- Express Middleware
- Hono Middleware
- Request Context Pattern
- Error Handling Patterns
- Typed Error Hierarchy
- Error Recovery

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
