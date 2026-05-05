#!/usr/bin/env bash
# Convenience wrapper. Runs every install script in order, stopping on first failure.
# Idempotent — safe to re-run.

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

log_step "install-all — running full agent-stack install"

bash "${SCRIPT_DIR}/00-prereqs-check.sh"
bash "${SCRIPT_DIR}/01-install-superpowers.sh"
bash "${SCRIPT_DIR}/02-install-mcp-memory.sh"
bash "${SCRIPT_DIR}/03-install-mcp-fetch.sh"
bash "${SCRIPT_DIR}/04-install-mcp-filesystem.sh"
bash "${SCRIPT_DIR}/05-install-mcp-playwright.sh"
bash "${SCRIPT_DIR}/06-install-mcp-chroma.sh"
bash "${SCRIPT_DIR}/07-install-agency-agents.sh"
bash "${SCRIPT_DIR}/08-install-firecrawl-mcp.sh"
bash "${SCRIPT_DIR}/09-install-graphify.sh"
bash "${SCRIPT_DIR}/99-verify-all.sh"

log_step "install-all complete"
log_info "Next step: append config/CLAUDE.md.template to each project's CLAUDE.md"
log_info "Then run a smoke test from a Claude Code session in any project."
