---
name: brand-blueprint-builder
description: "Builds a comprehensive brand blueprint for any business — personal brand, founder brand, agency, product company, or service business. Produces a multi-document brand system covering identity, narrative, visual identity, messaging, services & revenue, content engine, and AI operating manual. Use when the user asks to 'build a brand blueprint', 'create a brand book', 'document our brand', 'set up brand foundation', 'do a brand audit and lock decisions', 'write our positioning', 'create brand guidelines', 'redo our brand strategy', or starts a new venture and needs a complete brand foundation. Walks through the work in eight ordered sections with explicit prompts; outputs both supporting documents AND a master blueprint that synthesizes them. Generic across personal vs. commercial brands."
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Field-tested on a real personal-brand build (April 2026); StoryBrand SB7 framework; brand-archetype canon (Margaret Mark / Carol Pearson); Marty Neumeier brand-strategy lineage
---

# Brand Blueprint Builder

You produce a complete brand blueprint — a multi-document system that locks every brand decision in one place so the brand can be operated by anyone (humans, agents, agencies, freelancers) without drift.

**Run discipline:**

- The blueprint is built in **eight ordered sections**. Earlier sections feed later ones. Don't skip ahead — the visual identity (Section 4) doesn't make sense if the archetype (Section 3) isn't locked, and content pillars (Section 7) don't make sense if services (Section 6) aren't defined.
- Every section produces a written deliverable. Nothing stays in your head. The deliverables are the blueprint.
- For each section, you ask the user the right questions, draft proposals, and the user locks each decision before moving on. You never advance a section while a prior decision is still open.
- Apply the `human-voice` skill (if installed) to every piece of copy you draft.
- Filter `{{EXCLUDED_ENTITIES}}` from any client-facing copy.
- The blueprint is project-agnostic. It works the same whether the brand is a person, an agency, a product company, or a service business.

---

## Brand-config integration

If `brand-config.yml` exists, the blueprint reads it for `owner.name`, `brand.primary`, `brand.excluded_entities`, and `owner.timezone`. Otherwise the skill collects those values inline at the start of Section 1.

The skill also writes its outputs to `paths.brand_playbook` (or defaults to `brand-blueprint.md` at the project root) plus the supporting docs listed below.

---

## Output structure

You produce these files in this exact order:

```
brand/
├── 01_founder_story_and_values.md          ← Section 1
├── 02_brand_identity.md                     ← Section 3 supporting doc
├── 03_visual_identity.md                    ← Section 4 supporting doc
├── 04_services_and_offers.md                ← Section 6 supporting doc
├── 05_messaging_framework.md                ← Section 5 supporting doc
├── 06_content_strategy.md                   ← Section 7 supporting doc
├── 07_brand_narrative_core.md               ← Section 2 supporting doc
└── 99_brand_blueprint.md                    ← THE master blueprint (synthesis)
```

The master blueprint at `99_brand_blueprint.md` is the deliverable the brand owner shares with every collaborator. The numbered supporting docs are the source-of-truth files those decisions live in.

---

## The eight sections

### Section 1 · The Person / The Entity (foundation)

What you're capturing: who is behind the brand, what they actually love, what they refuse, what they're optimizing for. A brand that doesn't know who's behind it produces vague copy.

**Questions to ask:**
- Who founded / leads / IS this brand? (For personal brands: the person. For commercial brands: the founders, the parent entity, key leadership.)
- What's the legal entity architecture? (LLC / Inc / DBA / parent → subsidiary → DBA chains.) For multi-entity owners, name every entity and which surfaces use which.
- What does the founder / leadership ACTUALLY love about this work? Not the marketing answer.
- What's the founder optimizing for? (Money, freedom, legacy, mission, craft, mastery — usually a mix; rank them.)
- What's their aesthetic sensibility? (Minimalist / maximalist, modern / classical, technical / warm — name three reference brands and why.)
- What are their privacy tiers? (What's public-facing, what's internal-only, what's never-mentioned.)
- What entities/ventures must NEVER appear in client-facing copy? (`brand.excluded_entities`)

**Output: `brand/01_founder_story_and_values.md`**, structured as:
- The person/entity (1–2 paragraphs)
- What they love (life + work)
- Aesthetic sensibility (with three reference brands)
- Mission / why
- Entity architecture (full diagram in markdown)
- Privacy tiers (public / contextual / never-mentioned)
- How this shapes the brand (about-page narrative voice, mission-level copy register)

This document is the soul of the brand. Everything else flows from it.

---

### Section 2 · Narrative Core (Purpose / Mission / Vision / Values)

What you're capturing: the abstract layer above tactics. Why the brand exists, where it's going, what it refuses to become.

See `references/narrative-core.md` for the full structure and per-section prompts. At the high level, you produce:

- **Purpose** — the why. The reason the brand exists beyond making money. One sentence.
- **Mission** — the what. What we do for whom and how we measure it. Two sentences max.
- **Vision** — the where. What the world looks like if we succeed. One paragraph in present tense (as if it's already here).
- **Values** — typically 5. Each value gets a full treatment: name, one-line definition, three behaviors that make it visible, three anti-behaviors (what violates it), one example moment.
- **Principles** — how we decide. Decision rules derived from the values.
- **Promise** — what every client experiences. The "if-this-isn't-true-the-brand-is-broken" commitment.
- **Anti-vision** — what we refuse to become. Names 3–5 specific brands or archetypes the brand will never imitate.
- **North Star Metric** — one number that, if it grows, the brand is healthy.
- **Elevator pitches** — four lengths: 10s, 30s, 60s, 2-min.
- **Manifesto** — the rallying declaration. 200–400 words. The thing that lives on the About page or in the speaker intro.
- **Positioning statement** — one sentence in the form: *"For [audience], we are the [category] that [unique thing] so that [outcome]."*
- **Tagline hierarchy** — primary tagline + 2–3 alternates for different contexts.

**Output: `brand/07_brand_narrative_core.md`**

Critical: don't draft these in isolation. Each item informs the next. Purpose anchors mission; mission frames vision; values constrain principles; principles produce the promise; promise + anti-vision define positioning; positioning produces the tagline. Walk it in order.

---

### Section 3 · Positioning, Voice & Identity

What you're capturing: how the brand sounds and what category it claims.

Read `brand/01_founder_story_and_values.md` and `brand/07_brand_narrative_core.md` first.

**Sub-sections:**

#### 3.1 Positioning statement (locked from Section 2)

Restate it. Add the **target client profile (ICP)** — the person who reads this and says "yes, that's me":
- Demographic (industry, role, size, geography)
- Stage (revenue range, employee count, lifecycle phase)
- Psychographic (what they value, what they fear, what they've tried that didn't work)
- Decision criteria (how they buy, who else they consider, what closes the deal)
- Anti-ICP (who is NOT a fit — name them so the brand doesn't drift toward them)

#### 3.2 Brand archetypes (Margaret Mark / Carol Pearson)

Pick **primary + secondary** from the 12 archetypes:
- Sage, Creator, Hero, Rebel/Outlaw, Magician, Lover, Jester, Caregiver, Ruler, Innocent, Explorer, Everyperson

Document why those two and what each contributes. Worked examples in `references/archetype-canon.md`.

#### 3.3 Voice pillars (3–5)

Each pillar has a one-line definition + 3 behaviors that demonstrate it. Common pillar shapes: *direct*, *practitioner-grade*, *generous*, *contrarian*, *systems-thinking*, *playful*. Name yours from the archetypes + values, not from a list of adjectives.

#### 3.4 Signature phrases

3–8 phrases the brand owns. Each phrase: the phrase itself, when to use it, an anti-version (what NOT to say that's close).

#### 3.5 Write / Don't-write checklist

Two columns. Concrete examples of voice-on / voice-off lines. The list grows over time as drift gets caught.

**Output: `brand/02_brand_identity.md`**

---

### Section 4 · Visual Identity

What you're capturing: the look. Done after voice so the visuals reinforce the voice, not invent it.

See `references/visual-identity-system.md` for the full per-section prompts and decision rubric.

**Sub-sections:**

#### 4.1 Design philosophy
A 1-paragraph statement of the visual stance. Names the aesthetic family ("minimalist editorial," "maximalist tech," "warm artisanal"), the design heroes / reference systems, and the tradeoffs the brand is willing to make.

#### 4.2 Mood board — reference brands
5–10 reference brands with one-line "what we take from them." Be specific about what — typography, color discipline, motion, photography style.

#### 4.3 Color system
Three palettes, not one:
- **Signature palette** — the brand mark + product surfaces. 3–5 colors, every color named, every hex value locked, contrast ratios documented.
- **Digital surface palette** — typically the signature palette + 2–3 extension colors for blog images, social cards, email.
- **Print / deck palette** — what reproduces well in CMYK, what holds at small sizes.

#### 4.4 Typography
- **Display family** — for headlines, marks, hero copy.
- **Text family** — for body copy.
- **System fallbacks** — for performance.
- Specific sizes/weights for h1 / h2 / h3 / body / small.
- One example for each.

#### 4.5 Logo
- The mark itself, in lockup variations (full / monogram / favicon).
- Clear-space rules.
- Color applications (on light, on dark, on photography, monochrome).
- Forbidden treatments (don't stretch / don't recolor / don't add effects / don't combine with other marks).

#### 4.6 Photography / imagery direction
Concrete: hero image templates per content pillar. Stock vs. custom rules. AI-generated rules. Crop ratios. Subject treatment.

#### 4.7 Motion
Default easing curve. Default duration. What animates and what doesn't. Reduced-motion fallback.

#### 4.8 Spacing & layout
Grid system. Vertical rhythm baseline. Section-spacing scale.

#### 4.9 Iconography
Library + style + stroke-weight + corner-radius rules.

#### 4.10 Do's and Don'ts summary
Side-by-side examples of correct vs. incorrect application. This catches 90% of agency drift.

**Output: `brand/03_visual_identity.md`** plus a separate visual brand-hub artifact (`brand-hub.html` or equivalent) if the brand wants a clickable reference.

---

### Section 5 · Messaging Framework

What you're capturing: the actual copy that lives on the homepage, in the email signature, in the pitch deck. Done after voice + visual so the copy fits the rest.

See `references/messaging-framework.md` for the full template.

**Sub-sections:**
- **Hero headlines** — 3–5 options for the homepage hero. Pick one as primary.
- **Homepage copy framework** — section-by-section copy: hero, sub-hero, value props, services teaser, social proof, secondary CTA, footer.
- **Service block headlines** — one per service. Locked.
- **CTA inventory** — every CTA in the brand, where it appears, what action it triggers.
- **Key brand phrases** — the lines that appear across many surfaces: signatures, decks, social bios.
- **Newsletter / social proof copy** — testimonial templates, case-study lede patterns, subscription pitch.
- **Copy do / don't quick reference**

**Output: `brand/05_messaging_framework.md`**

---

### Section 6 · Services & Revenue Architecture

What you're capturing: what the brand sells, at what price, to whom, and how the revenue actually compounds.

See `references/revenue-architecture.md` for the offers ladder and active/leveraged/passive model.

**Sub-sections:**

#### 6.1 Service / offer pillars
Typically 3–5 pillars. Each pillar is a problem-shape, not a service. (E.g., "Brand foundation work" not "Logo design.") For each pillar: one-line description, when a client needs it, what the deliverable is.

#### 6.2 Signature offers (the ladder)
3–7 offers organized as a ladder from low-commitment to high-commitment. Each offer has: name, format, length, price (or "request quote"), who it's for, what it produces.

#### 6.3 The full revenue model
Three layers:
- **Active revenue** — trade time at high rates. (Consulting hours, retainer hours, custom projects.)
- **Leveraged revenue** — your time reaches more people. (Cohort programs, group coaching, paid speaking, courses delivered live.)
- **Passive / automated revenue** — builds once, runs without the founder. (Self-paced courses, books, products, license-able templates, software.)

For each layer, name the specific offers, the unit economics, and the constraints (max hours, max cohort size, max margin).

#### 6.4 The automation architecture
Where the offers connect to the rest of the stack — CRM, scheduling, payments, fulfillment, follow-up. This is what makes revenue compound. Reference the actual MCPs / tools the brand uses (or plans to).

#### 6.5 Revenue timeline (phased)
Quarter-by-quarter: which revenue layers are live, what's being built, what milestones unlock the next layer.

#### 6.6 Lead → client journey
The exact path from "first awareness" to "signed contract." Every touchpoint named, every CTA mapped to a stage.

**Output: `brand/04_services_and_offers.md`**

---

### Section 7 · Content & Growth Engine

What you're capturing: what the brand publishes, on what cadence, on which platforms, to what end.

**Sub-sections:**

#### 7.1 Content pillars
Typically 5. Each pillar is a topic-territory the brand owns. For each pillar: definition, three example post angles, what topics fall OUTSIDE the pillar (so we don't drift).

#### 7.2 Day-themes (if cadence is daily)
Mon/Tue/Wed/Thu/Fri primary themes. Each day = one pillar.

#### 7.3 Platforms
3–4 primary platforms with platform-specific rules. (E.g., LinkedIn = thought leadership long-form, X = thread, IG = visual carousel, blog = canonical long-form.)

#### 7.4 Repurposing flow
How one piece of canonical content (typically blog or podcast) becomes 5–10 platform-specific posts.

#### 7.5 Publishing tooling
The actual tools — CMS, scheduler, email platform, analytics. Plus the agentic skills from this library that automate parts of it (newsletter-drafter, social-content-drafter, voice-drift-scanner).

#### 7.6 Newsletter strategy
Cadence, length, structure, lead magnet, list-building strategy.

**Output: `brand/06_content_strategy.md`**

---

### Section 8 · AI Operating Manual

What you're capturing: how AI tools should behave for this brand. Required because every AI tool a brand uses (Claude, ChatGPT, Gemini, Cursor, Cowork, internal agents) needs the same context to stay on-brand.

**Sub-sections:**

#### 8.1 The three-step "always" checklist
What every AI agent does at session start: (1) read the brand playbook, (2) load the human-voice skill (if applicable), (3) check `brand-config.yml` for the active configuration.

#### 8.2 Always use
The skills, prompts, and references the AI agent should default to. Reference the AI Agent Skills Library entries by name.

#### 8.3 Never do
Banned behaviors: auto-publishing, naming excluded entities, inventing facts, etc.

#### 8.4 When in doubt
The escalation path. Who decides what when the AI is unsure.

#### 8.5 File hierarchy for AI context
The exact order of files an AI agent should read at session start. The blueprint itself is the highest-priority file; supporting docs follow.

#### 8.6 Agentic stack
The actual MCPs, plugins, and skills the brand operates with. Reference the AI Agent Skills Library bundles by name.

**Output:** A section in the master blueprint, plus optionally a copy at `AGENTS.md` at the project root for IDE-based agents.

---

## The master blueprint (Section 9 — synthesis)

After all eight sections produce their supporting docs, you write the master blueprint at `brand/99_brand_blueprint.md`. The master is **not a copy** of the supporting docs — it's a synthesis. It pulls the locked decision from each supporting doc and presents the brand as a whole.

Master blueprint structure:

```markdown
# Brand Blueprint — {{PRIMARY_BRAND}}

> The single document anyone needs to read to operate this brand consistently.
> Each section links to the supporting doc where the decisions live in full.

## Table of Contents
[8 numbered sections as above + cross-references at the end]

## 1. The Person / Entity
[2-paragraph synthesis from 01_founder_story_and_values.md]

## 2. Narrative Core
[Purpose, mission, vision, values (one-line each), positioning statement, tagline.
Pulled from 07_brand_narrative_core.md.]

## 3. Positioning & Voice
[Positioning statement, ICP one-line, archetypes, voice pillars (one-line each),
signature phrases. Pulled from 02_brand_identity.md.]

## 4. Visual Identity
[Design philosophy in one paragraph, color system table, typography table,
logo lockup variations (linked images), 3 do/don't examples.
Pulled from 03_visual_identity.md.]

## 5. Messaging Framework
[Hero headline (locked), 3 service block headlines, primary CTAs.
Pulled from 05_messaging_framework.md.]

## 6. Services & Revenue Architecture
[Service pillars, offers ladder, active/leveraged/passive layers, current revenue phase.
Pulled from 04_services_and_offers.md.]

## 7. Content & Growth Engine
[5 pillars, day-themes, platforms, newsletter cadence.
Pulled from 06_content_strategy.md.]

## 8. AI Operating Manual
[The full content of Section 8 — this lives ONLY in the master blueprint.]

## Cross-references
[Table mapping every supporting doc to the section it backs.]
```

---

## What this skill explicitly does NOT do

- Does not invent founder backstories, claims, statistics, or proof points. If the user can't answer a question, the skill flags it for the user to fill in rather than making it up.
- Does not pick the brand archetype for the user. It proposes options based on Section 1 + Section 2 inputs, the user picks.
- Does not draft visual assets (logos, photography). It documents the system and links to where assets live; design execution happens elsewhere (use the `design-methodology` skill in this library for the actual design work).
- Does not lock decisions. The user locks each section before the skill advances. The skill's job is to draft and structure; the user's job is to decide.
- Does not output the entire blueprint in one shot. The skill is iterative — it walks one section at a time so the user can absorb and decide.
- Does not skip sections. If the user wants to skip Section 4 (visual identity) because the visuals are still in flux, the skill stubs the section ("DEFERRED — see Section 4 in v2") rather than omitting it.

---

## When to update this SKILL.md

- A new brand-strategy framework worth integrating (e.g., Jobs-to-be-Done layered into Section 5, or a new archetype canon).
- A section consistently produces low-quality output → tighten the prompts in that section.
- A new supporting doc is added (e.g., a "10_partnership_kit.md" for brands that do co-marketing).
- The master blueprint synthesis pattern changes (e.g., new platform-specific call-outs).
- The AI Operating Manual section needs a new always-load entry as the AI Agent Skills Library grows.

---

## Examples

### Example 1 — new personal brand from scratch

```
User: "I just left my agency to go solo. Build me a brand blueprint."

Skill:
  Section 1 — Asks 8 founder questions, drafts 01_founder_story_and_values.md.
              User locks. Skill commits.
  Section 2 — Walks Purpose → Mission → Vision → Values → ... → Tagline.
              Drafts 07_brand_narrative_core.md.
              User reviews each sub-section, locks. Skill commits.
  Section 3 — Proposes 3 archetype combinations based on §1 + §2.
              User picks. Skill drafts voice pillars + signature phrases.
              User locks. Skill commits 02_brand_identity.md.
  Section 4 — Asks for 5 reference brands. Drafts mood board.
              Walks color/typography/logo/photography/motion.
              User locks each. Skill commits 03_visual_identity.md.
  Section 5 — Drafts hero headlines + homepage copy + CTAs.
              User picks + locks. Skill commits 05_messaging_framework.md.
  Section 6 — Walks 3-layer revenue model. User maps existing offers to layers,
              defines new offers, sets phased timeline.
              Skill commits 04_services_and_offers.md.
  Section 7 — Drafts 5 pillars, day-themes, platforms.
              User locks. Skill commits 06_content_strategy.md.
  Section 8 — Drafts AI Operating Manual referencing the AI Agent Skills Library
              bundles the brand will use.
              User locks. Skill commits.
  Master   — Synthesizes 99_brand_blueprint.md from all supporting docs.
              Writes AGENTS.md at project root.
              Pings review channel: "Blueprint v1.0 ready for review."
```

### Example 2 — commercial product company refresh

```
User: "We've been operating without a real brand foundation for 3 years.
       Build us a blueprint. We're a B2B SaaS in the data space, 25 people."

Skill: Same 8-section walkthrough, but:
  - Section 1's "founder" becomes "leadership team" — captures CEO + 2 cofounders + their entity architecture.
  - Section 6's revenue model is product-led, not service-led — adapts the offers ladder to ARR tiers, expansion motion, channel partners.
  - Section 7's content engine emphasizes thought-leadership content for buyer education over personality-driven content.
  - Section 8's AI operating manual references the team's existing AI tools, not a single-user setup.
```

### Example 3 — defer Section 4 because design is in flight

```
User on Section 4: "Pause this section, we're still in a logo iteration with our designer."

Skill:
  - Stubs 03_visual_identity.md with a "DEFERRED — see Section 4 in v2" note.
  - Adds a TODO entry to the master blueprint pointing at the deferred section.
  - Continues to Section 5.
  - Pings review channel at session close: "Blueprint v0.9 ready (Section 4 deferred). Resume Section 4 when designer locks."
```

---

*This skill encodes the structure of a real, field-tested personal-brand build (April 2026). The numbered file convention (01_..., 02_..., 99_master) survives across IDE / collaborator / agency handoffs because alphabetical sorting puts the founder-story first and the master last, so anyone walking the directory reads it in the right order.*
