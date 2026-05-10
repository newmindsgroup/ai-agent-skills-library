---
name: computer-use-agents
description: 'Use when building, reviewing, or hardening AI agents that observe screens and control mouse, keyboard, browser, or desktop environments.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/computer-use-agents/SKILL.md'
  imported_at: '2026-05-09'
---

# Computer Use Agents

Build or review agents that interact with computers through screenshots, vision reasoning, and mouse or keyboard actions. Keep the entrypoint focused on architecture, safety boundaries, and the decision points that determine which deep implementation pattern to load.

## When to Use

- Designing a perception-reasoning-action loop for browser, desktop, or VM control.

- Adding safety controls for autonomous clicking, typing, scrolling, or keyboard use.

- Comparing Anthropic Computer Use, OpenAI CUA/Operator-style flows, browser-use, or Playwright-backed approaches.

- Auditing an existing computer-use agent for sandboxing, step limits, cost limits, and action verification.

## When Not to Use

- A deterministic DOM or API automation path can solve the task with less risk.

- The request requires controlling a real user machine without an explicit sandbox and rollback plan.

- The task is just visual QA or browser testing and does not need an autonomous action loop.

## Core Workflow

1. Clarify the target surface, user goal, allowed actions, credential boundaries, and stop conditions.

2. Choose the narrowest control layer: DOM/API first, browser automation second, full screen control only when required.

3. Implement the observe-plan-act loop with an explicit action schema, max steps, timeouts, and result verification after every important action.

4. Run inside a sandboxed environment with network, filesystem, user, memory, and process limits appropriate to the task.

5. Log screenshots, model decisions, actions, errors, retries, and costs so failures can be replayed and audited.

6. Test in an isolated environment before allowing real accounts, payments, production systems, or destructive actions.

## Reference Map

Read `references/full-guidance.md` when the task needs the complete examples and edge cases. It includes:

- Perception-reasoning-action loop implementation and action schema examples.

- Sandboxed environment, Anthropic Computer Use, browser-use, confirmation, and action-logging patterns.

- Sharp edges around prompt injection, unreliable UI controls, context/cost growth, and running agents on real computers.

- Validation checks for missing sandboxing, absent step limits, root containers, missing seccomp, and no cost tracking.

## Safety and Quality Rules

- Prefer read-only or reversible actions until the agent proves it can observe and verify accurately.

- Require user confirmation for purchases, account changes, destructive operations, credential entry, and external communication.

- Never rely on visual reasoning alone for high-stakes state; verify through DOM, logs, API responses, or screenshots after action.

## Progressive Loading

Start with this entrypoint for routing and planning. Load `references/full-guidance.md` only after the task clearly requires deep implementation detail, code examples, validation checklists, or troubleshooting guidance.
