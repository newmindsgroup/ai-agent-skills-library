---
name: frontend-release-quality-gate
description: "Run a frontend release gate across responsive layout, visual regressions, browser workflows, accessibility, keyboard behavior, screen-reader basics, performance budgets, console errors, network failures, SEO essentials, and implementation evidence. Use before shipping UI, design-to-code work, public websites, product dashboards, and customer portals."
category: Frontend, UI, UX, Design
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Original New Minds Group frontend release workflow created from UI quality capability analysis; no third-party skill text copied
---

# Frontend Release Quality Gate

Version-Timestamp: 2026-08-04 13:10:00 AST

Use this skill before declaring a frontend, website, dashboard, customer portal, landing page, or design implementation ready.

## Baseline

Identify:

- Framework, routing, build command, design source, tokens, components, supported browsers, breakpoints, auth states, key workflows, analytics or SEO requirements, and accessibility target.
- Screens or flows that must be tested.
- Whether source changes are authorized or audit-only.

## Required Checks

Run a proportional set:

- Build and lint where available.
- Browser smoke test on desktop and mobile viewport.
- Critical workflow test, including authenticated paths if applicable.
- Responsive layout at narrow, tablet, standard desktop, and wide desktop sizes.
- Console errors, failed network requests, hydration errors, and uncaught exceptions.
- Text overflow, clipping, overlap, scroll traps, modals, empty states, loading states, and error states.
- Keyboard navigation, focus order, focus visibility, skip links where relevant, labels, form errors, and semantic headings.
- Color contrast, reflow, zoom behavior, and reduced-motion behavior.
- Performance budget for page weight, blocking scripts, image sizing, layout shift, and interaction delay.
- SEO essentials for public pages: title, description, canonical, robots, sitemap impact, structured data only when valid.

## Design-to-Code Rules

- Reuse existing tokens and components before adding new style systems.
- Match real content, not ideal placeholder content.
- Preserve layout stability with explicit dimensions and responsive constraints.
- Do not introduce decorative elements that interfere with scanning or accessibility.
- Verify in a real browser before completion.

## Evidence

Capture:

- Commands run and results.
- Tested URLs and viewports.
- Screenshots for material UI issues or pass evidence.
- Accessibility checks performed.
- Performance summary.
- Open risks and owner.

## Verdict

- `Pass`: build, workflows, layout, accessibility basics, and performance budget pass within scope.
- `Conditional pass`: UI is ready except for a named non-code or external condition.
- `Fail`: user workflow, layout, accessibility, performance, or runtime stability has a blocking defect.
