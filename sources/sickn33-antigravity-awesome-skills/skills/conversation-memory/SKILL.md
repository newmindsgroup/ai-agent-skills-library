---
name: conversation-memory
description: 'Persistent memory systems for LLM conversations including'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/conversation-memory/SKILL.md'
  imported_at: '2026-05-09'
---

# Conversation Memory

Persistent memory systems for LLM conversations including short-term, long-term, and entity-based memory

## When to Use
- User mentions or implies: conversation memory
- User mentions or implies: remember
- User mentions or implies: memory persistence
- User mentions or implies: long-term memory
- User mentions or implies: chat history

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Capabilities
- Prerequisites
- Scope
- Ecosystem
- Primary_tools
- Patterns
- Tiered Memory System
- Entity Memory
- Memory-Aware Prompting
- User Context
- Recent Conversation
- Current Query
- Sharp Edges
- Memory store grows unbounded, system slows
- Retrieved memories not relevant to current query
- Memories from one user accessible to another
- Validation Checks
- No User Isolation in Memory

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
