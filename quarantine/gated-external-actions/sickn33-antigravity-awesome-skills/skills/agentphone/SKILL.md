---
name: agentphone
description: 'Build AI phone agents with AgentPhone API. Use when the user wants to make phone calls, send/receive SMS, manage phone numbers, create voice agents, set up webhooks, or check usage — anything related to telephony, phone numbers, or voice AI.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/agentphone/SKILL.md'
  imported_at: '2026-05-09'
---

# AgentPhone

AgentPhone is an API-first telephony platform for AI agents. Give your agents phone numbers, voice calls, and SMS — all managed through a simple API.

## When to Use
- Use when the user wants to create or manage AI phone agents, voice agents, or telephony automations
- Use when the user needs to buy, assign, release, or inspect phone numbers tied to an agent workflow
- Use when the user wants to place outbound calls, inspect transcripts, or send and receive SMS through AgentPhone
- Use when the user is configuring webhooks, hosted voice mode, or account-level usage for AgentPhone
- Use only with explicit user intent before actions that spend money, send messages, place calls, or release phone numbers
- *Base URL:** `https://api.agentphone.to/v1`
- *Docs:** [docs.agentphone.to](https://docs.agentphone.to)
- *Console:** [agentphone.to](https://agentphone.to)
- --

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- How It Works
- Voice Modes
- Quick Start
- Step 1: Get Your API Key
- Step 2: Create an Agent
- Step 3: Buy a Phone Number
- Step 4: Make an Outbound Call
- Step 5: Check the Transcript
- Rules
- Security
- Phone Number Format
- Confirm Before Destructive Actions
- Best Practices
- Authentication
- API Reference
- Account
- Agents
- Phone Numbers

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
