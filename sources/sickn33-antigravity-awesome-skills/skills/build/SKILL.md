---
name: build
description: 'Provides the build workflow for agent-assisted work. Use when the user''s request matches this skill''s domain or trigger language.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/build/SKILL.md'
  imported_at: '2026-05-09'
---

# {Feature Name} Research

Provides the build workflow for agent-assisted work. Use when the user's request matches this skill's domain or trigger language.

## When to Use
- You need a structured workflow for building a major feature across research, planning, implementation, and tracking.
- The task involves moving a feature through named phases such as `research`, `implementation`, `progress`, or `phase`.
- You want one command to coordinate status, next steps, and phased delivery for a feature effort.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Instructions
- Argument Parsing
- Subcommand: Help (empty args)
- Subcommand: research
- Step 1: Get Feature Name
- Step 2: Check for Existing Research
- Step 3: Gather Feature Context
- Step 4: Research Scope
- Step 5: Conduct Deep Research
- Step 6: Write Research Document
- Overview
- Problem Statement
- User Stories / Use Cases
- Technical Research
- Approach Options
- Recommended Approach
- Required Technologies
- Data Requirements

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
