# Memory MCP — Operational Notes

## What it is

A knowledge-graph persistent memory MCP server, official Anthropic reference implementation. Stores entities, relations, and observations across sessions in a single JSON file.

- **Source:** https://github.com/modelcontextprotocol/servers/tree/main/src/memory
- **npm package:** `@modelcontextprotocol/server-memory`
- **License:** MIT
- **Author:** Anthropic (official reference)

## What it does

Provides a small set of tools the agent can call to persist knowledge:

- `create_entities` — add named entities with type and observations
- `create_relations` — link entities (e.g., "Alice manages AcmeCorp")
- `add_observations` — append facts to an existing entity
- `read_graph` — retrieve the entire knowledge graph
- `search_nodes` — query the graph by keyword
- `open_nodes` — get specific entities and their relations

The tool is unopinionated about what you store. Common patterns: client/team facts, brand voice rules, project state, recurring patterns the agent has learned.

## Installation

Automated:

```bash
bash scripts/02-install-mcp-memory.sh
```

What the script does:
1. Reads `MEMORY_STORE_PATH` from `client.env`
2. Pre-pulls the npm package via npx
3. Registers it with Claude Code: `claude mcp add memory --env MEMORY_FILE_PATH=<path> -- npx -y @modelcontextprotocol/server-memory`
4. Initializes an empty `{}` JSON file at the store path if none exists

## Verification

```bash
claude mcp list | grep memory
```

In a Claude Code session:

```
> Use the memory tool to create an entity named "test" of type "smoke-test"
> Then read it back
```

If the entity round-trips, the server is working.

## Configuration

| Setting | Source | Notes |
|---|---|---|
| Store file path | `MEMORY_STORE_PATH` in `client.env` | Persistent across sessions; back up |
| Server name | hardcoded as `memory` | Changing requires updating CLAUDE.md docs that reference the name |

## Backup

The memory store is the most load-bearing piece of state this stack creates. Treat it like a database.

Recommended: include `${MEMORY_STORE_PATH}` in your daily VPS backup. A simple cron:

```cron
0 3 * * * cp ${MEMORY_STORE_PATH} ${MEMORY_STORE_PATH}.$(date +\%Y\%m\%d) && find $(dirname ${MEMORY_STORE_PATH}) -name "memory.json.*" -mtime +30 -delete
```

(Replace `${MEMORY_STORE_PATH}` with the actual literal path from `client.env`.)

## When to use it (vs. project-level files)

| Scenario | Use Memory MCP | Use a project file |
|---|---|---|
| Facts that span multiple projects | ✓ | |
| Brand voice / writing style rules | ✓ | |
| Project-specific architectural decisions | | ✓ (CLAUDE.md or docs/) |
| Ephemeral session state | | ✗ (just keep in chat) |
| Things the agent should "always remember" | ✓ | |

The Cowork side already has its own auto-memory system. Memory MCP on the VPS is independent — it's the VPS agent's brain across its own sessions.

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| Server not in `claude mcp list` after install | Registration failed silently | Re-run install script (idempotent) |
| `memory.json` corrupted | Process killed mid-write | Restore from backup; if no backup, `echo '{}' > ${MEMORY_STORE_PATH}` to reset |
| Server starts but tools don't work in session | Claude Code session predates registration | Restart the Claude Code session |
| Slow over time | Graph grew large | Consider periodic pruning or migrate to a Chroma+Memory hybrid |

## Related files in this repo

- `scripts/02-install-mcp-memory.sh` — installer
- `config/client.example.env` — `MEMORY_STORE_PATH` setting
