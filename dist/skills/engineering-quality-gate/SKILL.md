---
name: engineering-quality-gate
description: Require project-specific tests, static analysis, security review, changed-path acceptance evidence, and a proportionate release check before non-trivial code is considered complete.
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
---

# Engineering Quality Gate

Version-Timestamp: 2026-08-24 17:37:30 AST

Use as the final-phase skill for non-trivial backend, frontend, API, automation, infrastructure, database, or repository code. It follows the specific implementation skill, such as `test-driven-development` or `systematic-debugging`. This gate turns the project’s actual commands and risk boundaries into evidence before completion.

## Before implementation

1. Read the repository `AGENTS.md`, `README`, architecture notes, and `.codex/quality-gates.toml` when present.
2. State the expected behavior, affected data, failure mode, acceptance evidence, and rollback or recovery path for stateful work.
3. Use the most specific implementation skill. Use `test-driven-development` for a new behavior, `systematic-debugging` for a defect, and the stack-specific skill for a named framework or provider.
4. Use a small local code worker for private, bounded first passes. Use Terra Medium Standard when repository tools, current documentation, or stronger implementation judgment is needed.

## Required evidence

Run only the relevant configured checks. Do not invent commands or treat one passing check as proof of another.

1. **Behavior:** focused tests for changed behavior. For new testable logic, observe the intended failure before the implementation and the passing behavior afterward.
2. **Static quality:** lint, formatting, typecheck, compilation, or language-native analysis configured by the repository.
3. **Integration:** build, contract, database, browser, API, or end-to-end check when the changed boundary requires it.
4. **Diff review:** inspect the final diff for unrelated edits, error handling, input validation, authorization boundaries, secrets, generated artifacts, and missing tests.
5. **Security:** run the project security check for user-facing, data-touching, authentication, payment, permission, infrastructure, or dependency changes. Use `security-auditor` when a targeted security review is warranted.
6. **Release safety:** for stateful, production, or client-facing changes, verify configuration, migration order, observability, rollback, and deployment criteria. Do not deploy solely because local tests pass.

## Escalation

Use Sol High or Claude Max for a deliberate independent review of a high-consequence architecture, security-sensitive diff, migration, production release, or deeply conflicting evidence. They are reviewers, not proof. Run the real checks after any model recommendation.

Read [the engineering evidence matrix](references/evidence-matrix.md) for the minimum gate by change type.
