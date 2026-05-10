---
name: website-copy-routing
description: 'Use when the user wants copy, messaging, structure, or content for a homepage, landing page, service page, sales page, about page, location page, or core website page, even if they do not explicitly mention StoryBrand. Also use when the user says "write this page," "rewrite this homepage," "landing page copy," "service page copy," "website messaging," "hero section," "above the fold," "headline and CTA," "page outline," "page structure," "website content," or "sales page." This skill routes website-page writing toward StoryBrand-first messaging, product marketing context, UX strategy, local SEO when relevant, and SEO-aware page structure.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/website-copy-routing/SKILL.md'
  imported_at: '2026-05-09'
---

# Website Copy Routing

Use this skill as the default router for core website-page writing and messaging work.

## Intent

When a request is about a website page, do not jump straight into generic copywriting. First choose the right combination of supporting skills and source material.

## Routing Rules

1. For homepage, landing page, services page, sales page, and about page work:
   - use `brand-brain` first
   - then use `storybrand-framework`
   - then use `copywriting` for the actual draft
2. If the user already has draft copy and wants it improved:
   - use `brand-brain` first
   - use `storybrand-framework` if the page is strategic or conversion-focused
   - use `copy-editing` for revision passes
3. If the request is about page structure, flow, sequence, navigation, or friction:
   - use `ux-strategy`
4. If the page targets a city, region, service area, or map-pack intent:
   - use `local-seo`
5. If the request is mainly critique, conversion diagnosis, or page restructuring:
   - use `landing-page-critique`
6. If the page is part of a broader messaging or campaign system:
   - read `.agents/product-marketing-context.md` if it exists
7. If the task is long-form page development from brief to outline to draft:
   - use `content-development`

## StoryBrand Requirement

For homepage, landing page, services page, sales page, and most core website pages, treat StoryBrand as the default messaging system unless the user explicitly asks for a different framework.

Read these source files before substantial page writing:

- `/Users/newmindsgroup/Library/CloudStorage/GoogleDrive-info@newmindsgroup.com/My Drive/ai-projects/AI Knowledge Library/Markdown Business Books for AI Projects/Building a StoryBrand - Clarify Your Message So Customers -- Donald Miller.md`
- `/Users/newmindsgroup/Library/CloudStorage/GoogleDrive-info@newmindsgroup.com/My Drive/ai-projects/AI Knowledge Library/Markdown Business Books for AI Projects/Building a StoryBrand 2.0- Clarify Your Message So Customers -- Donald Miller.md`

Also read:

- `/Users/newmindsgroup/.codex/skills/brand-brain/SKILL.md`

## Expected Deliverables

- page messaging strategy
- page outline or section order
- hero copy and CTA direction
- conversion-aware draft copy
- SEO-aware headings when relevant

## Guardrails

- Do not produce generic website copy when StoryBrand framing is appropriate
- Keep the customer as the hero and the brand as the guide
- Align structure, UX, and messaging instead of treating them separately
- For local intent pages, avoid thin city-page spam
