# Local Codex Skills Safety Audit

Generated: 2026-05-21T22:19:34Z

This report applies the repository safety policy to locally installed Codex-compatible skill roots. Active user-installed policy matches are moved only when the script is run with `--apply`.

## Summary

| Metric | Before | After |
|---|---:|---:|
| Active user skills | 1298 | 1298 |
| Runtime/plugin skills scanned | 37 | 37 |
| Active policy matches | 0 | 0 |
| Active unknown-to-library skills | 0 | 0 |
| Active local allowlisted skills | 2 | 2 |
| Active duplicate skill names | 9 | 9 |

- Mode: `apply`
- Local quarantine root: `/Users/newmindsgroup/.codex/skill-quarantine/20260521T221433Z`
- Audit manifest: [`../manifests/local-codex-skills-audit.json`](../manifests/local-codex-skills-audit.json)

## Reviewed Local-Only Allowlist

These active local skills are intentionally kept even though they are not part of the public safe-default library export.

| Skill | Status | Path | Reason |
|---|---|---|---|
| `android_ui_verification` | `allow-local-legacy-alias` | `/Users/newmindsgroup/.codex/skills/android_ui_verification` | Legacy underscore-named Android emulator UI verification skill. It overlaps with the safe default android-ui-verification skill and is limited to local ADB/emulator QA workflows. |
| `open-design-controller` | `allow-local-only` | `/Users/newmindsgroup/.codex/skills/open-design-controller` | Local Open Design runtime controller with machine-specific paths and OAuth/billing guardrails. Keep local; do not publish as a generic default skill without rewriting for portability. |

## Active Duplicate Names

These duplicates are reported so routing/debugging stays explicit. Identical copies were left in place when they span shared roots such as `~/.codex/skills` and `~/.agents/skills`.

| Skill | Identical SKILL.md | Paths |
|---|---|---|
| `ai-startup-building` | `true` | `/Users/newmindsgroup/.codex/skills/ai-startup-building`<br>`/Users/newmindsgroup/.agents/skills/ai-startup-building` |
| `business-model-canvas` | `true` | `/Users/newmindsgroup/.codex/skills/business-model-canvas`<br>`/Users/newmindsgroup/.agents/skills/business-model-canvas` |
| `graphify` | `true` | `/Users/newmindsgroup/.codex/skills/graphify`<br>`/Users/newmindsgroup/.agents/skills/graphify` |
| `metrics-frameworks` | `true` | `/Users/newmindsgroup/.codex/skills/metrics-frameworks`<br>`/Users/newmindsgroup/.agents/skills/metrics-frameworks` |
| `okr-frameworks` | `true` | `/Users/newmindsgroup/.codex/skills/okr-frameworks`<br>`/Users/newmindsgroup/.agents/skills/okr-frameworks` |
| `setting-okrs-goals` | `true` | `/Users/newmindsgroup/.codex/skills/setting-okrs-goals`<br>`/Users/newmindsgroup/.agents/skills/setting-okrs-goals` |
| `startup-validator` | `true` | `/Users/newmindsgroup/.codex/skills/startup-validator`<br>`/Users/newmindsgroup/.agents/skills/startup-validator` |
| `strategy-frameworks` | `true` | `/Users/newmindsgroup/.codex/skills/strategy-frameworks`<br>`/Users/newmindsgroup/.agents/skills/strategy-frameworks` |
| `zero-to-launch` | `true` | `/Users/newmindsgroup/.codex/skills/zero-to-launch`<br>`/Users/newmindsgroup/.agents/skills/zero-to-launch` |

## Operating Rule

Quarantined local skills are preserved outside active discovery paths so Codex will not load them automatically. Delete only after you no longer need the evidence trail; keep the policy entry until the library intentionally reclassifies or rewrites that skill.
