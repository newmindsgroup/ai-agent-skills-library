# Playwright MCP — Operational Notes

## What it is

Microsoft's official Playwright MCP server. Headless browser automation exposed as MCP tools. The VPS-side counterpart to Cowork's Chrome control.

- **Source:** https://github.com/microsoft/playwright-mcp
- **npm package:** `@playwright/mcp`
- **License:** Apache-2.0
- **Author:** Microsoft (official)

## What it does

Headless Chromium driven via MCP tools:

- `browser_navigate` — go to a URL
- `browser_click`, `browser_type`, `browser_select_option`
- `browser_screenshot` — capture pages
- `browser_snapshot` — get accessibility tree (DOM-aware, no pixel-counting)
- `browser_pdf` — render page as PDF
- `browser_console_messages`, `browser_network_requests` — debugging visibility

The accessibility-tree approach means the agent operates on semantic structure (buttons, links, inputs) rather than pixel coordinates. Faster and more reliable than pure visual automation.

## Why it's distinct from Cowork's Chrome control

Cowork's Chrome control runs on the user's local Mac with their own browser session: visible to them, interactive, manual-oversight friendly.

Playwright on the VPS is **unattended** — runs headless, no visible browser, perfect for scheduled tasks, batch screenshots, off-hours work.

| Need | Use |
|---|---|
| You want to watch what the agent is doing | Cowork Chrome control |
| Agent operates while you sleep | Playwright on VPS |
| Need authenticated session in your real browser | Cowork Chrome control |
| Need a clean isolated session | Playwright on VPS |
| Daily scheduled scrape | Playwright on VPS |
| Investigating a bug live | Cowork Chrome control |

## Installation

Automated:

```bash
bash scripts/05-install-mcp-playwright.sh
```

What the script does:
1. Detects package manager (apt) and installs Chromium runtime deps (libnss3, libatk1.0-0, etc.)
2. Pre-pulls `@playwright/mcp` via npx
3. Downloads Chromium browser (~200 MB) via `playwright install chromium`
4. Registers with Claude Code: `claude mcp add playwright -- npx -y @playwright/mcp@latest`

**This is the heaviest install in the stack** — expect ~3 minutes and ~500 MB of disk usage.

## Verification

```bash
claude mcp list | grep playwright
```

In a Claude Code session:

```
> Use the playwright tool to navigate to https://example.com and tell me the page title
```

## Configuration

Mostly defaults. The MCP server accepts CLI flags for things like browser type, viewport, user agent — see `npx -y @playwright/mcp --help`. Add flags after `@playwright/mcp@latest` in the registration command if needed.

## Resource considerations

Headless Chromium is the heaviest process in the stack:

- **RAM:** 200–500 MB per page load; can spike with heavy sites
- **CPU:** Spikes during page render
- **Disk:** Browser binaries ~200 MB; cache grows over time

On a 1 GB Vultr box: works for occasional use. For sustained scraping or parallel pages, size up.

## ToS-clean usage

Playwright is automation. Some sites prohibit automated access in their ToS. Rules of thumb:

- **OK:** Scraping public docs, screenshotting your own properties, automating forms on services you have an account with
- **Not OK:** Scraping social platforms in ways that violate their ToS, bypassing rate limits with rotating IPs, mass account creation
- **Always:** Honor robots.txt, set a polite User-Agent, throttle requests

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| `Browser not found` on first run | Chromium download failed | Re-run `npx playwright install chromium` |
| `error launching: missing libnss3` (or similar) | System deps missing | Re-run install script with sudo, or apt-get install the named lib manually |
| Hangs on simple navigation | Slow network or bot challenge | Set explicit timeout; check for CAPTCHA pages |
| OOM kills | Page too heavy or RAM too small | Size up the VPS or close other processes |
| Pages render differently than in real Chrome | Headless mode quirks | Pass `--headless=false` (where supported) or use Cowork Chrome control |

## Related files in this repo

- `scripts/05-install-mcp-playwright.sh` — installer
