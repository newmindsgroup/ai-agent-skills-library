#!/usr/bin/env bash
# Installs the Playwright MCP server (Microsoft official, Node).
#
# What it does:
#   - Pre-pulls the @playwright/mcp npm package via npx
#   - Triggers Chromium browser download (~200 MB) on first run
#   - Installs Linux system dependencies that headless Chromium needs
#   - Registers it with Claude Code as 'playwright' MCP server
#   - Verifies registration
#
# What it provides:
#   Headless browser automation. Navigate, click, fill forms, screenshot,
#   scrape JS-rendered DOM. The VPS-side counterpart to Cowork's Chrome control.

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

log_step "05 — Install Playwright MCP"

load_client_config

# Idempotency check
if mcp_server_installed "playwright"; then
  log_info "Playwright MCP already registered with Claude Code"
  log_implementation "05-install-mcp-playwright.sh" "Already registered, skipped"
  exit 0
fi

# ---- System dependencies ----
# Chromium needs a bunch of shared libraries. Install them via apt if available.
log_info "Checking for headless-Chromium system dependencies..."

if command -v apt-get >/dev/null 2>&1; then
  log_info "Detected apt; installing Chromium runtime dependencies..."
  sudo apt-get update -qq
  # Playwright's documented Linux deps for headless Chromium
  sudo apt-get install -y --no-install-recommends \
    libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 \
    libxkbcommon0 libxcomposite1 libxdamage1 libxfixes3 \
    libxrandr2 libgbm1 libpango-1.0-0 libcairo2 libasound2 \
    fonts-liberation \
    || log_warn "Some apt deps failed; Playwright may still work"
elif command -v dnf >/dev/null 2>&1; then
  log_warn "dnf detected; install Chromium deps manually if Playwright fails to launch"
else
  log_warn "Unknown package manager; install Chromium runtime deps manually if needed"
fi

# ---- Pre-pull and install browser ----
log_info "Pre-pulling @playwright/mcp via npx..."
npx -y @playwright/mcp --help >/dev/null 2>&1 || true

log_info "Installing Chromium browser (one-time, ~200 MB)..."
# The MCP package ships its own playwright dependency; install just the chromium browser
npx -y playwright install chromium

# ---- Register with Claude Code ----
log_info "Registering 'playwright' MCP server with Claude Code..."
claude mcp add playwright -- npx -y @playwright/mcp@latest

# Verify
if ! mcp_server_installed "playwright"; then
  log_error "'playwright' did not appear in 'claude mcp list' after registration"
  exit 1
fi

log_info ""
log_info "Playwright MCP installed."
log_info "  Server name: playwright"
log_info "  Browser: Chromium (headless)"
log_info "  Use for: JS-rendered scraping, screenshots, form automation"

log_step "Playwright MCP install complete"
log_implementation "05-install-mcp-playwright.sh" "Registered playwright MCP with Chromium"
