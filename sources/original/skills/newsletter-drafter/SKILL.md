---
name: newsletter-drafter
description: "Drafts a newsletter issue from RSS sources, the brand voice playbook, and a master HTML template. Stages the draft in the user's email platform AND saves a copy to the repo for review. Pings the review channel for human approval. Never auto-sends. Triggers on 'draft this week's newsletter', 'write the newsletter', 'pull RSS items into a newsletter', or as a scheduled weekly run."
license: MIT
metadata:
  version: '2.0.0'
  author: New Minds Group
  sources: Field-tested newsletter workflow; portable across email platforms via brand-config MCP prefixes
---

# Newsletter Drafter

You are drafting one issue of `{{NEWSLETTER_NAME}}`. Produce a working draft. The owner reviews and approves. The agent (or owner) ships from the email platform.

**Run discipline:**

- Read every file under "Step 1 · Read the canon" before generating any output.
- Apply the brand voice playbook as your system context. No exceptions.
- Apply the `human-voice` skill (if installed) on top of the brand-specific voice rules.
- Never publish, never auto-send. Output goes to (a) `drafts/newsletter/`, (b) the email platform as a named DRAFT, (c) the review channel as a preview ping.
- If you cannot produce a high-confidence draft, write a minimal draft + flag the gaps in a `NEEDS-REVIEW.md` sibling file AND in the meta file's editor notes.

---

## Brand-config requirements

Reads `brand-config.yml`. Needs:

- `paths.brand_playbook` — voice rules + banned-phrase list
- `paths.content_strategy` — pillars + day-themes + topic boundaries
- `paths.rss_sources` — curated RSS feed list
- `paths.newsletter_template` — the HTML master to populate
- `newsletter.name` — publication name
- `newsletter.cadence` and `newsletter.send_day`
- `mcp.crm_prefix` (or specific email-platform MCP) — to stage the draft
- `review.channel` — where to ping for approval
- `brand.excluded_entities` — entities to filter out of client-facing copy
- `owner.timezone`

If any required value is missing, the skill prints a "missing config" block and asks the user to either fill in `brand-config.yml` or provide values inline for this run.

---

## Step 1 · Read the canon

| File | What you're looking for |
|---|---|
| `{{BRAND_PLAYBOOK_PATH}}` | Voice rules. Phrase ban list. Voice mechanics. |
| `{{CONTENT_STRATEGY_PATH}}` | Pillars, day-themes, what topics belong on the newsletter vs. social. |
| `{{NEWSLETTER_PLAN_PATH}}` (if defined) | Newsletter strategy, structure, cadence rules. |
| `{{RSS_SOURCES_PATH}}` | Curated RSS feed URLs. |
| `{{NEWSLETTER_TEMPLATE_PATH}}` | HTML master to populate. |
| `drafts/newsletter/last-shipped.md` (if exists) | Most recently shipped issue, so you don't repeat its angle. |

Then pull the last 7 days of items from each RSS feed in `{{RSS_SOURCES_PATH}}`. If a feed-reader MCP is available, use it; otherwise use `web_fetch` per feed URL.

---

## Step 2 · Pick the angle

Filter the RSS items for:

- **Pillar match** — must hit one pillar in `{{CONTENT_STRATEGY_PATH}}`.
- **Insight density** — pick 1 anchor item + 2–3 supporting items, not a roundup of 12 links.
- **Voice fit** — items that pair with one of the brand's signature angles (read these from the playbook).

If nothing in the RSS feeds fits, fall back to one of the brand's documented evergreen themes (the playbook should list these). Track which theme was used in `drafts/newsletter/last-shipped.md` so the next run rotates.

---

## Step 3 · Subject line + pre-header

Generate **5 subject line options** using the patterns documented in the brand playbook (typically in a "Subject line formulas" section). Common pattern types:

- Contradiction / surprise
- Numbered insight
- Direct call-out
- Pattern statement
- Plain truth

Write each at 35–50 characters. Mark one as **recommended**; mark the other four as alternates.

Pre-header: 90 characters max, different from the subject, sets up the body.

---

## Step 4 · Draft the body

Use the structure in `{{NEWSLETTER_TEMPLATE_PATH}}`. Replace every `{{...}}` placeholder in the template:

- `{{ISSUE_NUMBER}}` — increment from last issue
- `{{ISSUE_DATE}}` — next send-day's date in long format (e.g. "April 28, 2026")
- `{{ISSUE_TAG}}` — the pillar
- `{{ISSUE_TITLE}}` — the recommended subject, slightly expanded if needed
- `{{ISSUE_LEDE}}` — 1–2 sentence hook, earns the scroll
- Body — opening paragraph, one h2, 2–3 body paragraphs, optional pull quote, one closing paragraph
- `{{CTA_*}}` — pick a relevant CTA from the offers doc
- Resource links — three RSS items with one-line descriptors

**Length target:** 600–900 words in the body. Not longer.

**Voice rules (non-negotiable):**

- Apply the brand playbook voice DNA verbatim as your system context.
- No banned phrases (universal AI-tells + brand-specific list).
- One em-dash max per paragraph, usually zero.
- Filter `{{EXCLUDED_ENTITIES}}` — these must not appear anywhere in the issue.
- Lead with insight. No "I'm thrilled to" or "I want to share."

---

## Step 5 · Stage in the email platform as a DRAFT

Stage the rendered HTML as a draft email template using the MCP at `{{CRM_MCP_PREFIX}}` (or the specific email platform MCP if separate).

```
Tool: {{CRM_MCP_PREFIX}}create_email_template
Args:
  name: "{{NEWSLETTER_NAME}} — Issue {NN} (DRAFT)"
  subject: "{recommended subject line}"
  preheader: "{90-char pre-header}"
  html: "{populated newsletter HTML}"
  category: "newsletter"
```

**Critical:** the template MUST be created with `(DRAFT)` in the name and MUST NOT be added to any active campaign. The owner decides when to attach it to a send.

If the MCP call fails (rate limit, auth, network), still proceed with the repo + review-channel steps. Never block on a single integration failure. Log the failure in the meta file.

---

## Step 6 · Save to repo drafts

Output paths:

- `drafts/newsletter/issue-{NN}-{YYYY-MM-DD}.html` — the populated newsletter HTML
- `drafts/newsletter/issue-{NN}-{YYYY-MM-DD}-meta.md` — the meta file

Where `{NN}` is the next issue number and `{YYYY-MM-DD}` is the next send-day's date.

Meta file structure:

```markdown
# Issue {NN} — {Subject line}

## Subject line options
1. **Recommended:** {chosen}
2. {alt}
3. {alt}
4. {alt}
5. {alt}

## Pre-header
{90-char pre-header}

## Source items used
- {RSS item 1 — URL}
- {RSS item 2 — URL}
- {RSS item 3 — URL}

## Pillar
{pillar name}

## Email-platform staging
- ✅ Template created: "{{NEWSLETTER_NAME}} — Issue {NN} (DRAFT)"
- (or) ❌ Staging failed — reason: {error}

## Editor notes
{Flags for the owner — uncertain claims needing fact-check, copy to tighten, etc.}

## Self-check
- [ ] Voice playbook applied
- [ ] No banned phrases (universal + brand)
- [ ] No excluded-entity mentions
- [ ] Subject < 50 chars
- [ ] Pre-header different from subject
- [ ] Body 600-900 words
- [ ] One pillar match
- [ ] CTA present
- [ ] Three resource links
- [ ] Email-platform draft staged (or failure logged)
```

Then commit + push if the repo is git-tracked:

```bash
git add drafts/newsletter/
git commit -m "Newsletter draft: Issue {NN} ready for review"
git push
```

---

## Step 7 · Review-channel preview ping

Send the owner a `{{REVIEW_CHANNEL}}` message. Format:

```
📬 {{NEWSLETTER_NAME}} Issue {NN} drafted

Subject (recommended): {recommended subject}
Pre-header: {pre-header}
Lede: {first 2 sentences of the lede, max 200 chars}

📁 Repo: drafts/newsletter/issue-{NN}-{YYYY-MM-DD}.html
📤 Email platform: "{{NEWSLETTER_NAME}} — Issue {NN} (DRAFT)" staged

✅ Reply APPROVE to mark ready for send
❌ Reply REVISE [feedback] to iterate
🛑 Reply HOLD to skip this issue
```

If APPROVE: rename the email-platform template (strip "(DRAFT)") and notify the owner to schedule the send manually. Sending stays a manual action.

If REVISE [feedback]: update the draft in-place (same issue number, same date) and re-ping.

If HOLD: move the draft to `drafts/newsletter/holds/` and add a skip note in `last-shipped.md`.

---

## What this skill explicitly does NOT do

- Does not auto-send or publish. The owner pulls the trigger.
- Does not invent client names, statistics, or proof points. If evidence is needed but not on hand, flag it for the owner to fill in.
- Does not pick CTAs that conflict with the current campaign — defaults to subscribe / book-a-call unless editor notes specify otherwise.
- Does not modify the master template. The master is structural; the draft is populated copy.
- Does not commit secrets, tokens, or PII.

---

## When to update this SKILL.md

- Voice playbook updates — re-read and re-apply.
- A new content pillar is added in `{{CONTENT_STRATEGY_PATH}}`.
- The owner keeps editing the same kind of mistake out of drafts — update the briefing to pre-empt it.
- New RSS sources added — update the source-pulling step.
- The email-platform MCP changes — update the staging step.
- The review channel changes — update step 7.

---

## Examples

### Example 1 — Monday 09:00 scheduled run

```
1. Read brand-config.yml → pillars, ban list, MCP prefixes
2. Pulled 47 RSS items from 12 feeds (last 7d)
3. Filtered to 3 candidates matching the "AI / Automation" pillar
4. Drafted issue 24, 720 words, "Why your AI rollout stalled at week 6"
5. Generated 5 subject lines, picked "The week-6 AI cliff"
6. Staged as draft in CRM, saved to drafts/newsletter/issue-24-2026-04-28.html
7. Pinged Telegram with preview
[awaiting APPROVE / REVISE / HOLD]
```

### Example 2 — owner replies REVISE

```
Owner: REVISE — tighten the lede, the second example feels too internal
Skill:
  - Re-drafts the lede
  - Replaces the second example with a more universal one
  - Updates the same draft files in place
  - Re-pings: "📬 Issue 24 revised — second pass ready"
```
