# Removed log

Version-Timestamp: 2026-11-25 11:10:37 AST

Agents moved out of the shipped library into `archive/agents/`, unchanged. Nothing is deleted. To restore one, `git mv archive/agents/<name>.md agents/<name>.md` and add it back to `.claude-plugin/marketplace.json` and `installers/superpowers-stack/agency-agents-installer/manifest.json`.

| Name | Type | Old path | Archive path | Replaced by | Date |
|---|---|---|---|---|---|
| agentic-identity-trust | agent | `agents/agentic-identity-trust.md` | `archive/agents/agentic-identity-trust.md` | Nothing (retired 2026-10-19 for zero use in five months) | 2026-11-25 |
| agents-orchestrator | agent | `agents/agents-orchestrator.md` | `archive/agents/agents-orchestrator.md` | Nothing (retired 2026-10-19 for zero use in five months) | 2026-11-25 |
| ai-engineer | agent | `agents/ai-engineer.md` | `archive/agents/ai-engineer.md` | Nothing (retired 2026-10-19 for zero use in five months) | 2026-11-25 |
| autonomous-optimization-architect | agent | `agents/autonomous-optimization-architect.md` | `archive/agents/autonomous-optimization-architect.md` | Nothing (retired 2026-10-19 for zero use in five months) | 2026-11-25 |
| carousel-growth-engine | agent | `agents/carousel-growth-engine.md` | `archive/agents/carousel-growth-engine.md` | Nothing (retired 2026-10-19 for zero use in five months) | 2026-11-25 |
| identity-graph-operator | agent | `agents/identity-graph-operator.md` | `archive/agents/identity-graph-operator.md` | Nothing (retired 2026-10-19 for zero use in five months) | 2026-11-25 |
| incident-response-commander | agent | `agents/incident-response-commander.md` | `archive/agents/incident-response-commander.md` | Nothing (retired 2026-10-19 for zero use in five months) | 2026-11-25 |
| sre | agent | `agents/sre.md` | `archive/agents/sre.md` | Nothing (retired 2026-10-19 for zero use in five months) | 2026-11-25 |
| code-reviewer | agent | `agents/code-reviewer.md` | `archive/agents/code-reviewer.md` | Anthropic's code-review plugin and the built-in `/code-review` | 2026-11-25 |
| prompt-engineering-expert | agent | `agents/prompt-engineering-expert.md` | `archive/agents/prompt-engineering-expert.md` | The `prompt-engineering-expert` skill and commands in the same plugin (kept) | 2026-11-25 |

## Do not reinstall

- The 10 agents above, unless restored on purpose.
- Synced plugins being turned off: Superpowers, Design Superpowers, Design Drift, Website Design, and the second Figma copy.

## Routing rewritten on 2026-11-25

The client template, the shipped skill and the runbooks now route to tools the superpowers-stack installs for every client, not to the archived agents:

| Request | Was | Now |
|---|---|---|
| Production is down, service crashed | `incident-response-commander` | `superpowers:systematic-debugging` |
| Multi-agent workflow, orchestrate | `agents-orchestrator` | `superpowers:dispatching-parallel-agents` |
| Security or compliance check before merge | `code-reviewer` | Built-in `/security-review`, then `/code-review` (or `superpowers:requesting-code-review`) |
| LLM cost, model routing | `autonomous-optimization-architect` | Row removed (no shipped replacement) |
| Dedupe contacts, entity resolution | `identity-graph-operator` | Row removed (no shipped replacement) |
| SLOs, error budgets | `sre` | Row removed (no shipped replacement) |

Files: `installers/superpowers-stack/config/CLAUDE.md.template`, `sources/original/skills/tool-leverage-heuristics/SKILL.md` (and its generated `dist/skills/tool-leverage-heuristics/SKILL.md`), `runbooks/tool-leverage-heuristics.md`, `runbooks/context7-integration-pattern.md` and `installers/superpowers-stack/config/client.example.env`. The archived agents stay in `archive/agents/`.

## Not changed here

The generated `dist/skills` copies of ai-engineer, code-reviewer and prompt-engineering-expert are separate skills vendored under `sources/`; they are not the archived agents and stay as they are.
