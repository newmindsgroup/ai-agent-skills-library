---
version: 0.1.0
name: <Your Brand Name>
owner: <Your Org>
last_updated: <YYYY-MM-DD>
description: "One-paragraph description of the visual system: mood, primary color, type system, density, key visual signature. AI agents read this paragraph as a top-level prompt before drilling into the sections below. Be specific. 'Editorial-meets-technical, dark canvas, single chromatic accent (#FF5500), monospace headlines, terminal aesthetic' beats 'modern and clean'."
canonical_sources:
  tokens: design-system/tokens/tokens.json     # if you have a tokens file
  visual_identity: <path-to-visual-identity-doc>
  design_north_star: <path-to-design-philosophy-doc>
---

# <Your Brand Name> — DESIGN.md

> **What this file is.** The agent-facing entry point for any AI tool generating UI for this brand. Drop this file into any project repo where you want UI to match the brand. AI agents read it before generating layouts, components, or imagery.
>
> **Format.** This follows the [Stitch DESIGN.md spec](https://stitch.withgoogle.com/docs/design-md/format/) popularized by [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md) — the format AI coding agents (Cursor, v0, Lovable, Stitch, Claude Code) parse most reliably.
>
> **Precedence.** Values declared here are the AGENT NAVIGATOR. If you have a machine-canonical design tokens file (`tokens.json`, etc.), declare it in `canonical_sources` above and let it win on conflicts.

---

## 1. Visual Theme & Atmosphere

**Mood.** <one or two sentences — what feeling does this brand evoke?>

**Density.** <how much white space, how dense, how editorial vs. utilitarian>

**Design philosophy.** <core philosophy — e.g. "Restraint by default. Cinematic moments are earned, not granted.">

**Reference targets** (steal vocabulary, never copy execution): <list 3-5 sites you point to>

---

## 2. Color Palette & Roles

| Swatch | Hex | Token | Role |
|---|---|---|---|
| ▮ | `#000000` | `ink` | Primary text |
| ▮ | `#XXXXXX` | `primary` | Primary brand color |
| ▮ | `#XXXXXX` | `accent` | Accent color (use sparingly, X% of surfaces) |
| □ | `#FFFFFF` | `bg` | Default background |

### Color application rules

- **Default surface:** <ground color, text color>
- **Reverse:** <ground, text>
- **Accent rules:** <when to use, when not to>
- **Never:** <combinations that violate the brand>

---

## 3. Typography Rules

**Type pair.** <Display font> + <Body font>. <Optional fallback>.

**Licensing.** <free / paid / proprietary — explicit so agents don't suggest unavailable fonts>

### Hierarchy

| Step | Token | Size | Use |
|---|---|---|---|
| Hero | `--fs-h1` | <px> | Hero headline |
| H2 | `--fs-h2` | <px> | Section headlines |
| H3 | `--fs-h3` | <px> | Subsection titles |
| Body | `--fs-body` | <px> | Default reading text |

**Weights.** <list weights — restrict so agents don't reach for hairline / black inappropriately>

---

## 4. Component Stylings

### Buttons

| State | Style |
|---|---|
| Primary | <fill, text, padding, radius> |
| Secondary | <fill, border, text> |
| Hover | <transition spec> |
| Disabled | <opacity / cursor> |

**Never:** <forbidden patterns — drop shadows, gradients, glows, etc.>

### Cards / Inputs / Navigation

<Define each component family. Be explicit about borders vs. shadows, padding scales, corner radii, hover states.>

---

## 5. Layout Principles

**Grid system.** <8px base? Golden ratio? Custom?>

**Max content width.** <px>

**Spacing scale.** <list the scale tokens>

**Whitespace philosophy.** <one paragraph>

---

## 6. Depth & Elevation

**Default elevation.** <0? subtle? — most modern brands lean flat>

**When elevation is allowed:**

| Token | Spec | Use |
|---|---|---|
| `shadow.subtle` | `<value>` | <use case> |
| `shadow.float` | `<value>` | <use case> |

**Never:** <forbidden combinations — glow + shadow, etc.>

---

## 7. Do's and Don'ts

### ✅ Do

- <one bullet per non-negotiable practice>

### ❌ Don't

- <one bullet per anti-pattern>
- <include logo violations, color violations, type violations, motion violations>
- **AI-image tells to avoid** (if you generate AI imagery): <perfect symmetry, glossy plastic, generic futuristic city, hands with wrong fingers, embedded text — let agents know>

---

## 8. Responsive Behavior

### Breakpoints

| Name | Min width | Use |
|---|---|---|
| `sm` | <px> | Phone landscape |
| `md` | <px> | Tablet |
| `lg` | <px> | Desktop |

### Touch targets + collapsing strategy

<minimum target size, how layouts collapse on small screens, what hides>

---

## 9. Agent Prompt Guide

### Quick color reference

```
ink:    #000000
primary: #XXXXXX
accent:  #XXXXXX
bg:      #FFFFFF
```

### Ready-to-use prompt fragments

**For AI image generation:**
> "<Brand-specific aesthetic prompt — mood, lighting, palette, composition rules, what to avoid>"

**For UI generation (Cursor, v0, Lovable):**
> "Use the DESIGN.md in this repo as the design system. <Key constraints — primary color, type pair, layout philosophy, what NOT to do>"

---

## How to use this file

For a new project (yours or a client's):

1. Copy `DESIGN.md` to the project root
2. Tell your AI agent: *"Use the DESIGN.md in this repo for all UI generation"*
3. (Optional) Maintain a `design-system/tokens/tokens.json` for machine-canonical token values

For a client's brand, replace the values in sections 2–6 but keep the structure — the 9-section Stitch format is what AI coding agents read most reliably.
