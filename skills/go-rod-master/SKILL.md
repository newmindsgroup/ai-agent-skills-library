---
name: go-rod-master
description: 'Comprehensive guide for browser automation and web scraping with go-rod (Chrome DevTools Protocol) including stealth anti-bot-detection patterns.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/go-rod-master/SKILL.md'
  imported_at: '2026-05-09'
---

# Go-Rod Browser Automation Master

Comprehensive guide for browser automation and web scraping with go-rod (Chrome DevTools Protocol) including stealth anti-bot-detection patterns.

## When to Use
- The request matches the skill description: Comprehensive guide for browser automation and web scraping with go-rod (Chrome DevTools Protocol) including stealth anti-bot-detection patterns.
- The task needs the implementation patterns, examples, validation checks, or edge cases listed in the topic map.
- The work would benefit from the complete guidance preserved in `references/full-guidance.md`.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Overview
- When to Use This Skill
- Safety & Risk
- Installation
- Core Concepts
- Browser Lifecycle
- Must vs Error Patterns
- Context & Timeout
- Element Selectors
- Auto-Wait
- Stealth & Anti-Bot Detection (go-rod/stealth)
- How Stealth Works
- Usage
- Verifying Stealth
- Implementation Guidelines
- Launcher Configuration
- Proxy Support
- Input Simulation

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- **CAPTCHAs:** Rod does not include CAPTCHA solving. External services (2captcha, etc.) must be integrated separately.
- **Extreme Anti-Bot:** While `go-rod/stealth` handles common detection (WebDriver, plugin fingerprints, WebGL), extremely strict systems (some Cloudflare configurations, Akamai Bot Manager) may still detect automation. Additional measures (residential proxies, human-like behavioral patterns) may be needed.
- **DRM Content:** Cannot interact with DRM-protected media (e.g., Widevine).
- **Resource Usage:** Each browser instance consumes significant RAM (~100-300MB+). Use `PagePool` and limit concurrency on memory-constrained systems.
- **Extensions in Headless:** Chrome extensions do not work in headless mode. Use `Headless(false)` with XVFB for server environments.
- **Platform:** Requires a Chromium-compatible browser. Does not support Firefox or Safari.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
