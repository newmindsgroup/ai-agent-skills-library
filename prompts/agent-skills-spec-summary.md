# Agent Skills Spec — One-Page Summary

A condensed reference for the [Agent Skills specification](https://agentskills.io). Paste into any conversation where you're authoring a `SKILL.md`.

## A skill is

A folder containing a `SKILL.md` plus optional `references/`, `scripts/`, and `assets/`. The folder name and the `name` field in frontmatter must match.

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

## SKILL.md frontmatter (required)

```yaml
---
name: your-skill-name
description: "Third-person description starting with a verb. Explains WHAT the skill does and WHEN to trigger it. Include trigger phrases the user would say. 1-1024 chars. Wrap in double quotes if it contains : or other YAML-special chars."
license: MIT
metadata:
  version: '1.0.0'
  author: your-name
  sources: where the knowledge came from
---
```

### Naming rules

- Lowercase letters, digits, hyphens. 1–64 chars.
- No starting / ending hyphen, no consecutive hyphens.
- Cannot be `claude` or `anthropic`.
- Folder name MUST equal the `name` field.

### Description rules

- Third person ("Drafts...", "Analyzes...", "Synthesizes..."). Never "I can help you...".
- Must explain WHAT the skill does AND WHEN to trigger it.
- Include the kinds of phrases a human would say to trigger it ("draft a newsletter", "audit my recent posts", etc.).
- Wrap in double quotes if it contains `:` or other YAML-special chars.

### Custom fields

Any custom field must be nested under `metadata`, not at the top level.

## Body rules

- Under 500 lines. Deep content goes in `references/`.
- Open with **one-paragraph statement of purpose** + run discipline.
- Then **how-to steps** (numbered, not narrative).
- End with a **what this skill does NOT do** section.
- Include **at least 2 concrete examples** at the bottom.

## How agents discover skills

The agent reads the `name` and `description` fields of every available skill at session start. When a user request matches the description's trigger language, the agent loads the body and follows it.

So: write the description as the trigger.

## Common mistakes

| Mistake | Fix |
|---|---|
| Description in first person ("I help you...") | Third person ("Helps you...") |
| Description doesn't list trigger phrases | Add 3-5 phrases the user would say |
| Body is narrative prose | Numbered steps, not paragraphs |
| Skill catches everything | Split into multiple narrow skills |
| Skill assumes a specific MCP / tool | Use `{{PLACEHOLDERS}}` from `brand-config.yml` and check tool availability before calling |
| No examples at the bottom | Add 2+ concrete invocations with expected behavior |
| Body > 500 lines | Move depth to `references/*.md`, link from body |
