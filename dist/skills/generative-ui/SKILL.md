---
name: generative-ui
description: Use when an AI assistant or copilot could answer with interactive forms, tables, charts, filters or cards, or when evaluating or integrating Thesys OpenUI. Ordinary static pages and fixed forms do not require this skill.
metadata:
  version: '0.1.0'
  author: New Minds Group
license: MIT
---

# Generative UI

Version-Timestamp: 2026-10-18 17:40:06 AST

Help an assistant answer through a small, developer-owned component vocabulary.
Reuse the method across projects; keep each project's data, design, inference
and permissions in that project. This skill is original local guidance based on
official SDK documentation. It contains no vendor skill or executable installer.

## Decide whether interaction helps

Identify the user's task and the advantage over text or a fixed interface.
Comparing options, filtering records, exploring a chart and filling a guided form
are useful candidates. Keep brochure pages and ordinary deterministic forms on
their existing stack. Do not add an LLM, migrate frameworks or install packages
merely because this method is available.

For a suitable feature, record the decision and integration boundary in its
existing work packet. The reusable [adoption contract](assets/project-adoption.md)
can fill a missing project record; do not create a competing documentation store.
Assessment alone does not authorize application changes or inference spending.
Existing projects adopt within their next relevant authorized task.

## Build within the existing application

Read [OpenUI integration notes](references/openui.md) when selecting OpenUI.
Recheck versions and compatibility against official sources before installation.

Use existing project components and design tokens where possible. Define a
focused registry with typed, described props; generate the model prompt from
that same registry. Keep the server and client contract synchronized. Preserve
the existing chat stack, approved provider, authentication and data storage.

Start with synthetic fixtures, then one read-only workflow. Measure a user task
against the current interface before expanding. Do not treat a synthetic render
as proof that live inference or a production integration works.

Browser tool handlers may call narrow, authenticated project endpoints. They
contain no secrets, database access or unrestricted CRM/MCP client. Treat model
output and all IDs as untrusted. Enforce tenant scope, input validation and action
allowlists on the server. OpenUI action schema unions do not enforce restrictions
at runtime. Writes need the project's actual authorization, confirmation,
idempotency and audit rules; never run a mutation on render.

## Privacy and verification

Before installing, set `OPENUI_TELEMETRY_DISABLED=1` in project-local and CI
installation environments. Keep hosted Autofix, cloud observability and Gateway
unconfigured unless separately approved for that project's data and billing.
Existing chat subscriptions do not establish API inference entitlement.

React development can auto-load CDN DevTools independently of telemetry. Resolve
that dependency and inspect development-mode network requests from the first
synthetic pilot. Do not call a pilot local-only or private from an env flag alone.

Keep a deterministic text/table fallback. Test incomplete and malformed streams,
retry/cancellation, missing data, unauthorized actions and cross-tenant IDs.
Render desktop/mobile and inspect keyboard, focus, loading, error and empty
states before accepting an application integration. Record actual checks,
network destinations and limitations. Guidance installed, fixture rendered,
live inference verified and application released are separate milestones.
