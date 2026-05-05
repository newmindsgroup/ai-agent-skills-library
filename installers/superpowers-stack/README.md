# Agent Stack — Portable Claude Code VPS Configuration

**A self-contained, idempotent installer for a Claude Code agent stack on any Linux VPS.**

This repository configures a single VPS to run Claude Code with a curated set of MCP servers and engineering-rituals plugins. It is designed to be cloned, configured per-client via a single environment file, and deployed to any VPS in under thirty minutes.

## What this installs

In sequence:

1. **Superpowers** (`obra/superpowers`) — agentic skills plugin for Claude Code: planning, TDD, systematic debugging, verification, code review, git worktrees, parallel agents
2. **MCP: Memory** (Anthropic official) — knowledge-graph persistent memory across sessions
3. **MCP: Fetch** (Anthropic official) — zero-key web reads
4. **MCP: Filesystem** (Anthropic official) — secure file operations within scoped directory roots
5. **MCP: Playwright** (Microsoft official) — headless browser automation
6. **MCP: Chroma** — local vector RAG over a knowledge library
7. **agency-agents cherry-pick** ([msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents), MIT) — 16 specialist sub-agents (engineering, marketing, design, testing) auto-routed via "Use PROACTIVELY when..." description triggers. Voice-aware ones inject brand-voice DNA paths from client config.
8. **MCP: Firecrawl** ([mendableai/firecrawl-mcp-server](https://github.com/mendableai/firecrawl-mcp-server)) — 14 tools: scrape, search, crawl, structured extract, persistent browser sessions. Optional; skipped gracefully if `FIRECRAWL_API_KEY` is empty.
9. **Graphify** ([safishamsi/graphify](https://github.com/safishamsi/graphify)) — turns any folder into a queryable knowledge graph the agent reads instead of grepping. CLI + Claude Code skill (registers `/graphify` slash command).

Each install is its own script. Run all in sequence with `scripts/install-all.sh`, or run individually.

## Architecture this fits

This stack assumes:

- A Linux VPS (tested on Ubuntu 22.04+, Debian 12+; should work on other distros with minor tweaks)
- Claude Code CLI installed and authenticated against an Anthropic Max, Pro, or Team subscription via `claude login`
- Outbound HTTPS to GitHub, npm, PyPI, and Anthropic's marketplace endpoints
- A non-root user with `sudo` available
- Node.js ≥ 18 and Python ≥ 3.10

It does NOT assume:

- Any Anthropic API key (Max-subscription auth only)
- Any third-party agent wrapper (no Hermes, no OpenClaw, no `claude -p` heartbeat loops)
- Any specific cloud provider (Vultr, DigitalOcean, Hetzner, AWS — all fine)

## How to use it

### First time — for the original client

```bash
# 1. Clone this repo onto the VPS
git clone <your-repo-url> ~/agent-stack
cd ~/agent-stack

# 2. Copy the example client config and fill in real values
cp config/client.example.env config/client.env
$EDITOR config/client.env

# 3. Run the prereqs check
bash scripts/00-prereqs-check.sh

# 4. Run the installs in sequence (or one at a time)
bash scripts/install-all.sh
# OR
bash scripts/01-install-superpowers.sh
bash scripts/02-install-mcp-memory.sh
# ...etc

# 5. Verify everything is wired
bash scripts/99-verify-all.sh
```

### Replicating for a new client

See `PORTABILITY.md`. Short version: clone fresh, swap `client.env`, run the same scripts. The stack is identical; only the client-specific configuration differs.

## Files in this repo

| Path | Purpose |
|---|---|
| `README.md` | This file |
| `INSTALL.md` | Step-by-step install runbook with verification checks |
| `PORTABILITY.md` | How to deploy this stack for another client / company |
| `implementation-log.md` | Running log of every install on the original VPS — append-only |
| `config/client.example.env` | Template for per-client configuration |
| `config/CLAUDE.md.template` | Project-instructions block to drop into client repos so Superpowers fires |
| `scripts/00-prereqs-check.sh` | Verifies Claude Code, Node, Python, git, and outbound network |
| `scripts/01-install-superpowers.sh` | Installs the Superpowers plugin |
| `scripts/02-install-mcp-memory.sh` | Installs the Memory MCP server |
| `scripts/03-install-mcp-fetch.sh` | Installs the Fetch MCP server |
| `scripts/04-install-mcp-filesystem.sh` | Installs the Filesystem MCP server |
| `scripts/05-install-mcp-playwright.sh` | Installs the Playwright MCP server |
| `scripts/06-install-mcp-chroma.sh` | Installs the Chroma MCP server |
| `scripts/99-verify-all.sh` | Smoke-tests every installed component |
| `scripts/install-all.sh` | Convenience wrapper running 01–06 in order |
| `scripts/lib/common.sh` | Shared bash helpers — logging, error handling, idempotency |
| `docs/per-server/*.md` | One operational note per installed server: what it does, how it's configured, how to verify, how to troubleshoot |

## License

MIT.

## Maintenance

Quarterly: re-crawl Anthropic's official Claude Code marketplace, refresh MCP server versions, run `99-verify-all.sh` on each deployed VPS.

Per-install: update `implementation-log.md` with the date, version installed, and any client-specific configuration deviations.
