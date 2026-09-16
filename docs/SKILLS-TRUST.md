# Skill Trust and Provenance

Generated trust overview for the installable skill library.

The trust layer is intentionally conservative: imported skills can be useful while still needing human review before sensitive use.

## Trust Levels

| Trust level | Count | Meaning |
|---|---:|---|
| `imported-review-recommended` | 755 | Imported and contains content that matched risk-sensitive keywords; review before sensitive use. |
| `imported` | 522 | Imported from an upstream source and schema/frontmatter validated here. |
| `curated` | 23 | Created and maintained directly in this library. |
| `runtime` | 3 | Bundled with a local runtime and tracked here for portability. |

## Risk Flags

| Risk flag | Count |
|---|---:|
| `shell-execution` | 575 |
| `secrets-sensitive` | 461 |
| `security-sensitive` | 363 |
| `network-access` | 53 |
| `destructive-system-ops` | 20 |

## Source Groups

| Source | Type | Trust posture | Skills |
|---|---|---|---:|
| [sickn33/antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills) | `github` | Imported upstream; validate before sensitive use | 1242 |
| [menkesu/awesome-pm-skills](https://github.com/menkesu/awesome-pm-skills) | `github` | Imported upstream; validate before sensitive use | 29 |
| Original New Minds Group | `original` | Curated in this repo | 23 |
| [mxyhi/ok-skills](https://github.com/mxyhi/ok-skills) | `github` | Imported upstream; validate before sensitive use | 4 |
| OpenAI Codex bundled system skills | `runtime` | Runtime-provided | 3 |
| [maigentic/stratarts](https://github.com/maigentic/stratarts) | `github` | Imported upstream; validate before sensitive use | 1 |
| [refoundai/lenny-skills](https://github.com/refoundai/lenny-skills) | `github` | Imported upstream; validate before sensitive use | 1 |

## Safety Quarantine

208 skill(s) are preserved under `../quarantine/` but removed from the default install/export path. See [`SKILLS-SAFETY.md`](SKILLS-SAFETY.md) for the policy, reasons, and reinstatement rules.

Machine-readable trust fields are included in [`../dist/skills-index.json`](../dist/skills-index.json) and [`../manifests/skills-manifest.json`](../manifests/skills-manifest.json).
