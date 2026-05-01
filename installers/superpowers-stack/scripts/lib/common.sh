#!/usr/bin/env bash
# Shared helpers sourced by every install script.
# Provides: logging, error trapping, config loading, idempotency primitives.

# Strict mode — every script that sources this gets it
set -euo pipefail

# Resolve paths relative to the agent-stack repo root regardless of where the
# script is invoked from
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[1]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
CONFIG_FILE="${REPO_ROOT}/config/client.env"

# ---- Logging ----

_TS() { date -u +"%Y-%m-%dT%H:%M:%SZ"; }

log_info()  { echo "[$( _TS )] [INFO]  $*"; }
log_warn()  { echo "[$( _TS )] [WARN]  $*" >&2; }
log_error() { echo "[$( _TS )] [ERROR] $*" >&2; }
log_step()  { echo ""; echo "[$( _TS )] === $* ==="; }

# ---- Error trapping ----

_on_error() {
  local exit_code=$?
  local line_no=$1
  log_error "Script failed at line ${line_no} with exit code ${exit_code}"
  log_error "See ${INSTALL_LOG_PATH:-install.log} for the full transcript"
  exit "${exit_code}"
}

trap '_on_error ${LINENO}' ERR

# ---- Config loading ----

load_client_config() {
  if [[ ! -f "${CONFIG_FILE}" ]]; then
    log_error "Missing config file at ${CONFIG_FILE}"
    log_error "Copy config/client.example.env to config/client.env and fill in real values"
    exit 1
  fi

  # shellcheck disable=SC1090
  source "${CONFIG_FILE}"

  # Required vars sanity check
  : "${CLIENT_NAME:?CLIENT_NAME must be set in client.env}"
  : "${CLAUDE_PROJECT_ROOT:?CLAUDE_PROJECT_ROOT must be set in client.env}"

  log_info "Loaded config for client: ${CLIENT_NAME}"
}

# ---- Idempotency helpers ----

# Returns 0 if the named MCP server is already registered with Claude Code
mcp_server_installed() {
  local name="$1"
  if ! command -v claude >/dev/null 2>&1; then
    return 1
  fi
  claude mcp list 2>/dev/null | grep -q "^${name}\b" && return 0 || return 1
}

# Returns 0 if the named Claude Code plugin is already installed
plugin_installed() {
  local name="$1"
  if ! command -v claude >/dev/null 2>&1; then
    return 1
  fi
  claude plugin list 2>/dev/null | grep -q "${name}" && return 0 || return 1
}

# ---- Verification helpers ----

require_command() {
  local cmd="$1"
  if ! command -v "${cmd}" >/dev/null 2>&1; then
    log_error "Required command not found: ${cmd}"
    exit 1
  fi
}

# ---- Implementation log helpers ----

# Append a line to the implementation log with timestamp + client + script
log_implementation() {
  local script_name="$1"
  local detail="$2"
  local log_path="${REPO_ROOT}/implementation-log.md"
  if [[ ! -f "${log_path}" ]]; then
    cat > "${log_path}" <<EOF
# Implementation Log — ${CLIENT_NAME}

Append-only log of every install run on this VPS.

EOF
  fi
  echo "- $( _TS )  \`${script_name}\`  ${detail}" >> "${log_path}"
}
