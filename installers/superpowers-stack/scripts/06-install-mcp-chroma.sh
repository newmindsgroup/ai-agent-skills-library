#!/usr/bin/env bash
# Installs the Chroma MCP server (Chroma official, Python).
#
# What it does:
#   - pip-installs chroma-mcp
#   - Initializes a persistent vector store at CHROMA_DB_PATH
#   - Registers it with Claude Code as 'chroma' MCP server
#   - Verifies registration
#
# What it provides:
#   Local vector database for RAG. Stores embeddings and supports similarity
#   search. Runs entirely on the VPS — no external vector service required.
#
# Note on embeddings:
#   By default, chroma-mcp uses a local default-embedding model (slower
#   but no external dependency). For faster/better embeddings, set
#   OPENAI_API_KEY_FOR_EMBEDDINGS in client.env.

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

log_step "06 — Install Chroma MCP"

load_client_config

: "${CHROMA_DB_PATH:?CHROMA_DB_PATH must be set in client.env}"

# Idempotency check
if mcp_server_installed "chroma"; then
  log_info "Chroma MCP already registered with Claude Code"
  log_info "  Store path: ${CHROMA_DB_PATH}"
  log_implementation "06-install-mcp-chroma.sh" "Already registered, skipped"
  exit 0
fi

# Ensure the DB directory exists
mkdir -p "${CHROMA_DB_PATH}"

# Install chroma-mcp
log_info "Installing chroma-mcp..."

if command -v pipx >/dev/null 2>&1; then
  log_info "Using pipx"
  pipx install chroma-mcp || pipx upgrade chroma-mcp
  chroma_cmd="$(command -v chroma-mcp)"
else
  log_info "pipx not available; using pip --user"
  python3 -m pip install --user --upgrade chroma-mcp
  user_bin="$(python3 -c 'import site; print(site.getuserbase() + "/bin")')"
  chroma_cmd="${user_bin}/chroma-mcp"
  if [[ ! -x "${chroma_cmd}" ]]; then
    log_error "chroma-mcp binary not found at ${chroma_cmd}"
    exit 1
  fi
fi

log_info "chroma-mcp binary: ${chroma_cmd}"

# Build the registration with appropriate env vars
register_args=(
  --env "CHROMA_DB_PATH=${CHROMA_DB_PATH}"
)

if [[ -n "${OPENAI_API_KEY_FOR_EMBEDDINGS:-}" ]]; then
  log_info "OPENAI_API_KEY_FOR_EMBEDDINGS set — using OpenAI embeddings"
  register_args+=(--env "OPENAI_API_KEY=${OPENAI_API_KEY_FOR_EMBEDDINGS}")
else
  log_info "No OpenAI key — using local default embedding model"
fi

# Register
log_info "Registering 'chroma' MCP server with Claude Code..."
claude mcp add chroma "${register_args[@]}" -- "${chroma_cmd}"

# Verify
if ! mcp_server_installed "chroma"; then
  log_error "'chroma' did not appear in 'claude mcp list' after registration"
  exit 1
fi

log_info ""
log_info "Chroma MCP installed."
log_info "  Server name: chroma"
log_info "  Store path: ${CHROMA_DB_PATH}"
log_info "  BACK UP this directory if it becomes load-bearing."
log_info ""
log_info "Next: ingest your knowledge library into Chroma. From a Claude Code session:"
log_info "  > Use chroma to create a collection named 'knowledge-library'"
log_info "  > Then ingest these directories: ..."

log_step "Chroma MCP install complete"
log_implementation "06-install-mcp-chroma.sh" "Registered chroma MCP, store at ${CHROMA_DB_PATH}"
