---
name: social-content-drafter
description: "Drafts day-themed social content for the user's brand — typically one LinkedIn post + one X thread + one IG caption per day. Stages each as a scheduled draft via the configured social MCP. Pings the review channel with previews and per-platform approval. Never publishes. Triggers on 'draft today's social posts', 'write me a LinkedIn post about X', 'social drafts for the week', or as a daily scheduled run."
license: MIT
metadata:
  version: '2.0.0'
  author: New Minds Group
  sources: Field-tested daily social workflow; portable across platforms via brand-config day-themes
---

# Social Content Drafter

You draft a day's worth of social content — typically one LinkedIn post, one X thread, one Instagram caption (configurable in `brand-config.yml`). Each follows that day's theme and the brand voice playbook.

**Run discipline:**

- Apply the brand voice playbook as system context.
- Layer the `human-voice` skill (if installed) on top.
- Never publish. Stage drafts with status "draft" or "scheduled-pending-approval" and ping the review channel.
- Filter out `{{EXCLUDED_ENTITIES}}` — these must not appear in any social copy.
- One post per platform per day. Quality over quantity.

---

## Brand-config requirements

Reads `brand-config.yml`. Needs:

- `paths.brand_playbook` — voice DNA + ban list
- `paths.content_strategy` — pillars + day-themes
- `paths.social_template_kit` (if defined) — platform-specific formulas, hashtag system, hook patterns
- `social.day_themes` — Mon-Fri theme map
- `social.platforms` — list of platforms to draft for
- `mcp.social_prefix` — to stage drafts
- `review.channel` — for previews
- `brand.excluded_entities`
- `owner.timezone`

Missing config → "missing config" message, no drafting.

---

## Step 1 · Read the canon

| File | What you're looking for |
|---|---|
| `{{BRAND_PLAYBOOK_PATH}}` | Voice DNA, ban list, voice mechanics |
| `{{CONTENT_STRATEGY_PATH}}` | Day-theme system, pillars |
| `{{SOCIAL_TEMPLATE_KIT_PATH}}` (if defined) | Per-platform formulas, hashtag system, hook patterns |
| `{{NARRATIVE_CORE_PATH}}` (if defined) | Strategic angles to anchor posts to |
| `drafts/social/last-shipped.md` (if exists) | Recent posts so you don't repeat yourself |

---

## Step 2 · Pick the angle for today

Identify today's theme from `social.day_themes` in `brand-config.yml`. Each day has a primary theme and (optionally) a secondary lens. Examples:

- Monday — Strategy
- Tuesday — AI / Automation
- Wednesday — Craft / UX
- Thursday — Process
- Friday — Thought leadership

Pick a single insight worth repeating. Don't try to teach a course in one post. Cross-check `last-shipped.md` so you don't reuse the same hook within 14 days.

---

## Step 3 · Draft per platform

For each platform in `social.platforms`, draft using the platform's documented formula. Defaults below — the brand's social template kit overrides these where it specifies.

### LinkedIn

- **Length:** 1,000–1,300 characters (algorithm sweet spot).
- **Structure:** hook line (≤ 12 words) → blank line → 3–6 short paragraphs → closing line that earns a comment → 3–5 hashtags.
- **Tone:** consultative, direct. No "thrilled to announce." No "humbled to share."
- **CTA:** ask one specific question OR point to one specific resource. Not both.

### X (Twitter)

- **Format:** thread (4–8 tweets).
- **Tweet 1:** the hook. Most controversial / most concrete claim.
- **Tweets 2-N:** the argument. One idea per tweet.
- **Final tweet:** the resolution. Plus a quote of tweet 1 (recap).
- **No threading hashtags.** One or two relevant hashtags max in the final tweet.

### Instagram

- **Caption:** the post. 150–300 words.
- **First line:** the hook. Below the cut, expand.
- **Visual:** describe what the image / carousel should be. Don't generate.
- **Hashtags:** 8–12 hashtags below a `.\n.\n.\n` separator.

### Other platforms

If `social.platforms` includes other platforms (Threads, Bluesky, Mastodon, TikTok), use their documented formulas in `{{SOCIAL_TEMPLATE_KIT_PATH}}` or fall back to the closest analog above.

---

## Step 4 · Self-check before staging

For each draft, run through:

- [ ] Voice playbook applied
- [ ] No banned phrases (universal + brand)
- [ ] No `{{EXCLUDED_ENTITIES}}` mentions
- [ ] Today's theme matched
- [ ] One specific insight, not a roundup
- [ ] One CTA (or none — never two competing CTAs)
- [ ] Platform spec respected (length, structure, hashtag count)
- [ ] Different hook from any post in `last-shipped.md` within 14 days

If any fails, fix before staging.

---

## Step 5 · Stage as platform drafts

For each platform, call the social MCP to create a DRAFT post:

```
Tool: {{SOCIAL_MCP_PREFIX}}create_social_post
Args:
  type: "draft"  (NOT "scheduled" — never auto-publishes)
  platform: "linkedin" | "x" | "instagram" | ...
  content: "{post body}"
  hashtags: [...]
  scheduled_at: null  (review channel approval gates the schedule)
```

Save the local copies to:

- `drafts/social/{YYYY-MM-DD}-linkedin.md`
- `drafts/social/{YYYY-MM-DD}-x-thread.md`
- `drafts/social/{YYYY-MM-DD}-instagram.md`

(Adapt filenames to whatever platforms you ran.)

If a stage fails (rate limit, auth, network), still write the local copy and log the failure in `drafts/social/{YYYY-MM-DD}-staging.md`. The agent never blocks on one integration failure.

---

## Step 6 · Review-channel previews

Send one preview ping per platform draft. Format:

```
📱 LinkedIn draft — {today's theme}

{first 200 chars of post}

📁 drafts/social/{YYYY-MM-DD}-linkedin.md
📤 Staged as draft in {platform}

✅ APPROVE LI to publish
❌ REVISE LI [feedback] to iterate
🛑 SKIP LI to drop today
```

Three pings (one per platform) — not one combined ping. Owner can approve / revise / skip each independently.

If APPROVE: ask the owner whether to schedule for {default time, e.g. 9 AM} or some other time. Never schedule without an explicit time.

---

## What this skill explicitly does NOT do

- Does not auto-publish. Every post requires explicit owner approval AND explicit owner-set schedule time.
- Does not generate images or carousel content — describes what's needed, the owner creates.
- Does not invent stats, client names, or proof points. Flag for the owner to fill if needed.
- Does not cross-post identical copy to multiple platforms — each post is platform-shaped.
- Does not violate `{{EXCLUDED_ENTITIES}}` — those entities never appear.
- Does not commit secrets, PII, or unreleased information.

---

## When to update this SKILL.md

- Voice playbook updates.
- New platform added to `social.platforms`.
- Day-theme map changes.
- Platform algorithm changes (e.g., LinkedIn changes optimal length).
- Hashtag system updates.

---

## Examples

### Example 1 — Tuesday 06:00 daily run (theme: AI / Automation)

```
Pulled day-theme: AI / Automation
Pulled angle: "the week-6 AI cliff" (matches narrative core)
Drafted:
  - LinkedIn: 1,180 chars, hook "Most AI rollouts die at week 6. Here's why."
  - X thread: 6 tweets, hook "Most AI rollouts die at week 6."
  - IG caption: 220 words, visual "carousel: 6-tile diagram of the cliff"
Staged 3 drafts. Pinged Telegram with 3 previews.
[awaiting per-platform approval]
```

### Example 2 — Owner replies "APPROVE LI / REVISE X / SKIP IG"

```
Skill:
  - Asks for LI schedule time → owner replies "9 AM" → updates draft to scheduled, replies "✅ Scheduled for 9:00 AM ET"
  - Drops X for second pass with feedback, re-pings
  - Moves IG draft to drafts/social/skipped/, logs in last-shipped.md
```
