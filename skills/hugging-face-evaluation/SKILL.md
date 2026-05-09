---
name: hugging-face-evaluation
description: 'Add and manage evaluation results in Hugging Face model cards. Supports extracting eval tables from README content, importing scores from Artificial Analysis API, and running custom model evaluations with vLLM/lighteval. Works with the model-index metadata format.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/hugging-face-evaluation/SKILL.md'
  imported_at: '2026-05-09'
---

# Overview

This skill provides tools to add structured evaluation results to Hugging Face model cards. It supports multiple methods for adding evaluation data: - Extracting existing evaluation tables from README content - Importing benchmark scores from Artificial Analysis - Running custom model evaluations with vLLM or accelerate backends (lighteval/inspect-ai)

## When to Use
- You need to add structured evaluation results to a Hugging Face model card.
- You want to import benchmark data or run custom evaluations with vLLM, lighteval, or inspect-ai.
- You are preparing leaderboard-compatible `model-index` metadata for a model release.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Integration with HF Ecosystem
- Core Dependencies
- Inference Provider Evaluation
- vLLM Custom Model Evaluation (GPU required)
- ⚠️ CRITICAL: Check for Existing PRs Before Creating New Ones
- Inspect and Extract Evaluation Tables from README
- Import from Artificial Analysis
- Model-Index Management
- Run Evaluations on HF Jobs (Inference Providers)
- Run Custom Model Evaluations with vLLM (NEW)
- Before running the script
- Running the script
- Features
- Prerequisites
- Method 1: Extract from README (CLI workflow)
- Method 2: Import from Artificial Analysis
- Method 3: Run Evaluation Job
- Method 4: Run Custom Model Evaluation with vLLM

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
