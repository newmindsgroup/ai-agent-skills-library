# Tool-Leverage Heuristics

The autonomy playbook. This is what makes an agent *strategic* instead of reactive — explicit guidance on which tool combos to fire for which situations, so the agent reaches for the right capability without you having to remember names.

Drop this content into your project's `CLAUDE.md` (or your IDE's equivalent project-instructions file) so the agent reads it before deciding how to handle every incoming message.

> Companion to the universal installer scripts (`installers/superpowers-stack/scripts/07-09`), the cherry-picked sub-agents (`agency-agents-installer/manifest.json`), and the brand-voice + visual SSOT pattern (`AGENTS.example.md` + `DESIGN.example.md`).

---

## The trigger → tool combo table

Map common natural-language triggers to the specific tools/agents that should fire together. Add to this table as you discover patterns.

| Trigger phrase or situation | Tools/agents to fire |
|---|---|
| "AI-search visibility" / "AEO" / "are we cited by ChatGPT?" | `firecrawl_search` + `ai-citation-strategist` |
| "Write a LinkedIn post" / "thought leadership content" | Read voice playbook → `linkedin-content-creator` |
| "Generate a Midjourney/DALL-E/SD prompt" | Read `DESIGN.md` → `image-prompt-engineer` |
| "Build a deck/report/proposal as PDF/PPTX/DOCX" | `document-generator` (auto-defers to voice playbook) |
| "Production is down" / "service crashed" / "[your stack]'s broken" | `incident-response-commander` |
| "Ready to ship?" / "is this done?" / "certify this" | `reality-checker` |
| "Map this codebase" / "before I work on it" | `/graphify <path>` |
| "Find/explain X in this repo" (large repo) | `graphify query` if `graphify-out/` exists, else grep |
| "Optimize the agent stack costs" / "LLM cost" / "model routing" | `autonomous-optimization-architect` |
| "Multi-agent workflow" / "coordinate agents" | `agents-orchestrator` |
| "Dedupe contacts" / "entity resolution" / "merge across data sources" | `identity-graph-operator` |
| "Map every path through X" / "before we code" | `workflow-architect` |
| "Run a security/compliance check before merge" | `code-reviewer` (security-focused review) |
| "This query is slow" / "schema for X" | `database-optimizer` |
| "Research this prospect" / "competitive intel" | `firecrawl_*` + your `research-agent` skill |
| "Set SLOs" / "error budget for X" / "observability gap" | `sre` |
| "Scan recent content for brand drift" | `voice-drift-scanner` skill |

---

## When NOT to reach for tools

- A trivial canon lookup will do. Don't fire `firecrawl_search` for "what's my tagline" — read the brand identity doc.
- The user explicitly says "skip the heavy lift" / "just answer in one line".
- The work is one-off shell or config — engineering rituals don't apply.
- The user is in conversational / meta mode ("how are you doing", "what do you know about me") — answer briefly from canon, no tool calls.

---

## How the agent decides

Every incoming message gets routed in one of four ways:

| Classification | What it means | Action |
|---|---|---|
| **Trivial lookup** | Single fact, file path, status check, definition from canon | Answer directly with one tool call. Do not delegate. |
| **Specialized work** | Drafting, analysis, research, audit that matches a sub-agent's domain | Delegate via the Task tool. Pass tight context. |
| **Conversational** | Meta, identity, mood, casual check-in | Answer briefly from canon, no tool calls unless one is obviously needed. |
| **Ambiguous** | Intent unclear, scope unclear, missing one critical input | Ask exactly one clarifying question. |

The combo table above operates within "Specialized work." When the message matches a trigger, the agent fires the listed tool combo BEFORE drafting a reply.

---

## The brand-voice + brand-visual lock

Two non-negotiables that override everything else:

**Brand voice playbook** (your tenant-specific path):
- ALWAYS read before producing any human-facing copy. Non-negotiable.
- Banned phrases are absolute. A draft containing any banned phrase is incomplete.

**Brand visual SSOT** (`DESIGN.md` at project root):
- ALWAYS read before generating any UI, image prompt, deck, or visual artifact.
- DESIGN.md is the navigator; `design-system/tokens/tokens.json` is machine-canonical. When they disagree, tokens.json wins.

These get enforced two ways:
1. **Inline injection** — script `07-install-agency-agents.sh` injects a "Brand Voice Lock" block at the top of voice-aware sub-agents (linkedin, carousel, ai-citation, image-prompt, document-generator) at install time when `BRAND_VOICE_PATHS_FILE` is set.
2. **User-level CLAUDE.md precedence** — even non-voice-aware agents inherit the rule via the user-level `~/.claude/CLAUDE.md` declaration of voice precedence.

---

## How to extend

If you find your agent NOT firing a tool combo it should:

1. **Add the trigger phrase to the description** of the relevant sub-agent. Edit the upstream agent file, OR override its description by re-running `07-install-agency-agents.sh` with an updated `agency-agents-installer/manifest.json`.
2. **Add the combo to your project's CLAUDE.md** under "Tool-leverage heuristics."
3. **Document the new combo in this runbook** so other tenants/projects pick it up.

Per the operating principles, **always commit the change** so it propagates to other tenants and survives re-deploys.

---

## Telltales of an under-leveraged agent

If you see the agent doing any of these, the heuristics need tightening:

- Grepping a large codebase instead of running `/graphify`
- Using `fetch` for JS-heavy sites instead of `firecrawl_scrape`
- Drafting copy without first reading the voice playbook (banned phrases sneak through)
- Generating image prompts without first reading DESIGN.md (palette + composition rules ignored)
- Trying to debug a production crash from scratch instead of routing to `incident-response-commander`
- Declaring work "done" without firing `reality-checker`

Every one of these is a missing trigger in the heuristics table above. Add it, deploy, watch the agent get sharper over time.
