#!/usr/bin/env bash
# Installs the Memory MCP server (Anthropic official).
#
# What it does:
#   - Pre-pulls the npm package via npx so first run is fast
#   - Registers it with Claude Code as 'memory' MCP server
#   - Configures MEMORY_FILE_PATH env var to a persistent location set in client.env
#   - Verifies registration
#
# What it provides:
#   A knowledge-graph persistent memory tool. Across sessions, agents can
#   create entities, relations, and observations and recall them later.

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

log_step "02 — Install Memory MCP"

load_client_config

: "${MEMORY_STORE_PATH:?MEMORY_STORE_PATH must be set in client.env}"

# Ensure parent directory exists
mkdir -p "$(dirname "${MEMORY_STORE_PATH}")"

# Idempotency check
if mcp_server_installed "memory"; then
  log_info "Memory MCP already registered with Claude Code"
  log_info "  Store path: ${MEMORY_STORE_PATH}"
  log_implementation "02-install-mcp-memory.sh" "Already registered, skipped"
  exit 0
fi

# Pre-pull the package so subsequent invocations are fast
log_info "Pre-pulling @modelcontextprotocol/server-memory via npx..."
npx -y @modelcontextprotocol/server-memory --help >/dev/null 2>&1 || true

# Register with Claude Code
# Pass MEMORY_FILE_PATH as an environment variable to the server
log_info "Registering 'memory' MCP server with Claude Code..."
claude mcp add memory \
  --env "MEMORY_FILE_PATH=${MEMORY_STORE_PATH}" \
  -- npx -y @modelcontextprotocol/server-memory

# Verify
log_info "Verifying registration..."
if ! mcp_server_installed "memory"; then
  log_error "'memory' did not appear in 'claude mcp list' after registration"
  exit 1
fi

# If the store file doesn't exist yet, create an empty JSON object so the
# server has something to read on first start
if [[ ! -f "${MEMORY_STORE_PATH}" ]]; then
  echo '{}' > "${MEMORY_STORE_PATH}"
  log_info "Initialized empty memory store at ${MEMORY_STORE_PATH}"
fi

log_info ""
log_info "Memory MCP installed."
log_info "  Server name: memory"
log_info "  Store file: ${MEMORY_STORE_PATH}"
log_info "  BACK UP this file if it becomes load-bearing state."

log_step "Memory MCP install complete"
log_implementation "02-install-mcp-memory.sh" "Registered memory MCP, store at ${MEMORY_STORE_PATH}"
