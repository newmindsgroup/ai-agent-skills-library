# Conversion Checklists — per-platform target requirements

Version-Timestamp: 2026-06-19

When converting a prompt/agent between platforms, preserve intent and adapt format.
Each target below lists what it requires. Verify every item before declaring the
conversion done.

## Claude Code — sub-agent (`agents/<name>.md`)
- Frontmatter: `name` (lowercase-hyphens), `description` (third person; include
  "Use PROACTIVELY when…" triggers). Optional: `tools` (comma list — least
  privilege), `model` (sonnet/opus/haiku), `color`.
- Body = the agent's system prompt. Keep it thin if it defers to a skill.

## Claude Code — skill (`skills/<name>/SKILL.md`)
- Folder name MUST equal frontmatter `name`. Frontmatter: `name`, `description`
  (what + when, with trigger phrases). Optional `license`, `metadata`.
- Depth goes in `references/`; body cites it by relative path.

## Claude Code — slash command (`commands/<name>.md`)
- Frontmatter: `description`. Body is the prompt; `$ARGUMENTS` injects user input.
- Installs to `~/.claude/commands/` (global) or `.claude/commands/` (project).

## Cursor — rule (`.cursor/rules/<name>.mdc`)
- Must be `.mdc` (a plain `.md` is ignored). Frontmatter: `description`, `globs`
  (comma-separated; blank = all), `alwaysApply` (boolean).
- `alwaysApply: false` + a strong `description` → agent-attached (Cursor decides
  when to apply from the description). Rules are per-project.

## Codex
- Always-on guidance → `AGENTS.md` at project root (also `~/.codex/AGENTS.md`
  global). Concatenated root→cwd, capped ~32 KiB.
- On-demand → `~/.codex/prompts/<name>.md` (becomes `/<name>`).
- Skills → `~/.codex/skills/<name>/SKILL.md` (Agent Skills spec; loads natively).

## Antigravity / Gemini CLI
- Instructions file → `GEMINI.md` (global `~/.gemini/GEMINI.md`, loaded
  hierarchically). Mind Antigravity's ~12,000-char per-rule limit.
- Skills → `~/.agents/skills/<name>/` (cross-runtime; takes precedence) or
  `~/.gemini/skills/<name>/`. Agent reads `SKILL.md` at session start.

## OpenAI Custom GPT
- Fields: Name, Description, **Instructions** (the system prompt — paste the body
  here), Conversation starters. No filesystem; no `references/` — inline the
  essentials and keep within the instructions length limit.

## Plain system prompt
- A single message, no frontmatter. Fold role + rules + output format into prose.
- Move any examples inline; there is no separate file layer.
