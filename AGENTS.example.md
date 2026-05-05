# AGENTS.md — Briefing for AI Tools & Collaborators

This file is the context pack for any AI agent or assistant working in this folder (Claude Code, Cursor, Cowork, Codex, OpenCode, Aider, Windsurf, ChatGPT with file access, etc.). Read this before taking any action.

> Drop this file at your project root. It mirrors the [`AGENTS.md` open standard](https://agents.md/) — companion to [`DESIGN.md`](DESIGN.md) (visual SSOT). One file tells AI agents *how to build*; the other tells them *how it should look*.

---

## Who the work is for

**<Person name / Company>** — <one-paragraph description: who you are, what you do, who you serve, where you operate from, your strengths, your aesthetic sensibility, your archetype if relevant>

- <One-line: where you're based, languages, timezone>
- <One-line: cultural / values context if it matters for client-facing output>
- <One-line: how senior is the audience — calibrate explanations accordingly>
- <One-line: what kinds of work you love doing vs. delegate>
- <One-line: target clients / industries>
- <One-line: key past wins / credibility markers>

Full founder story / team / values: `<path to longer doc>`.

---

## What the project is

<One paragraph: what is this repo / project / business effort? what's the current phase?>

- **Phase 1** — <current focus>
- **Phase 2** — <next>
- **Phase 3** — <after that>

Full plan: `<path to roadmap doc>`.

**<One non-negotiable sequencing or priority rule>.**

---

## Brand ground rules (non-negotiable)

When writing copy, generating imagery, or making any brand-aligned artifact, pull from these files — do not invent alternates:

- **Visual SSOT (read first for any UI / image / deck):** `DESIGN.md`
- **Machine-canonical design tokens** (if you have one): `<path to tokens.json>`
- **Positioning & voice:** `<your brand identity doc>`
- **Voice DNA + banned phrases:** `<your brand behavior playbook>`
- **AI-generated tells to avoid:** `<your AI tells doc>`
- **Headlines & key phrases:** `<your messaging framework doc>`
- **Services & pricing:** `<your services doc>`

### Voice checklist (apply to any generated text)

- ☑ <Tone attribute 1 — be specific, e.g. "Direct but empathetic">
- ☑ <Tone attribute 2 — e.g. "Strategic not salesy">
- ☑ <Tone attribute 3>
- ☑ Archetype: <primary> (primary) + <secondary> (secondary)

**Phrases to reuse:** <signature phrases this brand uses>

**Phrases banned:** <list — e.g. "thrilled to", "excited to share", "delve into", "in today's fast-paced world", "humbled to", "in the realm of">

---

## Working agreements with AI tools

- Source of truth lives in this repo. Read it when needed; do not invent facts that aren't there.
- Drafts only. Never auto-publish, auto-send, or auto-post. <Person> reviews everything client-facing before it ships.
- No fabrication. If canon doesn't cover it, say so and ask.
- <Add any other working agreements specific to this project>

---

## What's in this repo

<List the major folders/files an AI agent should know about. Group by purpose: brand canon, content drafts, design system, infrastructure, etc.>

- `DESIGN.md` — visual SSOT
- `AGENTS.md` — this file
- `<numbered docs or directories>` — <what they are>
- `agent-stack/` (if you've installed it) — Claude Code agent infrastructure
- `vps-setup/` (if you have a VPS-hosted always-on agent) — multi-tenant agent template

---

## Out of bounds

Do not touch:

- <list anything an AI tool should never modify — production sites, sensitive infrastructure, financial transactions, etc.>
- Anything in `.gitignore` (credentials, env files, local-only state).
- <Project-specific exclusions>

If a request implies any of the above, surface it and wait for confirmation.
