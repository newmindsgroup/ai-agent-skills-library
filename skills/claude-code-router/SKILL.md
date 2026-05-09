---
name: claude-code-router
description: 'Set up or explain Claude Code Router for multi-model routing, provider switching, and cost optimization across Claude Code workflows. Activate when the user asks about model routing, OpenRouter, DeepSeek, Ollama, Gemini, background vs thinking models, or how to make Claude Code cheaper and more flexible without changing Anthropic''s CLI foundation.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/claude-code-router/SKILL.md'
  imported_at: '2026-05-09'
---

# Claude Code Router

This skill wraps the `musistudio/claude-code-router` repo so Codex can use it as a knowledge source and setup guide.

## What it is for

- Routing Claude Code requests to different providers or models
- Separating cheap background models from premium reasoning models
- Using OpenRouter, DeepSeek, Ollama, Gemini, and similar providers behind Claude Code
- Explaining presets, transformers, and provider-specific routing
- Helping design a cheaper or more controllable Claude Code model stack

## Important scope note

This repo is **for Claude Code**, not for Codex runtime routing itself.

Use it when:
- the user wants a Claude Code routing setup
- the user wants to understand the router repo from the video
- the user wants help configuring provider/model strategy

Do not pretend it changes how Codex itself selects models.

## How to use it

1. Reference the vendored repo snapshot:
   - `/Users/newmindsgroup/.codex/vendor_imports/latest-video/claude-code-router`
2. Read `README.md` for install and config patterns.
3. If needed, inspect examples under:
   - `/Users/newmindsgroup/.codex/vendor_imports/latest-video/claude-code-router/examples`
4. Use the installed `ccr` CLI when demonstrating or validating commands.

## Good triggers

- "Set up model routing for Claude Code"
- "Use OpenRouter with Claude Code"
- "Use cheaper models for background tasks"
- "How does Claude Code Router work?"
- "Configure DeepSeek or Ollama behind Claude Code"

## Local source

- Repo snapshot: `/Users/newmindsgroup/.codex/vendor_imports/latest-video/claude-code-router`
- Installed CLI: `ccr`
