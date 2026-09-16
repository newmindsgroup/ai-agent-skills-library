# Repository reconciliation

Version-Timestamp: 2026-09-15 21:53:36 AST

## Preservation and decisions

- Original audit commits are preserved on remote audit/skills-curation-20260915-214607 and local backup/skills-curation-before-reconcile-20260915.
- Both upstream main histories are merged, with no rebase or force push.
- Local receiving-stage routing, pricing repairs, skill policy and curated plugin packages remain preserved. Upstream licensing, UTF-8 fixes, prompt plugin and configuration improvements are incorporated.
- The upstream offensive starter bundle is omitted because it references skills quarantined by the stricter local policy. Historical definitions remain in Git.
- Eleven numeric duplicate generated bundles were backed up under the local Codex backups directory before removal.
- The tooltip-fix regression now expects systematic-debugging, consistent with the existing bug-fix policy; the visual completion gate remains required.

## Validation

- Internal configuration: verify-config.sh --repo-only passed. All nine test scripts passed. Generated instructions are synchronized.
- Library: generated-file consistency, local Markdown links and ShellCheck passed. Final skill validation is recorded in PUSH-VALIDATION.md.
- Both approved-skill-policy.json copies match byte for byte.
- Independent Claude review remains skipped under the user's usage-limit fallback instruction. No new provider call was made.

## Remaining operational limits

- The 28 plugin skill path disables still need a complete live discovery confirmation. This does not block repository preservation.
- Archived source skills are broader than the daily activation policy; bulk installation is not policy enforcement.
- CI on GitHub supplies the Windows installer check unavailable on this Mac.

Routing: model-governor read in full; Astra Low recommendation, current Codex runtime retained for native Git and validation tools. No model switch or paid fallback. Systematic debugging and engineering quality gate used for the reproduced validation issues.

## Remote confirmation

Version-Timestamp: 2026-09-15 21:59:22 AST

Reconciled main commits: library af9d94e, internal configuration 1eea0e1. Both histories and backup refs are pushed. Internal configuration CI passed. Library Windows installer CI passed. Library Linux CI exposed Ruby JSON empty-container formatting and clock-dependent generation; a portability fix normalizes containers and preserves the recorded manifest date. Local regression coverage passes, and subsequent CI must verify the fix.
