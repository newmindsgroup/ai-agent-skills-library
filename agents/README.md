# Sub-Agents

This folder contains 16 specialist sub-agents cherry-picked from [`msitarzewski/agency-agents`](https://github.com/msitarzewski/agency-agents) (MIT). They are **portable, tenant-agnostic, project-agnostic** — drop them into any Claude Code, Cursor, or Cowork project's `~/.claude/agents/` (or equivalent) directory and they auto-route on natural-language triggers via "Use PROACTIVELY when..." phrases in their `description` frontmatter.

> **Skills vs sub-agents.** Skills (in `skills/`) load as system-prompt directives the agent reads on every turn. Sub-agents (here) are full specialist personas the harness can delegate to via the Task tool. Use sub-agents when work needs deep, domain-focused execution — not just guidance.

---

## How to install

### Claude Code

```bash
# Install all 16
cp agents/*.md ~/.claude/agents/

# Or only specific agents
cp agents/linkedin-content-creator.md agents/incident-response-commander.md ~/.claude/agents/
```

After install, the agents are available in every Claude Code session — the harness reads their `description` triggers and auto-routes when matching language appears. No further configuration required.

### Cowork

```bash
# Cowork sessions read the same ~/.claude/agents/ as Claude Code, so the
# above command works for Cowork too. If your Cowork install uses a
# different agent directory, copy there.
```

### Other IDEs

The sub-agent format (markdown with frontmatter) is the cross-IDE convention popularized by the [Agent Skills spec](https://agentskills.io). For IDEs without explicit sub-agent support, the same files work as project-instruction snippets — `cat agents/<name>.md >> CLAUDE.md` (or your IDE's equivalent) to load the relevant ones.

---

## The 16 cherry-picked agents

### Engineering / autonomous-stack

| Agent | When to use |
|---|---|
| [`ai-engineer`](ai-engineer.md) | ML model selection, LLM integration, RAG, embeddings, vector DBs, autonomous-agent reliability |
| [`autonomous-optimization-architect`](autonomous-optimization-architect.md) | LLM cost optimization, model routing, shadow testing, cost-per-task budgets, guardrails |
| [`incident-response-commander`](incident-response-commander.md) | Production-down events, hotfix chains, recurring-crash debugging |
| [`sre`](sre.md) | SLOs, error budgets, observability, alerting, capacity planning, toil reduction |
| [`code-reviewer`](code-reviewer.md) | Pre-merge review, security checks, maintainability gates |
| [`database-optimizer`](database-optimizer.md) | Slow queries, schema design, indexing, migration planning |

### Multi-agent / orchestration

| Agent | When to use |
|---|---|
| [`agents-orchestrator`](agents-orchestrator.md) | Coordinating multi-agent workflows |
| [`workflow-architect`](workflow-architect.md) | Mapping systems end-to-end before coding; documenting every path through a flow |
| [`agentic-identity-trust`](agentic-identity-trust.md) | Agent authentication, multi-agent authorization, audit trails |
| [`identity-graph-operator`](identity-graph-operator.md) | Entity deduplication across data sources (e.g., contact merge across CRMs) |

### Content production (voice-aware — defer to brand voice playbook)

| Agent | When to use |
|---|---|
| [`linkedin-content-creator`](linkedin-content-creator.md) | LinkedIn posts, content calendars, thought leadership, personal brand presence |
| [`carousel-growth-engine`](carousel-growth-engine.md) | IG/TikTok carousels, batch publish, slide narratives |
| [`ai-citation-strategist`](ai-citation-strategist.md) | AEO/GEO, AI-search visibility audits, citation tracking across ChatGPT/Claude/Gemini/Perplexity |
| [`document-generator`](document-generator.md) | PDF/PPTX/DOCX/XLSX generation from code (proposals, reports, decks, exports) |

These agents will read your project's brand voice playbook + DESIGN.md before producing output if the [`brand-ssot-precedence`](../skills/brand-ssot-precedence/) skill is also installed.

### Visual / production gate

| Agent | When to use |
|---|---|
| [`image-prompt-engineer`](image-prompt-engineer.md) | Midjourney / DALL-E / Stable Diffusion / Imagen prompts |
| [`reality-checker`](reality-checker.md) | Final evidence-based quality gate before declaring anything ready to ship |

---

## How auto-routing works

Each agent's frontmatter includes a `description` field with explicit `Use PROACTIVELY when...` trigger phrases. When you (the user) send a message, the Claude Code harness reads all installed agent descriptions and routes work to the matching specialist via the Task tool.

You don't need to remember names. Examples:

- *"Help me draft a LinkedIn post about…"* → `linkedin-content-creator` fires
- *"Production is down, the watchdog keeps restarting"* → `incident-response-commander` fires
- *"Generate a Midjourney prompt for our hero image"* → `image-prompt-engineer` fires
- *"Is this branch ready to ship?"* → `reality-checker` fires
- *"Optimize the LLM cost on our agent stack"* → `autonomous-optimization-architect` fires

For the full trigger combo table, see [`runbooks/tool-leverage-heuristics.md`](../runbooks/tool-leverage-heuristics.md) or install the [`tool-leverage-heuristics`](../skills/tool-leverage-heuristics/) skill so the agent applies it proactively.

---

## Brand-voice integration

The four content-producing agents (`linkedin-content-creator`, `carousel-growth-engine`, `ai-citation-strategist`, `document-generator`) are voice-aware — they expect a brand voice playbook to exist in the project and will read it before drafting.

**Two ways to wire up brand voice:**

1. **Lightweight** (recommended for cross-project portability): install the [`brand-ssot-precedence`](../skills/brand-ssot-precedence/) skill alongside these agents. The skill defines the precedence chain (AGENTS.md → DESIGN.md → voice playbook → tokens.json) and the agents pick it up automatically.

2. **Heavyweight** (for VPS-deployed always-on agents): use the [`installers/superpowers-stack/scripts/07-install-agency-agents.sh`](../installers/superpowers-stack/scripts/07-install-agency-agents.sh) script with `BRAND_VOICE_PATHS_FILE` set in `client.env`. The installer injects an inline brand-voice block into each voice-aware agent at install time, hard-coding the paths to your specific brand canon files.

For one-off or experimental projects, option 1 is enough. For production deployments where you want guarantees the voice block is always loaded, option 2.

---

## Updating the cherry-pick

The 16 agents here are a curated subset of the ~150 agents in the upstream `msitarzewski/agency-agents` repo. To customize the list:

1. Edit [`installers/superpowers-stack/agency-agents-installer/manifest.json`](../installers/superpowers-stack/agency-agents-installer/manifest.json) — add, remove, or change the `name` / `triggers` / `voice_aware` fields per agent.
2. Re-run the portable installer: `python3 installers/superpowers-stack/agency-agents-installer/install.py --repo /path/to/agency-agents-clone --target ./agents --manifest installers/superpowers-stack/agency-agents-installer/manifest.json`
3. Commit the updated `agents/` folder.

The portable installer accepts an optional `--voice-paths-file` flag for tenant-specific brand-voice injection. Without it (as used here), agents are tenant-agnostic and rely on the brand-ssot-precedence skill or user-level CLAUDE.md voice rules.

---

## License

MIT — same as the upstream `msitarzewski/agency-agents` repo. Each agent file preserves the original upstream content with the addition of explicit "Use PROACTIVELY when..." trigger phrases for harness auto-routing.

---

## Reference

- Upstream collection: [`msitarzewski/agency-agents`](https://github.com/msitarzewski/agency-agents) (MIT, ~150 agents)
- Cherry-pick rationale: see [`installers/superpowers-stack/agency-agents-installer/manifest.json`](../installers/superpowers-stack/agency-agents-installer/manifest.json) `_comment` field
- Companion skills: [`skills/tool-leverage-heuristics/`](../skills/tool-leverage-heuristics/), [`skills/brand-ssot-precedence/`](../skills/brand-ssot-precedence/)
- Companion runbook: [`runbooks/tool-leverage-heuristics.md`](../runbooks/tool-leverage-heuristics.md)
