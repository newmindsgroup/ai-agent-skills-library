---
name: neon-postgres
description: 'Expert patterns for Neon serverless Postgres, branching, connection'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/neon-postgres/SKILL.md'
  imported_at: '2026-05-09'
---

# Neon Postgres

Expert patterns for Neon serverless Postgres, branching, connection pooling, and Prisma/Drizzle integration

## When to Use
- User mentions or implies: neon database
- User mentions or implies: serverless postgres
- User mentions or implies: database branching
- User mentions or implies: neon postgres
- User mentions or implies: postgres serverless
- User mentions or implies: connection pooling
- User mentions or implies: preview environments
- User mentions or implies: database per preview

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Patterns
- Prisma with Neon Connection
- Code_example
- Anti_patterns
- References
- Drizzle with Neon Serverless Driver
- Connection Pooling with PgBouncer
- Database Branching for Development
- Vercel Preview Environment Integration
- Autoscaling and Cold Start Management
- Sharp Edges
- Cold Start Latency After Scale-to-Zero
- Using Pooled Connection for Migrations
- Connection Pool Exhaustion in Serverless
- PgBouncer Feature Limitations
- Branch Storage Accumulation
- Reserved Connections Reduce Available Pool
- HTTP Driver Doesn't Support Transactions

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
