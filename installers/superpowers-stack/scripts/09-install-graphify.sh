#!/usr/bin/env bash
# Installs Graphify (https://github.com/safishamsi/graphify) — turns a project
# folder into a queryable knowledge graph the agent reads instead of grepping.
#
# What it does:
#   - Installs `uv` (Astral) if missing — single-binary Python tool installer
#   - `uv tool install graphifyy` (note double-y in package name)
#   - `graphify install` to register the skill with Claude Code so /graphify
#     becomes available as a slash command
#   - Idempotent — skips installs that are already in place
#
# What it provides:
#   /graphify <path>   build a knowledge graph from any folder (code + docs + PDFs + images)
#   /graphify query    query the graph instead of grepping
#   graphify update    re-extract code files only (AST, no API cost)
#   graphify watch     auto-rebuild on file changes
#
# Cost note: first build calls the model API for non-code files. Subsequent
# AST-only updates are free. Run with --no-viz on large repos.

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

log_step "09 — Install Graphify"

load_client_config

# Idempotency: if `graphify` is already on PATH, skip the install
GRAPHIFY_BIN="$(command -v graphify 2>/dev/null || true)"
UV_BIN="$(command -v uv 2>/dev/null || true)"

# Common locations uv installs to
if [[ -z "${UV_BIN}" && -x "${HOME}/.local/bin/uv" ]]; then
  UV_BIN="${HOME}/.local/bin/uv"
fi

# Install uv if missing
if [[ -z "${UV_BIN}" ]]; then
  log_info "uv not found — installing via Astral installer..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  UV_BIN="${HOME}/.local/bin/uv"
  if [[ ! -x "${UV_BIN}" ]]; then
    log_error "uv install did not produce a binary at ${UV_BIN}"
    exit 1
  fi
  log_info "uv installed at ${UV_BIN}"
else
  log_info "uv already at ${UV_BIN}"
fi

# Install graphifyy
if [[ -z "${GRAPHIFY_BIN}" && -x "${HOME}/.local/bin/graphify" ]]; then
  GRAPHIFY_BIN="${HOME}/.local/bin/graphify"
fi

if [[ -z "${GRAPHIFY_BIN}" ]]; then
  log_info "Installing graphifyy via uv tool install..."
  "${UV_BIN}" tool install graphifyy
  GRAPHIFY_BIN="${HOME}/.local/bin/graphify"
  if [[ ! -x "${GRAPHIFY_BIN}" ]]; then
    log_error "graphify did not appear at ${GRAPHIFY_BIN}"
    exit 1
  fi
else
  log_info "graphify already at ${GRAPHIFY_BIN}"
fi

# Register the skill with Claude Code (idempotent — graphify install handles this)
log_info "Registering Graphify skill with Claude Code..."
"${GRAPHIFY_BIN}" install 2>&1 | tail -5

# Verify
if [[ ! -f "${HOME}/.claude/skills/graphify/SKILL.md" ]]; then
  log_error "Graphify SKILL.md not found at ${HOME}/.claude/skills/graphify/SKILL.md"
  exit 1
fi

log_info ""
log_info "Graphify installed."
log_info "  CLI:           ${GRAPHIFY_BIN}"
log_info "  Skill:         ${HOME}/.claude/skills/graphify/SKILL.md"
log_info "  First build:   run /graphify <path> from a Claude Code session in the target repo"
log_info "  Cost note:     first build calls the model API for non-code files; AST updates are free"

log_step "Graphify install complete"
log_implementation "09-install-graphify.sh" "Installed graphify CLI + Claude Code skill"
