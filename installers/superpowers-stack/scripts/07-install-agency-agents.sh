#!/usr/bin/env bash
# Installs cherry-picked sub-agents from msitarzewski/agency-agents (MIT) into
# the agent's ~/.claude/agents/ directory.
#
# What it does:
#   - Clones (or fetches) msitarzewski/agency-agents into a stable cache dir
#   - Runs agency-agents-installer/install.py with paths from client.env
#   - Voice-DNA paths get injected into voice-aware agents so they defer to the
#     client's brand voice playbook
#   - Idempotent — re-running just refreshes from latest upstream + manifest
#
# What it provides:
#   16 specialist sub-agents (engineering, marketing, design, testing) auto-
#   routed via "Use PROACTIVELY when..." trigger phrases in their description.
#   The agent harness routes by description without the user having to know
#   names.

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

log_step "07 — Install agency-agents (cherry-picked sub-agents)"

load_client_config

# Required vars
: "${AGENCY_AGENTS_CACHE_DIR:?AGENCY_AGENTS_CACHE_DIR must be set in client.env}"
: "${CLAUDE_AGENTS_DIR:?CLAUDE_AGENTS_DIR must be set in client.env}"

# Optional voice-paths file — without it, voice-aware agents install but skip
# the inline brand-voice block. The user-level CLAUDE.md should declare voice
# precedence anyway, so this is graceful.
VOICE_PATHS_FILE="${BRAND_VOICE_PATHS_FILE:-}"

require_command git
require_command python3

INSTALLER_DIR="${REPO_ROOT}/agency-agents-installer"
if [[ ! -f "${INSTALLER_DIR}/install.py" ]]; then
  log_error "Installer not found at ${INSTALLER_DIR}/install.py — agent-stack repo is incomplete"
  exit 1
fi

# Clone or update the upstream agency-agents repo
if [[ -d "${AGENCY_AGENTS_CACHE_DIR}/.git" ]]; then
  log_info "Updating existing agency-agents clone at ${AGENCY_AGENTS_CACHE_DIR}"
  git -C "${AGENCY_AGENTS_CACHE_DIR}" fetch --quiet origin
  git -C "${AGENCY_AGENTS_CACHE_DIR}" reset --hard --quiet origin/HEAD
else
  log_info "Cloning msitarzewski/agency-agents to ${AGENCY_AGENTS_CACHE_DIR}"
  mkdir -p "$(dirname "${AGENCY_AGENTS_CACHE_DIR}")"
  git clone --depth=1 --quiet https://github.com/msitarzewski/agency-agents.git "${AGENCY_AGENTS_CACHE_DIR}"
fi

mkdir -p "${CLAUDE_AGENTS_DIR}"

# Build the install command
install_args=(
  --repo "${AGENCY_AGENTS_CACHE_DIR}"
  --target "${CLAUDE_AGENTS_DIR}"
  --manifest "${INSTALLER_DIR}/manifest.json"
)

if [[ -n "${VOICE_PATHS_FILE}" && -f "${VOICE_PATHS_FILE}" ]]; then
  log_info "Voice-DNA paths file: ${VOICE_PATHS_FILE} (voice-aware agents will get inline brand-voice block)"
  install_args+=( --voice-paths-file "${VOICE_PATHS_FILE}" )
else
  log_warn "No BRAND_VOICE_PATHS_FILE set or file missing — voice-aware agents will install without inline injection."
  log_warn "(They will still defer to user-level CLAUDE.md voice precedence.)"
fi

log_info "Running install.py..."
python3 "${INSTALLER_DIR}/install.py" "${install_args[@]}"

# Verify
agent_count=$(find "${CLAUDE_AGENTS_DIR}" -maxdepth 1 -name "*.md" | wc -l | tr -d ' ')
if [[ "${agent_count}" -lt 1 ]]; then
  log_error "No agents installed in ${CLAUDE_AGENTS_DIR} — install.py may have failed silently"
  exit 1
fi

log_info ""
log_info "agency-agents installed."
log_info "  Source repo:  ${AGENCY_AGENTS_CACHE_DIR}"
log_info "  Target dir:   ${CLAUDE_AGENTS_DIR}"
log_info "  Agent count:  ${agent_count}"
log_info "  Restart claude-agent.service for new agents to load."

log_step "agency-agents install complete"
log_implementation "07-install-agency-agents.sh" "Installed ${agent_count} agents to ${CLAUDE_AGENTS_DIR}"
