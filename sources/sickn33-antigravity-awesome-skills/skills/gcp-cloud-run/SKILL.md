---
name: gcp-cloud-run
description: 'Specialized skill for building production-ready serverless'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/gcp-cloud-run/SKILL.md'
  imported_at: '2026-05-09'
---

# GCP Cloud Run

Specialized skill for building production-ready serverless applications on GCP. Covers Cloud Run services (containerized), Cloud Run Functions (event-driven), cold start optimization, and event-driven architecture with Pub/Sub.

## When to Use
- Use this skill when the request clearly matches the capabilities and patterns described above.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Principles
- Patterns
- Cloud Run Service Pattern
- Structure
- Gcloud_deploy
- Cloud Run Functions Pattern
- Cold Start Optimization Pattern
- Enable Startup CPU Boost
- Set Minimum Instances
- Optimize Container Image
- Lazy Initialize Heavy Dependencies
- Increase Memory (More CPU)
- Optimization_impact
- Concurrency Configuration Pattern
- Understanding Concurrency
- Node.js Concurrency
- Python Concurrency with Gunicorn
- Concurrency_guidelines

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
