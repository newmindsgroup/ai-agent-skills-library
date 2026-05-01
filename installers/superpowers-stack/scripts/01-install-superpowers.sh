#!/usr/bin/env bash
# Installs the Superpowers Claude Code plugin from Anthropic's official marketplace.
#
# What it does:
#   - Checks if Superpowers is already installed (idempotent)
#   - Runs `claude plugin install superpowers@claude-plugins-official`
#   - Verifies the install
#   - Logs success to implementation-log.md
#
# What it does NOT do:
#   - Modify any project's CLAUDE.md (you do that manually after — see config/CLAUDE.md.template)
#   - Configure per-project skill activation rules
#
# Manual fallback if this script fails:
#   Open an interactive Claude Code session and run:
#     /plugin install superpowers@claude-plugins-official
#   Or, if the official marketplace is unavailable:
#     /plugin marketplace add obra/superpowers-marketplace
#     /plugin install superpowers@superpowers-marketplace

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

log_step "01 — Install Superpowers (Claude Code plugin)"

load_client_config

# Idempotency check
if plugin_installed "superpowers"; then
  log_info "Superpowers already installed — skipping"
  log_implementation "01-install-superpowers.sh" "Already installed, skipped"
  exit 0
fi

# Install from the official Anthropic marketplace
log_info "Installing superpowers@claude-plugins-official..."
if claude plugin install "superpowers@claude-plugins-official"; then
  log_info "Install command succeeded"
else
  log_warn "Official marketplace install failed; trying author marketplace fallback"
  claude plugin marketplace add "obra/superpowers-marketplace" || true
  claude plugin install "superpowers@superpowers-marketplace"
fi

# Verify
log_info "Verifying install..."
if ! plugin_installed "superpowers"; then
  log_error "Superpowers does not appear in 'claude plugin list' after install"
  exit 1
fi

# List the skills it ships
log_info "Superpowers ships these skills (auto-fire on relevant tasks):"
log_info "  brainstorming, writing-plans, subagent-driven-development,"
log_info "  executing-plans, test-driven-development, requesting-code-review,"
log_info "  finishing-a-development-branch, systematic-debugging,"
log_info "  verification-before-completion, dispatching-parallel-agents,"
log_info "  using-git-worktrees, writing-skills"

log_info ""
log_info "NEXT STEP: For each project where you want Superpowers to fire,"
log_info "  append config/CLAUDE.md.template to that project's CLAUDE.md."
log_info "  Skills will not fire on projects without the directive block."

log_step "Superpowers install complete"
log_implementation "01-install-superpowers.sh" "Installed superpowers@claude-plugins-official"
