# Skill Trust and Provenance

Generated trust overview for the installable skill library.

The trust layer is intentionally conservative: imported skills can be useful while still needing human review before sensitive use.

## Trust Levels

| Trust level | Count | Meaning |
|---|---:|---|
| `imported-review-recommended` | 918 | Imported and contains content that matched risk-sensitive keywords; review before sensitive use. |
| `imported` | 567 | Imported from an upstream source and schema/frontmatter validated here. |
| `curated` | 15 | Created and maintained directly in this library. |
| `runtime` | 3 | Bundled with a local runtime and tracked here for portability. |

## Risk Flags

| Risk flag | Count |
|---|---:|
| `shell-execution` | 629 |
| `secrets-sensitive` | 583 |
| `security-sensitive` | 434 |
| `network-access` | 63 |
| `destructive-system-ops` | 31 |

## Source Groups

| Source | Type | Trust posture | Skills |
|---|---|---|---:|
| [sickn33/antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills) | `github` | Imported upstream; validate before sensitive use | 1448 |
| [menkesu/awesome-pm-skills](https://github.com/menkesu/awesome-pm-skills) | `github` | Imported upstream; validate before sensitive use | 29 |
| Original New Minds Group | `original` | Curated in this repo | 15 |
| [mxyhi/ok-skills](https://github.com/mxyhi/ok-skills) | `github` | Imported upstream; validate before sensitive use | 6 |
| OpenAI Codex bundled system skills | `runtime` | Runtime-provided | 3 |
| [maigentic/stratarts](https://github.com/maigentic/stratarts) | `github` | Imported upstream; validate before sensitive use | 1 |
| [refoundai/lenny-skills](https://github.com/refoundai/lenny-skills) | `github` | Imported upstream; validate before sensitive use | 1 |

Machine-readable trust fields are included in [`../dist/skills-index.json`](../dist/skills-index.json) and [`../manifests/skills-manifest.json`](../manifests/skills-manifest.json).
