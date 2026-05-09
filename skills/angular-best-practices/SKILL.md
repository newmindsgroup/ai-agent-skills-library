---
name: angular-best-practices
description: 'Angular performance optimization and best practices guide. Use when writing, reviewing, or refactoring Angular code for optimal performance, bundle size, and rendering efficiency.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/angular-best-practices/SKILL.md'
  imported_at: '2026-05-09'
---

# Angular Best Practices

Comprehensive performance optimization guide for Angular applications. Contains prioritized rules for eliminating performance bottlenecks, optimizing bundles, and improving rendering.

## When to Use
- Reference these guidelines when:
- Writing new Angular components or pages
- Implementing data fetching patterns
- Reviewing code for performance issues
- Refactoring existing Angular code
- Optimizing bundle size or load times
- Configuring SSR/hydration
- --

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Rule Categories by Priority
- Change Detection (CRITICAL)
- Use OnPush Change Detection
- Prefer Signals Over Mutable Properties
- Enable Zoneless for New Projects
- Async Operations & Waterfalls (CRITICAL)
- Eliminate Sequential Data Fetching
- Avoid Client-Side Waterfalls in SSR
- Bundle Optimization (CRITICAL)
- Lazy Load Routes
- Use @defer for Heavy Components
- Avoid Barrel File Re-exports
- Dynamic Import Third-Party Libraries
- Rendering Performance (HIGH)
- Always Use trackBy with @for
- Use Virtual Scrolling for Large Lists
- Prefer Pure Pipes Over Methods
- Use computed() for Derived Data

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
