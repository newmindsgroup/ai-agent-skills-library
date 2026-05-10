---
name: fp-data-transforms
description: 'Use when transforming TypeScript arrays, objects, grouped data, API responses, aggregations, or nested nullable values with practical functional patterns.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/fp-data-transforms/SKILL.md'
  imported_at: '2026-05-09'
---

# Practical Data Transformations

Use functional TypeScript patterns for everyday data reshaping: arrays, objects, normalized API state, grouping, aggregation, and null-safe access. Prefer clear native methods for simple cases and reach for fp-ts where composition, absence, or typed failure matters.

## When to Use

- Transforming arrays, object shapes, API responses, grouped records, aggregates, or nested optional data.

- Replacing verbose loops with map, filter, reduce, flatMap, grouping utilities, or small reusable predicates.

- Deciding whether native JavaScript methods, custom helpers, or fp-ts abstractions are the right fit.

## When Not to Use

- A simple direct loop is clearer and the transformation is not reused or composed.

- The transformation is performance-critical and should be benchmarked before introducing extra abstractions.

- The task requires fp-ts error modeling rather than data reshaping; use `fp-refactor` or fp-ts error-handling guidance instead.

## Core Workflow

1. Name the input shape, output shape, and the invariant the transform must preserve.

2. Choose the smallest clear primitive: map for one-to-one, filter for selection, reduce for accumulation, flatMap for flattening, and grouping helpers for indexes.

3. Extract predicates, mappers, and reducers into named functions when they are reused or hide business meaning.

4. Normalize API responses into app state before rendering so UI code stays simple.

5. Use Option or safe-access helpers when absence is expected and must be composed.

6. Add table-style tests that cover empty inputs, missing fields, duplicate keys, nullish values, and representative real-world payloads.

## Reference Map

Read `references/full-guidance.md` when the task needs the complete examples and edge cases. It includes:

- Array operations: map, filter, reduce, chaining, and fp-ts Array examples.

- Object transformations: pick, omit, merge, deep merge, and immutable nested updates.

- Data normalization, grouping, aggregation, null-safe access, and real-world examples.

- Guidance on when to use native methods, fp-ts, custom utilities, and performance-conscious alternatives.

## Safety and Quality Rules

- Avoid clever point-free code when named functions would make business intent clearer.

- Preserve input immutability unless mutation is intentionally contained and documented.

- Handle missing, null, duplicate, and empty cases explicitly before shipping transforms into UI or reporting code.

## Progressive Loading

Start with this entrypoint for routing and planning. Load `references/full-guidance.md` only after the task clearly requires deep implementation detail, code examples, validation checklists, or troubleshooting guidance.
