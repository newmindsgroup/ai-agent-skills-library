#!/usr/bin/env bash
# Installs the Firecrawl MCP server for web scraping, search, and structured
# extraction.
#
# What it does:
#   - Pre-pulls the npm package via npx so first run is fast
#   - Registers it with Claude Code as 'firecrawl' MCP server
#   - Configures FIRECRAWL_API_KEY env var from client.env
#   - Skips gracefully (with a log line) if FIRECRAWL_API_KEY is empty
#
# What it provides:
#   14 tools: scrape, map, search, crawl, extract (LLM-structured), agent
#   (autonomous research), persistent browser sessions, interact (forms/clicks).
#   Pairs particularly well with the ai-citation-strategist sub-agent and any
#   competitive-monitoring workflow.

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

log_step "08 — Install Firecrawl MCP"

load_client_config

if [[ -z "${FIRECRAWL_API_KEY:-}" ]]; then
  log_warn "FIRECRAWL_API_KEY is empty in client.env — skipping Firecrawl install."
  log_warn "Set the key and re-run this script to enable Firecrawl."
  log_implementation "08-install-firecrawl-mcp.sh" "Skipped — no API key"
  exit 0
fi

require_command npx
require_command python3

# Where to register Firecrawl. If AGENT_MCP_JSON_PATH is set in client.env,
# edit that file directly — this is the project-scope .mcp.json the agent
# reads at startup (matches the existing pattern, e.g. how GHL is registered
# at /opt/{{TENANT_LINUX_USER}}/agents/.mcp.json). Otherwise fall back to
# `claude mcp add`, which uses local config and is scoped to whatever cwd
# the script is run from — fine for one-shot project use but breaks when
# the agent runs from a different cwd.
AGENT_MCP_JSON="${AGENT_MCP_JSON_PATH:-}"

# Pre-pull the package so subsequent invocations are fast
log_info "Pre-pulling firecrawl-mcp via npx..."
npx -y firecrawl-mcp --help >/dev/null 2>&1 || true

if [[ -n "${AGENT_MCP_JSON}" ]]; then
  if [[ ! -f "${AGENT_MCP_JSON}" ]]; then
    log_error "AGENT_MCP_JSON_PATH set to ${AGENT_MCP_JSON} but the file does not exist"
    log_error "Either initialize it as {\"mcpServers\":{}} or unset AGENT_MCP_JSON_PATH"
    exit 1
  fi

  log_info "Registering 'firecrawl' in project-scope MCP file: ${AGENT_MCP_JSON}"
  FIRECRAWL_API_KEY="${FIRECRAWL_API_KEY}" AGENT_MCP_JSON="${AGENT_MCP_JSON}" python3 - <<'PYEOF'
import json, os, sys
path = os.environ["AGENT_MCP_JSON"]
key  = os.environ["FIRECRAWL_API_KEY"]
with open(path) as f: d = json.load(f)
d.setdefault("mcpServers", {})
d["mcpServers"]["firecrawl"] = {
    "command": "npx",
    "args": ["-y", "firecrawl-mcp"],
    "env": {"FIRECRAWL_API_KEY": key},
}
with open(path, "w") as f: json.dump(d, f, indent=2)
print(f"  servers: {list(d['mcpServers'].keys())}")
PYEOF
else
  # Fallback path — local-scope registration via `claude mcp add`
  if mcp_server_installed "firecrawl"; then
    log_info "Firecrawl MCP already registered with Claude Code (local scope)"
    log_implementation "08-install-firecrawl-mcp.sh" "Already registered, skipped"
    exit 0
  fi

  log_info "Registering 'firecrawl' MCP server with Claude Code (local scope)..."
  claude mcp add firecrawl \
    --env "FIRECRAWL_API_KEY=${FIRECRAWL_API_KEY}" \
    -- npx -y firecrawl-mcp

  log_info "Verifying registration..."
  if ! mcp_server_installed "firecrawl"; then
    log_error "'firecrawl' did not appear in 'claude mcp list' after registration"
    exit 1
  fi
fi

log_info ""
log_info "Firecrawl MCP installed."
log_info "  Server name: firecrawl"
log_info "  API key:     loaded from client.env (FIRECRAWL_API_KEY)"
log_info "  Restart claude-agent.service if it was already running."

log_step "Firecrawl MCP install complete"
log_implementation "08-install-firecrawl-mcp.sh" "Registered firecrawl MCP"
