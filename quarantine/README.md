# Quarantined Skills

This folder preserves skills that were removed from the default installable library during the May 21, 2026 safety audit.

These skills are intentionally not under `sources/*/skills/`, so `scripts/sync-skill-library.rb` will not export them to `dist/skills/` and the one-line installer will not install them.

Review metadata lives in [`../manifests/skill-safety-policy.json`](../manifests/skill-safety-policy.json). The human-readable safety policy lives in [`../docs/SKILLS-SAFETY.md`](../docs/SKILLS-SAFETY.md).

To reinstate a skill, rewrite it first, remove or update its policy entry, move the reviewed skill back into `sources/<source>/skills/<skill-name>/`, then run the full validation suite.

Local Codex cleanup uses a separate quarantine outside active discovery:

```text
~/.codex/skill-quarantine/<timestamp>/
```

That local quarantine is for already-installed user copies. This repository-level `quarantine/` folder is the canonical evidence and policy source for the public library.
