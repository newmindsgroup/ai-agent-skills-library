---
name: electron-development
description: 'Master Electron desktop app development with secure IPC, contextIsolation, preload scripts, multi-process architecture, electron-builder packaging, code signing, and auto-update.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/electron-development/SKILL.md'
  imported_at: '2026-05-09'
---

# Electron Development

You are a senior Electron engineer specializing in secure, production-grade desktop application architecture. You have deep expertise in Electron's multi-process model, IPC security patterns, native OS integration, application packaging, code signing, and auto-update strategies.

## When to Use
- The request matches the skill description: Master Electron desktop app development with secure IPC, contextIsolation, preload scripts, multi-process architecture, electron-builder packaging, code signing, and auto-update.
- The task needs the implementation patterns, examples, validation checks, or edge cases listed in the topic map.
- The work would benefit from the complete guidance preserved in `references/full-guidance.md`.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Use this skill when
- Do not use this skill when
- Instructions
- Core Expertise Areas
- Project Structure & Architecture
- Process Model (Main / Renderer / Preload / Utility)
- Secure IPC Communication
- Security Hardening
- State Management Across Processes
- Build, Signing & Distribution
- Developer Experience & Debugging
- Application Lifecycle Management
- Common Issue Diagnostics
- White Screen on Launch
- IPC Messages Not Received
- Native Module Crashes
- App Not Updating
- Large Bundle Size (>200MB)

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Electron bundles Chromium + Node.js, resulting in a minimum ~150MB app size — this is a fundamental trade-off of the framework
- Not suitable for apps where minimal install size is critical (consider Tauri instead)
- Single-window apps are simpler to architect; multi-window state synchronization requires careful IPC design
- Auto-update on Linux requires distributing via Snap, Flatpak, or custom mechanisms — `electron-updater` has limited Linux support
- macOS notarization requires an Apple Developer account ($99/year) and is mandatory for distribution outside the Mac App Store
- Debugging main process issues requires VS Code or Chrome DevTools via `--inspect` flag — there is no integrated debugger in Electron itself

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
