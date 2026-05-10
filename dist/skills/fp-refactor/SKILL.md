---
name: fp-refactor
description: 'Use when refactoring imperative TypeScript into fp-ts patterns such as Either, TaskEither, Option, Reader, traversal, and composable pipelines.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/fp-refactor/SKILL.md'
  imported_at: '2026-05-09'
---

# Refactoring Imperative Code to fp-ts

Refactor existing imperative TypeScript toward fp-ts without turning the codebase into a puzzle. Use this entrypoint to choose the right functional pattern, then load the full guidance for detailed before-and-after examples.

## When to Use

- Converting try/catch, thrown errors, Promise chains, callbacks, null checks, loops, or service classes into fp-ts equivalents.

- Planning a gradual fp-ts migration across module boundaries or data access layers.

- Reviewing whether a proposed functional refactor improves type safety, composition, and testability.

## When Not to Use

- The code is trivial, stable, and clearer without fp-ts.

- The hot path is performance-critical and allocation-heavy abstractions would hurt measurable performance.

- The team maintaining the code does not understand fp-ts and there is no migration/training plan.

## Core Workflow

1. Identify the current imperative pain: exceptions, nullable values, async composition, callbacks, loops, or dependency injection.

2. Refactor at the boundary first so types advertise failure, absence, async work, or dependency requirements explicitly.

3. Convert sync failures to Either, async failures to TaskEither, nullable values to Option, callbacks to Task, and injected services to Reader when the added structure pays for itself.

4. Use pipe, map, chain/flatMap, traverse, and sequence to compose operations without nesting.

5. Add tests around behavior before and after the refactor, especially left/error cases and None/empty paths.

6. Stop refactoring where the functional version becomes less readable than the imperative original.

## Reference Map

Read `references/full-guidance.md` when the task needs the complete examples and edge cases. It includes:

- try/catch to Either/TaskEither, including helper utilities and async examples.

- null/undefined to Option and Option/Either conversion patterns.

- callbacks to Task, class-based dependency injection to Reader, and loop refactors to map/filter/reduce/flatMap.

- Promise chains, Promise.all/race migration, common pitfalls, gradual adoption strategy, and when not to refactor.

## Safety and Quality Rules

- Do not mix async/await and TaskEither in ways that hide errors outside the type system.

- Do not erase useful error details when mapping thrown exceptions into typed errors.

- Avoid broad rewrites; migrate one boundary or module at a time and keep bridge functions for callers.

## Progressive Loading

Start with this entrypoint for routing and planning. Load `references/full-guidance.md` only after the task clearly requires deep implementation detail, code examples, validation checklists, or troubleshooting guidance.
