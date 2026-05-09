---
name: salesforce-development
description: 'Expert patterns for Salesforce platform development including'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/salesforce-development/SKILL.md'
  imported_at: '2026-05-09'
---

# Salesforce Development

Expert patterns for Salesforce platform development including Lightning Web Components (LWC), Apex triggers and classes, REST/Bulk APIs, Connected Apps, and Salesforce DX with scratch orgs and 2nd generation packages (2GP).

## When to Use
- User mentions or implies: salesforce
- User mentions or implies: sfdc
- User mentions or implies: apex
- User mentions or implies: lwc
- User mentions or implies: lightning web components
- User mentions or implies: sfdx
- User mentions or implies: scratch org
- User mentions or implies: visualforce
- User mentions or implies: soql
- User mentions or implies: governor limits

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Patterns
- Lightning Web Component with Wire Service
- Context
- Bulkified Apex Trigger with Handler Pattern
- Queueable Apex for Async Processing
- REST API Integration with Connected App
- Bulk API 2.0 for Large Data Operations
- Salesforce DX with Scratch Orgs
- 2nd Generation Package (2GP) Development
- Sharp Edges
- Governor Limits Apply Per Transaction, Not Per Record
- @wire Results Are Cached and May Be Stale
- LWC Properties Are Case-Sensitive
- Null Pointer Exceptions in Apex Collections
- Trigger Recursion Causes Infinite Loops
- Cannot Make Callouts from Synchronous Triggers
- Cannot Mix Setup and Non-Setup DML
- Dynamic SOQL Is Vulnerable to Injection

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
