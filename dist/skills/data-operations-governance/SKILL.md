---
name: data-operations-governance
description: "Route and execute data work safely across profiling, cleaning, validation, contracts, reconciliation, migrations, lineage, pipelines, analytics models, database reliability, and large-scale processing. Use when data correctness, ownership, evidence, sensitivity, or repeatability matters."
category: AI, Agents, LLMs, Data
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Original New Minds Group data operations workflow created from data-skill capability analysis; no third-party skill text copied
---

# Data Operations Governance

Version-Timestamp: 2026-08-04 13:10:00 AST

Use this skill when a request involves datasets, analytics, imports, exports, migrations, data quality, lineage, transformations, pipelines, or database reliability.

## Route the Request

Classify first:

- `profile-clean-validate`: understand and fix messy data.
- `contract`: define schema, nullability, domains, keys, freshness, ownership, and compatibility rules.
- `reconciliation`: prove source and destination parity after import, migration, sync, or correction.
- `lineage-governance`: map sources, transformations, owners, classifications, access, retention, and impact.
- `pipeline`: design idempotent scheduled data movement with retries, backfills, checkpoints, and quality gates.
- `analytics-engineering`: build tested staging, dimensions, facts, semantic metrics, docs, and freshness checks.
- `database-reliability`: audit integrity, constraints, transactions, indexing, backup, restore, retention, and recovery.
- `large-scale`: choose distributed or parallel methods when data exceeds practical single-process limits.

## Safety Rules

- Treat production data, customer data, health data, financial data, employee data, and credentials as confidential by default.
- Do not run writes, migrations, backfills, deletes, or corrections without explicit authorization and rollback evidence.
- Prefer read-only profiling before mutation.
- Keep reproducible queries and transformations, but remove secrets and unnecessary personal data from reports.
- Separate source-system facts from inferred conclusions.

## Minimum Evidence

For every data operation, record:

- Source systems and owners.
- Data classification and retention requirements.
- Grain, primary keys, natural keys, foreign keys, and expected uniqueness.
- Row counts, distinct counts, null rates, domain violations, duplicate keys, freshness, and outlier checks.
- Transformation version, code path, query, or job ID.
- Before and after metrics.
- Exceptions, unresolved records, and owner decisions.

## Reconciliation Pattern

Use layered checks:

1. Count totals by source, destination, entity, and partition.
2. Compare primary key coverage and missing or extra records.
3. Hash stable fields where safe.
4. Compare aggregates and distributions.
5. Validate referential integrity and tenant boundaries.
6. Sample human-readable records for edge cases.
7. Record exceptions with disposition.

## Pipeline Pattern

Require:

- Idempotent jobs.
- Explicit dependencies.
- Retry and dead-letter behavior.
- Backfill plan.
- Freshness checks.
- Quality thresholds.
- Alerting owner.
- Run history.
- Safe failure mode.

## Completion Criteria

- The request is routed to the right data operation type.
- Risky mutations have authorization, backup, and rollback path.
- Results are reproducible from documented inputs and transformations.
- Data quality issues are quantified, not hand-waved.
- Open exceptions have owners and next actions.
