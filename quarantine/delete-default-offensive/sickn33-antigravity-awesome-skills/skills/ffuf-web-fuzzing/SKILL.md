---
name: ffuf-web-fuzzing
description: 'Expert guidance for ffuf web fuzzing during penetration testing, including authenticated fuzzing with raw requests, auto-calibration, and result analysis'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/ffuf-web-fuzzing/SKILL.md'
  imported_at: '2026-05-09'
---

# FFUF (Fuzz Faster U Fool) Skill

Expert guidance for ffuf web fuzzing during penetration testing, including authenticated fuzzing with raw requests, auto-calibration, and result analysis

## When to Use
- You are fuzzing web targets with `ffuf` during authorized security testing or penetration testing.
- The task involves content discovery, subdomain enumeration, parameter fuzzing, or authenticated request fuzzing.
- You need guidance on wordlists, filtering, calibration, and interpreting ffuf results efficiently.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Overview
- Installation
- Core Concepts
- The FUZZ Keyword
- Multi-wordlist Modes
- Common Use Cases
- Directory and File Discovery
- Subdomain Enumeration
- Parameter Fuzzing
- POST Data Fuzzing
- Header Fuzzing
- Filtering and Matching
- Matchers (Include Results)
- Filters (Exclude Results)
- Auto-Calibration (USE BY DEFAULT!)
- Rate Limiting and Timing
- Rate Control
- Time Limits

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
