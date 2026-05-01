# Filesystem MCP — Operational Notes

## What it is

A scoped filesystem-access MCP server. The agent can read, write, edit, search, and move files — but only within explicitly allowed directory roots. Anything outside is invisible.

- **Source:** https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem
- **npm package:** `@modelcontextprotocol/server-filesystem`
- **License:** MIT
- **Author:** Anthropic (official reference)

## What it does

Tools provided:

- `read_file`, `read_multiple_files`
- `write_file`, `edit_file`
- `create_directory`, `list_directory`, `directory_tree`
- `move_file`, `search_files`
- `get_file_info`

All operations are sandboxed to the configured allowed roots. The server cannot read outside those paths even if asked.

## Why this matters

Claude Code already has its own file operations (Read / Write / Edit) for the project it's running in. Filesystem MCP is for **other** directories — knowledge libraries, content drafts, brand books — that aren't part of any specific project.

Typical use: this is how a VPS agent reaches into knowledge-library directories without making them part of every individual project.

## Installation

Automated:

```bash
bash scripts/04-install-mcp-filesystem.sh
```

What the script does:
1. Reads `KNOWLEDGE_LIBRARY_ROOTS` (comma-separated absolute paths) from `client.env`
2. Validates each root exists (creates it if missing)
3. Registers with Claude Code: `claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem <root1> <root2> ...`

## Verification

```bash
claude mcp list | grep filesystem
```

In a Claude Code session:

```
> Use the filesystem tool to list the contents of <one of the allowed roots>
```

If it returns the directory listing, the server works.

## Configuration

| Setting | Source | Notes |
|---|---|---|
| Allowed roots | `KNOWLEDGE_LIBRARY_ROOTS` in `client.env` | Comma-separated, absolute paths |
| Server name | hardcoded as `filesystem` | |

## Changing allowed roots

Roots are baked into the registration. To change them:

```bash
claude mcp remove filesystem
# Edit KNOWLEDGE_LIBRARY_ROOTS in config/client.env
bash scripts/04-install-mcp-filesystem.sh
```

## Security considerations

- Roots are full-trust within their scope. The agent can write or delete anything under them.
- Do NOT add `/`, `/home`, or `/etc` as a root. Scope tightly.
- For shared multi-user VPSes, scope to a user-owned directory tree.
- Back up directories before granting write access if they contain irreplaceable content.

## When to use Filesystem vs. Claude Code's built-in Read/Write/Edit

| Scenario | Tool |
|---|---|
| Files inside the current project Claude Code is running in | Built-in Read/Write/Edit |
| Files in a knowledge library not tied to any project | Filesystem MCP |
| Content drafts shared across multiple projects | Filesystem MCP |
| Reading a teammate's documents you've been pointed at | Filesystem MCP (if path is in roots) |

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| "path not allowed" error | Path is outside configured roots | Check `KNOWLEDGE_LIBRARY_ROOTS`; add the root and reinstall |
| Server not in `claude mcp list` | Registration failed | Re-run install script |
| Path traversal blocked (`..` segments) | Working as designed | Use absolute paths within roots |

## Related files in this repo

- `scripts/04-install-mcp-filesystem.sh` — installer
- `config/client.example.env` — `KNOWLEDGE_LIBRARY_ROOTS` setting
