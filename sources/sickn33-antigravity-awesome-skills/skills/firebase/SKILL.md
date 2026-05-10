---
name: firebase
description: 'Firebase gives you a complete backend in minutes - auth, database,'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/firebase/SKILL.md'
  imported_at: '2026-05-09'
---

# Firebase

Firebase gives you a complete backend in minutes - auth, database, storage, functions, hosting. But the ease of setup hides real complexity. Security rules are your last line of defense, and they're often wrong. Firestore queries are limited, and you learn this after you've designed your data model.

This skill covers Firebase Authentication, Firestore, Realtime Database, Cloud Functions, Cloud Storage, and Firebase Hosting. Key insight: Firebase is optimized for read-heavy, denormalized data. If you're thinking relationally, you're thinking wrong.

2025 lesson: Firestore pricing can surprise you. Reads are cheap until they're not. A poorly designed listener can cost more than a dedicated...

## When to Use
- User mentions or implies: firebase
- User mentions or implies: firestore
- User mentions or implies: firebase auth
- User mentions or implies: cloud functions
- User mentions or implies: firebase storage
- User mentions or implies: realtime database
- User mentions or implies: firebase hosting
- User mentions or implies: firebase emulator
- User mentions or implies: security rules
- User mentions or implies: firebase admin

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
- Core
- Testing
- Frameworks
- Patterns
- Modular SDK Import
- Security Rules Design
- Data Modeling for Queries
- Real-time Listeners
- Cloud Functions Patterns
- Batch Operations
- Social Login (Google, GitHub, etc.)
- Popup vs Redirect Auth
- Account Linking
- Auth State Persistence

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
