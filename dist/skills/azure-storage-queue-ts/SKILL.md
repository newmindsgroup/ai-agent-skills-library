---
name: azure-storage-queue-ts
description: 'Azure Queue Storage JavaScript/TypeScript SDK (@azure/storage-queue) for message queue operations. Use for sending, receiving, peeking, and deleting messages in queues.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/azure-storage-queue-ts/SKILL.md'
  imported_at: '2026-05-09'
---

# @azure/storage-queue (TypeScript/JavaScript)

SDK for Azure Queue Storage operations — send, receive, peek, and manage messages in queues.

## When to Use
- This skill is applicable to execute the workflow or actions described in the overview.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Installation
- Environment Variables
- Authentication
- DefaultAzureCredential (Recommended)
- Connection String
- StorageSharedKeyCredential (Node.js only)
- SAS Token
- Client Hierarchy
- Queue Operations
- Create Queue
- List Queues
- Delete Queue
- Get Queue Properties
- Set Queue Metadata
- Message Operations
- Send Message
- Receive Messages
- Peek Messages

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
