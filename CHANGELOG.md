# Changelog

## 2026-05-09

- Imported the local Codex and agent skill corpus into `skills/`, preserving existing New Minds skills and flattening nested local skill paths into the standard `skills/<skill-name>/SKILL.md` layout.
- Added generated catalog and provenance files: `docs/SKILLS-CATALOG.md`, `docs/SKILL-SOURCES.md`, and `manifests/skills-manifest.json`.
- Normalized imported skill frontmatter with matching `name`, portable `description`, `license: MIT`, and import metadata so repository validation can scan the complete library.
- Compacted the 200 long `SKILL.md` files that triggered validator warnings by moving deep guidance into `references/full-guidance.md` while keeping compact progressive-loading entrypoints in each skill.
- Added `scripts/compact-long-skills.rb` so future long-skill warning cleanup can be repeated from validator logs.
- Added `sources/` as a repo-named provenance index, including `sources/original/` for New Minds-created skills, while preserving the canonical loadable `skills/<skill-name>/` layout.
- Added `scripts/generate-source-index.rb` and expanded `manifests/skills-manifest.json` with `source_slug`, `source_label`, `source_type`, and `source_path` fields.

All notable changes to this library are documented here. The library follows [semver](https://semver.org/): MAJOR.MINOR.PATCH where MAJOR breaks compatibility with installed skills, MINOR adds skills/installers/runbooks without breaking existing ones, PATCH is bug fixes + docs.

## [1.3.0] — 2026-05-05

### Added
- **`agents/`** (NEW top-level folder) — 16 specialist sub-agents cherry-picked from [`msitarzewski/agency-agents`](https://github.com/msitarzewski/agency-agents) (MIT). Tenant-agnostic — installed without inline brand-voice injection so they defer to the `brand-ssot-precedence` skill or user-level voice rules. Drop into `~/.claude/agents/` (or any IDE's equivalent) and they auto-route on natural-language triggers via "Use PROACTIVELY when..." phrases in their `description` frontmatter. Coverage: 6 engineering, 4 orchestration, 4 content (voice-aware), 1 visual, 1 production gate.
- **`agents/README.md`** — comprehensive guide: install commands per IDE, the 16-agent table grouped by purpose, how auto-routing works, two ways to wire up brand voice, how to update the cherry-pick.
- **`agency-agents` bundle** in `.claude-plugin/marketplace.json` — installs all 16 sub-agents in one shot. Companion to the existing `agent-foundation` / `content-engine` / `ops-pipeline` / `agent-self-improvement` skill bundles.

### Changed
- **`.claude-plugin/marketplace.json`**: library version 1.2.0 → 1.3.0; description now mentions sub-agents + Cowork support; new `agency-agents` bundle added (5 bundles total).

## [1.2.0] — 2026-05-05

### Added
- **`skills/tool-leverage-heuristics/SKILL.md`** — the autonomy playbook as a portable, IDE-agnostic skill. Maps natural-language triggers ("AI-search visibility", "production is down", "ready to ship?") to specific tool/agent combos that should fire together. The agent reaches for the right tool without being told. Companion to the existing `runbooks/tool-leverage-heuristics.md`.
- **`skills/brand-ssot-precedence/SKILL.md`** — defines the precedence chain for brand single sources of truth (AGENTS.md → DESIGN.md → voice playbook → tokens.json). The agent reads brand canon BEFORE producing any human-facing copy or visual artifact. Project-agnostic.
- **`docs/SKILLS-CATALOG.md`** — comprehensive index of every skill with bundle membership, brand-config requirements, dependencies, install priority, and a decision tree for picking the right skill.
- **`CHANGELOG.md`** — this file.

### Changed
- **`skills/human-voice/SKILL.md`** (v1.1.0 → v1.2.0): description now explicitly tells the harness this is UNIVERSAL anti-AI-tell rules, and that any project-specific brand voice playbook overrides it on conflicts. New section "How this skill layers with project-specific brand voice" spells out the precedence chain. Closes the gap where projects with their own voice DNA were getting generic anti-AI-tell rules without their banned/signature phrases applied first.
- **`scripts/validate-all.sh`**: graceful fallback when the `agentskills` CLI isn't installed locally (it's not on PyPI as of this commit). Always runs the lightweight `validate-frontmatter.sh` first; conditionally runs the full agentskills pass if the CLI is found.
- **`.claude-plugin/marketplace.json`**: `agent-foundation` bundle (v1.1.0 → v1.2.0) now includes the two new skills (`tool-leverage-heuristics`, `brand-ssot-precedence`). Library version bumped to v1.2.0.
- **`README.md`**: references the new skills, catalog doc, and changelog.

## [1.1.0] — 2026-05-05

### Added
- **`installers/superpowers-stack/scripts/07-install-agency-agents.sh`** — clones [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) (MIT) and runs the portable installer with voice-DNA paths from `client.env`. Voice-aware sub-agents (linkedin-content-creator, carousel-growth-engine, ai-citation-strategist, image-prompt-engineer, document-generator) get an inline brand-voice block injected at install time.
- **`installers/superpowers-stack/scripts/08-install-firecrawl-mcp.sh`** — registers Firecrawl MCP. Supports project-scope direct JSON edit (recommended for always-on agents — set `AGENT_MCP_JSON_PATH`) and local-scope `claude mcp add` fallback.
- **`installers/superpowers-stack/scripts/09-install-graphify.sh`** — installs `uv` if missing, then `graphifyy` via uv, then registers the Claude Code skill so `/graphify` becomes a slash command.
- **`installers/superpowers-stack/agency-agents-installer/`** — portable installer (`install.py` + `manifest.json` + `voice-paths.example.json`). Same script works on Mac, VPS, or any future client install.
- **`DESIGN.example.md`** (top level) — Stitch 9-section visual SSOT template. Drop-in for any project.
- **`AGENTS.example.md`** (top level) — agents.md open-standard brand-context template. Drop-in for any project.
- **`runbooks/tool-leverage-heuristics.md`** — the human-readable autonomy playbook (combo-pattern table mapping triggers to tool/agent combos).

### Changed
- **`installers/superpowers-stack/scripts/install-all.sh`**: now calls 07/08/09 in sequence (idempotent).
- **`installers/superpowers-stack/config/client.example.env`**: adds `AGENCY_AGENTS_CACHE_DIR`, `CLAUDE_AGENTS_DIR`, `BRAND_VOICE_PATHS_FILE`, `AGENT_MCP_JSON_PATH`. Tightens Firecrawl comment.
- **`installers/superpowers-stack/config/CLAUDE.md.template`**: adds Firecrawl, sub-agents catalog (16 cherry-picked), knowledge-graph navigation, brand-voice precedence, brand-visual precedence, and Tool-Leverage Heuristics combo table.
- **`installers/superpowers-stack/README.md`**: adds items 7/8/9 to "What this installs."
- **`runbooks/README.md`**: adds tool-leverage-heuristics row.
- **`README.md`**: references the new installers, brand-context drop-ins, and runbook.

## [1.0.0] — Initial release

- 12 skills following the [Agent Skills specification](https://agentskills.io)
- 6 runbooks covering deploy gates, watchdog discipline, drive-handoff, defensive bindings, escalation hygiene, and operating principles
- 1 installer kit: `superpowers-stack` (Superpowers + Memory / Fetch / Filesystem / Playwright / Chroma MCPs)
- 3 prompt templates (voice DNA, agent-skills spec summary, institutional AI stance)
- Multi-IDE installer (`install.sh` + `install.ps1`) detecting Claude Code, Cursor, Codex, Windsurf, OpenCode, and Antigravity
- `brand-config.example.yml` for project-local tenant config
- Claude Code marketplace manifest (`.claude-plugin/marketplace.json`) with four installable bundles
- Lightweight frontmatter validator + scaffolding helper

---

## Versioning policy

- **MAJOR**: removes a skill, renames a skill folder (breaks installs that referenced the old path), or changes the skill spec compliance contract.
- **MINOR**: adds a new skill, runbook, prompt, installer, bundle, or config field. Adds a new IDE adapter to install.sh. Adds a new top-level template (e.g. AGENTS.example.md, DESIGN.example.md).
- **PATCH**: docs, comments, validation script bug fixes, frontmatter typos, broken-link fixes.

When a skill's behavior changes meaningfully, bump its individual `metadata.version` in the SKILL.md frontmatter even if the library MINOR version doesn't bump. Per-skill versions are independent of library version.
