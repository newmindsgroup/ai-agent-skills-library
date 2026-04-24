# Golden Ratio — When φ Applies, When It Doesn't

φ ≈ 1.618. The classical proportion. It has a long history of legitimate use and an even longer history of cargo-cult misuse. This file is the hard-won lesson: apply it where it belongs, refuse it where it doesn't.

---

## The rule, one line

**Golden ratio governs enclosed proportions, not intimate letter-spacing inside a word.**

Say it out loud before you apply it.

---

## Where φ legitimately applies

1. **Aspect ratios of enclosed areas** — business cards, landing-page hero slots, deck covers, banner crops.
   - 1.618 : 1 horizontal → classic landscape proportion (business cards, banner).
   - 1 : 1.618 vertical → portrait composition (stacked wordmarks, book covers).

2. **Clear-space rules around a mark** — "reserve 1.618 × cap height on all four sides" is a valid and enforceable rule.

3. **Composition blocks** — dividing a hero section into 61.8% / 38.2% image-to-text splits.

4. **Monogram / favicon tile proportions** — the letter block fills φ⁻¹ (≈ 0.618) of the inner tile area, leaving φ⁻² (≈ 0.382) padding.

5. **Font metrics** — ascender / x-height / descender ratios in carefully-designed typefaces often sit near φ⁻¹ or φ⁻². This is observational; designers don't typically enforce it.

In every case above, φ is doing real work: *governing the relationship between two enclosed quantities.*

---

## Where φ does **not** apply — and my mistake

I once specified a wordmark's word gap as **0.618 em** between "FirstName" and "LastName," citing golden ratio to cap height. It was wrong on two counts:

1. **φ governs enclosed proportions, not letter-space.** Letter-space is intra-word, not inter-block. Applying φ to it is mechanical, not meaningful.

2. **At 0.618 em, the gap fragments the name.** A proper noun should read as one identity with two parts, not two separate words. The gap looked like an editorial pause. It drifted.

The correct word gap for a serif wordmark in the 0.02–0.08 em range (near-zero, optical only), and for italic + roman pairings **the italic-to-roman transition IS the separation** — so the gap can be as low as 0.04 em. The italic lean creates the optical break; adding whitespace on top is redundant.

**Lesson:** I applied φ as a decoration, not as a principle. The user flagged it. I fixed it. Now this file exists so nobody repeats it.

---

## Other common misapplications of φ

- **Headline font-size to body-size ratio.** A 1.618× ratio is sometimes too tight, sometimes too loose. Use a **modular type scale** (1.125, 1.2, 1.25, 1.333, 1.5) chosen for legibility, not for numerology.
- **Paragraph spacing.** Vertical rhythm should come from your type scale and leading, not from φ.
- **Component padding.** Component padding should follow your spacing scale (4 / 8 / 12 / 16 / 24 / 32 / 48…), not φ.
- **Brand color hue angles on a color wheel.** This is pure numerology. Use color theory (complementary, split-complementary, analogous, triadic), not φ.

---

## Decision rule — a checklist before applying φ

Before you write `1.618` or `0.618` into a design spec, ask:

- [ ] Is the thing I'm proportioning an **enclosed area** (width × height of a box)?
- [ ] Or is it **two quantities that are both spatial** (e.g. left column to right column in a 2-col layout)?
- [ ] Is there a **visual body / visual ground** relationship?

If yes → φ is a candidate. Still test it against a modular scale; φ isn't magic, it's just one good ratio.

If the answer is "no, this is inside a word / between lines / adjacent to type at a typographic scale" → **do not use φ.** Use optical judgment, a modular type scale, or the kerning tables of the typeface.

---

## How to describe φ when the user asks for it

When a user says "apply golden ratio", they usually mean "make this feel proportioned and intentional, not random." That's a legitimate request. Translate it:

- If they want it applied to a logo: clear space, aspect ratio, monogram tile fill — yes.
- If they want it applied to letter-spacing inside the wordmark: redirect. Explain why that's not where φ earns its keep. Offer optical spacing instead. Show examples.

Don't silently refuse the ratio. Don't silently misapply it. Explain the scope of where it works and apply it there.

---

## Example: a logo's full φ spec (correct usage)

```
Cap height:            1.000 (reference)
x-height:              0.500 (observational, typeface-dependent)
Ascender above x-line: 0.618 (φ⁻¹)
Descender depth:       0.236 (φ⁻²)
Clear space, all sides: 1.618 × cap height (enclosed-proportion φ — valid)
Horizontal aspect:     1.618 : 1 (enclosed-proportion φ — valid)
Stacked aspect:        1 : 1.618 (enclosed-proportion φ — valid)
Monogram letter fill:  0.618 of inner tile area (enclosed-proportion φ — valid)
Word gap:              0.04 em  ← NOT φ. Optical, near-zero.
Italic letter-spacing: −0.010 em  ← Not φ. Optical.
Roman letter-spacing:  −0.005 em  ← Not φ. Optical.
```

Note the annotations. Every φ application is labeled; every non-φ decision is labeled too. That way, future collaborators can see what's principled and what's measured by eye.

---

## The one-sentence rule

**If it encloses a space, try φ. If it spaces inside a word, use your eye.**
