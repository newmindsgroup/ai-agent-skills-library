# Flat Skills Export

This directory is generated from `../sources/<source>/skills/`.

Agent Skills-compatible tools generally expect a flat layout:

```text
<skills-root>/<skill-name>/SKILL.md
```

Do not edit `dist/skills/` directly. Edit the canonical source skill under `sources/`, then run:

```bash
ruby scripts/sync-skill-library.rb
```

Search and discovery artifacts are generated beside this directory:

- `skills-index.json` - machine-readable search index
- `skills-index.tsv` - shell-friendly search index
- `bundles.json` and `bundles/*.txt` - starter-pack definitions for installers
