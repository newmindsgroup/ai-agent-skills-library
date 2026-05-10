---
name: graphify
description: 'any input (code, docs, papers, images) → knowledge graph → clustered communities → HTML + JSON + audit report. Use when user asks any question about a codebase, project content, architecture, or file relationships — especially if graphify-out/ exists. Provides persistent graph with god nodes, community detection, and BFS/DFS query tools.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/graphify/SKILL.md'
  imported_at: '2026-05-09'
---

# /graphify

Turn any folder of files into a navigable knowledge graph with community detection, an honest audit trail, and three outputs: interactive HTML, GraphRAG-ready JSON, and a plain-language GRAPH_REPORT.md.

## When to Use
- The request matches the skill description: any input (code, docs, papers, images) → knowledge graph → clustered communities → HTML + JSON + audit report. Use when user asks any question about a codebase, project content, architecture, or file relationships — especially if graphify-out/ exists. Provides persistent graph with god nodes, community detection, and BFS/DFS query tools.
- The task needs the implementation patterns, examples, validation checks, or edge cases listed in the topic map.
- The work would benefit from the complete guidance preserved in `references/full-guidance.md`.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Usage
- What graphify is for
- What You Must Do When Invoked
- Step 1 - Ensure graphify is installed
- Step 2 - Detect files
- Step 2.5 - Transcribe video / audio files (only if video files detected)
- Step 3 - Extract entities and relationships
- Step 4 - Build graph, cluster, analyze, generate outputs
- Step 5 - Label communities
- Step 6 - Generate Obsidian vault (opt-in) + HTML
- Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag)
- Step 7b - SVG export (only if --svg flag)
- Step 7c - GraphML export (only if --graphml flag)
- Step 7d - MCP server (only if --mcp flag)
- Step 8 - Token reduction benchmark (only if total_words > 5000)
- Step 9 - Save manifest, update cost tracker, clean up, and report
- For --update (incremental re-extraction)
- For --cluster-only

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
