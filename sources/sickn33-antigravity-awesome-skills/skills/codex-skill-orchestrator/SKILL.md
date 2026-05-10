---
name: codex-skill-orchestrator
description: 'A Codex-first meta-skill that evaluates task complexity, selects the minimal useful skill set, and avoids unnecessary skill usage for simple work.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/codex-skill-orchestrator/SKILL.md'
  imported_at: '2026-05-09'
---

# Codex Skill Orchestrator

Use this skill when a task is complex, multi-step, or clearly spans multiple domains and you want Codex to choose a minimal, sensible set of installed skills.

## When to Use

- The user wants the best combination of skills for a large task
- The request spans planning, implementation, testing, and verification
- The right skill is not obvious from the request alone
- You want a Codex-first orchestration layer instead of relying on upstream branding

## Core Rules

1. Check complexity first. If the task is simple, do the work directly without orchestrating skills.
2. Prefer the smallest skill set that covers the task.
3. Use one primary skill whenever possible.
4. Add another skill only when it covers a distinct phase or domain.
5. Search the installed Codex skill library before assuming no relevant skill exists.

## Routing

- Vague or exploratory request: use `skill-router`
- Planning-heavy request: use `brainstorming`, `concise-planning`, or `writing-plans`
- Debugging-heavy request: use `systematic-debugging`
- Implementation with tests: use the most specific domain skill, then `test-driven-development` if appropriate
- Final validation: use `verification-before-completion`

## Process

1. Evaluate whether the task is simple or complex.
2. Search the local installed skills by name and frontmatter when the best fit is not obvious.
3. Select the minimal useful combination.
4. Execute in order, announcing the current phase when helpful.
5. Verify outcomes before claiming completion.

## Limitation

This is a local Codex alias skill for orchestration. It is meant to keep the local setup understandable and Codex-branded.
