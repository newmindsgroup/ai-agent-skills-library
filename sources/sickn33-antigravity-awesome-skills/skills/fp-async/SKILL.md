---
name: fp-async
description: 'Practical async patterns using TaskEither - clean pipelines instead of try/catch hell, with real API examples'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/fp-async/SKILL.md'
  imported_at: '2026-05-09'
---

# Practical Async Patterns with fp-ts

Stop writing nested try/catch blocks. Stop losing error context. Start building clean async pipelines that handle errors properly.

**TaskEither is simply an async operation that tracks success or failure.** That's it. No fancy terminology needed.

## When to Use
- You need async error handling in TypeScript with `TaskEither`.
- The task involves wrapping Promises, composing API calls, or replacing nested `try/catch` flows.
- You want practical fp-ts async patterns instead of academic explanations.
- ```typescript
- // TaskEither<Error, User> means:
- // "An async operation that either fails with Error or succeeds with User"
- ```
- --

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Wrapping Promises Safely
- The Problem: Try/Catch Everywhere
- The Solution: Wrap Once, Handle Cleanly
- tryCatch Explained
- Creating Success and Failure Values
- Chaining Async Operations
- The Problem: Callback Hell / Nested Awaits
- The Solution: Clean Pipelines with chain
- chain vs map
- Building Context with Do Notation
- Parallel vs Sequential Execution
- When to Use Each
- Sequential Chaining
- Parallel Execution
- Parallel Array Operations
- Parallel with Batch Control
- Sequential When Parallel Looks Tempting
- Error Recovery Patterns

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
