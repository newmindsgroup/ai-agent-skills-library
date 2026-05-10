# Iteration Playbook

The process spine. Every design engagement runs this loop.

```
Discovery → Diagnosis → Principles → Exploration → Critique → Lock → Propagate
```

Some projects run it fast. Some run it slow. The stages don't change.

---

## Stage 1 · Discovery

**Goal:** understand what exists before proposing anything.

Read in this order:
1. Project memory — `CLAUDE.md`, `memory/*.md`, `project-memory/*.md`, or whatever the project uses.
2. Brand docs — any `brand-*.md`, `visual-identity.md`, `brand-hub.html`, `brand-blueprint.md`.
3. Design tokens — `tokens.json`, `tokens.css`, `tailwind.config.js`, `brand-kit.md`.
4. Existing design files — current logo, current website, current templates.
5. Open decisions — any file documenting unresolved questions (palette hierarchy, typography licensing, site aesthetic).
6. Prior iterations — `logo-lab.html`, `logo-rationale.html`, change-log entries.

**Outputs of Discovery:**
- A short written summary of what you found ("Here's the brand as it stands…")
- A list of locked decisions you'll respect
- A list of open decisions you'll surface

**Do not** start the next stage until Discovery is done. Redesigning from zero on a project that has locked decisions is the most common failure mode.

---

## Stage 2 · Diagnosis

**Goal:** honest assessment of what's working and what isn't.

Score the current state on a multi-criteria matrix. For brand / identity work:

| Criterion | Score 0–10 | Evidence |
|---|---|---|
| Archetype fit | | Does it signal the intended archetype? (Sage, Creator, etc.) |
| Distinctiveness in category | | Would a competitor's mark look out of place, or interchangeable? |
| Timelessness (target horizon) | | Does it carry a visible decade-of-origin? |
| Scalability | | Does it hold at 16 px favicon and at billboard? |
| Voice match | | Does it feel like the brand's stated voice? |
| Category signal | | Does it place the brand in the right shelf? |
| Internal system consistency | | Does every mark/asset feel like variants of one voice? |

For **web** or **app** work, swap in relevant criteria: hierarchy clarity, interaction consistency, responsive integrity, accessibility, conversion path.

**Critical rule:** don't inflate scores to justify a change. If the current work scores 6/10, say 6/10. If your proposal scores 8/10, say 8/10, not 10/10. Honest comparison is how you earn the right to recommend a change.

---

## Stage 3 · Principles

**Goal:** ground the exploration in deliberate design reasoning, not vibes.

Before opening a design tool or writing CSS, articulate:
- Which **elements** are active (line, shape, space, color, typography, form)
- Which **principles** you're leaning on (balance, emphasis, proportion, rhythm, unity, contrast)
- Which **classical systems** apply (and — critically — *where* they apply; see `golden-ratio.md` for the hardest case)
- What **archetype** you're serving
- What **reference set** you're borrowing restraint from

If you can't articulate these before designing, you're decorating, not designing.

---

## Stage 4 · Exploration

**Goal:** produce alternatives, not just one "right answer."

Build a **sandbox file** separate from any production file. For a wordmark engagement, that usually means:

- `logo-lab.html` — interactive sandbox with live controls (sliders for size, gap, letter-spacing, weight; pickers for typeface, color, background)
- `logo-rationale.html` — the written case for the direction

In the sandbox:
1. Render the current (incumbent) design next to your proposed direction, at matched scale.
2. Test **multiple typefaces** side by side — don't assert "X is the right typeface" without seeing 3–5 alternatives at the same spec.
3. Test **multiple treatments** — italic+roman, all italic, all roman, weight contrast, small caps, etc.
4. Test **context** — favicon, nav bar, business card, email signature, social avatar, deck cover, speaker banner, hero headline. Logos that look great in a vacuum often die in production.
5. Test **color** — not just ink on white. Put the mark on every palette surface it has to live on.

**Never ship from exploration.** Exploration is for learning what the right answer is.

---

## Stage 5 · Critique

**Goal:** catch your own mistakes before the user does.

Run through the `references/honesty-protocol.md` checklist. Specific things to catch:

- Have you **mechanically applied a principle** (like golden ratio to letter-space) without testing if it serves the brief? See `golden-ratio.md`.
- Have you **dismissed an alternative** without actually testing it (e.g. serif vs sans without building both)?
- Have you **inflated distinctiveness scoring** — saying "rare and ownable" when the move is actually common?
- Have you **flattered your own proposal** in the decision matrix?
- Have you **missed a locked decision** in the project that your proposal silently violates?
- Have you **ignored a stated reference set** in favor of what you personally like?

If the user pushes back on anything, **start with "you're right"** and diagnose before defending. Defensiveness here is where trust breaks.

---

## Stage 6 · Lock

**Goal:** commit the direction with a clear written spec.

A locked design decision has:
- **A single committed spec** (typeface, weight, spacing, palette — no ambiguity)
- **A rationale** (why this, not the alternatives you tested)
- **A decision log entry** with date and status
- **A list of propagation targets** (what files / surfaces this affects downstream)

Lock in writing. "We talked about it" is not locked — it's at best a maybe.

---

## Stage 7 · Propagate

**Goal:** make the locked decision show up everywhere it should, atomically.

Propagation order (for a brand-system decision):

1. **Source tokens** — edit `tokens.json` (or equivalent single-source file). Bump version. Note the change in CHANGELOG.md.
2. **Generated tokens** — run the build script that regenerates `tokens.css`, `tokens.scss`, `tailwind.config.js`, `tokens.figma.json`, `brand-kit.md`. Never hand-edit generated files.
3. **Brand hub** — update the main brand reference document (HTML or MD) to reflect the new decision.
4. **Strategy docs** — update `visual-identity.md`, `brand-identity.md`, `personal-brand-blueprint.md`, or equivalent.
5. **Templates** — deck master, proposal template, email signature, letterhead — anything that renders the brand.
6. **Exports** — regenerate locked SVG / PNG assets. For logos, include every lockup × every color variant.
7. **Asset index** — if you have a browsable logo-assets page, regenerate it so it shows the new files.

**Atomicity matters.** If you update tokens but not templates, contractors get conflicting signals. Commit the whole ripple in one pass.

---

## Signals that you're skipping a stage

- **"Let me just quickly…"** — you're about to skip Discovery.
- **"This obviously needs to change."** — you're skipping Diagnosis; prove it first.
- **"Let's go with X."** — without alternatives tested, you're skipping Exploration.
- **"The user will love this."** — you're skipping Critique. They might. They might not.
- **"We can always change it later."** — you're not really Locking. Lock now or don't commit.
- **"I'll update the tokens next session."** — you're leaving Propagation half-done. Finish it.

Every one of those phrases is a flag to pause and step back into the loop properly.

---

## Fast-loop vs slow-loop

Not every task needs the full seven stages in sequence. Rough heuristic:

| Task size | Loop speed |
|---|---|
| Tweak one spacing value | Skip to Lock + Propagate (Stages 6–7). |
| Adjust a color | Diagnosis + Lock + Propagate (Stages 2, 6, 7). |
| Replace a typeface | Full loop, fast. Couple hours. |
| New wordmark | Full loop, slow. Multiple sessions. Sandbox file required. |
| New brand identity system | Full loop, slow. Multiple weeks. All reference files active. |
| Full site redesign | Full loop, slow. Plus `web-layer.md` throughout. |

When in doubt, run the full loop. The cost of discipline is smaller than the cost of shipping something half-thought.
