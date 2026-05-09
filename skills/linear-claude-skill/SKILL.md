---
name: linear-claude-skill
description: 'Manage Linear issues, projects, and teams'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/linear-claude-skill/SKILL.md'
  imported_at: '2026-05-09'
---

# Linear

Tools and workflows for managing issues, projects, and teams in Linear.

## When to Use
- The request matches the skill description: Manage Linear issues, projects, and teams
- The task needs the implementation patterns, examples, validation checks, or edge cases listed in the topic map.
- The work would benefit from the complete guidance preserved in `references/full-guidance.md`.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- When to Use This Skill
- ⚠️ Tool Availability (READ FIRST)
- 🔐 Security: Varlock Integration
- Safe Commands (Always Use)
- Unsafe Commands (NEVER Use)
- Setup for New Projects
- Quick Start (First-Time Users)
- Check Your Setup
- Get API Key (If Needed)
- Test Connection
- Common Operations
- Project Planning Workflow
- Create Issues in the Correct Project from the Start
- Project Management Commands
- project-status
- link-initiative
- unlink-initiative
- Complete Project Lifecycle Example

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
