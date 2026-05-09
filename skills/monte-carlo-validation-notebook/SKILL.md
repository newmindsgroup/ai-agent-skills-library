---
name: monte-carlo-validation-notebook
description: 'Generates SQL validation notebooks for dbt PR changes with before/after comparison queries.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/monte-carlo-validation-notebook/SKILL.md'
  imported_at: '2026-05-09'
---

# Setup

**Prerequisites:** - **`gh`** (GitHub CLI) — required for PR mode. Must be authenticated (`gh auth status`). - **`python3`** — required for helper scripts. - **`pyyaml`** — install with `pip3 install pyyaml` (or `pip install pyyaml`, `uv pip install pyyaml`, etc.)

**Note:** Generated SQL uses ANSI-compatible syntax that works across Snowflake, BigQuery, Redshift, and Athena. Minor adjustments may be needed for specific warehouse quirks.

This skill includes two helper scripts in `${CLAUDE_PLUGIN_ROOT}/skills/monte-carlo-validation-notebook/scripts/`:

- **`resolve_dbt_schema.py`** - Resolves dbt model output schemas from `dbt_project.yml` routing rules and model config overrides. -...

## When to Use
- The request matches the skill description: Generates SQL validation notebooks for dbt PR changes with before/after comparison queries.
- The task needs the implementation patterns, examples, validation checks, or edge cases listed in the topic map.
- The work would benefit from the complete guidance preserved in `references/full-guidance.md`.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Parameter Cell Spec
- Phase 1: Get Changed Files
- If PR mode (GitHub PR):
- If Local mode (Local Directory):
- Model Selection (applies to both modes)
- Phase 2: Parse Changed Models
- 2a. Model Metadata
- 2b. Diff Analysis
- 2c. Model Classification
- Phase 3: Generate Validation Queries
- Query Patterns for NEW Models
- Query Patterns for MODIFIED Models
- Phase 4: Build Notebook YAML
- 4a. Metadata
- 4b. Parameter Cells
- 4c. Markdown Summary Cell
- 4d. SQL Cell Format
- 4e. Cell Organization

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
