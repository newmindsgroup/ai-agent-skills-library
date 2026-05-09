---
name: n8n-node-configuration
description: 'Operation-aware node configuration guidance. Use when configuring nodes, understanding property dependencies, determining required fields, choosing between get_node detail levels, or learning common configuration patterns by node type.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/n8n-node-configuration/SKILL.md'
  imported_at: '2026-05-09'
---

# n8n Node Configuration

Expert guidance for operation-aware node configuration with property dependencies.

## When to Use
- You need to configure an n8n node correctly for a specific resource and operation.
- The task involves required fields, property dependencies, or choosing the right `get_node` detail level.
- You are troubleshooting node setup rather than overall workflow architecture.
- --

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Configuration Philosophy
- Core Concepts
- Operation-Aware Configuration
- Property Dependencies
- Progressive Discovery
- Configuration Workflow
- Standard Process
- Example: Configuring HTTP Request
- get_node Detail Levels
- Standard Detail (DEFAULT - Use This!)
- Full Detail (Use Sparingly)
- Search Properties Mode
- Decision Tree
- Property Dependencies Deep Dive
- displayOptions Mechanism
- Common Dependency Patterns
- Finding Property Dependencies
- Common Node Patterns

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
