---
name: tool-leverage-heuristics
description: "Apply this skill on every session to make the agent strategic about which tools and sub-agents it reaches for. Maps natural-language triggers (\"AI-search visibility\", \"production is down\", \"map this codebase\", \"ready to ship?\") to specific tool/agent combos that should fire together. Loads as a system-prompt directive — the agent reads the trigger table before deciding how to handle each user message and proactively reaches for the right tools without being asked. Companion to runbooks/tool-leverage-heuristics.md (the human-readable version of the same patterns)."
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Claude Code production deployment patterns; agency-agents (msitarzewski) integration; multi-MCP orchestration field experience
---

# Tool-Leverage Heuristics — Autonomy Playbook Skill

You have access to multiple tools, MCP servers, and specialist sub-agents. Don't wait to be told which one to use. The table below maps common natural-language triggers to the specific tool/agent combos that should fire together.

**This skill applies before any other skill or sub-agent.** When a user message arrives, scan for the triggers in section 1. If a trigger fires, run the matching combo BEFORE drafting your reply.

---

## 1. Trigger → tool combo table

| Trigger phrase or situation | Tools/agents to fire |
|---|---|
| "AI-search visibility" / "AEO" / "are we cited by ChatGPT/Claude/Gemini/Perplexity?" | `firecrawl_search` + sub-agent `ai-citation-strategist` |
| "Write a LinkedIn post" / "thought leadership content" | Read voice playbook → sub-agent `linkedin-content-creator` |
| "Generate a Midjourney/DALL-E/SD/Imagen prompt" | Read `DESIGN.md` → sub-agent `image-prompt-engineer` |
| "Build a deck/report/proposal as PDF/PPTX/DOCX" | Sub-agent `document-generator` (auto-defers to voice playbook) |
| "Production is down" / "service crashed" / "[stack] broke" | Sub-agent `incident-response-commander` |
| "Ready to ship?" / "is this done?" / "certify this" | Sub-agent `reality-checker` |
| "Map this codebase" / "before I work on it" / "what's connected to X?" | `/graphify <path>` (build graph) → `graphify query` for traversal |
| "Find/explain X in this repo" (large repo) | `graphify query` if `graphify-out/` exists, else grep |
| "Optimize the agent stack costs" / "LLM cost" / "model routing" | Sub-agent `autonomous-optimization-architect` |
| "Multi-agent workflow" / "coordinate agents" / "orchestrate" | Sub-agent `agents-orchestrator` |
| "Dedupe contacts" / "entity resolution" / "merge across data sources" | Sub-agent `identity-graph-operator` |
| "Map every path through X" / "before we code" | Sub-agent `workflow-architect` |
| "Run a security/compliance check before merge" | Sub-agent `code-reviewer` (security-focused review) |
| "This query is slow" / "schema for X" / "indexing" | Sub-agent `database-optimizer` |
| "Research this prospect/company" / "competitive intel" | `firecrawl_*` tools + your project's research-agent |
| "Set SLOs" / "error budget" / "observability gap" | Sub-agent `sre` |
| "Scan recent content for brand drift" | Skill `voice-drift-scanner` |

This table is portable and editable. Add new triggers as you discover patterns.

---

## 2. When NOT to reach for tools

Heavy machinery is wrong for trivial work. Don't fire tools when:

- A trivial canon lookup will do (don't `firecrawl_search` for "what's our tagline" — read the brand identity doc).
- The user explicitly says "skip the heavy lift" / "just answer in one line" / "don't go deep on this."
- The work is one-off shell or config — engineering rituals don't apply.
- The user is in conversational / meta mode ("how are you doing", "what do you know about me") — answer briefly from canon, no tool calls unless one is obviously needed.

---

## 3. Decision routing

Every incoming message gets routed in one of four ways:

| Classification | What it means | Action |
|---|---|---|
| **Trivial lookup** | Single fact, file path, status check, definition from canon | Answer directly with one tool call. Do not delegate. |
| **Specialized work** | Drafting, analysis, research, audit that matches a sub-agent's domain | Delegate via the Task tool. Pass tight context. |
| **Conversational** | Meta, identity, mood, casual check-in | Answer briefly from canon, no tool calls unless one is obviously needed. |
| **Ambiguous** | Intent unclear, scope unclear, missing one critical input | Ask exactly one clarifying question. |

The trigger table operates within "Specialized work." When the message matches a trigger, fire the listed tool combo BEFORE drafting a reply.

---

## 4. Sub-agent delegation

Sub-agents auto-route via "Use PROACTIVELY when..." trigger phrases in their `description` frontmatter. You don't need to remember names — describe what's needed and delegate via the Task tool.

If the project installed sub-agents from [`msitarzewski/agency-agents`](https://github.com/msitarzewski/agency-agents) via the `installers/superpowers-stack/scripts/07-install-agency-agents.sh` script, the 16-agent cherry-pick is available in `~/.claude/agents/`. Coverage:

- **Engineering / autonomous-stack:** ai-engineer, autonomous-optimization-architect, incident-response-commander, sre, code-reviewer, database-optimizer
- **Multi-agent / orchestration:** agents-orchestrator, workflow-architect, agentic-identity-trust, identity-graph-operator
- **Content production (voice-aware):** linkedin-content-creator, carousel-growth-engine, ai-citation-strategist, document-generator
- **Visual / production gate:** image-prompt-engineer, reality-checker

Voice-aware sub-agents have inline brand-voice locks at the top of their system prompts pointing at the project's voice playbook. They will refuse drafts that violate banned phrases.

---

## 5. Brand voice + visual SSOT (non-negotiable)

These two override everything else:

**Brand voice playbook.** ALWAYS read before producing any human-facing copy. The `brand-ssot-precedence` skill (companion to this one) handles the precedence chain: project voice playbook → AGENTS.md → user-level CLAUDE.md voice rules. Banned phrases are absolute.

**Brand visual SSOT (`DESIGN.md`).** ALWAYS read before generating any UI, image prompt, deck, or visual artifact. `DESIGN.md` is the navigator; `design-system/tokens/tokens.json` is machine-canonical. When they disagree, tokens.json wins.

---

## 6. Telltales of an under-leveraged agent

If you catch yourself doing any of these, the heuristics need tightening:

- Grepping a large codebase instead of running `/graphify`
- Using `fetch` for JS-heavy sites instead of `firecrawl_scrape`
- Drafting copy without first reading the voice playbook
- Generating image prompts without first reading DESIGN.md
- Trying to debug a production crash from scratch instead of routing to `incident-response-commander`
- Declaring work "done" without firing `reality-checker`

When a missing pattern shows up, add it to section 1 and propagate to the project's CLAUDE.md.

---

## 7. How to extend

If the agent isn't firing a tool combo it should:

1. Add the trigger phrase to the description frontmatter of the relevant sub-agent.
2. Add the combo to this skill's section 1 trigger table (open a PR to the skills library).
3. Document in the project's CLAUDE.md if the heuristic is project-specific.

---

## Examples

**User:** "Hey, can you check if we're being cited in AI search engines for our consulting niche?"

**Agent (correct behavior):** Detects AI-search visibility trigger. Fires `firecrawl_search` for the niche queries + delegates to `ai-citation-strategist` sub-agent for analysis. Returns a structured citation audit.

**Agent (wrong behavior):** Does a generic web search and writes a paragraph about "monitoring AI search" without actually checking visibility for the user's brand.

---

**User:** "Production is down again, the watchdog keeps restarting the service."

**Agent (correct behavior):** Detects production-down trigger. Routes to `incident-response-commander` sub-agent immediately. Doesn't try to debug from scratch.

**Agent (wrong behavior):** Starts grepping logs and offering generic systemd advice without delegating to the specialist.

---

**User:** "What's the relationship between the auth middleware and the rate limiter?"

**Agent (correct behavior):** If `graphify-out/` exists in the repo, runs `graphify query "what connects auth to the rate limiter?"`. If no graph exists yet, suggests building one with `/graphify .` and falls back to grep + read for now.

**Agent (wrong behavior):** Greps the entire codebase, reads 12 files, produces a wall of text.

---

## License

MIT — see repository LICENSE.

This skill is the agent-loadable counterpart to `runbooks/tool-leverage-heuristics.md` (the human-readable runbook). Both are kept in sync — when you update one, update the other.
