# Messaging Framework — Full Section 5 Walkthrough

The messaging framework is where voice meets surface. It's the actual copy that lives on the homepage, in the email signature, in the deck cover. Most brands have decent voice rules and decent copy on individual surfaces, but the surfaces don't reinforce each other because no one wrote them together.

This walkthrough produces 7 outputs, all synthesized into `brand/05_messaging_framework.md`.

---

## 5.1 Hero headlines

The single most-tested copy block in the brand. The homepage hero gets 70% of first impressions. Get this wrong and every downstream surface inherits the wrongness.

**Generate 5 candidates** using these patterns:

### Pattern A — Plain truth
*"You don't need another website. You need a system that converts."*
- States the customer's problem in their own words, then names what the brand actually delivers.
- Anti-pattern: cleverness over clarity.

### Pattern B — Contradiction
*"Your brand isn't a logo problem."*
- Names the wrong assumption the customer is making, sets up the real problem.
- Anti-pattern: contradicting something the customer doesn't actually believe.

### Pattern C — Numbered insight
*"Three things every $1M-stuck founder is missing."*
- Specific number, specific persona, specific pain.
- Anti-pattern: vague numbers ("multiple," "several").

### Pattern D — Pattern statement
*"The pattern in every brand that stops shipping."*
- Frames the brand as the diagnostician of a recurring industry pattern.
- Anti-pattern: making up a pattern that doesn't exist.

### Pattern E — Direct CTA-as-headline
*"Lock your brand foundation in 6 weeks."*
- Names the offer and the timeframe up front. Highest-converting for direct-response surfaces.
- Anti-pattern: overpromising the timeline.

**Pick one as primary.** Mark the other four as "alternates" — they're fallbacks for split-tests, paid ad variations, and email subject lines.

**Length target:** 6-12 words. Anything longer and the hero is doing the body's job.

---

## 5.2 Homepage copy framework — section by section

The homepage is roughly 8 sections. Each has a copy template the brand fills in.

### 1. Hero
- Hero headline (from 5.1)
- Sub-hero: 1-2 sentence elaboration of the headline
- Primary CTA button text
- (Optional) secondary CTA / "learn more" anchor

### 2. The problem (or "for whom")
- Problem statement: one sentence naming the audience's pain
- Three 1-sentence symptoms the customer recognizes ("Sound familiar?")
- Transition: "We solve this differently."

### 3. The approach (or "how we work")
- 3 columns / blocks naming the brand's distinct methodology steps
- Each block: 3-word headline + 2-sentence description
- The 3 steps map to either the offers (Section 6) or to the brand's signature framework

### 4. Services teaser
- Mini-block per service pillar (typically 3-5)
- Each: pillar name + one-line description + "Learn more →" link
- This isn't the full services page — it's the orientation that sends the visitor deeper

### 5. Social proof
- Logo bar of past clients (if available)
- 2-3 testimonial quotes with attribution
- Headline above: "Built brands for businesses who..."

### 6. About teaser
- 2-paragraph elevator-pitch version of the founder story
- Photo
- "Read the full story →" link to About page

### 7. Lead magnet / newsletter pitch
- Headline pitching the newsletter or lead magnet
- 2-line value prop
- Email-capture form
- Privacy reassurance one-liner

### 8. Footer + secondary CTA
- Final CTA (often differs from primary): "Book the diagnostic" vs. "Subscribe to the weekly memo"
- Links: services, about, contact, social
- Brand mark + tagline

---

## 5.3 Service block headlines (locked)

Each service / offer / pillar gets ONE locked headline. These appear:
- On the homepage services teaser
- On the dedicated services page
- In sales emails
- In pitch decks

**Locked** means the headline doesn't get rewritten by every contractor / agency / freelancer who touches the brand. The blueprint is the source of truth.

**Per-service headline structure:**

```markdown
### {Service / pillar name}

**Locked headline:** {6-12 word headline}

**Sub-headline:** {1-2 sentence elaboration}

**Body copy (200-300 words):**
[the locked description used wherever this service is described]

**Primary CTA:** {button text + destination}

**Alt copy (for compressed surfaces):**
{50-word and 150-word variants for ad copy, social bios, etc.}
```

---

## 5.4 CTA inventory

Every CTA in the brand, in one table, mapped to the journey stage from Section 6.6.

| CTA text | Where it appears | What action it triggers | Journey stage |
|---|---|---|---|
| "Subscribe" | Homepage footer, blog footer, end of newsletter | Email opt-in | Audience |
| "Book the diagnostic" | Homepage hero, services page CTA | Calendar booking | Qualified lead |
| "Read the full case study" | Services page, social posts | Page navigation | Audience → consideration |
| "Get the workbook" | Lead magnet form | Email-gated download | First touch |
| ... | ... | ... | ... |

**Anti-pattern:** dozens of CTAs that compete. The CTA inventory forces consolidation: every CTA must serve a different journey stage. Two CTAs in the same stage = pick one.

---

## 5.5 Key brand phrases — reusable

Phrases that appear across many surfaces. The brand's owned lines.

```markdown
### "{Phrase}"

**Where it appears:**
- Homepage tagline
- Email signature
- Speaker bio
- Social bios

**What it signals:**
{One-line on what this phrase is doing — positioning, voice marker, etc.}

**When NOT to use:**
{Contexts where this phrase is wrong — internal, technical, formal, etc.}
```

5-10 phrases. These become the brand's verbal tics — the lines a customer can quote from memory.

---

## 5.6 Newsletter / social proof copy

Templates for content that appears repeatedly:

### Testimonial template
```markdown
> "{One-sentence outcome}"
>
> — {Name}, {Title} at {Company}
```

### Case-study lede pattern
```markdown
**The challenge:** {one sentence}
**What we did:** {one sentence}
**The result:** {one sentence with numbers}
```

### Newsletter subscription pitch (3 lengths)
```markdown
**Long (homepage):**
{60-80 words pitching the newsletter}

**Medium (blog footer):**
{30-40 words}

**Short (social bio):**
{15-word teaser}
```

---

## 5.7 Copy do / don't quick reference

A two-column table at the bottom of the messaging framework doc.

| Do | Don't |
|---|---|
| {voice-on example} | {voice-off near-equivalent} |
| {voice-on example} | {voice-off near-equivalent} |

10-20 entries. The table grows over time — every time the brand owner edits something OUT of a draft, that becomes a new entry.

---

## What this walkthrough does NOT do

- Does not finalize copy without the brand owner's sign-off. The skill drafts; the owner locks.
- Does not invent customer testimonials, case-study outcomes, or numbers. If the brand doesn't have them yet, the framework leaves placeholders.
- Does not write SEO copy as a separate task. Hero / service copy is written for humans first; SEO refinement happens during page implementation, not blueprint authoring.
- Does not pick CTAs for the user. It documents what the journey requires; the user picks the words.

---

## Cross-references

- Section 3 (positioning, voice) — every line in this framework respects the locked voice.
- Section 6.6 (lead-to-client journey) — every CTA in 5.4 maps to a stage in 6.6.
- The `human-voice` skill — running every draft through the AI-tell self-check.
- `voice-drift-scanner` skill — scanning shipped copy for drift from the messaging framework.
