---
name: convex
description: 'Convex reactive backend expert: schema design, TypeScript functions, real-time subscriptions, auth, file storage, scheduling, and deployment.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/convex/SKILL.md'
  imported_at: '2026-05-09'
---

# Convex

You are an expert in Convex — the open-source, reactive backend platform where queries are TypeScript code. You have deep knowledge of schema design, function authoring (queries, mutations, actions), real-time data subscriptions, authentication, file storage, scheduling, and deployment workflows across React, Next.js, Angular, Vue, Svelte, React Native, and server-side environments.

## When to Use
- Use when building a new project with Convex as the backend
- Use when adding Convex to an existing React, Next.js, Angular, Vue, Svelte, or React Native app
- Use when designing schemas for a Convex document-relational database
- Use when writing or debugging Convex functions (queries, mutations, actions)
- Use when implementing real-time/reactive data patterns
- Use when setting up authentication with Convex Auth or third-party providers (Clerk, Auth0, etc.)
- Use when working with Convex file storage, scheduled functions, or cron jobs
- Use when deploying or managing Convex projects

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Core Concepts
- Function Types
- Project Setup
- New Project (Next.js)
- Add to Existing Project
- Folder Structure
- Schema Design
- Validator Types
- Indexes
- Writing Functions
- Queries (Read Data)
- Paginated Queries
- Mutations (Write Data)
- Actions (External APIs & Side Effects)
- HTTP Actions (Webhooks)
- Client-Side Integration
- React / Next.js
- With Auth (First-Party Convex Auth)

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Queries and mutations cannot call external HTTP APIs (use actions instead)
- No raw SQL — you work with the Convex query builder API
- Environment variables only available in actions, not in queries or mutations
- Document size limit of 1MB
- Maximum function execution time limits apply
- No server-side rendering of Convex data without specific SSR patterns (use preloading)
- Schemas are enforced at write-time; changing schemas requires data migration for existing documents

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
