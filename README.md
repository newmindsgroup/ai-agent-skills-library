# AI Agent Skills Library

A shared, versioned library of AI agent skills for the team. Every skill follows the open [Agent Skills specification](https://agentskills.io) — a single `SKILL.md` plus optional `references/`, `scripts/`, and `assets/` — and works across Claude Code, Cursor, Codex, Windsurf, OpenCode, and Google Antigravity.

## Why this exists

AI models are commodity. The harness — the skills, the memory, the coordination — is the moat. This repo is our Dojo: a code-reviewed, versioned marketplace of skills so one person's breakthrough becomes everyone's baseline.

## Quick install

### One-liner (macOS / Linux)

```bash
curl -fsSL https://raw.githubusercontent.com/newmindsgroup/ai-agent-skills-library/main/install.sh | bash
```

### One-liner (Windows PowerShell)

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

### Install a single skill

```bash
curl -fsSL https://raw.githubusercontent.com/newmindsgroup/ai-agent-skills-library/main/install.sh | bash -s -- institutional-ai-operating-principles
```

### Scope: project or global?

By default the installer installs **project-scoped** (inside the current folder) if it detects a project-level config folder (`.claude/`, `.cursor/`, `.agent/`, etc.). Otherwise it falls back to global. Override with:

```bash
curl -fsSL .../install.sh | bash -s -- --scope global
curl -fsSL .../install.sh | bash -s -- --scope project
```

## Manual install

If you'd rather not pipe a remote script to `bash`, every skill lives under `skills/<skill-name>/`. Copy the folder into your tool's skill directory:

| Tool | Project-scoped path | Global-scoped path |
|---|---|---|
| Claude Code | `.claude/skills/<skill-name>/` | `~/.claude/skills/<skill-name>/` |
| Cursor | `.cursor/skills/<skill-name>/` | — |
| Codex / AGENTS.md | reference from `AGENTS.md` | — |
| Windsurf | `.windsurf/skills/<skill-name>/` | — |
| OpenCode | `.opencode/skills/<skill-name>/` | `~/.config/opencode/skills/<skill-name>/` |
| Google Antigravity | `.agent/skills/<skill-name>/` | `~/.gemini/antigravity/skills/<skill-name>/` |

See [`docs/INSTALL.md`](docs/INSTALL.md) for tool-by-tool detail, including fallback patterns (Cursor rules, ChatGPT / Claude Projects / Gemini Gems) for tools that don't natively support the Agent Skills format.

## Current skills

| Skill | Description | Version |
|---|---|---|
| [institutional-ai-operating-principles](skills/institutional-ai-operating-principles/) | Operating principles that turn any AI assistant into an institutional agent. Enforces signal over noise, revenue over time savings, anti-sycophancy, skills-first reusability. | 1.0.0 |

## Contributing a new skill

1. Read [`docs/AUTHORING.md`](docs/AUTHORING.md) — the full authoring guide.
2. Copy `skills/institutional-ai-operating-principles/` as a starting template, or use the scaffold script: `./scripts/new-skill.sh drafting-proposals`.
3. Write your `SKILL.md` following the Agent Skills spec (under 500 lines, gerund naming, third-person description, examples at the bottom).
4. Validate locally: `./scripts/validate-all.sh`.
5. Open a pull request. CI will re-validate every skill on push.

## What this repo does not do

**There is no true "universal auto-installer" protocol today.** No spec exists in April 2026 that lets an IDE take a Git URL and automatically figure out which adapter to use. This repo's `install.sh` is the closest practical equivalent: it reads the environment, detects the IDE, and installs the right files. If a new IDE or adapter format emerges, we add it to the installer.

Every skill itself is portable — the canonical `SKILL.md` is the Agent Skills standard, and all "adapters" are thin pointers to that canonical file, not parallel copies.

## License

MIT — see [LICENSE](LICENSE).
