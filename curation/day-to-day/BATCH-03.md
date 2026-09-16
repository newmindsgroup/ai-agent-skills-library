# Behavior qualification batch

Version-Timestamp: 2026-09-15 09:52:13 AST

## Results

- Negotiation: four independent synthetic cases passed. Outputs preserve the minimum price and concession authority, avoid invented buyer commitment, accept supplied context without pretending CRM evidence exists, and recommend the competitor when it meets a mandatory requirement. The first-sale scenario had limited offer detail, so it does not establish domain-specific sales effectiveness. See NEGOTIATION-TESTS.md.
- Finance: baseline Artifact Tool recalculation passed balance-sheet, cash roll-forward and operating cash reconciliation checks across 12 months. Baseline formula-error search found no entries.
- Finance input changes: failed. Base, Growth and Downside returned identical sampled revenue and cash values. Increasing base collection days from 45 to 60 left cash unchanged. This is a failed qualification result, not proof of a workbook defect: engine/import/dependency behavior has not been isolated. Do not promote this template as a qualified interactive forecast. See finance-recalculation-tests.json.
- Comparison-page draft: removed compulsory index-page language for single-page requests and replaced trial signup with explicit authorization. These wording changes still need the affected behavior case rerun and exact upstream provenance before installation.

## Activation decision

Keep the existing negotiation skill as a behavior-tested candidate for these scoped cases. Do not create a duplicate negotiation plugin. Keep the finance template unqualified for forecasting pending investigation in its intended spreadsheet engine. Existing installed files were not edited, and the reference workbook was neither exported nor overwritten. No additional global disable actions occurred in this batch. Recorded cleanup total remains 138.

## Next priority

Investigate the finance input-change failure with a minimal dependency probe, then verify in the intended spreadsheet engine if available. Finish sales provenance and affected scope testing before expansion. Follow with a representative brand-canon and UX-state test batch rather than more name-only inventory.
