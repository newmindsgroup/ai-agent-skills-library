---
name: n8n-code-python
description: 'Write Python code in n8n Code nodes. Use when writing Python in n8n, using _input/_json/_node syntax, working with standard library, or need to understand Python limitations in n8n Code nodes.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/n8n-code-python/SKILL.md'
  imported_at: '2026-05-09'
---

# Python Code Node (Beta)

Expert guidance for writing Python code in n8n Code nodes.

## When to Use
- The request matches the skill description: Write Python code in n8n Code nodes. Use when writing Python in n8n, using _input/_json/_node syntax, working with standard library, or need to understand Python limitations in n8n Code nodes.
- The task needs the implementation patterns, examples, validation checks, or edge cases listed in the topic map.
- The work would benefit from the complete guidance preserved in `references/full-guidance.md`.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- ⚠️ Important: JavaScript First
- Quick Start
- Essential Rules
- Mode Selection Guide
- Run Once for All Items (Recommended - Default)
- Run Once for Each Item
- Python Modes: Beta vs Native
- Python (Beta) - Recommended
- Python (Native) (Beta)
- Data Access Patterns
- Pattern 1: _input.all() - Most Common
- Pattern 2: _input.first() - Very Common
- Pattern 3: _input.item - Each Item Mode Only
- Pattern 4: _node - Reference Other Nodes
- Critical: Webhook Data Structure
- Return Format Requirements
- Correct Return Formats
- Incorrect Return Formats

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
