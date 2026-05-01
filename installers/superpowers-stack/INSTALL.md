# Install Runbook

Sequential install procedure for the agent stack on a fresh VPS. Read this once before running `install-all.sh` so you know what to expect.

## Pre-flight

Before running any script:

1. SSH to the VPS as a non-root user with sudo
2. Verify outbound HTTPS to github.com, registry.npmjs.org, pypi.org, anthropic.com
3. Have Claude Code installed and run `claude login` if not already authenticated
4. Have at least 2 GB free disk and 2 GB RAM (Playwright in particular wants headroom)

## The sequence

| # | Component | Time | External keys | Notes |
|---|---|---|---|---|
| 0 | Prereqs check | <1 min | none | Aborts if anything is missing |
| 1 | Superpowers (Claude Code plugin) | ~1 min | none | Installs from official Anthropic marketplace |
| 2 | Memory MCP | ~1 min | none | npx-based; idempotent |
| 3 | Fetch MCP | ~1 min | none | pip-based; respects robots.txt |
| 4 | Filesystem MCP | ~1 min | none | Scoped to directories listed in `client.env` |
| 5 | Playwright MCP | ~3 min | none | Downloads Chromium (~200 MB) |
| 6 | Chroma MCP | ~2 min | none for local; embedding provider TBD | Local vector store |
| V | Verify all | <1 min | none | Smoke test every component |

Expected total time on a clean VPS: 10–15 minutes.

## Per-script semantics

Every script in `scripts/` follows the same conventions:

- **`set -euo pipefail`** — fail fast on errors, undefined variables, and pipeline failures
- **Idempotent** — safe to re-run; uses `claude mcp list` checks and version comparisons before re-installing
- **Sourced common helpers** — every script sources `lib/common.sh` for logging, error trapping, and config loading
- **Loads `config/client.env`** — environment-specific values come from the env file, never hardcoded
- **Logs progress** — prefixed with the step number; failures dump diagnostic context
- **Verifies on success** — each script ends with a verification step that proves the install actually worked

If any script fails, it exits non-zero and `install-all.sh` stops. Re-run the failing script after fixing the cause; it will pick up where it left off.

## Logging

All script output is also written to `~/agent-stack/install.log` with timestamps. After a clean run, that file plus `implementation-log.md` are the audit trail.

## Order matters

Don't reorder the sequence. Reasoning:

1. Superpowers first — it's a Claude Code plugin and doesn't depend on any MCP server, but the engineering rituals it adds are useful for everything that follows
2. Memory before everything else MCP — cross-session persistence is the most foundational primitive
3. Fetch and Filesystem next — zero-key, zero-dependency, give the agent its basic read/write surfaces
4. Playwright after Filesystem — Playwright produces files (screenshots) and needs Filesystem to manage them
5. Chroma last — depends on having a knowledge library to embed; standing it up before the library exists is wasted work

## After install

1. Add the `config/CLAUDE.md.template` block to any project's `CLAUDE.md` where you want Superpowers to fire
2. Run a low-stakes test: open a Claude Code session in any project directory, ask it to "fetch https://example.com and summarize" — verify Fetch MCP responds
3. Update `implementation-log.md` with the install date and any deviations
4. Commit any client-side changes (CLAUDE.md additions, etc.) to the relevant client repos

## Troubleshooting

See `docs/troubleshooting.md` for known issues. Common ones up front:

- **`claude: command not found`** — install Claude Code first per Anthropic's official instructions; this script does not install it
- **`claude auth status` shows "not authenticated"** — run `claude login` and complete the browser flow
- **`/plugin install` errors with "marketplace not found"** — older Claude Code; update to a recent version
- **Playwright Chromium download times out** — slow network; rerun the script (idempotent)
- **Chroma fails on `pip install`** — Python version too old; needs ≥3.10
