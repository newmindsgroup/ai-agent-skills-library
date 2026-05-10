---
name: graphql
description: 'GraphQL gives clients exactly the data they need - no more, no'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/graphql/SKILL.md'
  imported_at: '2026-05-09'
---

# GraphQL

GraphQL gives clients exactly the data they need - no more, no less. One endpoint, typed schema, introspection. But the flexibility that makes it powerful also makes it dangerous. Without proper controls, clients can craft queries that bring down your server.

This skill covers schema design, resolvers, DataLoader for N+1 prevention, federation for microservices, and client integration with Apollo/urql. Key insight: GraphQL is a contract. The schema is the API documentation. Design it carefully.

2025 lesson: GraphQL isn't always the answer. For simple CRUD, REST is simpler. For high-performance public APIs, REST with caching wins. Use GraphQL when you have complex data relationships and...

## When to Use
- User mentions or implies: graphql
- User mentions or implies: graphql schema
- User mentions or implies: graphql resolver
- User mentions or implies: apollo server
- User mentions or implies: apollo client
- User mentions or implies: graphql federation
- User mentions or implies: dataloader
- User mentions or implies: graphql codegen
- User mentions or implies: graphql query
- User mentions or implies: graphql mutation

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Principles
- Capabilities
- Scope
- Tooling
- Server
- Client
- Tools
- Patterns
- Schema Design
- DataLoader for N+1 Prevention
- Apollo Client Caching
- Code Generation
- Error Handling with Unions
- Sharp Edges
- Each resolver makes separate database queries
- Deeply nested queries can DoS your server
- Introspection enabled in production exposes your schema
- Authorization only in schema directives, not resolvers

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
