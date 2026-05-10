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
