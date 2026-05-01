# Visual Identity System — Full Section 4 Walkthrough

Visual identity comes AFTER voice (Section 3). Visuals should reinforce the voice the brand has already locked, not invent it. Brands that start with the logo end up with logos that don't match how they sound.

---

## 4.1 Design philosophy

**One paragraph.** Names the aesthetic family, the design heroes / reference systems, and the tradeoffs the brand is willing to make.

Aesthetic families (pick ONE primary, optional secondary):
- **Editorial / minimalist** — restraint, generous whitespace, classical typography. Think: Apple, Aesop, MAHF, Stripe Press.
- **Maximalist tech** — saturated color, bold geometry, density. Think: Stripe, Linear, Vercel.
- **Warm artisanal** — handmade feel, muted palettes, photography-forward. Think: Verve coffee, MUJI.
- **Brutalist / utilitarian** — function over form, raw type, monospace. Think: Are.na, MSCHF, Github docs.
- **Cinematic / luxury** — dark backgrounds, high contrast, hero photography. Think: Apple TV+, Lululemon.

**Tradeoffs to name explicitly:**
- "We trade reach for depth" — fewer pages, more thought per page
- "We trade legibility for distinctiveness" — wider type, denser layouts
- "We trade quick recognition for long memorability" — non-standard layouts that take a beat to parse

---

## 4.2 Mood board — reference brands

**5–10 reference brands. Each entry must be specific.**

Format per entry:
```markdown
### {Brand}
- URL: {url}
- What we take: {specific element — typography, color discipline, motion, photography style}
- What we don't take: {what we admire but won't borrow — keeps us from imitating}
```

**Anti-pattern:** vague mood boards ("we like clean modern design"). The reader of the blueprint should be able to pull up a reference brand and immediately see what's being imported.

---

## 4.3 Color system

**Three palettes, not one.** Different surfaces have different constraints.

### Signature palette (locked at brand launch)

The brand mark + product surfaces. 3–5 colors max. Per color:

```yaml
- name: "Daniel Black"
  hex: "#0A0A0A"
  rgb: "10, 10, 10"
  cmyk: "0, 0, 0, 96"
  pantone: "Black 6 C"
  role: "Primary text / brand mark fill"
  contrast_against_white: "20.4:1 (AAA)"
  contrast_against_signature_bg: "12.6:1 (AAA)"
  forbidden_pairings: ["any other near-black color"]
```

Every signature color needs:
- Hex, RGB, CMYK, Pantone
- One named role (don't have two colors competing for the same job)
- Documented WCAG contrast ratios against text colors
- Forbidden pairings if any

### Digital surface palette

Signature palette + 2–3 extension colors for blog images, social cards, email. Extension colors are NOT for the brand mark — they're for content surfaces that need more variety.

### Print / deck palette

What reproduces well in CMYK at small sizes. Often a slightly desaturated version of the digital palette. Document the print-substitution rules ("if the screen color is X, the print equivalent is Y").

---

## 4.4 Typography

### Display family

For headlines, the brand mark, hero copy. One typeface family. Pick a typeface that:
- Has 4+ weights (Light, Regular, Medium, Bold minimum)
- Has italics or a clear italic substitute
- Is webfont-ready AND print-ready

Common choices: GT America, Inter, Söhne, Söehne Mono, Recoleta, Söhne Breit.

### Text family

For body copy. Either same family as display (single-family system, Apple-like) or a complementary text family (humanist sans + slab serif is a classic pairing).

### Monospace / system / fallbacks

For code blocks, technical content, and system fallbacks for performance. Document the fallback chain explicitly:

```css
font-family: "Söhne", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
```

### Size scale

Document explicit sizes for:
- h1 (display)
- h2 (sub-display)
- h3 (section header)
- body
- small / caption
- mono / code

For each, name: font family, weight, size in rem, line-height, letter-spacing (if non-default).

### Example block

A 1-paragraph "lorem ipsum" set in the body family at the body size, with one h2 above and one h3 within. Anyone designing a new page can copy this block to validate their layout.

---

## 4.5 Logo

### The mark itself

In **lockup variations**:
- Full lockup (mark + wordmark)
- Monogram (initials only)
- Wordmark (no mark)
- Favicon (16px, 32px, 64px optimized)

Each variation in:
- SVG (vector, primary)
- PNG (1x, 2x, 3x for raster surfaces)
- PDF (for print)

### Clear-space rules

The minimum clear space around the logo, expressed as a multiple of the logo's height (typically 1×, 1.5×, or 2×).

### Color applications

- On light background: signature palette dark color
- On dark background: signature palette light color (or pure white)
- On photography: monochrome version with documented opacity rules
- Monochrome: pure black, pure white, single-color brand variant

### Forbidden treatments

- Don't stretch / skew / rotate
- Don't recolor outside the documented variants
- Don't add drop shadows / glows / outlines
- Don't combine with other marks (no co-lockups except in explicit partnership documents)
- Don't place on busy backgrounds without the documented contrast treatment

---

## 4.6 Photography & imagery direction

### Per-pillar templates

If the brand has content pillars (Section 7), document a hero-image template per pillar:

```markdown
### Template — AI / Automation
- Style: technical diagram + photography composite
- Primary color: signature dark + accent
- Subject: tools / hardware / hands-on UI shots, not faces
- Crop: 1200×630 (OG), 1080×1350 (IG)
- Treatment: high-contrast B&W subject + 1 saturated accent
- Forbidden: stock-photo "business person at desk"
```

### Stock vs. custom rules

When stock photography is acceptable, when it's not. Stock-source approval list (Unsplash subset, owned shoots, etc.).

### AI-generated imagery rules

When AI imagery is acceptable, when not. Required disclosure if used. Style-guide for prompts (so AI imagery looks consistent across surfaces).

### Crop ratios

Per-platform crop ratios, with the "safe zone" documented (so the focal subject doesn't get cropped out on Instagram vs. Twitter cards).

---

## 4.7 Motion

- **Default easing curve** — usually `cubic-bezier(0.4, 0, 0.2, 1)` or a brand-specific curve
- **Default duration** — short (150–200ms) for micro-interactions, medium (300–500ms) for page transitions
- **What animates** — hover states, page transitions, scroll-reveal of hero elements
- **What does NOT animate** — body text, dense data UI, anything that distracts from reading
- **Reduced-motion fallback** — what the brand looks like with `prefers-reduced-motion: reduce` (animations replaced with instant transitions)

---

## 4.8 Spacing & layout

- **Grid system** — column count + max-width
- **Vertical rhythm baseline** — typically 4px or 8px increments
- **Section spacing scale** — small (32px), medium (64px), large (128px), hero (192px+)
- **Container padding** — mobile, tablet, desktop

---

## 4.9 Iconography

- **Icon library** — Phosphor, Lucide, Heroicons, custom — pick one family
- **Style** — outline vs. filled vs. duotone
- **Stroke weight** — 1px / 1.5px / 2px
- **Corner radius** — sharp / rounded / pill
- **Forbidden** — mixing styles, using emoji as icons, decorative icons that aren't part of the system

---

## 4.10 Do's and Don'ts summary

A two-column table or side-by-side image gallery. **At least 8 examples** covering:
- Logo placement (correct / incorrect)
- Color application (correct / incorrect)
- Typography hierarchy (correct / incorrect)
- Photography crops (correct / incorrect)
- Layout density (correct / incorrect)
- Voice + visual pairing (e.g., serious headline + playful illustration = wrong)

This catches 90% of agency drift. Designers who haven't read the full visual identity will look at the do/don't summary and fix their work to match.

---

## The visual brand-hub artifact

Many brands also produce a clickable visual brand-hub (HTML page) that renders all of this in a single navigable surface — color swatches, type specimens, logo lockups, photography templates, motion examples. This is optional but high-value: agencies, contractors, freelancers can be linked to the brand hub and onboarded in 15 minutes.

If the brand wants one, generate a single-file HTML artifact at `brand-hub.html` with sections matching this section's structure. The hub uses the brand's actual colors and typography, so it's also a working example of the system.
