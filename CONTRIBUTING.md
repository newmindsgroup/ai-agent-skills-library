# Contributing

Thanks for adding a skill to the New Minds Group skills library. Quick version:

1. Read [`docs/AUTHORING.md`](docs/AUTHORING.md).
2. Scaffold: `./scripts/new-skill.sh <skill-name>`
3. Edit `sources/original/skills/<skill-name>/SKILL.md`.
4. Regenerate exports and indexes: `ruby scripts/sync-skill-library.rb`
5. Validate: `./scripts/validate-all.sh`
6. Check generated files and links: `./scripts/check-generated.sh && ruby scripts/check-links.rb`
7. Open a PR. CI will re-validate.

## Ground rules

- **One skill, one workflow.** Don't build catch-all skills. Split them.
- **Third-person descriptions.** Never "I can help you…" — always "Drafts…", "Reviews…", "Synthesizes…".
- **Write triggers into the description.** The description is how the agent decides whether to load the skill.
- **No placeholder descriptions.** Avoid generic text like "Use when working with..." without a concrete outcome, trigger, and domain.
- **No secrets, ever.** This repo is public. No API keys, tokens, client names, or proprietary data.
- **Keep SKILL.md under 500 lines.** Deep content belongs in `references/`.
- **Every skill ships with examples.** Minimum two concrete examples at the bottom of SKILL.md.
- **Do not edit `dist/skills/` directly.** It is generated from `sources/` for installer compatibility.

## Review criteria

Reviewers check:

- Does the skill have a clearly defined, narrow scope?
- Is the trigger language in the description precise?
- Is the body under 500 lines and free of fluff?
- Do the examples show realistic invocations?
- Does validation pass?
- Are generated indexes and source docs up to date?
- Is there no secret or confidential information?
