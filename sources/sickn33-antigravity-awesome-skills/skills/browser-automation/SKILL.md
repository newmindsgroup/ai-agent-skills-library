---
name: browser-automation
description: 'Browser automation powers web testing, scraping, and AI agent'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/browser-automation/SKILL.md'
  imported_at: '2026-05-09'
---

# Browser Automation

Browser automation powers web testing, scraping, and AI agent interactions. The difference between a flaky script and a reliable system comes down to understanding selectors, waiting strategies, and anti-detection patterns.

This skill covers Playwright (recommended) and Puppeteer, with patterns for testing, scraping, and agentic browser control. Key insight: Playwright won the framework war. Unless you need Puppeteer's stealth ecosystem or are Chrome-only, Playwright is the better choice in 2025.

Critical distinction: Testing automation (predictable apps you control) vs scraping/agent automation (unpredictable sites that fight back). Different problems, different solutions.

## When to Use
- User mentions or implies: playwright
- User mentions or implies: puppeteer
- User mentions or implies: browser automation
- User mentions or implies: headless
- User mentions or implies: web scraping
- User mentions or implies: e2e test
- User mentions or implies: end-to-end
- User mentions or implies: selenium
- User mentions or implies: chromium
- User mentions or implies: browser test

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Principles
- Capabilities
- Scope
- Tooling
- Frameworks
- Stealth_tools
- Cloud_browsers
- Patterns
- Test Isolation Pattern
- Playwright Test Example
- Shared Authentication Pattern
- User-Facing Locator Pattern
- Good Examples (User-Facing)
- Bad Examples (Fragile)
- Filtering and Chaining
- Auto-Wait Pattern
- Wrong - Manual Waits
- Correct - Let Auto-Wait Work

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
