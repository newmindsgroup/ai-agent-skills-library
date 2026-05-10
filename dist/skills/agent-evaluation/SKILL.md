---
name: agent-evaluation
description: 'Testing and benchmarking LLM agents including behavioral testing,'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/agent-evaluation/SKILL.md'
  imported_at: '2026-05-09'
---

# Agent Evaluation

Testing and benchmarking LLM agents including behavioral testing, capability assessment, reliability metrics, and production monitoring—where even top agents achieve less than 50% on real-world benchmarks

## When to Use
- User mentions or implies: agent testing
- User mentions or implies: agent evaluation
- User mentions or implies: benchmark agents
- User mentions or implies: agent reliability
- User mentions or implies: test agent

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
- Alternatives
- Deprecated
- Patterns
- Statistical Test Evaluation
- Behavioral Contract Testing
- Adversarial Testing
- Regression Testing Pipeline
- Sharp Edges
- Agent scores well on benchmarks but fails in production
- Same test passes sometimes, fails other times
- Agent optimized for metric, not actual task
- Test data accidentally used in training or prompts
- Delegation Triggers

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
