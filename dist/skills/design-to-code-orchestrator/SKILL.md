---
name: design-to-code-orchestrator
description: 'Use when the user wants to build a screen in Figma, implement from Figma, design this screen, build this page, match code to design, match design to code, or coordinate a hybrid workflow between design artifacts and implementation. Also use when the user asks for both design and code help and the path needs to be chosen explicitly instead of ad hoc.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/design-to-code-orchestrator/SKILL.md'
  imported_at: '2026-05-09'
---

# Design To Code Orchestrator

Use this skill to choose and enforce the right workflow for hybrid design and implementation work.

## Read First

- `/Users/newmindsgroup/.codex/knowledge/visual-core/component-composition-rules.md`
- `/Users/newmindsgroup/.codex/knowledge/design-reviews/design-qa-checklist.md`

## Routing Rules

- If Figma files, Figma URLs, or design artifacts are present or requested, prefer Figma-first:
  - `figma-use`
  - `figma-generate-design`
  - `figma-implement-design`
  - design-system rules where relevant
- If the request starts in code or implementation, prefer code-first:
  - `visual-style-bible`
  - `design-system`
  - `design-qa`
- If the user wants both, choose the primary owner first and document the sequence.

## Workflow

1. Detect artifacts and intent.
2. Choose Figma-first or code-first explicitly.
3. Route to the relevant skills.
4. Ensure a review step exists before calling the work complete.

## Guardrails

- do not leave the workflow choice implicit
- prefer reusable system rules over one-off screen decisions
