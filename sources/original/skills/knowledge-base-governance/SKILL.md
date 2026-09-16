---
name: knowledge-base-governance
description: "Maintain a safe local knowledge base for reusable, non-secret organizational knowledge with source, owner, verification date, duplicate resolution, and confidentiality controls. Use when adding, retrieving, reconciling, or pruning shared agent memory, project references, reusable patterns, or cross-project operating guidance."
category: Automation, Integrations, Productivity
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Original New Minds Group knowledge governance workflow created from cross-agent memory capability analysis; no third-party skill text copied
---

# Knowledge Base Governance

Version-Timestamp: 2026-08-04 13:10:00 AST

Use this skill when a user asks to add knowledge to a shared library, retrieve prior context, reconcile duplicate notes, or create a reusable source of truth.

## Classification

Classify every item before writing:

- `Public or reusable`: portable patterns, public references, non-sensitive operating guidance.
- `Internal non-secret`: local paths, service inventory, owners, project pointers, non-secret environment names.
- `Project-specific`: active requirements, defects, volatile implementation notes, and client-specific state.
- `Secret or restricted`: passwords, tokens, API keys, private keys, cookies, recovery codes, credential-bearing URLs, private customer data, or unnecessary personal information.

If unsure, treat the item as restricted and do not write it.

## Storage Rules

- Store secrets in an approved secret manager, operating-system credential store, or environment variable, not Markdown.
- Store only a non-secret reference to restricted material, such as secret name, owner, system, and retrieval procedure.
- Keep active project state in the project repository. Put only stable pointers in the central knowledge base.
- Add `Version-Timestamp` to maintained catalogs and exported references.

## Write Workflow

1. Resolve the approved knowledge-base root from project instructions or user approval.
2. Read local instructions in that root before editing.
3. Search for an existing canonical page and aliases.
4. Merge compatible facts.
5. Preserve conflicting facts with status and owner instead of silently overwriting.
6. Record source, owner, scope, verification date, and authority level.
7. Verify the final note contains no secrets, unnecessary personal data, inaccessible assumptions, or stale commands presented as current fact.

## Retrieve Workflow

1. Search the knowledge base before asking for information that may already exist.
2. Treat stored knowledge as a discovery layer, not proof that volatile facts remain current.
3. Verify time-sensitive, security-sensitive, legal, financial, production, or client-facing details against the authoritative source.
4. Report whether the answer is verified-current or memory-derived.

## Duplicate Resolution

- Pick one canonical page per topic.
- Replace true duplicates with short pointers.
- Keep provenance and last verification dates.
- Do not delete disputed records without owner confirmation.

## Completion Criteria

- The item belongs in shared knowledge.
- No secret or unnecessary confidential data was written.
- Source, owner, scope, and verification status are visible.
- Duplicates are resolved or explicitly tracked.
- Project-specific detail remains in the project repository.
