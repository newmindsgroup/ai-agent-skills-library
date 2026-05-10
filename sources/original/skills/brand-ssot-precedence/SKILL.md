---
name: brand-ssot-precedence
description: "Apply this skill on every session in any project that has brand context. Defines the precedence chain for brand single sources of truth (SSOT) — AGENTS.md, DESIGN.md, voice playbook, design tokens, brand-config.yml — so the agent reads brand canon BEFORE producing any human-facing copy or visual artifact. The chain is: AGENTS.md (project rules) → DESIGN.md (visual SSOT) → voice playbook (voice DNA) → tokens.json (machine-canonical token values, wins on conflicts with DESIGN.md). Triggers proactively before any drafting, designing, or imagery-generation work — even when the user doesn't explicitly mention brand canon. Project-agnostic — works for any company with documented brand standards."
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: agents.md (open standard), Stitch DESIGN.md format, VoltAgent/awesome-design-md, multi-tenant brand canon deployment patterns
---

# Brand SSOT Precedence — Agent-Readable Brand Canon Skill

Brand canon is fragmented across files, formats, and folders. Without a precedence rule, the agent guesses or invents alternates. With this skill loaded, the agent reads the right files in the right order before any brand-aligned work.

**This skill applies before any drafting, designing, or imagery-generation task.** When you (the agent) detect a brand-aligned trigger (write a post, generate an image, design a UI, draft an email), pause and read the brand canon files in the precedence chain below before producing output.

---

## 1. The precedence chain

Read these in order. The earlier file wins on conflicts unless explicitly overridden.

### Voice + behavior precedence (any human-facing copy)

| Priority | File | Purpose |
|---|---|---|
| 1 | `<project>/<voice-playbook>.md` | Voice DNA, banned phrases, tone calibration. Project-specific name varies — see "Locating the voice playbook" below. |
| 2 | `AGENTS.md` (project root) | Brand context for any AI tool. [Open standard](https://agents.md/). Lists which files matter and what's out of bounds. |
| 3 | `brand-config.yml` (project root) | Tenant config: entity separation rules, channel themes, banned phrases (alternative location). |
| 4 | User-level `~/.claude/CLAUDE.md` | Cross-project brand voice precedence rules. |
| 5 | This skill | Universal pattern — applied when no project-specific file exists. |

### Visual precedence (any UI / image / deck / visual artifact)

| Priority | File | Purpose |
|---|---|---|
| 1 | `design-system/tokens/tokens.json` (or equivalent) | **Machine-canonical** token values. If `DESIGN.md` and `tokens.json` disagree, `tokens.json` wins and `DESIGN.md` is updated to match. |
| 2 | `DESIGN.md` (project root) | [Stitch 9-section format](https://stitch.withgoogle.com/docs/design-md/format/) visual SSOT. The agent navigator. |
| 3 | `<project>/<visual-identity>.md` | Human-readable visual identity spec (palette, typography, hero templates). |
| 4 | `<project>/<design-philosophy>.md` | Design north star, motion philosophy, reference targets. |

---

## 2. Locating the voice playbook

The voice playbook filename varies by project. Look in this order:

1. `brand-voice-playbook.md` (project root)
2. `voice-playbook.md` (project root)
3. `15_Brand_Behavior_Playbook.md` (or any `*_Brand_Behavior_*.md`)
4. Any path declared in `brand-config.yml` under `paths.brand_playbook`
5. Any path declared in user-level `~/.claude/CLAUDE.md` under voice precedence

If none exist, fall back to the universal anti-AI-tell rules from the `human-voice` skill.

---

## 3. What each file commits to

### AGENTS.md (open standard — agents.md)

The "how to build" companion to `DESIGN.md`. Tells AI agents:
- Who the work is for (person/company)
- What the project is (current phase, roadmap)
- Brand ground rules (which files to pull from, never invent alternates)
- Voice checklist (apply to any generated text)
- What's out of bounds

Always read AGENTS.md first if it exists. It's the project's executive summary.

### DESIGN.md (Stitch 9-section format — visual SSOT)

The agent-facing visual specification. Sections:

1. Visual Theme & Atmosphere (mood, density, philosophy)
2. Color Palette & Roles (semantic name + hex + functional role)
3. Typography Rules (font families, hierarchy table, licensing)
4. Component Stylings (buttons, cards, inputs, navigation with states)
5. Layout Principles (grid, spacing scale, whitespace philosophy)
6. Depth & Elevation (shadow system, surface hierarchy)
7. Do's and Don'ts (anti-patterns, AI-image tells to avoid)
8. Responsive Behavior (breakpoints, touch targets, collapsing strategy)
9. Agent Prompt Guide (quick references + ready-to-use prompt fragments)

`DESIGN.md` is the navigator. `tokens.json` is the machine source of truth — when they disagree, tokens.json wins and DESIGN.md gets updated to match.

### Voice Playbook

The canonical voice DNA spec. Common sections:

1. Voice DNA in one paragraph (specific, no generic adjectives)
2. Voice attributes (the checklist applied to every draft)
3. Banned phrases (absolute, no exceptions)
4. Sentence patterns to avoid
5. Phrases to reuse (signature lines)
6. Channel-specific tone calibration
7. The canonical Voice DNA spec (the section voice-aware sub-agents quote verbatim)

### brand-config.yml

Tenant-specific structured config:
- Owner identity
- Brand identity (primary + excluded entities)
- Paths to canonical docs
- Newsletter/social cadences
- Day themes
- Scheduled-task configuration

Reads as a YAML file — see `brand-config.example.yml` in the skills library root for the full schema.

---

## 4. The reading discipline

Before drafting any human-facing copy:

1. Read the voice playbook (if present). Note banned phrases + signature phrases.
2. Read AGENTS.md (if present). Note the audience + tone calibration for the relevant channel.
3. Read brand-config.yml (if present). Note excluded entities — never name them in client-facing output.
4. Draft. Run mental check against banned-phrase list.

Before generating any UI / image / deck / visual artifact:

1. Read DESIGN.md (if present). Note palette + typography + layout philosophy + hard rules in section 7.
2. Read tokens.json (if present). Use these exact values, not the human-readable approximations.
3. Read AGENTS.md for any visual ground rules.
4. Generate. Run mental check against the do's and don'ts in DESIGN.md §7.

---

## 5. Voice-aware sub-agent integration

If the project installed the agency-agents cherry-pick (via `installers/superpowers-stack/scripts/07-install-agency-agents.sh`), five voice-aware sub-agents have inline brand-voice locks at the top of their system prompts:

- `linkedin-content-creator`
- `carousel-growth-engine`
- `ai-citation-strategist`
- `image-prompt-engineer`
- `document-generator`

These sub-agents read the voice playbook BEFORE drafting and refuse drafts that violate banned phrases. Delegate to them via the Task tool whenever brand-aligned content is the goal — they are pre-locked to the precedence chain above.

---

## 6. When canon is missing or contradictory

If a critical rule isn't in canon, **say so and ask** rather than inventing:

> *"I checked the voice playbook and AGENTS.md — neither covers tone for paid-ad copy. Should I default to the email-reply tone (closest analogue) or do you want a separate paid-ads tone calibration?"*

If two canon files contradict (e.g. brand identity doc says "primary blue is #0D374C" but `tokens.json` declares `blue.900: #0E3A50`), **flag the conflict** and let the human resolve:

> *"Conflict: `02_Brand_Identity.md` declares primary blue as `#0D374C`. `tokens.json` declares it as `#0E3A50`. Per precedence, `tokens.json` wins. Want me to update the brand identity doc to match, or update tokens.json?"*

Per [`runbooks/agent-operating-principles.md`](../../runbooks/agent-operating-principles.md), no fabrication. If canon doesn't cover it, surface the gap.

---

## 7. Setting up brand SSOT in a new project

If a project doesn't yet have any brand canon, drop in the templates from this library:

```bash
cp /path/to/ai-agent-skills-library/AGENTS.example.md ./AGENTS.md
cp /path/to/ai-agent-skills-library/DESIGN.example.md ./DESIGN.md
cp /path/to/ai-agent-skills-library/brand-config.example.yml ./brand-config.yml
# Then: edit each with real values; remove the .example suffix or rename
```

Each template is heavily commented. Fill in the bracketed sections, keep the structure.

For a voice playbook, see the `voice-dna-template.md` in `prompts/` for a fillable spec.

---

## Examples

**User:** "Draft a LinkedIn post about our new product launch."

**Agent (correct):**
1. Reads project root for voice playbook → finds `brand-voice-playbook.md`
2. Reads AGENTS.md → notes target audience is "service founders at $100K-$1M ARR"
3. Reads brand-config.yml → notes excluded entities (don't name these)
4. Delegates to `linkedin-content-creator` sub-agent with context: voice playbook path, audience, banned phrases
5. Returns draft with hooks compliant with the playbook

**Agent (wrong):** Drafts an enthusiastic LinkedIn post with "Excited to announce..." opener, missing the banned-phrase check, no audience awareness.

---

**User:** "Generate a Midjourney prompt for our homepage hero."

**Agent (correct):**
1. Reads `DESIGN.md` → notes palette (e.g. signature blue + 2-5% accent amber), photography style, what to avoid
2. Reads `tokens.json` → uses exact hex values
3. Delegates to `image-prompt-engineer` sub-agent with the DESIGN.md context

**Agent (wrong):** Generates a generic "futuristic city, neon, cinematic" prompt that ignores the brand palette entirely.

---

## License

MIT — see repository LICENSE.

Companion skills:
- `human-voice` (universal anti-AI-tell rules — applies under the project voice playbook)
- `tool-leverage-heuristics` (decides which tools to fire for each user message)
- `voice-drift-scanner` (audits shipped content against the voice playbook)
