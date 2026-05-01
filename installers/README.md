# Installers

Bootable kits that install full stacks of agentic infrastructure with one command — not single skills, but coordinated bundles of plugins, MCP servers, configurations, and scripts.

Use these when you need to stand up a working agent environment from scratch, not when you just want to drop in one skill.

## What's here

| Installer | What it installs | Where it runs |
|---|---|---|
| [`superpowers-stack`](superpowers-stack/) | The Superpowers Claude Code plugin + 5 Tier-1 MCPs (Memory, Fetch, Filesystem, Playwright, Chroma). Adds TDD discipline, planning, debugging, verification gates, sub-agent dispatch, git worktree workflows, and skill-creation. | Linux VPS or any machine running Claude Code |

## Adding an installer

1. Each installer is a self-contained subdirectory.
2. Required files: `README.md` (what + why), `INSTALL.md` (the runbook), and the actual scripts.
3. Use a `client.example.env` (or equivalent) for any per-deployment configuration. Never commit a real `client.env`.
4. Make scripts idempotent — re-running them must not break a working install.
5. Document the success-check at the end of `INSTALL.md`.
