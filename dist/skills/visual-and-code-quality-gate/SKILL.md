---
name: visual-and-code-quality-gate
description: Require proportionate functional, visual, accessibility, and source-of-truth verification before completing code, UI, UX, or design work.
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
---

# Visual and Code Quality Gate

Version-Timestamp: 2026-08-24 16:41:09 AST

Use this as the second, final-phase skill for a non-trivial code, UI, UX, or visual-design change. It is a completion gate, not a replacement for the specific implementation skill.

## Route before building

Classify the work with `model-governor`, then select the smallest capable worker:

- Deterministic checks, small styling changes, and routine component work: Terra, Medium, Standard. A local code worker may perform a private first pass.
- Screenshot, diagram, document-image, or interface interpretation: local vision worker for a bounded first pass. Confirm important findings in the rendered product.
- Architecture, a client-facing design system, a release candidate, or conflicting evidence: Sol High or a deliberate Claude Max independent review.
- Never use Fast, Extra High, Ultra, parallel workers, or an external provider merely because the work is visual. Escalate only when the task's consequence or uncertainty warrants it.

## Required evidence

### For every non-trivial code change

1. Identify the acceptance behavior before editing.
2. Run the narrowest relevant test, lint, typecheck, build, or deterministic command after editing.
3. Inspect the diff for unrelated changes, secrets, and changed behavior that has no test or acceptance evidence.
4. For security, production, legal, client-facing, or data-touching changes, apply the project-specific review gate and a proportionate independent review.

### Additional evidence for UI, UX, HTML, CSS, diagrams, and interaction

1. Read the project's `DESIGN.md` and token source of truth when they exist. Do not invent a second visual system.
2. Verify the rendered artifact in a real browser at desktop and mobile widths.
3. Exercise every changed interaction. Hover, focus, keyboard, loading, error, empty, and narrow-screen states are required when applicable.
4. Capture or inspect the specific state that motivated the change. HTML syntax, a build, or an unhovered screenshot does not prove an interaction works.
5. Check clipping, overlap, z-index, focus visibility, contrast, readable labels, and viewport overflow.
6. State exactly what was verified and what was not. Do not claim visual completion without rendered evidence.

## Failure handling

If an observed state disagrees with the implementation, stop escalating models blindly. Use browser inspection and developer tools to isolate the cause first. Common causes include selector specificity, a stacking context, overflow, responsive breakpoints, stale assets, and an incorrect test state.

Read [the evidence matrix](references/evidence-matrix.md) before choosing a final gate for a high-consequence change.
