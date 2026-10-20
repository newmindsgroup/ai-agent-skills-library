---
name: project-init
description: "Stamp the shared operating standard (the four-pillar Engineering Mantra plus the full Working Style spine) into a project so every tool that enters the repo works under the same Security, Stability, Reliability, and Compliance lens. Use when starting a new project or repo, when onboarding an existing project that lacks an AGENTS.md, when the user says 'set up this project', 'apply our standard', 'add the operating standard here', 'make this project follow the four pillars', 'init this repo', or '/project-init'. Creates AGENTS.md if absent, merges the standard into an existing AGENTS.md without overwriting project-specific content, and offers a DESIGN.md scaffold for brand-facing projects. Idempotent and safe to re-run."
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
---

# Project Init — stamp the operating standard into a project

Version-Timestamp: 2026-10-04 17:19:58 AST

Goal: make a project self-contained under the same operating lens as the global
config, so the four pillars and working-style rules travel with the repo (for
teammates, CI, cloud agents, other machines, and tools that read only project
files). The global `~/.claude` config already applies these in every session on
this machine; this skill puts them **in the repo** so they survive outside it.

## What gets written

`AGENTS.md` is the cross-tool standard read by Claude Code, Codex, Cursor, and
Antigravity. The shared operating standard lives between `<!-- SPINE:START -->`
and `<!-- SPINE:END -->` markers, sourced from `references/operating-spine.md`
(extracted from `ide-config-template`, so it stays genericized and in sync with
the canonical spine). It carries all twelve sections, including:

- **Engineering Mantra — Security, Stability, Reliability, Compliance** (the four pillars)
- Skill & Command Leverage, Design Evidence Feedback Loop, Qualifying Questions, Proportional Rigor,
  Attribution & Versioned Outputs, Third-Party Component Trust, Data Handling,
  Truthfulness & Escalation, Writing Standard (no em/en dashes), Look Around the
  Corner, Skill-Worthiness Radar, Next Steps & Sequenced Building.

## How to run it

1. **Identify the target project directory** (default: the current working dir).
   Confirm it is the intended repo root.
2. **Apply the standard** with the bundled injector. It is idempotent and
   preserves all existing content:
   ```bash
   bash ~/.claude/skills/project-init/scripts/apply-spine.sh [TARGET_DIR]
   ```
   Behavior:
   - No `AGENTS.md` -> creates one with a short header plus the SPINE block.
   - `AGENTS.md` already has SPINE markers -> refreshes only the block between them.
   - `AGENTS.md` exists without markers -> appends the standard, leaving the
     project's own content untouched.
   Use `--check [DIR]` first to see status without writing (exit 0 in sync, 3 drift).
3. **Never overwrite project-specific rules.** The injector only touches the SPINE
   block. If a project already has hand-written brand voice, design, or domain
   rules, they are preserved above and below the markers.
4. **Brand-facing projects also get DESIGN.md.** If the project ships UI, brand,
   or client-facing visuals, scaffold a `DESIGN.md` from the Visual SSOT (Stitch
   9-section format) and, when applicable, the brand voice files. Section 4
   carries the Iconography block (one pinned, self-hosted icon set; logos from a
   logo set; see `brand-ssot-precedence`). Skip this for pure code/utility repos
   where it would be noise.
5. **Do not auto-commit other repos.** Create or update the files in the working
   tree, then tell the user what changed and let them commit per repo (each
   project has its own remote and workflow). If they ask, commit with the
   standard attribution footer.
6. **Keep project learning project-local.** For design-relevant work, use the
   existing work packet to record feedback source, outcome and verification.
   Promote a reusable method only after repeated, verified results. Do not copy
   client evidence into a shared skill library.

## Keeping projects current

Because the block is marker-delimited, re-running the injector after the canonical
spine changes refreshes every project's standard in place. To re-stamp a set of
repos, run the injector (or `--check`) across each root. This is the per-project
analog of `sync-instructions.sh` for the global tool files.

## Sensitivity

Do not stamp `AGENTS.md` into client-shared cloud folders (Google Drive, OneDrive,
iCloud shared libraries) without confirming, since an internal-ops file would be
visible to the client. Default scope is local repos.
