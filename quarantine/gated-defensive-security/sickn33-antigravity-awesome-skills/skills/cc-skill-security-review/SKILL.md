---
name: cc-skill-security-review
description: 'This skill ensures all code follows security best practices and identifies potential vulnerabilities. Use when implementing authentication or authorization, handling user input or file uploads, or creating new API endpoints.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/cc-skill-security-review/SKILL.md'
  imported_at: '2026-05-09'
---

# Security Review Skill

This skill ensures all code follows security best practices and identifies potential vulnerabilities.

## When to Use
- Implementing authentication or authorization
- Handling user input or file uploads
- Creating new API endpoints
- Working with secrets or credentials
- Implementing payment features
- Storing or transmitting sensitive data
- Integrating third-party APIs

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Security Checklist
- Secrets Management
- Input Validation
- SQL Injection Prevention
- Authentication & Authorization
- XSS Prevention
- CSRF Protection
- Rate Limiting
- Sensitive Data Exposure
- Blockchain Security (Solana)
- Dependency Security
- Security Testing
- Automated Security Tests
- Pre-Deployment Security Checklist
- Resources

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
