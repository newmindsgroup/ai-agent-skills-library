# NOTICE

This repository (the New Minds Group AI Agent Skills Library) is distributed under the MIT License (see [`LICENSE`](LICENSE)).

It redistributes third-party skills vendored under `sources/`. Each kept third-party source retains its own upstream license, preserved as `sources/<dir>/LICENSE`, and per-skill `license:` frontmatter reflects the true upstream license. Redistribution and attribution for every kept source are recorded below.

## Redistributed sources

| Source dir | Upstream repo URL | Author | License (SPDX) |
|---|---|---|---|
| `original` | — (created in this repository) | New Minds Group | MIT |
| `maigentic-stratarts` | https://github.com/maigentic/stratarts | maigentic | MIT |
| `refoundai-lenny-skills` | https://github.com/refoundai/lenny-skills | refoundai | MIT |
| `menkesu-awesome-pm-skills` | https://github.com/menkesu/awesome-pm-skills | Udi Menkes | MIT |
| `mxyhi-ok-skills` | https://github.com/mxyhi/ok-skills | mxyhi | Apache-2.0 |
| `openai-codex-bundled-system-skills` | OpenAI Codex bundled system skills (runtime) | OpenAI | Apache-2.0 |
| `sickn33-antigravity-awesome-skills` | https://github.com/sickn33/antigravity-awesome-skills | sickn33 | MIT (some skills Apache-2.0; see per-skill `license:` and per-skill `LICENSE` files) |

The `sickn33-antigravity-awesome-skills` source is MIT at the repository level, but it aggregates skills from multiple upstreams. Skills that ship their own Apache-2.0 `LICENSE` file (for example Anthropic-authored skills such as `skill-creator`, `mcp-builder`, `canvas-design`, `web-artifacts-builder`, `brand-guidelines-*`, `internal-comms*`, `theme-factory`, `frontend-design`, `algorithmic-art`, `claude-api`, `slack-gif-creator`, `playwright-interactive`, `webapp-testing`) carry `license: Apache-2.0` in their frontmatter and retain that `LICENSE` file. All other sickn33 skills remain MIT.

## Quarantined sources (removed for licensing reasons)

The following content was removed from `sources/` because it is **not redistributable** under this repository's MIT license. It has been deleted and no longer ships in `dist/`:

- `sources/ailabs-393-ai-labs-claude-skills/` — no upstream license found (all rights reserved).
- `sources/scientiacapital-skills/` — no upstream license found (all rights reserved).
- `sources/sickn33-antigravity-awesome-skills/skills/{docx-official,xlsx-official,pdf-official,pptx-official}` — Anthropic "all rights reserved" skills, not redistributable.
- `sources/sickn33-antigravity-awesome-skills/skills/{figma-generate-design,figma-implement-design,figma-use,figma-create-design-system-rules}` — Figma proprietary terms, not redistributable.
- `sources/sickn33-antigravity-awesome-skills/skills/loki-mode` — BSD/scikit-learn corpus mislabeled as MIT; removed pending correct licensing.

Each upstream MIT/Apache-2.0 license requires that the copyright and permission notice be preserved. The corresponding `sources/<dir>/LICENSE` files satisfy that obligation.
