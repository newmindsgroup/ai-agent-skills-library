---
name: n8n-mcp-tools-expert
description: 'Expert guide for using n8n-mcp MCP tools effectively. Use when searching for nodes, validating configurations, accessing templates, managing workflows, or using any n8n-mcp tool. Provides tool selection guidance, parameter formats, and common patterns.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/n8n-mcp-tools-expert/SKILL.md'
  imported_at: '2026-05-09'
---

# n8n MCP Tools Expert

Master guide for using n8n-mcp MCP server tools to build workflows.

## When to Use
- You are using the `n8n-mcp` toolset to discover nodes, validate configs, or manage workflows.
- The task involves choosing the right MCP tool or understanding its expected parameters and usage pattern.
- You need guidance on workflow creation or editing through n8n MCP rather than through the n8n UI alone.
- --

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Tool Categories
- Quick Reference
- Most Used Tools (by success rate)
- Tool Selection Guide
- Finding the Right Node
- Validating Configuration
- Managing Workflows
- Critical: nodeType Formats
- Format 1: Search/Validate Tools
- Format 2: Workflow Tools
- Conversion
- Common Mistakes
- Mistake 1: Wrong nodeType Format
- Mistake 2: Using detail="full" by Default
- Mistake 3: Not Using Validation Profiles
- Mistake 4: Ignoring Auto-Sanitization
- Mistake 5: Not Using Smart Parameters
- Mistake 6: Not Using intent Parameter

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
