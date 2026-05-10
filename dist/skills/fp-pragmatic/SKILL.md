---
name: fp-pragmatic
description: 'A practical, jargon-free guide to functional programming - the 80/20 approach that gets results without the academic overhead'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/fp-pragmatic/SKILL.md'
  imported_at: '2026-05-09'
---

# Pragmatic Functional Programming

**Read this first.** This guide cuts through the academic jargon and shows you what actually matters. No category theory. No abstract nonsense. Just patterns that make your code better.

## When to Use
- You want a pragmatic starting point for fp-ts or functional programming in TypeScript.
- The task is exploratory or educational and needs an 80/20 view of what is actually worth adopting.
- You need guidance on when FP helps and when it is better to keep code simple.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- The Golden Rule
- The 80/20 of FP
- Pipe: Chain Operations Clearly
- Option: Handle Missing Values Without null Checks
- Either: Make Errors Explicit
- Map: Transform Without Unpacking
- FlatMap: Chain Operations That Might Fail
- When NOT to Use FP
- Simple Null Checks
- Simple Loops
- Performance-Critical Code
- When Your Team Doesn't Know FP
- Quick Wins: Easy Changes That Improve Code Today
- Replace Nested Ternaries with pipe + fold
- Replace try-catch with tryCatch
- Replace undefined Returns with Option
- Replace Error Strings with Typed Errors
- Use const Assertions for Error Types

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
