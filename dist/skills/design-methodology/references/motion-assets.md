# Motion assets: the Apple-minimal micro-interaction set

Version-Timestamp: 2026-10-19 18:36:44 AST
Source: roadmap claude-design-hacks-03 (narrowed to the visual SSOT). Pairs with `baseline-ui` (200ms cap, no unrequested animation) and `frontend-design` (motion is earned).

Use these five recipes only when the brief asks for motion or the Critique stage finds a state change that needs feedback. Nothing here is a default; the default is still no animation.

## Hard limits (from the SSOT, not negotiable)

- Elevation stays 0. A hover never adds a box-shadow; depth comes from a hairline border tone shift and a ground colour shift.
- Interaction feedback runs 200ms or less. Entrances may take longer but never block reading.
- Only `transform` and `opacity` move. No layout, colour-of-text or size animation.
- Signature Amber is never a hover or focus colour; it stays a 2 to 5 percent accent.
- A `prefers-reduced-motion: reduce` block is mandatory and removes every transition and transform in this file.
- Every animated element states its job in a code comment. No job, no motion.

## The five recipes

| Recipe | Spec | When |
|---|---|---|
| Card hover lift | `translateY(-2px)`, border tone one step darker, 160ms ease-out, no shadow | Clickable cards only |
| Button press | `scale(0.98)` on `:active`, 120ms, returns on release | Primary and secondary buttons |
| Staggered entrance | `opacity 0 to 1` plus `translateY(8px) to 0`, 40ms stagger per item, 240ms each, runs once on first paint of the section | Lists of 3 to 8 cards in a hero or feature band, when the brief asks |
| Count-up | Runs once, under 900ms, ends on the exact real value, only for real data the brief supplies, never for `[needs number]` placeholders | Stat tiles with verified numbers, when the brief asks |
| Focus ring | 2px ring in the text colour at 100 percent opacity, 120ms ease-out on `:focus-visible` only | Every interactive element (accessibility, always on) |

## Reference CSS

```css
/* motion job: card hover tells the user the card is a link. Elevation stays 0. */
.card { transition: transform 160ms ease-out, border-color 160ms ease-out; border: 1px solid var(--line); }
.card:hover { transform: translateY(-2px); border-color: var(--line-strong); }
.btn:active { transform: scale(0.98); transition: transform 120ms ease-out; }
:focus-visible { outline: 2px solid currentColor; outline-offset: 2px; transition: outline-offset 120ms ease-out; }
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after { transition: none !important; animation: none !important; transform: none !important; }
}
```

## Critique checklist for motion

1. Does each moving element have a stated job? Remove the ones that do not.
2. Does any hover add a shadow, a glow or an amber tint? Remove it.
3. Is anything over 200ms on interaction? Cut it.
4. Does the page read the same with reduced motion on? It must.
5. Is a count-up pointing at a placeholder or an unverified number? Remove the count-up and keep `[needs number]` visible.
