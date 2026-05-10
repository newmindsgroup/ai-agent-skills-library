---
name: shopify-apps
description: 'Use when building or auditing Shopify apps with React Router/Remix, App Bridge, Admin GraphQL, Polaris, webhooks, billing, or app extensions.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/shopify-apps/SKILL.md'
  imported_at: '2026-05-09'
---

# Shopify Apps

Build Shopify apps with modern embedded-app architecture, App Bridge, React Router/Remix conventions, Admin GraphQL, Polaris, billing, webhooks, and extensions. Treat platform requirements, secrets, rate limits, and App Store review constraints as part of the implementation, not cleanup.

## When to Use

- Starting or modifying a Shopify embedded app, admin surface, app extension, billing flow, or webhook pipeline.

- Using Shopify Admin GraphQL, Polaris, App Bridge, session storage, or protected customer data.

- Reviewing code for Shopify platform pitfalls such as duplicate webhook registration, REST usage, missing GDPR webhooks, or synchronous webhook work.

## When Not to Use

- The task is a storefront theme-only change with no app backend, Admin API, extension, or embedded admin surface.

- The request depends on protected customer data without approved access and graceful fallback behavior.

- The app would store sessions in memory or expose Shopify secrets to client code.

## Core Workflow

1. Confirm the app surface: embedded admin app, extension, webhook handler, billing, GraphQL integration, or protected-data flow.

2. Set up server-side authentication, durable session storage, environment secrets, App Bridge, and Polaris before building feature screens.

3. Prefer Admin GraphQL for new work and design around rate limits, bulk operations, and retry behavior.

4. Configure webhooks in `shopify.app.toml`, validate HMAC/signatures, respond within five seconds, and process slow work asynchronously.

5. Implement required GDPR and compliance handlers even when the app stores minimal data.

6. Test install, auth callback, embedded loading, webhook delivery, billing states, extension deployment, and App Store review checks.

## Reference Map

Read `references/full-guidance.md` when the task needs the complete examples and edge cases. It includes:

- React Router app setup, embedded App Bridge layout, webhook handling, GraphQL Admin API, billing, and app-extension templates.

- Sharp edges for five-second webhooks, API rate limits, protected customer data, duplicate webhooks, trailing slashes, REST migration, App Bridge, and GDPR handlers.

- Validation checks for hardcoded Shopify secrets, missing HMAC, synchronous webhooks, REST API usage, in-memory sessions, and missing session validation.

## Safety and Quality Rules

- Never expose Shopify API secret, access tokens, or session data to client code.

- Do not rely on in-memory session storage outside throwaway local development.

- Treat webhook validation and async processing as required production behavior.

## Progressive Loading

Start with this entrypoint for routing and planning. Load `references/full-guidance.md` only after the task clearly requires deep implementation detail, code examples, validation checklists, or troubleshooting guidance.
