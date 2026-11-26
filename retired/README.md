# Retired plugins, skills and agents

Version-Timestamp: 2026-11-26 08:09:27 AST

Everything listed here is archived, retired, or must not be installed again. Nothing is deleted: archived files sit in `skill-archive/` (ide-config-internal) or `archive/agents/` (ai-agent-skills-library) and come back with one `git mv`.

In this library, ai-agent-skills-library#14 moved the agents listed below into `archive/agents/` and took them out of the installer manifest.

Paths that start with `~/` (for example `~/.claude/` and `~/src/agency-agents`) and `openai/` paths are on the maintainer's machine or in ide-config-internal, not in this repository.

The owner's account-level entries (plugins synced from the owner's claude.ai account, and the owner's internal skills) are kept only in the private register in ide-config-internal.

## Before you install anything

1. Search this file for the name. If it is here, do not install it; use what the Replaced by column names.
2. Check the Restore paths section below. Each of those scripts can bring a retired item back without anyone asking for it.
3. Run the vetting checklist (`vetting-third-party-components`) and log the result in `~/.claude/vetting-log.md` before anything new touches client work.
4. If you do restore an item on purpose, remove its row here in the same change and say why.

## Plugins and tools

| Name | Type | Where it lived | Date | Reason | Replaced by |
|---|---|---|---|---|---|
| graphify 0.7.10 and 0.6.9, global skill and command | skill and tool | `~/.claude/skills/graphify`, global Python and uv installs | 2026-11-02 | Rejected by the vetting log: auto-triggered on codebase questions and ran outside its guards | A project's own vetted runtime when its docs name one; otherwise grep and file reads |

## Agents

| Name | Type | Where it lived | Date | Reason | Replaced by |
|---|---|---|---|---|---|
| agentic-identity-trust | agent | `~/.claude/agents/agentic-identity-trust.md`; library `agents/agentic-identity-trust.md` | 2026-11-25 | Retired 2026-10-19 for zero use in five months; never actually removed until 2026-11-25 | None |
| agents-orchestrator | agent | `~/.claude/agents/agents-orchestrator.md`; library `agents/agents-orchestrator.md` | 2026-11-25 | Retired 2026-10-19 for zero use in five months; never actually removed until 2026-11-25 | Parallel subagents through the Agent tool; `superpowers:dispatching-parallel-agents` in client projects |
| ai-engineer | agent | `~/.claude/agents/ai-engineer.md`; library `agents/ai-engineer.md` | 2026-11-25 | Retired 2026-10-19 for zero use in five months; never actually removed until 2026-11-25 | None |
| autonomous-optimization-architect | agent | `~/.claude/agents/autonomous-optimization-architect.md`; library `agents/autonomous-optimization-architect.md` | 2026-11-25 | Retired 2026-10-19 for zero use in five months; never actually removed until 2026-11-25 | `model-governor` skill |
| carousel-growth-engine | agent | `~/.claude/agents/carousel-growth-engine.md`; library `agents/carousel-growth-engine.md` | 2026-11-25 | Retired 2026-10-19 for zero use in five months; never actually removed until 2026-11-25 | None |
| identity-graph-operator | agent | `~/.claude/agents/identity-graph-operator.md`; library `agents/identity-graph-operator.md` | 2026-11-25 | Retired 2026-10-19 for zero use in five months; never actually removed until 2026-11-25 | None |
| incident-response-commander | agent | `~/.claude/agents/incident-response-commander.md`; library `agents/incident-response-commander.md` | 2026-11-25 | Retired 2026-10-19 for zero use in five months; never actually removed until 2026-11-25 | `engineering:incident-response` (Claude); `superpowers:systematic-debugging` in client projects |
| sre | agent | `~/.claude/agents/sre.md`; library `agents/sre.md` | 2026-11-25 | Retired 2026-10-19 for zero use in five months; never actually removed until 2026-11-25 | None |
| code-reviewer | agent | `~/.claude/agents/code-reviewer.md`; library `agents/code-reviewer.md` | 2026-11-25 | Duplicate of the code-review plugin | code-review plugin and the built-in `/code-review`; `/security-review` for security |
| prompt-engineering-expert | agent | `~/.claude/agents/prompt-engineering-expert.md`; library `agents/prompt-engineering-expert.md` | 2026-11-25 | Duplicate of the skill with the same name | The `prompt-engineering-expert` skill (kept) |

## Skills

| Name | Type | Where it lived | Date | Reason | Replaced by |
|---|---|---|---|---|---|
| frontend-design | skill | `~/.claude/skills/frontend-design` | 2026-11-25 | Duplicate of Anthropic's frontend-design plugin | frontend-design plugin (Anthropic) |
| grill-me | skill | `~/.claude/skills/grill-me` | 2026-11-25 | Duplicate of grilling from the same source; cannot trigger on its own | `grilling` |
| security-audit | skill | `~/.claude/skills/security-audit` | 2026-11-25 | Duplicate of security-auditor and the claude-security plugin | `security-auditor` and the claude-security plugin |
| business-model-canvas | skill | `~/.claude/skills/business-model-canvas` | 2026-11-25 | Duplicate of business-model-designer | `business-model-designer` |
| ai-product | skill | `~/.claude/skills/ai-product` | 2026-11-25 | Outdated: truncated description; covered by two fuller skills | `ai-product-patterns` and `ai-startup-building` |
| code-review-excellence | skill | `~/.claude/skills/code-review-excellence` | 2026-11-25 | Duplicate of the code-review plugin | code-review plugin, `engineering:code-review`, built-in `/code-review` |
| bug-hunter | skill | `~/.claude/skills/bug-hunter` | 2026-11-25 | Duplicate of engineering:debug | `engineering:debug` |
| architecture | skill | `~/.claude/skills/architecture` | 2026-11-25 | Duplicate of engineering:architecture | `engineering:architecture` |
| backend-architect | skill | `~/.claude/skills/backend-architect` | 2026-11-25 | Duplicate of engineering:system-design | `engineering:system-design` |
| lint-and-validate | skill | `~/.claude/skills/lint-and-validate` | 2026-11-25 | Duplicate of engineering-quality-gate | `engineering-quality-gate` |

## Restore paths to watch

- **agency-agents installer:** `~/src/agency-agents/.local-install/manifest.json` still lists the 8 retired agents and code-reviewer. Running `install.py` copies them back into `~/.claude/agents/`. Remove them from that manifest, or delete them again after a run.
- **ai-agent-skills-library superpowers-stack installer:** `07-install-agency-agents.sh` installs the agents its manifest lists. Since ai-agent-skills-library#14 that is 7; adding a retired agent back to the manifest restores it.
- **ai-agent-skills-library `install.sh` and `dist/skills`:** the library still exports skills named frontend-design, code-review-excellence, bug-hunter, architecture, backend-architect, lint-and-validate and ai-product. Installing them into `~/.claude/skills` brings the duplicates back.
- **Codex copies:** `~/.codex/skills` holds its own copies of several archived skills (frontend-design, bug-hunter, architecture, backend-architect, lint-and-validate, ai-product, business-model-canvas, code-review-excellence). They affect Codex only; `openai/skills-curation/approved-skill-policy.json` still records the old `~/.claude` paths.
- **graphify:** any global `pip install graphifyy` or `uv tool install` restores the rejected version. Use only a project's vetted runtime.

## Sources

- [`removed-log.md`](../removed-log.md): this library's record of the archived agents and the routing rewrite.
- `~/.claude/removed-log.md`: the 2026-11-25 moves and the routing changes.
- `~/.claude/vetting-log.md`: the graphify retirement and plugin vetting.
