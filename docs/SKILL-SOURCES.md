# Skill Sources and Import Report

This report records how the repository skill library was reconciled with the local Codex and agent skill roots.

- Sync date: 2026-05-09
- Total repository skills after sync: 1513
- Added this sync: 1499
- Preserved existing repo skills: 14
- Duplicate source names resolved: 11

## Import Priority

1. Existing repository skills were preserved and never overwritten.
2. `~/.codex/skills` was used as the canonical imported source for Codex-ready skills.
3. `~/.codex/skills/.system` filled runtime/system skills that were not already present.
4. `~/.agents/skills` filled agent-side PM/business skills that were not already mirrored into Codex.

## Duplicate Source Names

- `ai-startup-building` kept from `codex-regular` at `~/.codex/skills/ai-startup-building/SKILL.md`. Other copies: `agents:~/.agents/skills/ai-startup-building/SKILL.md`
- `business-model-canvas` kept from `codex-regular` at `~/.codex/skills/business-model-canvas/SKILL.md`. Other copies: `agents:~/.agents/skills/business-model-canvas/SKILL.md`
- `graphify` kept from `codex-regular` at `~/.codex/skills/graphify/SKILL.md`. Other copies: `agents:~/.agents/skills/graphify/SKILL.md`
- `metrics-frameworks` kept from `codex-regular` at `~/.codex/skills/metrics-frameworks/SKILL.md`. Other copies: `agents:~/.agents/skills/metrics-frameworks/SKILL.md`
- `okr-frameworks` kept from `codex-regular` at `~/.codex/skills/okr-frameworks/SKILL.md`. Other copies: `agents:~/.agents/skills/okr-frameworks/SKILL.md`
- `setting-okrs-goals` kept from `codex-regular` at `~/.codex/skills/setting-okrs-goals/SKILL.md`. Other copies: `agents:~/.agents/skills/setting-okrs-goals/SKILL.md`
- `skill-creator` kept from `codex-regular` at `~/.codex/skills/skill-creator/SKILL.md`. Other copies: `codex-system:~/.codex/skills/.system/skill-creator/SKILL.md`
- `skill-installer` kept from `codex-regular` at `~/.codex/skills/skill-installer/SKILL.md`. Other copies: `codex-system:~/.codex/skills/.system/skill-installer/SKILL.md`
- `startup-validator` kept from `codex-regular` at `~/.codex/skills/startup-validator/SKILL.md`. Other copies: `agents:~/.agents/skills/startup-validator/SKILL.md`
- `strategy-frameworks` kept from `codex-regular` at `~/.codex/skills/strategy-frameworks/SKILL.md`. Other copies: `agents:~/.agents/skills/strategy-frameworks/SKILL.md`
- `zero-to-launch` kept from `codex-regular` at `~/.codex/skills/zero-to-launch/SKILL.md`. Other copies: `agents:~/.agents/skills/zero-to-launch/SKILL.md`

## Machine-Readable Manifest

See [`../manifests/skills-manifest.json`](../manifests/skills-manifest.json).
