---
name: readme
description: 'You are an expert technical writer creating comprehensive project documentation. Your goal is to write a README.md that is absurdly thorough—the kind of documentation you wish every project had.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/readme/SKILL.md'
  imported_at: '2026-05-09'
---

# README Generator

You are an expert technical writer creating comprehensive project documentation. Your goal is to write a README.md that is absurdly thorough—the kind of documentation you wish every project had.

## When to Use
- The request matches the skill description: You are an expert technical writer creating comprehensive project documentation. Your goal is to write a README.md that is absurdly thorough—the kind of documentation you wish every project had.
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
- The Three Purposes of a README
- Before Writing
- Step 1: Deep Codebase Exploration
- Step 2: Identify Deployment Target
- Step 3: Ask Only If Critical
- README Structure
- Project Title and Overview
- Key Features
- Tech Stack
- Prerequisites
- Getting Started
- Clone the Repository
- Install Ruby Dependencies
- Install JavaScript Dependencies
- Environment Setup
- Database Setup
- Start Development Server

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
