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

## Vendoring a new third-party source

Importing an external repo into `sources/` adds third-party code that ships to every installer. Before vendoring a new source, complete this checklist in the PR description (a CODEOWNER must approve):

1. **Provenance** — record the upstream repo URL and the exact commit SHA being vendored.
2. **License** — confirm the upstream LICENSE permits redistribution. Preserve the upstream `LICENSE` file inside the source dir, carry the real SPDX id (do **not** relabel as MIT), and add the source to `NOTICE.md`. No license = "all rights reserved" = do not vendor without written permission.
3. **Malware/secret scan** — run a dangerous-pattern scan over the source's executable code (`curl|bash`, `eval`/`exec`, reverse shells, credential reads, obfuscation) and a secret scan. Note results.
4. **Manual sample review** — read a representative sample of `SKILL.md` files for prompt-injection or unsafe-instruction content, and read every bundled `scripts/` file.
5. **Privacy** — flag any skill that collects/transmits personal data; gate scraping/OSINT/pen-test skills behind an opt-in bundle.
6. **Record it** — log who vetted the source, when, and against what criteria.

If any step is uncertain, do not vendor — quarantine and resolve first.
