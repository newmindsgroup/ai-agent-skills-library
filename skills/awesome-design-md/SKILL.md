---
name: awesome-design-md
description: 'Use a curated library of brand-inspired DESIGN.md files to make AI-generated UIs match specific visual styles like Vercel, Stripe, Linear, Notion, Apple, Cursor, and many others. Activate when the user asks for a site to look like a known brand, wants a DESIGN.md file, wants visual inspiration from a real product site, or wants to drop a design system into a project before generating UI.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/awesome-design-md/SKILL.md'
  imported_at: '2026-05-09'
---

# Awesome DESIGN.md

This skill wraps the `VoltAgent/awesome-design-md` repo as a Codex-friendly design reference.

## What it is for

- Making a project look like an existing brand or product site
- Starting a UI from a concrete design system instead of vague taste prompts
- Creating or selecting a `DESIGN.md` before generating pages or components
- Asking for "make this feel like Vercel", "use Stripe style", "give me a Linear-like dashboard", or similar

## How to use it

1. Identify the closest visual reference the user wants.
2. Check the vendored DESIGN.md collection at:
   - `/Users/newmindsgroup/.codex/vendor_imports/latest-video/awesome-design-md/design-md`
3. Pick the most relevant brand folder and read its `DESIGN.md`.
4. Use that file as the design source of truth while generating or refining UI.
5. If the user wants, copy or adapt the chosen `DESIGN.md` into the working project as `DESIGN.md`.

## Good triggers

- "Make this look like Vercel"
- "I want a Stripe-style landing page"
- "Can you use a DESIGN.md for this?"
- "Give me a premium SaaS look"
- "Use a known brand design system as inspiration"

## Notes

- This is a design corpus, not an executable CLI.
- The repo contains dozens of ready-made `DESIGN.md` files plus previews.
- Use the closest matching style rather than mixing many brands at once.

## Local source

- Repo snapshot: `/Users/newmindsgroup/.codex/vendor_imports/latest-video/awesome-design-md`
- Collection root: `/Users/newmindsgroup/.codex/vendor_imports/latest-video/awesome-design-md/design-md`
