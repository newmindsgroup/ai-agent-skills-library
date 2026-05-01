#!/usr/bin/env bash
# Smoke-tests every component of the agent stack.
# Returns 0 if all checks pass, non-zero if any fail.

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

log_step "99 — Verifying full agent stack"

load_client_config

failures=0

check() {
  local name="$1"
  local cmd="$2"
  if eval "${cmd}" >/dev/null 2>&1; then
    log_info "PASS  ${name}"
  else
    log_error "FAIL  ${name}"
    failures=$((failures + 1))
  fi
}

# ---- Claude Code itself ----
check "Claude Code is installed"             "command -v claude"
check "Claude Code is authenticated"         "claude auth status"

# ---- Superpowers plugin ----
check "Superpowers plugin installed"         "claude plugin list | grep -q superpowers"

# ---- MCP servers registered ----
check "MCP server: memory"                   "claude mcp list | grep -q '^memory\b'"
check "MCP server: fetch"                    "claude mcp list | grep -q '^fetch\b'"
check "MCP server: filesystem"               "claude mcp list | grep -q '^filesystem\b'"
check "MCP server: playwright"               "claude mcp list | grep -q '^playwright\b'"
check "MCP server: chroma"                   "claude mcp list | grep -q '^chroma\b'"

# ---- Persistent state paths exist ----
check "Memory store path exists"             "test -f '${MEMORY_STORE_PATH}'"
check "Chroma DB path exists"                "test -d '${CHROMA_DB_PATH}'"

# ---- Filesystem MCP allowed roots exist ----
IFS=',' read -r -a roots_array <<< "${KNOWLEDGE_LIBRARY_ROOTS}"
for root in "${roots_array[@]}"; do
  trimmed="$(echo "${root}" | xargs)"
  check "Filesystem root exists: ${trimmed}"   "test -d '${trimmed}'"
done

# ---- Summary ----
log_step "Verification summary"

if [[ "${failures}" -eq 0 ]]; then
  log_info "All checks passed. Stack is operational."
  log_implementation "99-verify-all.sh" "All checks passed"
  exit 0
else
  log_error "${failures} check(s) failed. See output above."
  log_implementation "99-verify-all.sh" "FAILED — ${failures} check(s) failed"
  exit 1
fi
