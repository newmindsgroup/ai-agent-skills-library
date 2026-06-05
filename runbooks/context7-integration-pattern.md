# Context7 Integration Pattern

**Status:** v1.5.0 (2026-06-05)
**Reference implementation:** ella-claude-code-ai-agent + daniel-personal-brand, 2026-06-04/05 (see commits with prefix `context7-`).
**When to apply:** any client deploy where the agent will produce code that uses third-party libraries, SDKs, frameworks, CLIs, or external APIs. Skip for non-coding tenants (e.g. a sales-only or content-only agent that never generates source code).

## Why this exists

The agent's training data ages. By the time an LLM is deployed, a third-party library's API may have shifted — new parameter names, deprecated endpoints, renamed methods, changed return shapes. Generating code from training-data guesses produces plausible-but-wrong output that costs review time and erodes trust.

[Context7](https://github.com/upstash/context7) (Upstash) is an MCP server that fetches **version-specific library documentation at query time**. The agent calls it before generating code, so the output matches today's API surface instead of yesterday's training cut-off.

This runbook codifies a seven-piece integration so any client agent gets the full benefit on day one, not just a partial install that the agent then routes around.

## The seven pieces

Apply in order. Each is independently shippable; each is verified by smoke after deploy.

### 1. Installer (operator-side)

`agent-stack/scripts/10-install-context7-mcp.sh`

What it does:
- Pre-pulls `@upstash/context7-mcp@latest` via `npx` so the first invocation is fast.
- Writes the `context7` block to the tenant's `.mcp.json` (or, fallback, runs `claude mcp add --scope user context7`).
- Idempotent — skips registration if already present.
- Updates `~/.claude.json`'s `projects[<root>].enabledMcpjsonServers` to include `context7` so Claude Code actually **loads** the project MCP at startup. Without this, the .mcp.json entry exists but the MCP is gated behind an approval dialog that never fires in `dontAsk` mode — the silent failure mode that catches teams.

Env hooks the installer reads:
- `AGENT_MCP_JSON_PATH` — path to the tenant's `.mcp.json`
- `USER_CLAUDE_JSON_PATH` — path to `~/.claude.json` (defaults to `dirname(CLAUDE_PROJECT_ROOT)/.claude.json`)
- `CLAUDE_PROJECT_ROOT` — the project key inside `.claude.json`
- `CONTEXT7_API_KEY` — optional, for higher rate limits

### 2. `.mcp.json` block (tenant template)

In `agent-template/.mcp.json.example.tmpl`:

```json
"context7": {
  "command": "npx",
  "args": ["-y", "@upstash/context7-mcp@latest"],
  "env": {
    "CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"
  }
}
```

The `${CONTEXT7_API_KEY}` is an env-var reference, not a literal — Claude Code expands it at runtime.

### 3. CLAUDE.md rule (auto-use directive)

In `agent-template/CLAUDE.md.tmpl`, a top-level `## Library / API docs — ALWAYS use Context7 before generating code` section that:
- Names the two tools by exact MCP id: `mcp__context7__resolve-library-id` then `mcp__context7__get-library-docs`.
- Lists explicit triggers (e.g. "set up X", "configure Y", "what's the API for…").
- Specifies the explicit user opt-in phrase `use context7`.
- Specifies skip conditions (pure logic, own brand canon).
- Tells the agent to surface a missing MCP rather than fall back silently.

This makes Context7 the **default behavior**, not the exceptional one.

### 4. `/docs` slash command

In `agent-template/CLAUDE.md.tmpl` slash-command routing section (or `.claude/commands/docs.md.tmpl` if the agent uses native slash commands):

```
/docs <library> [<question>] → force a Context7-grounded answer.
```

Strict: answer ONLY from returned snippets; never fall back to training data; surface MCP unavailable as an error.

### 5. VPS skill library install (`context7-cli`)

`agent-template/skills-bundle/context7-cli/` (SKILL.md + references) + `agent-template/scripts/install-context7-cli-skill.sh`.

Installs the [Context7 CLI](https://www.npmjs.com/package/ctx7) globally via `npm install -g ctx7@latest` (warn-only on failure — MCP path still works without it) and mirrors the local skill into `{{TENANT_AGENT_HOME}}/{{TENANT_AGENT_SKILLS_DIR}}/context7-cli/`.

Wire into `bootstrap-tenant.sh` step 6 so fresh deploys auto-run it.

### 6. Sub-agent awareness (cherry-picked code-producing agents)

In the agency-agents installer (`agent-stack/agency-agents-installer/install.py`):
- Add a `context7_aware` boolean flag (parallel to `voice_aware`).
- Define a `context7_block()` function that injects a "**Library Docs — Context7 First**" header at the top of the sub-agent's system prompt.
- Set `"context7_aware": true` in `manifest.json` for code-producing agents (recommended set: `ai-engineer`, `code-reviewer`, `database-optimizer`, `agentic-identity-trust`, `autonomous-optimization-architect`).

This propagates the Context7-First rule into dispatched sub-agents, which otherwise inherit only their upstream system prompt without the agent's CLAUDE.md context.

### 7. Mission Control "Library Docs" tile

In `agent-template/scripts/dashboard-sync-autonomy.py.tmpl`, add `sync_context7()`:
- Walks `~/.claude/projects/*/*.jsonl` for assistant tool_use entries whose name starts `mcp__context7__`.
- Aggregates `calls_24h`, `calls_7d`, `top_libraries` (top 5), `last_queries` (last 5).
- Writes `state/context7.json` (and via existing dashboard-sync.sh wiring, `/var/www/<host>/api/context7.json`).

In `agent-template/dashboard/index.html`, add a `data-tab="library-docs"` nav link + `data-tab-content="library-docs"` panel with four stat cards (calls 24h/7d, tier, unique libs), a top-libraries bar chart, and a recent-queries timeline. Wire `safeFetch('/api/context7.json')` into the polling list and a `renderContext7()` function into the main render loop.

Cost: $0 — pure log parsing on the free Context7 tier.

## Smoke verification (always add these to smoke-test.sh)

```bash
section "18. CONTEXT7 MCP (version-aware library docs)"
# .mcp.json registration
jq -e '.mcpServers.context7' "{{TENANT_AGENT_HOME}}/.mcp.json" >/dev/null \
  && ok "context7 in .mcp.json" || fail "context7 missing from .mcp.json"
# project trust list
jq -e --arg p "{{TENANT_AGENT_HOME}}" '.projects[$p].enabledMcpjsonServers | index("context7")' \
  "{{TENANT_USER_HOME}}/.claude.json" >/dev/null \
  && ok "context7 in enabledMcpjsonServers" \
  || fail "context7 NOT in enabledMcpjsonServers — agent will not load it"
# npx package reachable
npx -y @upstash/context7-mcp@latest --help >/dev/null 2>&1 \
  && ok "Context7 MCP package fetchable" || warn "npx fetch failed"
# CLAUDE.md rule
grep -q "ALWAYS use Context7" "{{TENANT_AGENT_HOME}}/CLAUDE.md" \
  && ok "CLAUDE.md rule present" || fail "CLAUDE.md rule missing"
# /docs slash command
grep -q "/docs <library>" "{{TENANT_AGENT_HOME}}/CLAUDE.md" \
  && ok "/docs slash command wired" || fail "/docs missing from routing"
# Mission Control endpoint
jq -e '.calls_24h, .calls_7d' "/var/www/{{TENANT_DASHBOARD_HOSTNAME}}/api/context7.json" \
  >/dev/null && ok "state/context7.json live" || fail "endpoint missing or invalid"
# Mission Control tab
grep -q 'data-tab="library-docs"' "/var/www/{{TENANT_DASHBOARD_HOSTNAME}}/index.html" \
  && ok "Library Docs tab present" || warn "Library Docs tab missing"
```

That's seven checks — six pass-required, one warn-only. Add the skill-presence check if Piece 5 was applied:

```bash
test -f "{{TENANT_AGENT_HOME}}/{{TENANT_AGENT_SKILLS_DIR}}/context7-cli/SKILL.md" \
  && ok "context7-cli skill installed" || warn "skill missing"
```

## Anti-patterns

**Don't** add a doc-staleness watcher. Context7 IS the staleness fix; a watcher is layered over the layer that already solves the problem.

**Don't** add a second `.mcp.json` registration mechanism (e.g. via `claude mcp add` AND via the .mcp.json block AND via a settings.json override). Pick one. Piece 1 handles it.

**Don't** add more CLAUDE.md rules beyond the §"Library / API docs" section in Piece 3. A second "remember to use Context7" rule elsewhere dilutes the first.

**Don't** wire the paid API key on day one unless the free tier is actually rate-limiting. Free tier is generous for a single-tenant agent. Adding paid-key plumbing prematurely creates a credentials-management surface that doesn't earn its keep.

**Don't** assume `claude mcp list` will show the project-scoped `context7` server. It won't — that listing only shows user-scope + claude.ai-connector MCPs. Project MCPs from `.mcp.json` are loaded by Claude Code at session start but don't appear in `mcp list`. Verify via the `.mcp.json` jq check and `enabledMcpjsonServers` instead.

## Known interactions

**Claude.ai hosted Context7 vs local npx Context7.** If the agent's claude.ai account has the hosted Context7 connector enabled (`https://mcp.context7.com/mcp`), it will appear in `claude mcp list` as `claude.ai Context7 ✓ Connected`. That's a *different* server with *different* tool names (e.g. `mcp__claude_ai_Context7__resolve-library-id` instead of `mcp__context7__resolve-library-id`).

Both can coexist. The CLAUDE.md rule in Piece 3 names the local npx tool names. If only the claude.ai version is wired, the rule will silently miss because the named tool doesn't exist. Always wire the local npx version per this runbook — claude.ai stays as redundant capacity.

**The `dontAsk` permission mode interaction.** Production agents typically run with `--permission-mode dontAsk` for autonomy. That mode auto-allows tool calls but does NOT auto-approve project MCPs that haven't been trusted. Piece 1's `enabledMcpjsonServers` update is what bridges this gap.

## Rollback

Each piece is independently revertible:
- `git revert <piece-N-commit>` undoes the template change.
- For Piece 1's live `.claude.json` change, the safe undo is to remove `context7` from `enabledMcpjsonServers`:
  ```bash
  jq '.projects["<root>"].enabledMcpjsonServers -= ["context7"]' ~/.claude.json
  ```
- For Piece 6's MC endpoint, the file at `state/context7.json` is regenerated on the next `dashboard-sync-autonomy.py` run; remove `sync_context7` from the dispatch tuple to stop writing it.

## See also

- `runbooks/proactive-watcher-pattern.md` — similar shape for watchers; instructive for understanding why a Context7 watcher is the wrong tool.
- `runbooks/split-llm-bash-design.md` — relevant when the LLM hallucinates `tool denied` for `mcp__context7__*` calls in `--print` mode (known issue with project MCPs in non-interactive sessions).
- `runbooks/smoke-test-recipe.md` — the broader pattern for adding `section "N. <feature>"` blocks to smoke-test.sh.
