# Agent Instructions

## Validation
- Run before every push — same commands CI runs (`.github/workflows/validate.yml`):

```bash
bash scripts/validate-all.sh      # frontmatter check on every skill in dist/skills/
bash scripts/check-generated.sh   # fails if generated files drift from sources/
ruby scripts/check-links.rb       # local Markdown link check
```

- Single skill: `SKILLS_ROOT=dist/skills bash scripts/validate-frontmatter.sh dist/skills` (validator is per-tree; keep SKILL.md under 500 lines, description present, name matches folder).
- CI also shellchecks repo shell scripts and smoke-tests `install.sh` / `install.ps1` — touch those, run `shellcheck install.sh scripts/*.sh`.
- `sources/` and `dist/` are excluded from shellcheck. Do not lint them.
- Ruby scripts are stdlib-only; system Ruby works, no Gemfile. Requires a UTF-8 locale (`LC_ALL=en_US.UTF-8`) — US-ASCII shells crash the sync script.

## Generated Files
- **After editing any skill under `sources/`, run `ruby scripts/sync-skill-library.rb` and commit everything it regenerates — or CI fails.**
- Regenerated paths: `dist/` (flat export, bundles, indexes, README), `manifests/skills-manifest.json`, `docs/SKILL-SOURCES.md`, `docs/SKILLS-TRUST.md`, `docs/STARTER-PACKS.md`, `sources/README.md`, `sources/*/README.md`.
- Never hand-edit any of the above.

## Commit Attribution
- AI commits MUST include:

```
Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>
```

## Structure
- Canonical skill tree: `sources/<source-slug>/skills/<skill-name>/SKILL.md`.
- First-party skills live in `sources/original/skills/` — the only `sources/` subtree to edit.
- All other `sources/<slug>/` trees are third-party vendored — do not edit or lint.
- `dist/skills/` is the generated flat export — never hand-edit.
- New skill: `./scripts/new-skill.sh <skill-name>`, then see `CONTRIBUTING.md` and `docs/AUTHORING.md`.
- `AGENTS.example.md` / `DESIGN.example.md` are installer templates for target projects, not this repo's instructions.
