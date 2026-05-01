#!/usr/bin/env bash
# Verifies the VPS has everything the install scripts need.
# Run this first. Aborts on any missing prerequisite.

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

log_step "Prerequisites check"

# Load client config (also validates it exists)
load_client_config

# ---- Required commands ----

log_info "Checking required commands..."
require_command claude
require_command git
require_command node
require_command npm
require_command npx
require_command python3
require_command pip
require_command bash
require_command grep
require_command sed

# ---- Version checks ----

log_info "Checking versions..."

# Claude Code
claude_version="$(claude --version 2>&1 | head -1 || echo "unknown")"
log_info "Claude Code: ${claude_version}"

# Node ≥ 18
node_major="$(node -v | sed 's/^v//' | cut -d. -f1)"
if [[ "${node_major}" -lt 18 ]]; then
  log_error "Node.js ≥ 18 required; found $(node -v)"
  exit 1
fi
log_info "Node.js: $(node -v)"

# Python ≥ 3.10
py_version="$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')"
py_major="$(echo "${py_version}" | cut -d. -f1)"
py_minor="$(echo "${py_version}" | cut -d. -f2)"
if [[ "${py_major}" -lt 3 ]] || { [[ "${py_major}" -eq 3 ]] && [[ "${py_minor}" -lt 10 ]]; }; then
  log_error "Python ≥ 3.10 required; found ${py_version}"
  exit 1
fi
log_info "Python: ${py_version}"

# ---- Claude Code authentication ----

log_info "Checking Claude Code authentication..."
if ! claude auth status >/dev/null 2>&1; then
  log_error "Claude Code is not authenticated"
  log_error "Run: claude login"
  exit 1
fi
log_info "Claude Code is authenticated"

# ---- Network reachability ----

log_info "Checking outbound network..."
for host in github.com registry.npmjs.org pypi.org; do
  if ! curl -fsS --max-time 5 "https://${host}" >/dev/null 2>&1; then
    log_warn "Could not reach https://${host} — install scripts may fail"
  else
    log_info "Reachable: https://${host}"
  fi
done

# ---- Disk space ----

avail_gb="$(df -BG --output=avail / | tail -1 | tr -dc '0-9')"
if [[ "${avail_gb}" -lt 5 ]]; then
  log_warn "Low free disk: ${avail_gb} GB on / — Playwright alone needs ~500 MB"
else
  log_info "Free disk: ${avail_gb} GB on /"
fi

# ---- Memory ----

if command -v free >/dev/null 2>&1; then
  total_mb="$(free -m | awk '/^Mem:/{print $2}')"
  if [[ "${total_mb}" -lt 1500 ]]; then
    log_warn "Low RAM: ${total_mb} MB — Playwright recommends ≥2 GB"
  else
    log_info "Total RAM: ${total_mb} MB"
  fi
fi

# ---- Configured paths exist or can be created ----

log_info "Checking configured paths..."

# CLAUDE_PROJECT_ROOT
if [[ ! -d "${CLAUDE_PROJECT_ROOT}" ]]; then
  log_warn "CLAUDE_PROJECT_ROOT does not exist: ${CLAUDE_PROJECT_ROOT}"
  log_info "Creating it..."
  mkdir -p "${CLAUDE_PROJECT_ROOT}"
fi
log_info "CLAUDE_PROJECT_ROOT: ${CLAUDE_PROJECT_ROOT}"

# Memory store parent directory
mem_dir="$(dirname "${MEMORY_STORE_PATH:-/tmp/_unused_}")"
mkdir -p "${mem_dir}"

# Chroma directory
mkdir -p "${CHROMA_DB_PATH:-/tmp/_unused_chroma}"

log_step "Prerequisites check passed"
log_implementation "00-prereqs-check.sh" "Prereqs check passed for ${CLIENT_NAME}"
