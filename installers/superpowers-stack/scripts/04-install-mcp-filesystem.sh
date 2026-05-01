#!/usr/bin/env bash
# Installs the Filesystem MCP server (Anthropic official, Node).
#
# What it does:
#   - Pre-pulls the npm package via npx
#   - Registers it with Claude Code as 'filesystem' MCP server
#   - Scopes access to the directories listed in KNOWLEDGE_LIBRARY_ROOTS
#   - Verifies registration
#
# What it provides:
#   Read/write/edit/move/search file operations within explicitly allowed
#   directory roots. Anything outside the allowlisted roots is inaccessible.

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

log_step "04 — Install Filesystem MCP"

load_client_config

: "${KNOWLEDGE_LIBRARY_ROOTS:?KNOWLEDGE_LIBRARY_ROOTS must be set in client.env}"

# Idempotency check
if mcp_server_installed "filesystem"; then
  log_info "Filesystem MCP already registered with Claude Code"
  log_info "  To change allowed roots, remove and reinstall:"
  log_info "    claude mcp remove filesystem"
  log_info "    bash scripts/04-install-mcp-filesystem.sh"
  log_implementation "04-install-mcp-filesystem.sh" "Already registered, skipped"
  exit 0
fi

# Convert comma-separated roots into space-separated args
IFS=',' read -r -a roots_array <<< "${KNOWLEDGE_LIBRARY_ROOTS}"

# Validate each root exists and is absolute
log_info "Validating allowed roots..."
for root in "${roots_array[@]}"; do
  root="$(echo "${root}" | xargs)"  # trim whitespace
  if [[ "${root}" != /* ]]; then
    log_error "Root must be an absolute path: ${root}"
    exit 1
  fi
  if [[ ! -d "${root}" ]]; then
    log_warn "Root does not exist: ${root} — creating it"
    mkdir -p "${root}"
  fi
  log_info "  Allowed: ${root}"
done

# Pre-pull the package
log_info "Pre-pulling @modelcontextprotocol/server-filesystem via npx..."
npx -y @modelcontextprotocol/server-filesystem --help >/dev/null 2>&1 || true

# Build the command line — server-filesystem takes the allowed roots as positional args
# Trim whitespace from each root for the final invocation
trimmed_roots=()
for root in "${roots_array[@]}"; do
  trimmed_roots+=("$(echo "${root}" | xargs)")
done

log_info "Registering 'filesystem' MCP server with Claude Code..."
claude mcp add filesystem \
  -- npx -y @modelcontextprotocol/server-filesystem "${trimmed_roots[@]}"

# Verify
if ! mcp_server_installed "filesystem"; then
  log_error "'filesystem' did not appear in 'claude mcp list' after registration"
  exit 1
fi

log_info ""
log_info "Filesystem MCP installed."
log_info "  Server name: filesystem"
log_info "  Allowed roots: ${KNOWLEDGE_LIBRARY_ROOTS}"
log_info "  Anything outside these roots is inaccessible to the agent."

log_step "Filesystem MCP install complete"
log_implementation "04-install-mcp-filesystem.sh" "Registered filesystem MCP, roots: ${KNOWLEDGE_LIBRARY_ROOTS}"
