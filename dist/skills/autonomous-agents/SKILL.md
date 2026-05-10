---
name: autonomous-agents
description: 'Autonomous agents are AI systems that can independently decompose'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/autonomous-agents/SKILL.md'
  imported_at: '2026-05-09'
---

# Autonomous Agents

Autonomous agents are AI systems that can independently decompose goals, plan actions, execute tools, and self-correct without constant human guidance. The challenge isn't making them capable - it's making them reliable. Every extra decision multiplies failure probability.

This skill covers agent loops (ReAct, Plan-Execute), goal decomposition, reflection patterns, and production reliability. Key insight: compounding error rates kill autonomous agents. A 95% success rate per step drops to 60% by step 10. Build for reliability first, autonomy second.

2025 lesson: The winners are constrained, domain-specific agents with clear boundaries, not "autonomous everything." Treat AI outputs as...

## When to Use
- User mentions or implies: autonomous agent
- User mentions or implies: autogpt
- User mentions or implies: babyagi
- User mentions or implies: self-prompting
- User mentions or implies: goal decomposition
- User mentions or implies: react pattern
- User mentions or implies: agent loop
- User mentions or implies: self-correcting agent
- User mentions or implies: reflection agent
- User mentions or implies: langgraph

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Principles
- Capabilities
- Scope
- Tooling
- Frameworks
- Patterns
- ReAct Agent Loop
- Basic ReAct Implementation
- LangGraph ReAct (Production)
- Plan-Execute Pattern
- LangGraph Plan-Execute
- Decomposition Strategies
- Reflection Pattern
- Basic Reflection
- LangGraph Reflection
- Separate Evaluator (More Robust)
- Guardrailed Autonomy
- Multi-Layer Guardrails

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
