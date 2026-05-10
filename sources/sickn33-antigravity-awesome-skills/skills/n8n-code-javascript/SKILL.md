---
name: n8n-code-javascript
description: 'Write JavaScript code in n8n Code nodes. Use when writing JavaScript in n8n, using $input/$json/$node syntax, making HTTP requests with $helpers, working with dates using DateTime, troubleshooting Code node errors, or choosing between Code node modes.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/n8n-code-javascript/SKILL.md'
  imported_at: '2026-05-09'
---

# JavaScript Code Node

Expert guidance for writing JavaScript code in n8n Code nodes.

## When to Use
- The request matches the skill description: Write JavaScript code in n8n Code nodes. Use when writing JavaScript in n8n, using $input/$json/$node syntax, making HTTP requests with $helpers, working with dates using DateTime, troubleshooting Code node errors, or choosing between Code node modes.
- The task needs the implementation patterns, examples, validation checks, or edge cases listed in the topic map.
- The work would benefit from the complete guidance preserved in `references/full-guidance.md`.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Quick Start
- Essential Rules
- Mode Selection Guide
- Run Once for All Items (Recommended - Default)
- Run Once for Each Item
- Data Access Patterns
- Pattern 1: $input.all() - Most Common
- Pattern 2: $input.first() - Very Common
- Pattern 3: $input.item - Each Item Mode Only
- Pattern 4: $node - Reference Other Nodes
- Critical: Webhook Data Structure
- Return Format Requirements
- Correct Return Formats
- Incorrect Return Formats
- Common Patterns Overview
- Multi-Source Data Aggregation
- Filtering with Regex
- Data Transformation & Enrichment

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
