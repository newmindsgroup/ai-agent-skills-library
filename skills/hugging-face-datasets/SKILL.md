---
name: hugging-face-datasets
description: 'Create and manage datasets on Hugging Face Hub. Supports initializing repos, defining configs/system prompts, streaming row updates, and SQL-based dataset querying/transformation. Designed to work alongside HF MCP server for comprehensive dataset workflows.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/hugging-face-datasets/SKILL.md'
  imported_at: '2026-05-09'
---

# Overview

This skill provides tools to manage datasets on the Hugging Face Hub with a focus on creation, configuration, content management, and SQL-based data manipulation. It is designed to complement the existing Hugging Face MCP server by providing dataset editing and querying capabilities.

## When to Use
- You need to create, configure, or update datasets on the Hugging Face Hub.
- You want SQL-style querying, transformation, or export flows over Hub datasets.
- You are managing dataset content and metadata directly rather than only searching existing datasets.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Integration with HF MCP Server
- Dataset Lifecycle Management
- SQL-Based Dataset Querying (NEW)
- Multi-Format Dataset Support
- Quality Assurance Features
- Prerequisites
- Quick Start
- SQL Query Syntax
- Common Operations
- Explore Dataset Structure
- Filter and Transform
- Create Subsets and Push to Hub
- Export to Local Files
- Working with Dataset Configs/Splits
- Raw SQL with Full Paths
- Python API Usage
- HF Path Format
- Useful DuckDB SQL Functions

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
