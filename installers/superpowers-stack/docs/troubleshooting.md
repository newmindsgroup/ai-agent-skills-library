# Troubleshooting Guide

Cross-cutting issues that span multiple servers. Per-server issues live in the individual `docs/per-server/*.md` files.

## Claude Code itself

### `claude: command not found`
Claude Code is not installed on the VPS. Install per Anthropic's documentation. This stack does not bundle the Claude Code installer.

### `claude auth status` returns non-authenticated
Run `claude login` and complete the browser flow. The VPS will print a URL to open in your local browser. After approving in the browser, the VPS terminal continues.

### `claude` runs but `claude mcp list` shows nothing
Either no MCP servers have been registered yet, or your Claude Code version predates the MCP feature. Update Claude Code.

### MCP server registered but not usable in a session
Restart the Claude Code session. Registrations made during one session don't always show up until restart.

## npm / Node issues

### `npx` hangs on first run
First-time package downloads can be slow. Subsequent runs are cached. If a single `npx -y <pkg>` call times out, retry — it's a network issue, not a logic issue.

### `EACCES` permission errors during `npm install`
You're trying to install globally without sudo, or your `~/.npm` directory has wrong permissions. Don't install globally; use `npx` (which we do throughout) or `pnpm` if you prefer.

## Python / pip issues

### `pip install` errors with `externally-managed-environment`
Newer Debian/Ubuntu distros block system-wide pip installs. Use one of:
- `pipx install <pkg>` (cleanest)
- `pip install --user <pkg>` (what our scripts do)
- `pip install --break-system-packages <pkg>` (only if you understand the implication)

### `mcp-server-fetch` or `chroma-mcp` not found after install
The pip --user bin dir (`~/.local/bin`) may not be in PATH. Our scripts register MCP servers using absolute paths to avoid this, but if you're invoking manually, run:
```bash
export PATH="$HOME/.local/bin:$PATH"
```

## Network / firewall

### `curl` to github.com / npmjs / pypi times out
Outbound HTTPS is blocked or you're behind a proxy. Check `iptables -L`, your VPS provider's firewall, and any HTTPS proxy env vars. The stack needs unrestricted outbound HTTPS to those three hosts.

### Playwright Chromium download is extremely slow
Playwright downloads from a Google CDN. Some networks throttle this. Workarounds: use a different VPS region, or set `PLAYWRIGHT_DOWNLOAD_HOST` to a mirror.

## Disk / memory

### `No space left on device` during install
Run `df -h` to find the offender. Common culprits: Playwright's Chromium (`~/.cache/ms-playwright`), npm cache (`~/.npm/`), pip cache (`~/.cache/pip/`). Cleanup commands:
```bash
npm cache clean --force
pip cache purge
```

### Playwright crashes with OOM
Headless Chromium needs ≥1 GB RAM minimum, ≥2 GB recommended. If your VPS is 1 GB, either:
- Upgrade the VPS (cheapest path)
- Add swap (not great for performance but workable)
- Use Fetch MCP for static pages instead of Playwright

## Configuration

### Script complains "MEMORY_STORE_PATH must be set in client.env"
You haven't created `config/client.env` yet, or it's missing required variables. Copy from `config/client.example.env` and fill in real values.

### Filesystem MCP says "path not allowed"
The path you're trying to access isn't in `KNOWLEDGE_LIBRARY_ROOTS`. Either:
- Add it to `client.env` and re-run `04-install-mcp-filesystem.sh`
- Use a path that's already in roots

### `claude mcp add` errors with "server already exists"
The server is already registered. Our scripts check this before registering, but if you're running commands manually, use:
```bash
claude mcp remove <name>
# then add again
```

## Idempotency expectations

Every script in this repo is idempotent — re-running should be safe. If you encounter a script that errors on re-run with "already exists" or similar, it's a bug in the script, not user error. File an issue or fix the script.

## When in doubt

1. Re-read `INSTALL.md`
2. Check `install.log` (the full transcript with timestamps)
3. Check `implementation-log.md` (what was installed when)
4. Run `99-verify-all.sh` to see what's broken vs. fine
5. For component-specific issues, see `docs/per-server/<name>.md`
