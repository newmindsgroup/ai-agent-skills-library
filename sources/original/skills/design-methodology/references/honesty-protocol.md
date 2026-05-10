# Honesty Protocol

The discipline that separates serious design work from decorative design work. Self-critique upfront beats defensiveness on review.

---

## The six self-critique triggers

Whenever any of these show up in your thinking, stop and examine. If the critique lands, correct in writing.

### 1. Inflated scoring in your own favor

**Trigger:** your decision matrix scores your proposal 9/10 on every criterion and the incumbent 3/10.

**Reality check:** real comparisons aren't that lopsided. If the incumbent was truly 3/10 on everything, it wouldn't have shipped. If your proposal is truly 9/10 on everything, it's either a masterpiece or you're lying.

**Correction:**
- Rescore the incumbent with someone looking over your shoulder. Brand equity, familiarity, and customer recognition are real criteria — don't zero them out just because you want to change the mark.
- Rescore your proposal. Every design has tradeoffs. Find yours and name them.
- If the comparison still favors your direction after honest scoring, you've earned the recommendation. If it doesn't, the incumbent probably stays.

### 2. Mechanical application of a principle

**Trigger:** you're applying a principle (golden ratio, minimalism, italic + roman, monochrome, skeuomorphism) because it's the principle, not because it serves this brief.

**Examples:**
- "Apply golden ratio to the word gap" → mechanical. Golden ratio is for enclosed proportions. See `golden-ratio.md`.
- "Go all-minimalist because Apple does" → mechanical. Apple's minimalism serves Apple's category and scale. Your brand may need more warmth or more distinctiveness.
- "Italic + roman wordmark" → risks mechanical if applied to every entity name in a system. Works once; becomes a tic if over-applied.

**Correction:**
- Ask: what problem is this principle solving for this brief?
- If you can't articulate the problem, the principle is decoration.
- Test against 2–3 alternatives that don't use the principle. If your chosen direction still wins, the principle is earning its role.

### 3. Dismissing an alternative without testing it

**Trigger:** you're asserting "serif is the right call" or "sans is obvious" or "black-on-white is the only option" without building the alternative and comparing.

**Reality check:** confident assertions without testing are a form of intellectual laziness. They might be right, but you haven't earned the right to say they are.

**Correction:**
- Build the dismissed alternative at the same spec as your preferred direction.
- Compare in the same sandbox, at the same scale, on the same backgrounds.
- If you still prefer your original, now you have evidence. If you change your mind, congratulations — that's the process working.

### 4. "Rare and ownable" / "timeless" / "award-winning" without evidence

**Trigger:** you're using marketing words to justify a design decision rather than specific evidence.

**Reality check:**
- "Rare and ownable" — actually search the category. Is it rare? Show the search.
- "Timeless" — most typefaces have a decade-of-origin. Name it. "Playfair feels timeless" ≠ "Playfair is timeless." It was everywhere on wedding invitations 2015–2022.
- "Award-winning" — tie to specific award criteria (see `award-criteria.md`). Don't use it as vibes.

**Correction:**
- Replace marketing words with specific evidence.
- "Rare in category" becomes "I looked at 20 competitor sites; 18 use sans, 2 use serif, and neither of those uses italic + roman."
- "Timeless" becomes "Transitional serifs have 270 years of continuous use; this specific cut has a 2010s timestamp but the lineage is older."

### 5. Ignoring a locked decision the user already made

**Trigger:** you're proposing something that silently violates a prior decision the user has already made — or you're starting from zero on a project where the user has already locked several decisions.

**Examples:**
- Proposing a serif wordmark after the user resolved their site aesthetic to "Apple-minimal" with a reference set of all-sans brands.
- Proposing a new color palette when `tokens.json` has a committed palette and a changelog.
- Proposing a three-entity brand architecture when the user said "keep my personal brand standalone."

**Correction:**
- Re-read project memory and locked decisions (see `iteration-playbook.md` Stage 1).
- If you still want to propose the change, surface the tension explicitly: "You locked Apple-minimal on [date]. This proposal runs against that. Here's why I think it's still worth considering, and here's how to proceed if you disagree."
- Never silently violate. Name the tension.

### 6. Defensiveness when the user pushes back

**Trigger:** the user says "this looks wrong" or "I don't think this is working" or flags a specific issue — and your first instinct is to explain why you're right.

**Reality check:** the user is looking at the deliverable fresh. You have rationale-blindness from building it. They see what users see.

**Correction:** open with "you're right, let me diagnose." Then:
1. Look at exactly what they flagged. Don't jump to fixes.
2. Name the mistake if you can see it.
3. If you can't see the mistake, ask one specific clarifying question.
4. Only after you've genuinely diagnosed do you propose a fix.

---

## The correction log

When you catch one of these — in yourself, before the user catches it, or because the user caught it — log it.

In the project's decision log, add an entry like:

```
2026-04-24 · Correction · word gap was wrong
Original spec: 0.618 em (golden ratio to cap height).
Revised to 0.04 em. Reason: φ applied to letter-space is wrong.
Letter-space is intra-word; φ governs enclosed proportions. Gap
at 0.618 em read as two words, not one name. Fixed in lab,
rationale, and all production files.
Status: Fixed
```

The correction log is not a punishment. It's the audit trail that makes the project's decisions defensible when someone asks "why this?" in six months.

---

## How to phrase ownership of a mistake

When you're writing a correction — whether in the decision log or to the user — use language that:

- **Names the specific error** ("0.618 em word gap was wrong")
- **Explains why** ("φ governs enclosed proportions, not letter-space")
- **Shows the fix** ("Revised to 0.04 em")
- **Avoids self-flagellation** (don't turn it into "I'm so sorry, I'm terrible at this")
- **Avoids minimizing** (don't say "small tweak" for something you sold as a key spec)

One-paragraph ownership > one-page apology. Move forward.

---

## The short version

Five sentences to keep in your head:

1. Inflated scoring in your own favor is lying.
2. Mechanically applied principles are decoration.
3. Dismissing without testing is laziness.
4. Marketing words without evidence are vibes.
5. When pushed back on, diagnose first; defend only if evidence says so.

The goal isn't to be harsh on yourself. It's to make the work strong enough that harsh critique doesn't shake it.
