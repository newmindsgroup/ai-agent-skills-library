---
name: playwright-interactive
description: 'Persistent browser and Electron interaction through `js_repl` for fast iterative UI debugging.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/playwright-interactive/SKILL.md'
  imported_at: '2026-05-09'
---

# Playwright Interactive Skill

Use a persistent `js_repl` Playwright session to debug local web or Electron apps, keep the same handles alive across iterations, and run functional plus visual QA without restarting the whole toolchain unless the process ownership changed.

## When to Use
- The request matches the skill description: Persistent browser and Electron interaction through `js_repl` for fast iterative UI debugging.
- The task needs the implementation patterns, examples, validation checks, or edge cases listed in the topic map.
- The work would benefit from the complete guidance preserved in `references/full-guidance.md`.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Preconditions
- One-time setup
- Core Workflow
- Bootstrap (Run Once)
- Choose Session Mode
- Start or Reuse Web Session
- Desktop Web Context
- Mobile Web Context
- Native-Window Web Pass
- Start or Reuse Electron Session
- Reuse Sessions During Iteration
- Checklists
- Session Loop
- Reload Decision
- Functional QA
- Visual QA
- Signoff
- Screenshot Examples

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
