---
name: vercel-deployment
description: 'Expert knowledge for deploying to Vercel with Next.js'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/vercel-deployment/SKILL.md'
  imported_at: '2026-05-09'
---

# Vercel Deployment

Expert knowledge for deploying to Vercel with Next.js

## When to Use
- User mentions or implies: vercel
- User mentions or implies: deploy
- User mentions or implies: deployment
- User mentions or implies: hosting
- User mentions or implies: production
- User mentions or implies: environment variables
- User mentions or implies: edge function
- User mentions or implies: serverless function

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Capabilities
- Prerequisites
- Patterns
- Environment Variables Setup
- Edge vs Serverless Functions
- Build Optimization
- Preview Deployment Workflow
- Custom Domain Setup
- Sharp Edges
- NEXT_PUBLIC_ exposes secrets to the browser
- Preview deployments using production database
- Serverless function too large, slow cold starts
- Edge runtime missing Node.js APIs
- Function timeout causes incomplete operations
- Environment variable missing at runtime but present at build
- CORS errors calling API routes from different domain
- Page shows stale data after deployment
- Validation Checks

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
