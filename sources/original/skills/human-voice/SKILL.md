---
name: human-voice
description: "Apply this skill whenever generating content that will be read by humans on a public surface. Includes website copy, marketing emails, sales decks, blog posts, social posts, ad copy, video scripts, podcast intros, landing pages, case studies, and any first-person content that should not read as AI-generated. Triggers on any request that involves writing, drafting, editing, or rewriting content for public consumption. Specifically active when the user asks to 'write a', 'draft a', 'create copy for', 'rewrite', 'punch up', 'edit for voice', or names a content surface (homepage, email, ad, post, landing page, etc.). IMPORTANT: This skill is universal anti-AI-tell rules. If the project root has a brand-specific voice playbook (look for `brand-voice-playbook.md`, `15_Brand_Behavior_Playbook.md`, `voice-playbook.md`, or paths declared in `brand-config.yml` / user-level CLAUDE.md), READ THAT FIRST and apply its rules + banned phrases ON TOP of the universal rules below. The project's voice playbook always overrides this skill on conflicts."
license: MIT
metadata:
  version: '1.2.0'
  author: New Minds Group
  sources: 2024-2025 AI-tell research; OpenAI's Nov 2025 em-dash setting; field-tested rewrites against ChatGPT/Claude/Gemini outputs
---

# Human Voice — Anti-AI-Tell Writing Skill

The single rule: written content should sound like a sharp human wrote it, not an AI. Frequency is what gives AI away. Apply this skill to every word you write for public consumption.

## How this skill layers with project-specific brand voice

This skill provides **universal** anti-AI-tell rules that apply to every brand. If the project has its own voice playbook, the layering is:

1. **READ the project voice playbook first.** Look at the project root for `brand-voice-playbook.md`, `15_Brand_Behavior_Playbook.md`, `voice-playbook.md`, or any path declared in `brand-config.yml` / user-level `~/.claude/CLAUDE.md` precedence.
2. **Apply the project's banned phrases first.** Those override and extend the universal banned-phrase set below.
3. **Apply the project's signature phrases.** Those phrases the brand reuses on purpose — don't strip them as "AI tells" just because the patterns look frequent.
4. **Then layer the universal rules** (em-dash ban, frequency-based detection, read-aloud test). Where this skill says "default to X" but the project playbook says "default to Y," the playbook wins.

If no project voice playbook exists, this skill is the voice spec. Apply its rules wholesale.

---

## 1. The em dash is banned by default

Em dashes (`—`) became the most-recognized AI-generated-text tell in 2024–2025. ChatGPT, Claude, and Gemini statistically use em dashes 5–10× more often than typical human writers. When every paragraph has one, the page reads as machine-written. OpenAI added a setting in November 2025 to disable em dashes specifically because the pattern was so visible.

**Default: zero em dashes per piece of content.** If a piece runs longer than 800 words and an em dash genuinely earns its place, one is acceptable. Otherwise, none.

The substitutions:

| Where AI wants an em dash | Use this instead |
|---|---|
| Setup → payoff break: *"You're stuck — but not for the reasons you think."* | Period and capital: *"You're stuck. Not for the reasons you think."* |
| Parenthetical interruption: *"The work, what compounds, is what matters — not the busywork."* | Two short sentences or commas: *"The work that compounds is what matters. Busywork is not."* |
| Mid-sentence emphasis: *"Brand thinking — applied to AI — is what compounds."* | Cut the dashes; the sentence works. *"Brand thinking applied to AI is what compounds."* |
| List with explanation: *"Strategy, systems, and scale — three things most consultants sell as one."* | Period + follow-up: *"Strategy. Systems. Scale. Three beats most consultants compress into one."* |
| Range or pause: *"In 4 weeks — locked."* | Reverse or split: *"Locked in 4 weeks."* OR *"4 weeks. Locked."* |

---

## 2. Other AI tells to avoid

The em dash is loudest. These are the next ones.

### 2.1 Ban list — never use these phrasings

| Tell | Replacement strategy |
|---|---|
| "delve into" | "get into," "look at," or just say it |
| "navigate the complexities of" | "use," "work with," or rephrase entirely |
| "in the realm of" | drop it. Just say what you're talking about. |
| "tapestry of" / "labyrinth of" | name the actual thing |
| "moreover" / "furthermore" | "also," or start the new sentence without a connector |
| "It's not just X, it's Y" | Just say what it is. *"It's not just a website. It's a system that converts."* → *"You don't need another website. You need a system that converts."* |
| "game-changer" / "unlock" / "revolutionize" / "10x" / "disrupt" / "synergy" | Brand-flagged buzzwords. Use the actual outcome instead. |
| "Imagine if you could…" | Cut it. Start with the actual thing. |
| "In today's fast-paced world" | Cut it. Start with the actual thing. |
| Any phrase that starts with "Embark on a journey" | Cut it. Start with the actual thing. |

### 2.2 Patterns to avoid

**Triplets by reflex.** *"Clear, concise, and compelling."* Pick one or two qualifiers. Three by reflex is the AI tell.

**Adjective stacking.** *"A sleek, modern, intuitive interface."* Pick one. Or zero — describe what it does instead.

**Hedge stacking.** *"This can potentially help you achieve…"* Cut the hedges. *"This produces…"*

**Vague abstractions.** *"Optimize your workflows."* Name the specific thing. *"Cut concepting time in half."*

**Em-dash-led parentheticals.** *"The result — what every founder wants — is X."* Two short sentences instead.

**Setup-payoff "But here's the thing" / "Here's the reality" / "The truth is" openers.** Just say the thing.

**Fake-intimacy openers.** *"Let me be real with you for a second."* / *"Here's what nobody tells you."* These are influencer-speak imported into AI defaults. Cut them. Start with the substance.

**Engagement-bait CTAs.** *"What's your take?"* / *"Drop a 🔥 in the comments."* Ask one specific question OR none.

---

## 3. The voice we ARE going for

Three positive principles that take the place of the AI tells:

1. **Short sentences. Periods.** If a sentence has more than one comma or one connector, it probably needs to be two sentences.
2. **Common words, named outcomes.** Replace every abstract noun ("transformation," "efficiency") with a specific named outcome ("+28% engagement," "cut concepting time in half").
3. **Speak to the reader, not at them.** Use "you" in second person. The reader is the hero of the story; the brand is the guide.

### 3.1 The read-aloud test

Before shipping any copy, read it aloud. Three failure modes:

- If you stumble on a sentence, it's too long. Split it.
- If a phrase makes you self-conscious to say (e.g., "delve into the labyrinth of brand strategy"), it's AI. Rewrite.
- If a paragraph could be cut in half and lose nothing, cut it in half.

### 3.2 The em-dash audit

After writing any piece, count em dashes. If there is more than one in a piece under 800 words, rewrite. The substitution patterns in §1 cover every case.

### 3.3 The cadence cap

For long content (1000+ words):

| Surface | Max em dashes | Max triplets | Max "in the realm of" / "delve into" / "tapestry" |
|---|---:|---:|---:|
| Headline / sub-headline | 0 | 0 | 0 |
| Marketing email | 0 | 0 | 0 |
| Landing page | 1 (only if it earns it) | 1 | 0 |
| Long-form post (1000+ words) | 4 max | 2 | 0 |

---

## 4. When to use this skill

- Writing or rewriting copy for a website (homepage, about, services, case studies)
- Drafting a marketing email, sales email, or sequence
- Writing ad copy, social posts, or video scripts
- Editing AI-generated copy that someone wants to "humanize"
- Writing a podcast intro, panel bio, or speaker abstract
- Drafting a pitch deck
- Anywhere a human reader will judge the content

## 5. When NOT to use this skill

- Code (variable names, comments, docstrings)
- Internal documentation that engineers will read
- Technical specs where precision beats voice
- Legal disclaimers (those have their own conventions)

In those contexts, normal AI cadence is fine because the audience isn't judging it for human-ness.

---

## 6. Brand-config integration (optional)

If a `brand-config.yml` exists at the project root with a `brand.banned_phrases:` list, append it to the ban list in §2.1. This lets organizations layer their own banned-word list (cliches specific to their industry, internal jargon, terms a competitor owns) on top of the universal AI-tell list.

Example `brand-config.yml` excerpt:

```yaml
brand:
  banned_phrases:
    - "world-class"
    - "leverage"
    - "best-in-class"
    - "synergize"
```

Without `brand-config.yml`, the universal list above is the active ban list.

---

## 7. Self-check before shipping

Run every piece through this 5-question check before saying it's done:

1. **Em-dash count?** (Target: 0 unless it's long-form and earns one)
2. **Any banned phrases?** (universal list + brand-config additions)
3. **Any triplets I added by reflex?** ("Clear, concise, and compelling.")
4. **Read-aloud test passed?** (No stumbles, no self-conscious phrases)
5. **Concrete outcomes named?** (Real numbers, real names, not "transformation" or "efficiency")

If any answer is no, fix before shipping.

---

## 8. Examples

### Example 1 — landing page hero

**AI default:**
> Embark on a journey to unlock the full potential of your business. Our cutting-edge platform empowers you to navigate the complexities of digital transformation — delivering game-changing results that revolutionize your workflow.

**Human-voiced rewrite:**
> Your business runs on workflows that nobody has rebuilt in a decade. We rebuild them. Most clients ship faster within 90 days.

### Example 2 — newsletter intro

**AI default:**
> Welcome to this week's edition! In today's fast-paced world, staying ahead of the curve is more important than ever. We're thrilled to share insights that will help you navigate the ever-evolving landscape of AI — moreover, we'll delve into game-changing strategies that unlock your team's potential.

**Human-voiced rewrite:**
> One pattern this week. Every team that shipped an AI tool in Q1 also shipped two it didn't ship in Q2. The constraint isn't models. It's pickaxe focus. Here's what the teams that kept shipping did differently.

---

*This skill encodes the universal AI-tells research. Layer your organization's specific banned phrases via `brand-config.yml`. The skill is portable — copy `human-voice/` into any IDE's skill directory and it triggers automatically on content-writing tasks.*
