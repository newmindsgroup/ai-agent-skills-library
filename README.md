# AI Agent Skills Library

A versioned, code-reviewed library of agentic AI skills for the team. Works across Claude Code, Cursor, Codex, Windsurf, OpenCode, and Google Antigravity.

Every skill follows the open [Agent Skills specification](https://agentskills.io) — a single `SKILL.md` plus optional `references/`, `scripts/`, and `assets/` — and stays portable across organizations through a project-local `brand-config.yml`.

## Why this exists

AI models are commodity. The harness (skills, memory, runbooks, coordination) is the moat. This repo is our Dojo: a code-reviewed, versioned marketplace of skills + patterns + installers so one person's breakthrough becomes everyone's baseline.

## What's inside

```
.
├── .claude-plugin/marketplace.json   ← Claude Code plugin marketplace manifest
├── agents/                            ← 16 sub-agents (cherry-picked from msitarzewski/agency-agents, MIT)
│   ├── ai-engineer.md, sre.md, code-reviewer.md, incident-response-commander.md, ...
│   └── README.md                       ← install + auto-routing guide
├── skills/                            ← individual Agent Skills (cross-IDE)
│   ├── institutional-ai-operating-principles/
│   ├── design-methodology/
│   ├── brand-blueprint-builder/
│   ├── human-voice/
│   ├── tool-leverage-heuristics/      ← autonomy playbook: when to fire which tool
│   ├── brand-ssot-precedence/         ← read AGENTS.md → DESIGN.md → voice playbook chain
│   ├── newsletter-drafter/
│   ├── social-content-drafter/
│   ├── voice-drift-scanner/
│   ├── inbound-triage/
│   ├── calendar-scheduler/
│   ├── pipeline-reporter/
│   ├── competitive-monitor/
│   └── self-improvement-review/
├── runbooks/                          ← non-loadable patterns + lessons
│   ├── gate-pattern.md
│   ├── systemd-watchdog-patterns.md
│   ├── drive-clone-handoff.md
│   ├── defensive-api-bindings.md
│   ├── read-before-escalating.md
│   ├── agent-operating-principles.md
│   └── tool-leverage-heuristics.md   ← when to fire which tool (the autonomy playbook)
├── installers/                        ← bootable kits
│   └── superpowers-stack/             ← Superpowers + 5 official MCPs + agency-agents (16) + Firecrawl + Graphify
├── prompts/                           ← reusable system-prompt templates
│   ├── voice-dna-template.md
│   ├── agent-skills-spec-summary.md
│   └── institutional-ai-stance.md
├── docs/
│   ├── INSTALL.md                     ← per-IDE install detail
│   ├── AUTHORING.md                   ← how to write a new skill
│   ├── PLACEHOLDERS.md                ← brand-config.yml placeholder system
│   └── SKILLS-CATALOG.md              ← full index w/ dependencies + decision tree
├── CHANGELOG.md                       ← versioned history of every release
├── brand-config.example.yml           ← copy to project root: tenant config, voice/visual paths
├── DESIGN.example.md                  ← copy to project root: visual SSOT (Stitch 9-section format)
├── AGENTS.example.md                  ← copy to project root: brand-context for any AI tool (open standard)
├── install.sh / install.ps1           ← cross-IDE one-liner installer
└── scripts/                           ← validation + scaffolding helpers
```

## Quick install

### Option A — Claude Code plugin marketplace (recommended for Claude Code users)

```bash
# In Claude Code:
/plugin marketplace add newmindsgroup/ai-agent-skills-library
/plugin install agent-foundation@ai-agent-skills-library
```

The marketplace exposes four bundles:

- **`agent-foundation`** — operating principles + design methodology + human-voice + brand-blueprint-builder + tool-leverage-heuristics + brand-ssot-precedence. Load on every project. Six skills make any AI tool act as an institutional agent: signal over noise, on-brand voice, strategic tool-fire decisions, brand canon precedence.
- **`content-engine`** — newsletter, social, brand-drift.
- **`ops-pipeline`** — inbox triage, calendar, pipeline, competitive intel.
- **`agent-self-improvement`** — weekly meta-review that improves your CLAUDE.md.
- **`agency-agents`** — 16 specialist sub-agents (engineering, orchestration, content, visual). Auto-route on natural-language triggers. Tenant-agnostic when installed via this bundle (defers to `brand-ssot-precedence` for voice).

For the full catalog with dependencies + install priority + decision tree, see [`docs/SKILLS-CATALOG.md`](docs/SKILLS-CATALOG.md).

### Option B — Cross-IDE one-liner (Cursor, Codex, Windsurf, OpenCode, Antigravity)

**macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/newmindsgroup/ai-agent-skills-library/main/install.sh | bash
```

**Windows PowerShell:**
```powershell
iwr -useb https://raw.githubusercontent.com/newmindsgroup/ai-agent-skills-library/main/install.ps1 | iex
```

The installer auto-detects your IDE and installs every skill into the right location. It supports:

- **Claude Code** → `.claude/skills/` or `~/.claude/skills/`
- **Cursor** → `.cursor/skills/` (with `.cursor/rules/` fallback)
- **Codex / AGENTS.md** → generates an `AGENTS.md` at repo root pointing to `skills/`
- **Windsurf** → `.windsurf/skills/`
- **OpenCode** → `.opencode/skills/` or `~/.config/opencode/skills/`
- **Google Antigravity** → `.agent/skills/` or `~/.gemini/antigravity/skills/`

### Option C — Install a single skill

```bash
curl -fsSL https://raw.githubusercontent.com/newmindsgroup/ai-agent-skills-library/main/install.sh | bash -s -- newsletter-drafter
```

### Option D — Manual

Each skill lives at `skills/<skill-name>/`. Copy the folder into your tool's skill directory. See [`docs/INSTALL.md`](docs/INSTALL.md) for the full per-tool path table.

## Configure brand context

Some skills (newsletter, social, triage, drift-scan, pipeline) need brand-specific context — voice rules, content pillars, entity-separation rules, schedules. Drop a `brand-config.yml` at the root of your project. Start from `brand-config.example.yml` and fill in your values.

Without `brand-config.yml`, those skills will surface a "missing config" message rather than guessing or using personal data from a previous user.

Full placeholder reference: [`docs/PLACEHOLDERS.md`](docs/PLACEHOLDERS.md).

## Currently shipped

### Skills

This repository now ships **1513 skills** in `skills/`. The original curated New Minds bundles are preserved, and the broader Codex/agent skill corpus has been imported as portable Agent Skills folders.

For the complete generated index with descriptions, use [`docs/SKILLS-CATALOG.md`](docs/SKILLS-CATALOG.md). For provenance and duplicate-resolution details, use [`docs/SKILL-SOURCES.md`](docs/SKILL-SOURCES.md).

| Category | Count |
|---|---:|
| AI, Agents, LLMs, Data | 735 |
| Automation, Integrations, Productivity | 188 |
| Backend, APIs, Databases | 97 |
| Business, Strategy, Product, Growth | 121 |
| Content, SEO, Writing, Docs | 56 |
| DevOps, Cloud, Infrastructure | 59 |
| Frontend, UI, UX, Design | 111 |
| General, Workflow, Research, Miscellaneous | 62 |
| Languages, Frameworks, Specialist Tools | 25 |
| Media, Documents, Office, Creative | 5 |
| Security, Compliance, Risk | 19 |
| Testing, QA, Debugging, Review | 35 |

Curated marketplace bundles remain intentionally small and high-signal:

- `agent-foundation`: `institutional-ai-operating-principles`, `design-methodology`, `human-voice`, `brand-blueprint-builder`, `tool-leverage-heuristics`, `brand-ssot-precedence`
- `content-engine`: `newsletter-drafter`, `social-content-drafter`, `voice-drift-scanner`
- `ops-pipeline`: `inbound-triage`, `calendar-scheduler`, `pipeline-reporter`, `competitive-monitor`
- `agent-self-improvement`: `self-improvement-review`

### Runbooks

See [`runbooks/README.md`](runbooks/README.md) for the full table. Six patterns covering deploy gates, watchdog discipline, drive-handoff, defensive bindings, escalation hygiene, and operating principles.

### Installers

See [`installers/README.md`](installers/README.md). Currently one: `superpowers-stack`, which installs the full agent baseline on a Linux VPS via a single `client.env`:

- **Superpowers plugin** (engineering rituals: planning, TDD, systematic debugging, verification, code review)
- **5 official MCP servers** (Memory, Fetch, Filesystem, Playwright, Chroma) — Tier-1 always-on
- **agency-agents cherry-pick** (16 sub-agents from [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) MIT) — auto-route via "Use PROACTIVELY when..." description triggers
- **Firecrawl MCP** — 14 tools for web scraping, search, structured extract, persistent browser sessions
- **Graphify** — turns any folder of code/docs/PDFs/images into a queryable knowledge graph (`/graphify` slash command)

Run with `bash installers/superpowers-stack/scripts/install-all.sh` (idempotent — safe to re-run). Configure once via `installers/superpowers-stack/config/client.env`.

### Brand-context drop-ins

Three top-level templates you copy to the root of any project where you want consistent agent behavior:

- [`brand-config.example.yml`](brand-config.example.yml) — tenant config (owner, brand, paths, schedules, social themes)
- [`DESIGN.example.md`](DESIGN.example.md) — visual SSOT in [Stitch 9-section format](https://stitch.withgoogle.com/docs/design-md/format/) (the format AI tools like Cursor, v0, Lovable, Claude Code parse most reliably)
- [`AGENTS.example.md`](AGENTS.example.md) — brand-context for any AI tool, [open standard](https://agents.md/)

Together: voice rules + visual rules + agent context, version-controlled, agent-readable, deliverable to clients.

### Prompts

See [`prompts/README.md`](prompts/README.md). Three reusable system-prompt templates for non-skills environments (ChatGPT custom GPT, Gemini Gem, Claude Project, Cursor rule).

## Contributing a new skill

1. Read [`docs/AUTHORING.md`](docs/AUTHORING.md) — the full authoring guide.
2. Copy `skills/institutional-ai-operating-principles/` as a starting template, or use the scaffold script: `./scripts/new-skill.sh drafting-proposals`.
3. Write your `SKILL.md` following the Agent Skills spec (under 500 lines, gerund naming, third-person description, examples at the bottom).
4. If your skill needs brand context, document the required `brand-config.yml` keys at the top of SKILL.md and use `{{PLACEHOLDERS}}` in the body. See [`docs/PLACEHOLDERS.md`](docs/PLACEHOLDERS.md).
5. Validate locally: `./scripts/validate-all.sh`.
6. Open a pull request. CI will re-validate every skill on push.

## What this repo does not do

**There is no true "universal auto-installer" protocol today.** No spec exists in 2026 that lets every IDE take a Git URL and automatically figure out which adapter to use. This repo's `install.sh` is the closest practical equivalent: it reads the environment, detects the IDE, and installs the right files. The Claude Code marketplace path (Option A above) is the supported native path for Claude Code specifically.

Every skill is portable — the canonical `SKILL.md` is the Agent Skills standard, and adapters are thin pointers to it, not parallel copies.

## License

MIT — see [LICENSE](LICENSE).
