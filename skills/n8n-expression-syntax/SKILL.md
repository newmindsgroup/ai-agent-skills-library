---
name: n8n-expression-syntax
description: 'Validate n8n expression syntax and fix common errors. Use when writing n8n expressions, using {{}} syntax, accessing $json/$node variables, troubleshooting expression errors, or working with webhook data in workflows.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/n8n-expression-syntax/SKILL.md'
  imported_at: '2026-05-09'
---

# n8n Expression Syntax

Expert guide for writing correct n8n expressions in workflows.

## When to Use
- You need to write or debug n8n expressions using `{{ ... }}` syntax.
- The task involves `$json`, `$node`, webhook payloads, or expression-related workflow errors.
- You want syntax-correct dynamic values inside n8n nodes and parameters.
- --

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Expression Format
- Core Variables
- $json - Current Node Output
- $node - Reference Other Nodes
- $now - Current Timestamp
- $env - Environment Variables
- 🚨 CRITICAL: Webhook Data Structure
- Webhook Node Output Structure
- Correct Webhook Data Access
- Common Patterns
- Access Nested Fields
- Reference Other Nodes
- Combine Variables
- When NOT to Use Expressions
- ❌ Code Nodes
- ❌ Webhook Paths
- ❌ Credential Fields
- Validation Rules

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
