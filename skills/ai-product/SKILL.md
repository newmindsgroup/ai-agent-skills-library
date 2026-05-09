---
name: ai-product
description: 'Every product will be AI-powered. The question is whether you''ll'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/ai-product/SKILL.md'
  imported_at: '2026-05-09'
---

# AI Product Development

Every product will be AI-powered. The question is whether you'll build it right or ship a demo that falls apart in production.

This skill covers LLM integration patterns, RAG architecture, prompt engineering that scales, AI UX that users trust, and cost optimization that doesn't bankrupt you.

## When to Use
- Use this skill when the request clearly matches the capabilities and patterns described above.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Principles
- Patterns
- Structured Output with Validation
- Streaming with Progress
- Prompt Versioning and Testing
- Caching Expensive Operations
- Circuit Breaker for LLM Failures
- RAG with Hybrid Search
- Sharp Edges
- Trusting LLM output without validation
- User input directly in prompts without sanitization
- Separate user input:
- Input sanitization:
- Output filtering:
- Least privilege:
- Stuffing too much into context window
- Waiting for complete response before showing anything
- Not monitoring LLM API costs

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
