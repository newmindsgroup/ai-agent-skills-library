---
name: workflow-automation
description: 'Workflow automation is the infrastructure that makes AI agents'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/workflow-automation/SKILL.md'
  imported_at: '2026-05-09'
---

# Workflow Automation

Workflow automation is the infrastructure that makes AI agents reliable. Without durable execution, a network hiccup during a 10-step payment flow means lost money and angry customers. With it, workflows resume exactly where they left off.

This skill covers the platforms (n8n, Temporal, Inngest) and patterns (sequential, parallel, orchestrator-worker) that turn brittle scripts into production-grade automation.

Key insight: The platforms make different tradeoffs. n8n optimizes for accessibility, Temporal for correctness, Inngest for developer experience. Pick based on your actual needs, not hype.

## When to Use
- User mentions or implies: workflow
- User mentions or implies: automation
- User mentions or implies: n8n
- User mentions or implies: temporal
- User mentions or implies: inngest
- User mentions or implies: step function
- User mentions or implies: background job
- User mentions or implies: durable execution
- User mentions or implies: event-driven
- User mentions or implies: scheduled task

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
- Platforms
- Patterns
- Sequential Workflow Pattern
- Inngest Example (TypeScript)
- Temporal Example (TypeScript)
- n8n Pattern
- Parallel Workflow Pattern
- Inngest Example
- AWS Step Functions (Amazon States Language)
- Orchestrator-Worker Pattern
- Temporal Example
- Inngest with AI Orchestration
- Event-Driven Trigger Pattern
- Inngest Event-Based

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
