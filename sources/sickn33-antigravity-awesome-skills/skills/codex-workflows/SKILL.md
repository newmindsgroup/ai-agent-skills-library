---
name: codex-workflows
description: 'Codex-first workflow orchestration for multi-phase tasks such as planning, building, debugging, testing, and shipping.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/codex-workflows/SKILL.md'
  imported_at: '2026-05-09'
---

# Codex Workflows

Use this skill when the user wants a guided multi-step workflow instead of a single isolated skill.

## Good Fits

- Plan -> build -> test -> verify
- Audit -> fix -> validate
- Research -> implement -> review
- Large requests where checkpoints help

## How to Run

1. Identify the user’s concrete outcome.
2. Propose the most relevant workflow shape.
3. Pick the right skills for each phase.
4. Execute one phase at a time.
5. Verify each major phase before moving on.

## Default Phase Mapping

- Discovery and shaping: `brainstorming` or `skill-router`
- Task planning: `concise-planning` or `writing-plans`
- Build or fix: most specific domain skill available
- Debugging: `systematic-debugging`
- Test-first implementation: `test-driven-development`
- Final validation: `verification-before-completion`

## Notes

This local alias exists to provide a Codex-branded workflow entry point even though some upstream skills use different branding.
