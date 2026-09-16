# Yazinc Toolkit Import Audit

Version-Timestamp: 2026-08-04 12:52:19 AST

## Scope

Source reviewed: https://github.com/Yaz-inc/yazinc-ai-toolkit.git

Local review clone: `/tmp/yazinc-ai-toolkit-review.dmCKTY`

Reviewed commit: `23bb4109949bde727773f5ca708d93f2d35737f0`

Previously reviewed commit: `72dcc6c73505de43f6f83d0e2ff76576b8311635`

Reviewed surface:

* 51 installable skill folders under `skills/*/SKILL.md`, excluding `_template`.
* PowerShell installers under `scripts/`.
* Skill metadata under `skills/*/agents/openai.yaml`.
* Operational templates under `templates/`.
* Repository catalog files: `README.md`, `INDEX.md`, `AGENTS.md`, `WORKFLOW.md`.

## Executive Recommendation

Do not run the Yaz installer directly and do not bulk import all 51 skills.

Use the repository as a reviewed source candidate only. If imported, bring it in through our existing source-group model:

`sources/yaz-inc-yazinc-ai-toolkit/skills/<skill-name>/`

Then export through the normal validation and dist pipeline.

The blocker for public redistribution is licensing. The reviewed clone does not contain a `LICENSE` or `COPYING` file. Until the license or written permission is resolved, the safe action is not to copy upstream skill bodies into this public library.

Implementation decision: create original New Minds Group skills that cover the useful capability areas without copying third-party text, and preserve a machine-readable disposition for every upstream skill.

## Installer Verdict

Command supplied by user:

```powershell
git clone https://github.com/Yaz-inc/yazinc-ai-toolkit.git; cd yazinc-ai-toolkit; powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install-toolkit.ps1 -Target all
```

Verdict: do not run on this machine as part of the library import.

Reason:

* It mutates user-level skill roots, including `~/.agents/skills`, `~/.claude/skills`, and `~/.gemini/config/skills`.
* It bypasses our source-group provenance model.
* It would install duplicate and risky skills before license, safety, and redundancy review are complete.
* It does not appear malicious. It copies skill folders and marker files, with no dependency install or network fetch found in the installer. The issue is governance, not observed malware.

## Import Strategy

Recommended approach:

1. Resolve license or get written permission before importing any content into the public library.
2. Add a new source folder only after that resolution.
3. Import selected skills in batches, not all at once.
4. Normalize metadata on every imported skill:
   * `source_repository`
   * `source_commit`
   * `source_path`
   * `review_status`
   * `risk_flags`
   * `install_policy`
5. Merge redundant skills into existing stronger skills instead of adding name-level duplicates.
6. Keep risky operational skills quarantined or gated.
7. Run the existing library validation pipeline after each batch.

## Summary Counts

| Disposition | Count | Meaning |
|---|---:|---|
| Import candidate after license resolution | 17 | Valuable enough to bring in as distinct skills or source variants |
| Merge into existing skill | 18 | Useful content, but importing as a new skill would create redundancy |
| Optional Laravel pack | 10 | Valuable only as a clearly labeled Laravel vertical pack |
| Gated or quarantine only | 3 | Useful in controlled contexts, unsafe as default installs |
| Exclude or rewrite before import | 3 | Not appropriate as standalone default library skills |
| Total reviewed | 51 | Excludes `_template` |

## High-Priority Import Candidates

These are the best candidates after license resolution and metadata normalization.

| Skill | Recommendation | Reason |
|---|---|---|
| `deploy-secrets-zero-exposure` | Import after normalization | Strong deploy safety gate. Keep as defensive audit workflow. Verify the bundled scanner and adapt paths to our library style. |
| `test-software-app` | Import after normalization | Strong staged app audit workflow with clear authorization, mutation boundaries, evidence model, and verdict rules. |
| `data-operations-router` | Import | Useful router for data work. Helps avoid using the wrong data skill. |
| `data-quality-contracts` | Import or merge into a stronger data-quality pack | Practical contract-focused workflow. More specific than broad existing data quality skills. |
| `data-reconciliation-migration` | Import | Good migration and reconciliation method. Useful for client-system safety. |
| `data-lineage-governance` | Import | Adds governance, ownership, retention, impact analysis, and lineage focus. |
| `data-profile-clean-validate` | Import | Useful reproducible dataset profiling and cleanup workflow. |
| `data-pipeline-orchestration` | Import | Useful pipeline reliability and backfill workflow. |
| `analytics-engineering` | Import | Good dimensional analytics and tested transformation workflow. |
| `database-reliability-audit` | Import | Practical DB reliability audit coverage, including constraints, transactions, backups, and recovery. |
| `api-contract-testing` | Import | Good API contract and failure behavior workflow. |
| `frontend-quality-gate` | Import | Useful release gate for frontend performance, console, network, responsive, SEO, and regression evidence. |
| `deepeval-ai-testing` | Import or merge into AI evaluation cluster | Adds a concrete DeepEval regression path. Keep provider and data-publication cautions. |
| `ai-observability` | Import | Good privacy-aware tracing, quality, cost, latency, and incident diagnosis workflow. |
| `analyst-insight-reporting` | Import | Useful reproducible analysis and decision-reporting workflow. |
| `big-data-analytics` | Import | Adds scale-based routing for data beyond single-process workflows. |
| `ci-cd-release-gates` | Import with release-gate risk flags | Useful CI/CD gate design. Must retain explicit authorization before deployment or protected environment changes. |

## Merge, Do Not Duplicate

These contain useful material, but the library already has close equivalents. Importing them as separate top-level skills would increase noise.

| Skill | Recommendation | Existing overlap |
|---|---|---|
| `accessibility-audit` | Merge into existing accessibility skills | `fixing-accessibility`, `web-accessibility`, `accessibility-compliance-accessibility-audit`, `wcag-audit-patterns`, `ui-a11y` |
| `ai-evaluation-red-team` | Merge into AI evaluation and red-team guidance with explicit authorization gates | `agent-evaluation`, `advanced-evaluation`, existing security-sensitive review skills |
| `application-security-review` | Merge into security review guidance with explicit authorization gates | `laravel-security-audit`, `stride-analysis-patterns`, security review skills |
| `architecture-decision-records` | Do not import as new | Exact duplicate name already exists in the library |
| `design-system-engineering` | Merge | `tailwind-design-system`, `design-system`, `core-components`, `radix-ui-design-system` |
| `design-to-code-implementation` | Merge | `figma-implement-design`, `design-to-code-orchestrator`, `ui-visual-validator` |
| `figma-canva-design-workflow` | Merge or keep as connector-specific guidance | Overlaps design-to-code and design workflow skills. Must avoid unauthorized external uploads. |
| `nosql-query-engineering` | Merge | `database`, Azure Cosmos skills, NoSQL and data-modeling skills |
| `observability-incident-response` | Merge | `incident-response-incident-response`, `incident-runbook-templates`, `observability-engineer` |
| `performance-load-testing` | Merge | `k6-load-testing`, performance and QA skills |
| `playwright-e2e-testing` | Merge | `e2e-testing`, `go-playwright`, `testing-qa`, Playwright skills |
| `rag-evaluation` | Merge into RAG evaluation cluster | `rag-engineer`, `rag-implementation`, retrieval and vector skills |
| `screen-reader-accessibility-testing` | Merge | `screen-reader-testing`, accessibility skills |
| `sql-performance-optimization` | Merge | `sql-optimization-patterns`, `sql-pro`, `database-optimizer` |
| `sql-query-engineering` | Merge | `database`, SQL and query skills |
| `supply-chain-security` | Merge into security and dependency review cluster | `dependency-management-deps-audit`, `codebase-cleanup-deps-audit`, security review skills |
| `ui-ux-product-design` | Merge | `design-system`, `ux-flow`, `ui-ux-designer`, `web-design-guidelines` |
| `vector-database-readiness` | Merge | `vector-index-tuning`, `embedding-strategies`, `similarity-search-patterns`, Azure Search skills |

## Optional Laravel Pack

These should not be mixed into the default general-purpose install unless we intentionally create a Laravel starter pack. They are useful as a vertical pack after license resolution, code review of templates, and metadata normalization.

| Skill | Recommendation | Notes |
|---|---|---|
| `laravel-activity-logger` | Optional Laravel pack | Practical audit-log pattern. Verify privacy boundaries for payload logging. |
| `laravel-ai-multi-provider` | Optional Laravel pack | Useful provider fallback pattern. Must preserve key handling and provider-cost controls. |
| `laravel-datatables-module` | Optional Laravel pack | Useful CRUD/DataTables recipe. Low standalone value outside Laravel. |
| `laravel-env-maintenance` | Optional Laravel pack | Useful shared-hosting maintenance pattern. Must avoid unsafe `.env` editing. |
| `laravel-form-select2-global` | Optional Laravel pack | Narrow CSS consistency recipe. Include only if the pack supports UI implementation recipes. |
| `laravel-json-ai-settings` | Optional Laravel pack with sensitive-data flags | Handles encrypted API keys. Requires hardening review before default use. |
| `laravel-rbac-permissions` | Optional Laravel pack | Useful module RBAC pattern. Needs framework-version assumptions documented. |
| `laravel-security-hardening` | Optional Laravel pack | Strong fit for Laravel pack. Keep explicit defensive scope. |
| `laravel-soft-delete-trash` | Optional Laravel pack | Useful trash/restore workflow. Needs deletion and retention safeguards. |
| `laravel-vision-label-scan` | Optional Laravel pack | Useful AI/OCR feature pattern. Needs provider, privacy, and storage review. |

## Gated or Quarantine Only

These should not be default-installable without explicit activation rules.

| Skill | Verdict | Reason |
|---|---|---|
| `central-knowledge-base` | Gated | Writes to a central local knowledge base. Good safety posture, but storage location, confidentiality rules, and duplicate-resolution authority must be explicit. |
| `laravel-dual-repo-push` | Gated | Performs external GitHub mutations. Keep only as an explicit release workflow with authorization, clean remotes, and no force push unless separately approved. |
| `mission-control` | Gated | Uses API keys or session cookies and performs agent registration, heartbeat, task, and skill API actions. Keep only for known Mission Control deployments. |

## Exclude or Rewrite Before Import

| Skill | Verdict | Reason |
|---|---|---|
| `animated-glow-border` | Do not import as standalone | Too narrow for a large general skill library. Better as a snippet inside a UI animation or frontend recipe skill. |
| `extract-to-toolkit` | Do not import as-is | It is meta-authority for another repository and includes direct push guidance. Our library already has safer source governance. |
| `laravel-deploy-fix-php` | Rewrite or quarantine | Public `fix.php` recovery endpoint is high-risk. The template uses a fallback static key if `APP_KEY` is unavailable, mutates caches and filesystem state, prints operational details after auth, and the instructions conflict on keeping it permanently versus deleting after use. |

## Specific Safety Findings

### Missing License

No `LICENSE` or `COPYING` file was found in the reviewed clone. This blocks public redistribution through our library unless permission is clarified.

### Public Recovery Endpoint Risk

`laravel-deploy-fix-php` and `templates/fix.php.example` need a rewrite before any import. Minimum required changes:

* Remove fallback static key behavior.
* Prefer one-time or short-lived recovery secrets.
* Require IP allowlist or server-level auth for production.
* Require delete-after-use as the default.
* Remove output that exposes unnecessary operational detail.
* Keep it in quarantine if retained at all.

### External Mutation Risk

`laravel-dual-repo-push`, `mission-control`, and `extract-to-toolkit` can push, register, heartbeat, sync, or publish. These should not be default skills.

### Defensive Security Skills Need Scope Gates

`application-security-review`, `ai-evaluation-red-team`, and `supply-chain-security` are useful, but they must preserve explicit authorization boundaries for intrusive scanning, third-party probing, exploit testing, credential handling, and production testing.

### Metadata Needs Normalization

Most Yaz skills have useful descriptions, but they do not carry our full library metadata for source, trust, risk, review status, install policy, or license. Do not copy them directly into `dist`.

## Recommended Batch Plan

Batch 0: Legal and provenance

* Resolve license or obtain permission.
* Create source metadata for `yaz-inc-yazinc-ai-toolkit`.
* Add import policy for gated and optional-pack skills.

Batch 1: Safety and QA value

* `deploy-secrets-zero-exposure`
* `test-software-app`
* `api-contract-testing`
* `frontend-quality-gate`
* `ci-cd-release-gates`

Batch 2: Data operations cluster

* `data-operations-router`
* `data-quality-contracts`
* `data-reconciliation-migration`
* `data-lineage-governance`
* `data-profile-clean-validate`
* `data-pipeline-orchestration`
* `analytics-engineering`
* `database-reliability-audit`
* `big-data-analytics`

Batch 3: AI reliability cluster

* `ai-observability`
* `deepeval-ai-testing`
* `ai-evaluation-red-team` as merged, gated evaluation guidance
* `rag-evaluation` as merged RAG guidance

Batch 4: Laravel optional pack

* Import only if we want a named Laravel starter pack.
* Exclude or quarantine `laravel-deploy-fix-php`.
* Gate `laravel-dual-repo-push`.

Batch 5: Redundancy merge

* Pull useful sections from accessibility, design, SQL, Playwright, observability, and vector skills into existing stronger skills.
* Do not add duplicate top-level names.

## Validation Required Before Any Import

Run after each batch:

```bash
scripts/validate-safety-policy.rb
scripts/sync-skill-library.rb
scripts/validate-all.sh
scripts/check-generated.sh
scripts/smoke-install.sh
```

Also run a targeted search for:

```bash
rg -n "(curl|Invoke-RestMethod|git push|APP_KEY|fix\\.php|api key|cookie|token|secret|credential|delete|Remove-Item|chmod|sudo|eval|exec|shell_exec|system\\()" sources/yaz-inc-yazinc-ai-toolkit
```

## Final Verdict

Import all: no.

Import none: also no.

Best path: resolve license before copying upstream skill bodies. In the meantime, use the original New Minds Group replacement skills and decision manifest to leverage the useful capability coverage safely. Prioritize the safety, QA, data operations, and AI reliability skills. Merge redundant generic skills into existing library coverage. Keep Laravel as an optional pack. Quarantine or rewrite public endpoint, dual-push, Mission Control, and meta-publishing workflows.

## Implemented Safe Coverage

The following original skills were added to cover the high-value capability clusters without copying upstream text:

| Original skill | Coverage |
|---|---|
| `deployment-secret-exposure-gate` | Secret exposure, deploy safety, CI/CD release gates, supply-chain release checks |
| `application-release-audit` | App testing, release verdicts, evidence registers, authorized fixes |
| `data-operations-governance` | Data routing, contracts, profiling, reconciliation, lineage, pipelines, analytics, database reliability |
| `ai-reliability-evaluation` | AI evaluation, red-team boundaries, DeepEval-style regression, RAG, vector readiness, AI observability |
| `api-contract-release-gate` | API contract, auth, compatibility, failure, idempotency, and evidence checks |
| `frontend-release-quality-gate` | Frontend runtime quality, responsive QA, accessibility, browser workflows, performance |
| `laravel-delivery-safety-pack` | Safe Laravel vertical coverage without default public recovery endpoints |
| `knowledge-base-governance` | Safe central knowledge-base writes, retrieval, duplicate resolution, and confidentiality controls |

Decision manifest: [`../manifests/yazinc-toolkit-import-decisions.json`](../manifests/yazinc-toolkit-import-decisions.json)
