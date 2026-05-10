---
name: agent-memory-systems
description: 'Memory is the cornerstone of intelligent agents. Without it, every'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/agent-memory-systems/SKILL.md'
  imported_at: '2026-05-09'
---

# Agent Memory Systems

Memory is the cornerstone of intelligent agents. Without it, every interaction starts from zero. This skill covers the architecture of agent memory: short-term (context window), long-term (vector stores), and the cognitive architectures that organize them.

Key insight: Memory isn't just storage - it's retrieval. A million stored facts mean nothing if you can't find the right one. Chunking, embedding, and retrieval strategies determine whether your agent remembers or forgets.

The field is fragmented with inconsistent terminology. We use the CoALA cognitive architecture framework: semantic memory (facts), episodic memory (experiences), and procedural memory (how-to knowledge).

## When to Use
- User mentions or implies: agent memory
- User mentions or implies: long-term memory
- User mentions or implies: memory systems
- User mentions or implies: remember across sessions
- User mentions or implies: memory retrieval
- User mentions or implies: episodic memory
- User mentions or implies: semantic memory
- User mentions or implies: vector store
- User mentions or implies: rag
- User mentions or implies: langmem

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
- Memory_frameworks
- Vector_stores
- Embedding_models
- Patterns
- Memory Type Architecture
- LangMem Implementation
- Memory Retrieval at Runtime
- Vector Store Selection Pattern
- Pinecone (Enterprise Scale)
- Qdrant (Complex Filtering)
- ChromaDB (Prototyping)
- Chunking Strategy Pattern
- Fixed-Size Chunking (Baseline)
- Semantic Chunking (Better Quality)

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
