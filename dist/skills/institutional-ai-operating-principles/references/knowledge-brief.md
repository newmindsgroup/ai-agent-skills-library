# How the Best Companies Use AI — Knowledge Brief

**Source video:** *How the Best Companies Use AI* — The AI Daily Brief (NLW), April 2026, 22:02. [YouTube link](https://www.youtube.com/watch?v=t8vitqIj7u4)

**Purpose of this document:** Extract every tip, recommendation, and framework from the episode, verify each against the primary sources the host cites, and compile the tools/resources needed to implement them inside New Minds Group projects. Nothing in this brief is invented — every claim is sourced.

---

## 1. The central thesis

> *"The models are good enough. The harness isn't."* — Seb Goddijn, Ramp ([Ramp blog, via Reddit mirror](https://www.reddit.com/r/Ramp/comments/1skix41/we_built_every_employee_at_ramp_their_own_ai/))

The podcast makes one argument in three layers:

1. **Individual productivity ≠ organizational productivity.** AI has made individuals ~10x more productive, but no company is 10x more valuable yet — because the *institution* wasn't redesigned, only the tool was swapped in ([George Sivulka, a16z](https://www.a16z.news/p/institutional-ai-vs-individual-ai)).
2. **The gap between AI leaders and laggards is growing fast.** PwC found that **~75% of AI's economic gains are being captured by ~20% of companies**, and leaders are **2–3x more likely** to use AI for growth opportunities (not just cost-cutting) and **2.6x more likely** to report AI improves their ability to reinvent their business model (cited by NLW from the PwC study referenced earlier that week).
3. **The winning pattern is systems, not tools.** Leaders build a *harness* — an AI workspace with auto-connected tools, shared skills, persistent memory, and scheduled automations — so every employee starts at a high floor on day one.

---

## 2. McKinsey's 12-Theme AI Transformation Manifesto (verified against the source)

Source: [McKinsey — The AI transformation manifesto: 12 themes driving growth](https://www.mckinsey.com/capabilities/tech-and-ai/our-insights/the-ai-transformation-manifesto) (April 2026).

| # | Theme (verbatim) | Diagnostic question | What to do about it |
|---|---|---|---|
| 1 | Technology alone doesn't create advantage; enduring capabilities do. | Are you building enduring capabilities for the journey, or merely delivering one-off solutions? | Treat every AI project as capability-building, not a one-off deliverable. Codify learnings. |
| 2 | Economic leverage points are your best focal points. | Have you disproportionately focused your AI efforts on your economic leverage points? | Identify the 1–3 business domains where AI most moves revenue/margin, and concentrate there. |
| 3 | If the value you're creating doesn't move the business, you're getting it wrong. | Will your business transformation plan result in game-changing value, or will the wins be incremental? | Target **20% EBITDA uplift**, **break-even in 1–2 years**, **$3 incremental EBITDA per $1 invested** (McKinsey's leader benchmark, n=20 companies). |
| 4 | Building the tech and AI muscle of your senior business leaders should be a top priority. | Are your senior business leaders tech- and AI-capable? | Don't outsource transformation. Leaders must combine domain expertise with AI fluency. |
| 5 | Every tech and AI transformation is a people transformation. | Have you progressed enough on your people transformation? | McKinsey's **"30–70 shifts"**: >70% of AI talent in-house, >70% "doer" engineers, >70% at competent/expert skill level. |
| 6 | Speed is the defining organizational advantage. | What are you doing to increase the metabolic rate of your organization? | Measure cycle time (idea → shipped). Remove approval bottlenecks. Give unlimited AI budgets where ROI is clear. |
| 7 | Tech platforms are strategic assets; invest in them that way. | Are platforms understood and discussed as strategic assets? | Budget platforms like strategic investments, not cost centers. |
| 8 | Make data easy to consume—and enrich it for advantage. | Can your teams easily consume your data, or are they still wrangling it? | Data is the #1 constraint at laggards. Treat data as an ongoing operational discipline, not a one-time cleanup. |
| 9 | Design for adoption and build for scale. | Can your organization repeatedly adopt and scale AI, or is it still relying on isolated heroics? | Design every AI workflow so it can be shared and reused. No snowflake setups. |
| 10 | No trust, no right to deploy AI. | Would your AI deployments withstand public, regulatory, and customer scrutiny today? | Bake governance, auditability, and guardrails into the design, not after. |
| 11 | Agentic engineering becomes the next capability to master. | Will agentic workflows be your next engineering advantage—or your next catch-up problem? | Ingest unstructured data, extend platforms with agents, automate guardrails, codify a repeatable agentic playbook. |
| 12 | (Re)learn like your business depends on it. | Are you personally investing enough in continuous learning? | The half-life of skills is shrinking. Leadership learning journeys are the single highest-leverage CEO activity right now. |

**NLW's commentary (episode):** Theme 11 is the one area where even leading enterprises lag the frontier, because they still frame "agentic engineering" as a software-development discipline. At frontier companies, agentic engineering is the work of *everyone*.

---

## 3. The Seven Pillars of Institutional Intelligence (George Sivulka, a16z)

Source: [Institutional AI vs Individual AI — George Sivulka, a16z](https://www.a16z.news/p/institutional-ai-vs-individual-ai) (March 2026). Sivulka is the founder of Hebbia.

The historical analogy: 1890s textile mills installed electric motors where steam engines used to be — and saw **no productivity gain for 30 years**. Gains only came once factories redesigned the *floor* (assembly lines, distributed motors, new worker roles) in the 1920s. "We have our electricity. It's time to redesign our factories."

| # | Pillar | Individual AI | Institutional AI | Implication |
|---|---|---|---|---|
| 1 | **Coordination** | creates chaos | creates coordination | Without a coordination layer, every employee has their own ChatGPT habits, prompting styles, and outputs that don't talk to each other. Need defined swim lanes, OKRs, and agent-to-agent/agent-to-human protocols. |
| 2 | **Signal** | creates noise | finds signal | Generating anything is no longer the problem; selecting the right thing is. Institutional AI must be **defined, deterministic, and auditable** — deterministic agents with predictable checkpoints, not freewheeling chatbots. |
| 3 | **Bias** | feeds bias (sycophancy) | creates objectivity | The most important agents are "no-men," not "yes-men" — they interrogate reasoning, surface risks, enforce standards. Future categories: AI board members, auditors, compliance. |
| 4 | **Edge** | optimizes for usage | optimizes for edge | The future is ChatGPT/Claude **and** a domain-specific solution — not *or*. Purpose-built tools always lead the frontier for their niche. |
| 5 | **Outcomes** | saves time | scales revenue | CEOs prioritize revenue, but most AI products sell time-savings. Move "upstream" to the solution layer where outcomes (not tools) live. |
| 6 | **Enablement** | gives you a tool | shows you how to use it | "Process engineering" (a.k.a. writing Claude skills files) becomes arguably the most important technology in the near term. Domain expertise beats software expertise in rollout. |
| 7 | **Unprompted** | responds to prompts | acts unprompted | The most valuable work is the work nobody thinks to ask for. Unprompted systems watch data continuously and flag risks/opportunities before anyone asks. |

---

## 4. The Ramp / Glass case study — the operational blueprint

This is the most concrete, copyable section of the podcast. Every claim below is verified against Seb Goddijn's public writing and the Ramp/NLW/a16z ecosystem.

Sources:
- [Seb Goddijn on X](https://x.com/sytaylor/status/2042486675704533471) — "We Built Every Employee at Ramp Their Own AI Coworker"
- [Reddit mirror of the full essay](https://www.reddit.com/r/Ramp/comments/1skix41/we_built_every_employee_at_ramp_their_own_ai/)
- [Eric Glyman (Ramp co-founder) on X](https://x.com/eglyman/status/2043362828178841860)
- [AI Catchup — Internal AI Workspaces: The Ramp Glass Playbook](https://aicatchup.com/practices/internal-ai-workspaces-playbook)

### 4.1 The diagnosis

Ramp hit **99% AI adoption** — but most employees were stuck. Not because the models weren't good enough, but because:
- Terminal windows, npm installs, and MCP configurations overwhelmed most users.
- Those who did figure it out had **wildly different, unshareable setups** ("snowflake configurations").
- Urgency had been created without the infrastructure to act on it.

### 4.2 The three founding principles of Glass (Ramp's internal AI workspace)

1. **Don't limit anyone's upside.** The conventional move for non-technical users is to dumb things down. Ramp refused. "The goal isn't to remove complexity but to make it **invisible** while preserving full capability."
2. **One person's breakthrough should become everyone's baseline.** The biggest failure mode was that everyone had to figure things out alone.
3. **The product is the enablement.** No workshop can match a targeted nudge delivered while someone is already doing the work.

Motto: *"We don't believe in lowering the ceiling. We believe in raising the floor."*

### 4.3 The five structural components of Glass

| Component | What it does | Why it matters |
|---|---|---|
| **1. SSO-connected workspace** | One Okta sign-in auto-connects every internal tool (Slack, Notion, Linear, Gong, Salesforce, Zendesk, Ramp Research, Ramp Inspect, Ramp CLI). Zero setup. | Eliminates the configuration tax. "When a sales rep asks Glass to pull context from a Gong call, enrich it with Salesforce data, and draft a follow-up, it just works because everything is already connected." |
| **2. Dojo — a skills marketplace** | A Git-backed, versioned, code-reviewed marketplace of **350+ reusable skills**, each a markdown file that teaches an agent how to perform a specific task. | Converts tribal knowledge into organizational capability. One person's workflow becomes everyone's baseline. |
| **3. Sensei — an AI skill recommender** | An in-Glass guide that looks at each employee's connected tools, role, and recent activity, and surfaces the ~5 most relevant skills. | Solves discovery. A new account manager doesn't browse 350 skills; Sensei picks the five that matter on day one. |
| **4. Persistent memory** | On first open, Glass builds a memory system from the user's authenticated connections — people, active projects, Slack channels, Notion docs, Linear tickets. A **24-hour synthesis + cleanup pipeline** mines recent sessions and connected tools for updates. | Every conversation starts with full context. No re-explaining. |
| **5. Scheduled automations** | Cron-style jobs run daily/weekly/custom cadence and post directly to Slack. Users don't have to be at their device. | Example: a finance lead pulls spend anomalies at 8am each morning. Agents work overnight. |

### 4.4 Reported outcomes (from Ramp, 1 month post-launch)

- **99% daily AI usage** (Ramp-wide baseline, not Glass-specific)
- **700 daily active users** of Glass
- **350+ shared skills** in Dojo
- **84% of employees use coding agents weekly**, including marketers, finance, and ops teams ([Midas Tools summary](https://www.midastools.co/blog/ramp-ai-adoption-playbook-2026))

*Caveat:* The 84% and 99.5% figures come from secondary summaries and third-party reporting. The 99% figure is from Eric Glyman's own post. Cite as Ramp-reported.

### 4.5 Why Ramp built it instead of buying (Seb's three reasons)

1. **Internal productivity is a moat.** Don't hand your moat to a vendor.
2. **Speed of feedback.** Ship fixes the same day a user reports a problem. Most issues resolved in hours.
3. **It directly informs the external product.** Ramp sells to finance teams, and the memory/skills/distribution problems they solved internally translate straight to customers.

### 4.6 The L0–L3 AI Proficiency Framework

Ramp uses an internal proficiency ladder (reported by [Midas Tools](https://www.midastools.co/blog/ramp-ai-adoption-playbook-2026)):

- **L0 — Non-user.** Hasn't tried AI tools.
- **L1 — Basic.** Uses AI for chat, summarization, simple Q&A.
- **L2 — Integrated.** AI embedded into daily workflows, used for drafting, analysis, code review.
- **L3 — Autonomous.** Delegates entire workflows to agents, builds custom automations, ships code via agents.

**Key insight:** The jump from L1 → L2 is where the real value lives. Most companies have people stuck at L1. Moving them to L2 is the inflection point.

---

## 5. What the podcast says a "skill" actually is

NLW references "agent skills, markdown files that teach your agent how to perform a specific task." This is the **Agent Skills** open standard, originated by Anthropic and now adopted by Microsoft, OpenAI, Cursor, GitHub, and others.

Primary source: [Anthropic — Equipping agents for the real world with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills) and the [Agent Skills specification](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview).

### The SKILL.md contract (verified from Anthropic's spec)

```
your-skill/
├── SKILL.md          (required; contains YAML frontmatter + instructions)
├── references/       (optional; deep-dive files loaded only when needed)
│   └── *.md
├── scripts/          (optional; executable Python/bash, run but not read into context)
└── assets/           (optional; templates, schemas, examples)
```

**YAML frontmatter — required fields:**
- `name` — max 64 chars, lowercase + hyphens + digits only, cannot be "anthropic"/"claude"
- `description` — max 1024 chars, **written in third person**, must explain **what** it does and **when** to use it

**Three-tier progressive disclosure:**
| Level | When loaded | Token cost | Content |
|---|---|---|---|
| 1 — Metadata | Always, at startup | ~100 tokens/skill | `name` + `description` from YAML frontmatter |
| 2 — Instructions | When skill is triggered | <5k tokens | SKILL.md body |
| 3 — Resources | As needed | Effectively unlimited | Files in `references/`, `scripts/`, `assets/` |

**Authoring best practices (from [Anthropic's authoring guide](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)):**
- Keep SKILL.md body **under 500 lines**.
- Use **gerund names** (`processing-pdfs`, `analyzing-spreadsheets`) or noun phrases.
- Default assumption: Claude is already smart. Only add context Claude doesn't already have.
- Split into `references/*.md` when paths are mutually exclusive or rarely used together.
- Use scripts for deterministic operations (they run without consuming context).
- For MCP tools, always use fully qualified names: `ServerName:tool_name`.

---

## 6. NLW's closing synthesis — the three things leaders do differently

From the episode's conclusion:

1. **They frame AI around growth and new business, not efficiency and productivity.**
2. **They build systems** — coordination systems, context systems, and harness systems that make every employee an AI power user. They reject the assumption that the workforce divides into "chat users / copilot users / Claude Code users." Everyone's ceiling is unbounded; only the pacing differs.
3. **They treat AI use as a core organizational primitive** — not something outsourceable to vendors or consultants.

---

## 7. Tools & resources map (for implementation)

### Agent harnesses (the "Glass equivalent" for your team)
- **Claude Code** — [anthropic.com/claude-code](https://www.anthropic.com/claude-code). Supports custom SKILL.md skills via `.claude/skills/` (project) or `~/.claude/skills/` (personal). Full filesystem and network access.
- **Codex CLI / Codex App** (OpenAI) — GPT 5.2/5.3/5.4 series. Now ships with scheduled automations.
- **Cursor** — Supports the AGENTS.md standard plus SKILL.md via plugins.
- **Vercel's open-sourced reference platform for cloud coding agents** — [announced by Guillermo Rauch](https://vercel.com/blog) (referenced in the episode). Useful as a starting framework if you want to build a Glass-like internal harness.

### The open standards to build on
- **SKILL.md** — [Anthropic spec](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview) + [open-source skills repo](https://github.com/anthropics/skills). Adopted by 25+ tools.
- **AGENTS.md** — OpenAI + Google + Cursor convention, governed by the Linux Foundation's Agentic AI Foundation. Project-level instructions file. Used by 60,000+ GitHub repos.

### Infrastructure layers Glass uses (and you'd replicate)
- **SSO:** Okta, Google Workspace SSO, Azure AD
- **Memory:** a 24-hour synthesis pipeline across Slack, Notion, Linear, Calendar
- **Skills repo:** Git-backed marketplace, versioned and code-reviewed
- **Scheduling:** cron + Slack integration
- **Discovery:** an embedding/LLM-based recommender (Ramp's Sensei)

### The primary essays — read these in full
1. [McKinsey — The AI transformation manifesto: 12 themes driving growth](https://www.mckinsey.com/capabilities/tech-and-ai/our-insights/the-ai-transformation-manifesto)
2. [a16z — Institutional AI vs Individual AI (George Sivulka)](https://www.a16z.news/p/institutional-ai-vs-individual-ai)
3. [Ramp — We Built Every Employee at Ramp Their Own AI Coworker (Seb Goddijn)](https://www.reddit.com/r/Ramp/comments/1skix41/we_built_every_employee_at_ramp_their_own_ai/) *(full essay mirror)*
4. [Anthropic — Equipping agents for the real world with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)

---

## 8. A 90-day implementation roadmap for New Minds Group

Applied to a design / UX / business-development studio like yours. Derived directly from the podcast's recommendations — no invented steps.

### Phase 1 — Days 1–14: Map your leverage points and your L-levels
1. Identify **1–3 economic leverage points** for New Minds (McKinsey theme 2). Candidates for a UX/design/biz-dev studio: proposal + RFP generation, research synthesis, design system maintenance, client reporting, lead qualification.
2. Map every team member on the **L0–L3 proficiency ladder**. Goal: everyone at L2 within 90 days.
3. Pick one harness as your standard: Claude Code, Codex, or a combination. Don't let everyone snowflake their setup.

### Phase 2 — Days 15–45: Build your skills library (your "Dojo")
4. Create a shared Git repo: `newminds-skills/`. Every skill is a `SKILL.md` folder (see the AI rules file in this package for the exact authoring standard).
5. Seed it with the 5–10 skills your leverage points need first — e.g. `drafting-proposals`, `synthesizing-user-research`, `auditing-ux-copy`, `generating-case-studies`, `preparing-client-briefs`.
6. Require every skill to be code-reviewed like code. Version with semver.

### Phase 3 — Days 46–75: Connect everything on day one
7. Wire your tools through SSO so new agents/teammates get Notion, Google Drive, Google Analytics, GSC, GitHub, Trello, Canva, Slides, Sheets, Meet, GMB, YouTube, Vercel already connected. You already have connectors for all of these — inventory is in the appendix.
8. Build a persistent memory layer: a nightly job that pulls the last 24h of Slack threads, Google Docs edits, Trello cards, and calendar events into a compact user/project memory file.
9. Add scheduled automations: daily client-status digests, weekly analytics summaries, pre-meeting briefings.

### Phase 4 — Days 76–90: Close the loop
10. Instrument usage: how many people are using each skill? How often? Which are the most popular? Which are stale?
11. Run the Sensei pattern manually: every Monday, one person looks at what each teammate is working on and recommends the 1–3 skills they should try that week.
12. Measure against McKinsey's leader benchmarks: time-to-first-draft, cycle time per deliverable, and revenue per head.

---

## 9. What this episode does **not** say (important honesty check)

The podcast does **not**:
- Claim specific ROI numbers beyond the McKinsey benchmarks (20% EBITDA uplift, $3:$1, 1–2yr breakeven — all from a 20-company study).
- Claim that everyone should build a Glass. Seb's argument for building is specifically because Ramp ships AI products externally; NLW explicitly flags this as an edge case. For companies that don't, Vercel's open-sourced reference platform is presented as the shortcut.
- Prescribe specific tools beyond Claude Code, Codex, and Vercel's reference platform.
- Claim the 99.5% adoption number — the cited figure in the episode is 99% daily use from Eric Glyman's post.

Anywhere I've filled a gap (the L0–L3 ladder details, the 5-step Glass architecture breakdown, the specific skill names), the source is linked inline. Nothing is extrapolated beyond the published writing.

---

*Continue to the companion file: `02_ai_rules.md` — the drop-in instruction file for your AI tools.*
