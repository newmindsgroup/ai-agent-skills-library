---
name: aws-serverless
description: 'Specialized skill for building production-ready serverless'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/aws-serverless/SKILL.md'
  imported_at: '2026-05-09'
---

# AWS Serverless

Specialized skill for building production-ready serverless applications on AWS. Covers Lambda functions, API Gateway, DynamoDB, SQS/SNS event-driven patterns, SAM/CDK deployment, and cold start optimization.

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
- Lambda Handler Pattern
- Best_practices
- API Gateway Integration Pattern
- Structure
- Api_comparison
- Event-Driven SQS Pattern
- DynamoDB Streams Pattern
- Stream_view_types
- Cold Start Optimization Pattern
- Optimize Package Size
- Use SnapStart (Java/.NET)
- Right-size Memory
- Provisioned Concurrency (when needed)
- Keep Init Light
- Optimization_priority
- SAM Local Development Pattern

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
