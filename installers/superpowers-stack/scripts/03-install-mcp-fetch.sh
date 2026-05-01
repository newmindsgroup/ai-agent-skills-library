#!/usr/bin/env bash
# Installs the Fetch MCP server (Anthropic official, Python).
#
# What it does:
#   - pip-installs mcp-server-fetch (--break-system-packages safe in the userspace use case)
#   - Registers it with Claude Code as 'fetch' MCP server
#   - Verifies registration
#
# What it provides:
#   Single-URL HTML→markdown reads. Lightweight web ingestion that respects
#   robots.txt by default. Useful where Playwright is overkill.

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

log_step "03 — Install Fetch MCP"

load_client_config

# Idempotency check
if mcp_server_installed "fetch"; then
  log_info "Fetch MCP already registered with Claude Code"
  log_implementation "03-install-mcp-fetch.sh" "Already registered, skipped"
  exit 0
fi

# Install the Python package
# Prefer pipx if available (cleanest), fall back to pip --user
log_info "Installing mcp-server-fetch..."

if command -v pipx >/dev/null 2>&1; then
  log_info "Using pipx"
  pipx install mcp-server-fetch || pipx upgrade mcp-server-fetch
  fetch_cmd="$(command -v mcp-server-fetch)"
else
  log_info "pipx not available; using pip --user"
  python3 -m pip install --user --upgrade mcp-server-fetch
  # Resolve where pip --user installs binaries
  user_bin="$(python3 -c 'import site; print(site.getuserbase() + "/bin")')"
  fetch_cmd="${user_bin}/mcp-server-fetch"
  if [[ ! -x "${fetch_cmd}" ]]; then
    log_error "mcp-server-fetch binary not found at ${fetch_cmd}"
    exit 1
  fi
fi

log_info "Fetch binary: ${fetch_cmd}"

# Register with Claude Code
log_info "Registering 'fetch' MCP server with Claude Code..."
claude mcp add fetch -- "${fetch_cmd}"

# Verify
if ! mcp_server_installed "fetch"; then
  log_error "'fetch' did not appear in 'claude mcp list' after registration"
  exit 1
fi

log_info ""
log_info "Fetch MCP installed."
log_info "  Server name: fetch"
log_info "  Respects robots.txt by default."

log_step "Fetch MCP install complete"
log_implementation "03-install-mcp-fetch.sh" "Registered fetch MCP from ${fetch_cmd}"
