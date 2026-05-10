# Agent Skills — Specification Summary

This is a concise summary of the open Agent Skills standard. Primary source: [Anthropic — Equipping agents for the real world with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills). Full spec: [platform.claude.com/docs/en/agents-and-tools/agent-skills/overview](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview). Open-source skills reference repo: [github.com/anthropics/skills](https://github.com/anthropics/skills).

## What an Agent Skill is

A folder containing instructions and resources that teach an AI agent how to perform a specific task. Skills are the open equivalent of what Ramp built internally in their Dojo marketplace.

## Folder structure

```
skill-name/
├── SKILL.md          # required
├── references/       # optional deep-dive docs (loaded on demand)
├── scripts/          # optional executables (run by the agent, not read into context)
└── assets/           # optional templates, examples, schemas
```

## SKILL.md — required fields

```yaml
---
name: verb-ing-noun
description: "Third-person sentence explaining WHAT the skill does AND WHEN to use it."
---
```

### name

- 1–64 characters, lowercase letters, digits, and hyphens only.
- Cannot start or end with a hyphen.
- No consecutive hyphens.
- Must match the folder name exactly.
- Cannot be `anthropic` or `claude`.

### description

- 1–1024 characters.
- Written in third person.
- Must explain both **what** the skill does and **when** to trigger it.
- Wrap in double quotes if it contains `:`, `#`, `[`, `{`, or reserved words.
- Include trigger terms the user would actually say.

### Optional top-level fields

- `license` — e.g. `MIT`, `Apache-2.0`.
- `compatibility` — max 500 chars, environment requirements.
- `metadata` — nested key-value pairs for custom fields like `version`, `author`.
- `allowed-tools` — space-delimited list of pre-approved tools.

Any other top-level field will fail validation. Nest custom data under `metadata`.

## Three-tier progressive disclosure

| Level | When loaded | Token cost | Content |
|---|---|---|---|
| 1 — Metadata | Always, at startup | ~100 tokens per skill | `name` + `description` from YAML frontmatter |
| 2 — Instructions | When the skill triggers | Under 5k tokens | The SKILL.md body |
| 3 — Resources | On demand | Effectively unlimited | Files under `references/`, `scripts/`, `assets/` |

This is why SKILL.md should stay under 500 lines and long content belongs in `references/`.

## Authoring best practices

- Use gerund names (`processing-pdfs`, `drafting-proposals`).
- Assume the agent is already capable; only add context the agent doesn't already have.
- Split into `references/*.md` when paths are mutually exclusive or rarely used together.
- Use `scripts/` for deterministic operations — they run without consuming context.
- For MCP tools, use fully qualified names: `ServerName:tool_name`.
- Include a concrete **Examples** section at the bottom.

## Compatibility

The Agent Skills format is adopted by Claude, Cursor, Codex, Windsurf, and a growing set of tools. It is governed by agentskills.io and follows an open specification. Validation tool: `agentskills validate <skill-dir>/`.

## Validation checklist

Before shipping a skill:

- [ ] Folder name matches `name` in frontmatter.
- [ ] `description` is third-person, explains what + when, under 1024 chars.
- [ ] SKILL.md starts with `---` on line 1 (no blank lines or titles before).
- [ ] SKILL.md body is under 500 lines.
- [ ] Examples section exists.
- [ ] All reference files are linked by relative path from SKILL.md.
- [ ] No duplicate skill names in the same scope.
