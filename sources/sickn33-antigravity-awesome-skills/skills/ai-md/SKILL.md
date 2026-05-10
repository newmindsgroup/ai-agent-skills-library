---
name: ai-md
description: 'Convert human-written CLAUDE.md into AI-native structured-label format. Battle-tested across 4 models. Same rules, fewer tokens, higher compliance.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/ai-md/SKILL.md'
  imported_at: '2026-05-09'
---

# AI.MD v4 — The Complete AI-Native Conversion System

Convert human-written CLAUDE.md into AI-native structured-label format. Battle-tested across 4 models. Same rules, fewer tokens, higher compliance.

## When to Use
- The request matches the skill description: Convert human-written CLAUDE.md into AI-native structured-label format. Battle-tested across 4 models. Same rules, fewer tokens, higher compliance.
- The task needs the implementation patterns, examples, validation checks, or edge cases listed in the topic map.
- The work would benefit from the complete guidance preserved in `references/full-guidance.md`.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- When to Use This Skill
- What Is AI.MD?
- Why It Works: How LLMs Actually Process Instructions
- Mechanism 1: Attention Splitting
- Mechanism 2: Zero-Inference Labels
- Mechanism 3: Semantic Anchoring
- The Conversion Process: What Happens When You Give Me a CLAUDE.md
- Phase 1: UNDERSTAND — Read Like a Compiler, Not a Human
- Phase 2: DECOMPOSE — Break Every `|` and `()` Into Atomic Rules
- Phase 3: LABEL — Assign Function Labels
- Phase 4: STRUCTURE — Build the Architecture
- Phase 5: RESOLVE — Handle Conflicts and Edge Cases
- Phase 6: TEST — Multi-Model Validation (Non-Negotiable)
- Special Techniques Discovered During Battle-Testing
- Technique 1: Bilingual Label Strategy
- Technique 2: State Machine Gates
- Technique 3: XML Section Tags for Semantic Boundaries
- Technique 4: Cross-Reference Instead of Duplicate

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
