# Skills Catalog

Complete index of every skill in this library, grouped by purpose. Use this to decide which skills to install for your project.

For installation instructions per IDE, see [`docs/INSTALL.md`](INSTALL.md). For the marketplace bundle definitions, see [`.claude-plugin/marketplace.json`](../.claude-plugin/marketplace.json).

---

## Quick reference

| Skill | Bundle | Brand-config? | Purpose |
|---|---|---|---|
| [`institutional-ai-operating-principles`](../skills/institutional-ai-operating-principles/) | agent-foundation | No | Operating principles that turn any AI assistant into an institutional agent (signal over noise, anti-sycophancy, surfacing assumptions). |
| [`design-methodology`](../skills/design-methodology/) | agent-foundation | No | Discovery → Diagnosis → Principles → Exploration → Critique → Lock → Propagate, for logo/brand/web/app design work. |
| [`brand-blueprint-builder`](../skills/brand-blueprint-builder/) | agent-foundation | Optional | Walks any brand (personal or commercial) through producing an 8-section brand blueprint with supporting docs (StoryBrand SB7, archetypes, narrative core, visual identity, messaging framework, revenue architecture). |
| [`human-voice`](../skills/human-voice/) | agent-foundation | Optional (project banned phrases) | Universal anti-AI-tell writing rules: zero em-dashes by default, banned-phrase list, read-aloud test. **Layers under any project-specific voice playbook.** |
| [`tool-leverage-heuristics`](../skills/tool-leverage-heuristics/) | agent-foundation | No | The autonomy playbook. Maps natural-language triggers ("AI-search visibility", "production is down", "ready to ship?") to specific tool/agent combos. The agent reaches for the right tool without being told. |
| [`brand-ssot-precedence`](../skills/brand-ssot-precedence/) | agent-foundation | Optional | Defines the precedence chain for brand single sources of truth (AGENTS.md → DESIGN.md → voice playbook → tokens.json) so the agent reads brand canon BEFORE producing any human-facing copy or visual artifact. |
| [`newsletter-drafter`](../skills/newsletter-drafter/) | content-engine | Yes | Drafts newsletter from RSS + voice playbook, stages as draft in email platform, pings review channel. |
| [`social-content-drafter`](../skills/social-content-drafter/) | content-engine | Yes | Drafts day-themed LinkedIn / X / IG posts, stages as platform drafts, never auto-publishes. |
| [`voice-drift-scanner`](../skills/voice-drift-scanner/) | content-engine | Yes | Daily scan of published / scheduled content for banned phrases, entity violations, off-pillar drift. |
| [`inbound-triage`](../skills/inbound-triage/) | ops-pipeline | Yes | Polls inbox + CRM, classifies intent, drafts replies (never sends), pings review channel for HIGH priority. |
| [`calendar-scheduler`](../skills/calendar-scheduler/) | ops-pipeline | Yes | Find time, propose slots, book meetings on confirmation, respect working-hours rules. |
| [`pipeline-reporter`](../skills/pipeline-reporter/) | ops-pipeline | Yes | Weekly state-of-pipeline from CRM, flags stalled deals, internal-only summary. |
| [`competitive-monitor`](../skills/competitive-monitor/) | ops-pipeline | Yes | Daily scan of competitor sites, diffs against snapshot, surfaces material changes. |
| [`self-improvement-review`](../skills/self-improvement-review/) | agent-self-improvement | Optional | Weekly meta-review proposing updates to CLAUDE.md based on observed corrections. Compounds voice fidelity over time. |

---

## Bundle map

The skills above are grouped into four installable bundles in [`.claude-plugin/marketplace.json`](../.claude-plugin/marketplace.json):

### `agent-foundation` — load on every project

The non-optional foundation. Six skills that make any AI tool act as an institutional agent rather than a chat toy.

```bash
# Claude Code marketplace path
/plugin install agent-foundation@ai-agent-skills-library

# Cross-IDE path
curl -fsSL https://raw.githubusercontent.com/newmindsgroup/ai-agent-skills-library/main/install.sh | bash -s -- --bundle agent-foundation
```

Includes: `institutional-ai-operating-principles`, `design-methodology`, `brand-blueprint-builder`, `human-voice`, `tool-leverage-heuristics`, `brand-ssot-precedence`.

### `content-engine` — for content-producing operations

Three skills covering newsletter, social, and brand-drift detection. All require `brand-config.yml` configured.

Includes: `newsletter-drafter`, `social-content-drafter`, `voice-drift-scanner`.

### `ops-pipeline` — for sales/ops surfaces

Four skills covering CRM, calendar, inbox, competitive intel. All require `brand-config.yml` configured with the relevant integrations.

Includes: `inbound-triage`, `calendar-scheduler`, `pipeline-reporter`, `competitive-monitor`.

### `agent-self-improvement` — for compound improvement

One skill that runs a weekly meta-review and proposes updates to your project's CLAUDE.md based on observed patterns.

Includes: `self-improvement-review`.

---

## Install priority for a new project

If you're standing up a new project and want to install skills incrementally:

1. **Start with `agent-foundation`.** Loads on every session, no brand config required to start (most skills work without it; brand-aware ones politely surface "missing config" if absent).
2. **Add `brand-config.yml` to your project root** (copy from [`brand-config.example.yml`](../brand-config.example.yml), fill in values).
3. **Add `AGENTS.md` and `DESIGN.md`** to your project root (copy from [`AGENTS.example.md`](../AGENTS.example.md) and [`DESIGN.example.md`](../DESIGN.example.md), fill in values). The `brand-ssot-precedence` skill from `agent-foundation` will pick them up automatically.
4. **Add `content-engine`** when you're ready to start drafting newsletter / social content. Configure the platform integrations in `brand-config.yml`.
5. **Add `ops-pipeline`** when you have a CRM and want triage / reporting.
6. **Add `agent-self-improvement`** after you've used the agent for 2-3 weeks and have observable patterns worth meta-reviewing.

---

## When to use which skill (decision tree)

```
Are you...
├── Starting a new project?
│   → Install agent-foundation. Drop in AGENTS.md + DESIGN.md + brand-config.yml templates.
│
├── Drafting human-facing content?
│   ├── Need universal anti-AI-tell rules?    → human-voice
│   ├── Need brand voice DNA enforcement?     → brand-ssot-precedence (reads voice playbook)
│   ├── Newsletter / blog?                    → newsletter-drafter
│   └── Social post?                          → social-content-drafter
│
├── Designing a UI / image / deck?
│   ├── Need brand visual rules applied?      → brand-ssot-precedence (reads DESIGN.md)
│   └── Need design methodology guidance?     → design-methodology
│
├── Running operations?
│   ├── Inbox / CRM triage?                   → inbound-triage
│   ├── Scheduling / calendar?                → calendar-scheduler
│   ├── Pipeline reporting?                   → pipeline-reporter
│   └── Competitive monitoring?               → competitive-monitor
│
├── Building / shipping software?
│   └── Want strategic tool-fire decisions?   → tool-leverage-heuristics
│
├── Auditing your published content?
│   └── Voice drift / banned-phrase check?    → voice-drift-scanner
│
├── Building a new brand from scratch?
│   └── Producing 8-section blueprint?        → brand-blueprint-builder
│
└── Want the agent to improve itself over time?
    └── Weekly meta-review?                   → self-improvement-review
```

---

## Skill dependencies

A few skills assume others are present or that brand canon files exist:

| Skill | Assumes |
|---|---|
| `tool-leverage-heuristics` | None (works standalone). Optionally references sub-agents installed via `installers/superpowers-stack/scripts/07-install-agency-agents.sh`. |
| `brand-ssot-precedence` | Project has at least one of: AGENTS.md / DESIGN.md / voice-playbook.md / brand-config.yml. |
| `human-voice` | Layers under project voice playbook if one exists; works universally if not. |
| `voice-drift-scanner` | Project voice playbook exists with banned phrases configured. Reads recently published content (CRM / blog / social). |
| `newsletter-drafter` | `brand-config.yml` configured with newsletter cadence + email-platform integration. RSS sources file. |
| `social-content-drafter` | `brand-config.yml` configured with day themes + social platform credentials. |
| `inbound-triage` | Inbox + CRM credentials configured. Reply playbook reference. |
| `calendar-scheduler` | Calendar API credentials. Working hours configured. |
| `pipeline-reporter` | CRM API credentials. Pipeline stages defined. |
| `competitive-monitor` | List of competitor URLs configured. |
| `self-improvement-review` | The agent has been running long enough (~2-3 weeks) to have observable patterns. |

---

## Spec compliance

Every skill follows the [Agent Skills specification](https://agentskills.io):

- Single `SKILL.md` per skill folder, with required frontmatter (`name`, `description`, `license`)
- Optional `references/` for source material
- Optional `scripts/` for helper scripts
- Optional `assets/` for images / fonts / etc.
- Under 500 lines per `SKILL.md` (warning emitted if exceeded)
- Description 1-1024 characters

Validation:
```bash
bash scripts/validate-frontmatter.sh    # always works (no deps)
bash scripts/validate-all.sh             # adds full agentskills CLI pass if installed
```

---

## Adding a new skill

1. Read [`docs/AUTHORING.md`](AUTHORING.md) — full authoring guide.
2. Use the scaffold script: `./scripts/new-skill.sh <skill-name>`.
3. Or copy `skills/institutional-ai-operating-principles/` as a starting template.
4. Validate locally: `./scripts/validate-all.sh`.
5. Add an entry to this catalog (`docs/SKILLS-CATALOG.md`) and the marketplace.json bundle.
6. Open a PR.

---

## License

All skills in this library are MIT-licensed. Each `SKILL.md` declares its license in the frontmatter.

Some skills reference upstream tools (Firecrawl, Graphify, agency-agents, etc.) — those tools have their own licenses listed in [`installers/superpowers-stack/docs/per-server/`](../installers/superpowers-stack/docs/per-server/) and the manifests inside `installers/superpowers-stack/agency-agents-installer/`.
