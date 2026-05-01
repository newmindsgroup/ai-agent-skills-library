# Fetch MCP — Operational Notes

## What it is

A lightweight HTTP-fetch MCP server that converts HTML to markdown for LLM consumption. Anthropic's official Python reference implementation.

- **Source:** https://github.com/modelcontextprotocol/servers/tree/main/src/fetch
- **PyPI package:** `mcp-server-fetch`
- **License:** MIT
- **Author:** Anthropic (official reference)

## What it does

One tool: `fetch(url)` — retrieves the URL, converts the HTML body to markdown, returns the text. That's it. By design.

This is the "low-tech" web read. Use it for:

- Documentation lookups
- Reading public docs and blog posts
- Quick competitive scans
- Anything you'd otherwise pipe through `curl | html2text`

It is NOT the right tool for:

- Sites that need JavaScript rendering (use Playwright MCP)
- Authenticated APIs (use the API directly)
- High-volume scraping (use Firecrawl)
- Anything that violates robots.txt (Fetch respects it; you should too)

## Installation

Automated:

```bash
bash scripts/03-install-mcp-fetch.sh
```

What the script does:
1. Installs `mcp-server-fetch` via pipx (preferred) or `pip --user` (fallback)
2. Resolves the binary path
3. Registers it with Claude Code: `claude mcp add fetch -- /path/to/mcp-server-fetch`

## Verification

```bash
claude mcp list | grep fetch
```

In a Claude Code session:

```
> Use the fetch tool to retrieve https://example.com and return the title
```

If it returns "Example Domain" or similar, the server works.

## Configuration

| Setting | Source | Notes |
|---|---|---|
| robots.txt respect | hardcoded ON | Cannot be disabled — this is intentional |
| Server name | hardcoded as `fetch` | |
| Timeout | server default | If you hit timeouts on slow sites, prefer Firecrawl |

## When to use Fetch vs. Playwright vs. Firecrawl

| Need | Use |
|---|---|
| Read a static doc page | Fetch |
| Read a SPA (JS-rendered) | Playwright |
| Crawl a whole site | Firecrawl (Tier 2) |
| Click a button or fill a form | Playwright |
| Take a screenshot | Playwright |
| Quick research lookup | Fetch |

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| `mcp-server-fetch` not found after install | pip --user bin dir not in PATH | Script registers via absolute path so this shouldn't matter; if it does, `~/.local/bin` to PATH |
| 403 / 429 from a target | Site rate-limiting or blocking bots | Don't try to bypass — use a different source |
| Empty response | JS-rendered site | Switch to Playwright MCP |
| Timeouts | Slow upstream | One-off — retry; persistent — use Firecrawl |

## Related files in this repo

- `scripts/03-install-mcp-fetch.sh` — installer
