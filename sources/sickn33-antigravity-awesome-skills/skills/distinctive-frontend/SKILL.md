---
name: distinctive-frontend
description: 'Provides the distinctive-frontend workflow for agent-assisted work. Use when the user''s request matches this skill''s domain or trigger language.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/distinctive-frontend/SKILL.md'
  imported_at: '2026-05-09'
---

# Distinctive Frontend Design

Create visually distinctive, high-impact frontend interfaces that avoid generic "AI slop" aesthetics. This skill applies the four-vector approach: typography, color/theme, motion, and backgrounds.

## When to Use
- The request matches the skill description: Provides the distinctive-frontend workflow for agent-assisted work. Use when the user's request matches this skill's domain or trigger language.
- The task needs the implementation patterns, examples, validation checks, or edge cases listed in the topic map.
- The work would benefit from the complete guidance preserved in `references/full-guidance.md`.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Core Principles
- Typography - Use Extremes
- Font Weight Strategy
- Font Pairing
- Implementation Pattern
- Color & Theme - Commit to Cohesion
- Strategy
- Theme Examples
- Application Pattern
- Motion - Orchestrated Page Load
- Implementation Patterns
- React/JavaScript Pattern
- Backgrounds - Atmospheric Depth
- Gradient Patterns
- Workflow: Building a Distinctive Interface
- Choose Your Aesthetic Reference
- Set Up Design Tokens
- Apply All Four Dimensions

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
