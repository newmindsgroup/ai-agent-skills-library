---
name: scientific-writing
description: 'This is the core skill for the deep research and writing tool—combining AI-driven deep research with well-formatted written outputs. Every document produced is backed by comprehensive literature search and verified citations through the research-lookup skill.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/scientific-writing/SKILL.md'
  imported_at: '2026-05-09'
---

# Scientific Writing

This is the core skill for the deep research and writing tool—combining AI-driven deep research with well-formatted written outputs. Every document produced is backed by comprehensive literature search and verified citations through the research-lookup skill.

## When to Use
- The request matches the skill description: This is the core skill for the deep research and writing tool—combining AI-driven deep research with well-formatted written outputs. Every document produced is backed by comprehensive literature search and verified citations through the research-lookup skill.
- The task needs the implementation patterns, examples, validation checks, or edge cases listed in the topic map.
- The work would benefit from the complete guidance preserved in `references/full-guidance.md`.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Overview
- When to Use This Skill
- Visual Enhancement with Scientific Schematics
- Graphical Abstract (REQUIRED)
- Additional Figures (GENERATE EXTENSIVELY)
- Core Capabilities
- Manuscript Structure and Organization
- Section-Specific Writing Guidance
- Citation and Reference Management
- Figures and Tables
- Reporting Guidelines by Study Type
- Writing Principles and Style
- Writing Process: From Outline to Full Paragraphs
- Professional Report Formatting (Non-Journal Documents)
- Journal-Specific Formatting
- Field-Specific Language and Terminology
- Common Pitfalls to Avoid
- Workflow for Manuscript Development

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
