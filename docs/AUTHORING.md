# Authoring a new skill

Every skill in this library follows the open [Agent Skills specification](https://agentskills.io). A skill is a folder containing a `SKILL.md` file plus optional `references/`, `scripts/`, and `assets/` subdirectories.

## Quick start

```bash
# Scaffold a new skill from the template
./scripts/new-skill.sh drafting-proposals

# Edit the generated files
$EDITOR skills/drafting-proposals/SKILL.md

# Validate before committing
./scripts/validate-all.sh
```

## Folder structure

```
skills/
└── your-skill-name/
    ├── SKILL.md              # required
    ├── references/           # optional — deep-dive content loaded on demand
    │   └── *.md
    ├── scripts/              # optional — executables the agent runs
    │   └── *.py, *.sh
    └── assets/               # optional — templates, schemas, examples
```

## SKILL.md rules

**Frontmatter** (required):

```yaml
---
name: drafting-proposals
description: "Drafts client proposals and scopes of work. Use when the user asks to write, draft, or revise a proposal, RFP response, SOW, or engagement letter."
license: MIT
metadata:
  version: '1.0.0'
  author: your-name
---
```

- `name` — lowercase, hyphens, digits. 1–64 chars. No starting/ending hyphen, no consecutive hyphens. Must match the folder name. Cannot be `claude` or `anthropic`.
- `description` — 1–1024 chars. **Third person** ("Drafts…", "Analyzes…"). Must explain **what** the skill does and **when** to trigger it. Include trigger phrases a human would say. Wrap in double quotes if it contains `:` or other YAML-special characters.
- Any custom field must be nested under `metadata`, not at the top level.

**Body**:

- Keep under 500 lines. Split overflow into `references/*.md`.
- Use gerund names (`drafting-`, `auditing-`, `synthesizing-`, `researching-`).
- Start with a "When to use this skill" section.
- Use numbered workflows for anything with more than 3 steps.
- Reference other files by relative path, never by pasting content inline.
- End with an **Examples** section: 2–3 concrete invocations.

## Naming convention

Use gerund prefixes to keep the library browsable:

- `drafting-` — proposals, emails, decks, SOWs
- `researching-` — market, competitive, user, SEO
- `auditing-` — UX, content, analytics, accessibility, code
- `synthesizing-` — interviews, survey data, analytics
- `generating-` — case studies, reports, social posts
- `preparing-` — briefs, meeting notes, client updates
- `monitoring-` — analytics, rankings, uptime, alerts
- `reviewing-` — code, copy, contracts

Exception: meta-skills like `institutional-ai-operating-principles` that define operating stance rather than a workflow.

## The three-tier disclosure model

When authoring, understand how skills load:

| Tier | Loaded when | Content |
|---|---|---|
| 1 — Metadata | Session start | `name` + `description` only |
| 2 — Instructions | Skill triggered | `SKILL.md` body |
| 3 — Resources | On demand | `references/`, `scripts/`, `assets/` |

Put *triggering* language in the description. Put *stable instructions* in SKILL.md. Put *rarely-used depth* in references.

## Validation

Run before every commit:

```bash
./scripts/validate-all.sh
```

This runs the `agentskills` validator on every skill in `skills/`. PRs fail CI if validation fails.

If you don't have `agentskills` installed:

```bash
pip install agentskills
```

Or use the Node version:

```bash
npm install -g @agentskills/cli
```

## PR checklist

- [ ] `SKILL.md` starts with `---` on line 1 (no title or blank lines before)
- [ ] `name` in frontmatter matches folder name exactly
- [ ] `description` is third-person and explains what + when
- [ ] Body is under 500 lines
- [ ] Examples section exists
- [ ] All referenced files exist at the paths named
- [ ] `./scripts/validate-all.sh` passes locally
- [ ] Added an entry to the "Current skills" table in the root `README.md`

## Versioning

Use semver in the `metadata.version` field:

- `1.0.0` — first stable release
- `1.1.0` — new content, backward-compatible
- `1.0.1` — fixes, clarifications
- `2.0.0` — breaking change (renamed rules, restructured behavior)
