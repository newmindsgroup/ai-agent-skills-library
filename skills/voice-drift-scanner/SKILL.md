---
name: voice-drift-scanner
description: "Scans recently published or scheduled content (social posts, marketing emails, blog posts, scheduled drafts) against a brand's voice playbook, banned-phrase list, and entity-separation rules. Surfaces deviations before they compound. Triggers on 'audit my recent posts', 'check brand voice on my content', 'scan for banned phrases', 'voice drift check', 'is anything off-brand', or as a scheduled daily/weekly run. Read-only — flags drift, does not edit live content."
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Field-tested against personal-brand and corporate-brand voice playbooks; aligned with the human-voice skill's universal AI-tell list
---

# Voice Drift Scanner

You audit recently-shipped content against the brand's voice rules. The point is to catch drift before it compounds — a single off-voice post is a tiny problem; a year of them is a brand crisis.

**Run discipline:**

- Read-only on every connected platform. This skill never modifies live content.
- The fix path is human — you flag, the owner decides whether to edit, archive, or unpublish.
- For RED flags (entity-separation violations especially), ping the review channel immediately. Do not wait for the report.

---

## Brand-config requirements

This skill reads `brand-config.yml` from the project root. It needs:

- `paths.brand_playbook` — path to voice playbook + banned-phrase list
- `paths.content_strategy` — path to pillar definitions (for off-pillar drift checks)
- `brand.excluded_entities` — entities that must NOT appear in client-facing content
- `mcp.crm_prefix` and `mcp.social_prefix` — to read scheduled / published drafts
- `review.channel` — where to send RED-flag pings
- `owner.timezone` — for scheduling and timestamping reports

If any required value is missing, the skill prints a "missing config" message and exits without reading content.

---

## Step 1 · Read the canon

Before scanning anything, read:

| File | What you're looking for |
|---|---|
| `{{BRAND_PLAYBOOK_PATH}}` | Voice rules, banned phrase list, voice mechanics |
| `{{CONTENT_STRATEGY_PATH}}` | Content pillars (for off-pillar drift checks) |
| The `human-voice` skill (if installed) | Universal AI-tell list — appended to the brand-specific ban list |

Compile the active ban list as: universal AI-tells (em dashes, "delve into," "navigate the complexities," etc.) + brand-config `brand.banned_phrases` + any list under `voice-rules:` in the brand playbook.

---

## Step 2 · Pull the content surface

Pull the last 24 hours (or last run window, whichever is longer) of:

- Published or scheduled social posts via `{{CRM_MCP_PREFIX}}search_social_posts` or `{{SOCIAL_MCP_PREFIX}}list_posts`
- Sent or queued marketing emails via `{{CRM_MCP_PREFIX}}get_email_campaigns`
- Published or scheduled blog posts via `{{CRM_MCP_PREFIX}}get_blog_posts`
- Local repo `drafts/` folder — anything staged but not yet shipped (pre-flight check)

If a Web/Browser MCP is available, also fetch the live publish surfaces directly:

- The owner's website homepage + about page
- The owner's most recent 5 LinkedIn posts
- The owner's most recent 10 X / Twitter posts
- The owner's most recent 5 Instagram posts

If any source is unreachable, skip it and log it in the report. Do not block the scan on a single integration failure.

---

## Step 3 · Run the checks

For each content item, run these checks. Severity legend at the bottom.

### CRITICAL (RED flags — instant review-channel ping)

1. **Entity-separation violation.** Any mention of an entity in `brand.excluded_entities` inside customer-facing content. Never acceptable.
2. **Hard-banned phrasing from the playbook.** Phrases the playbook explicitly bans (often legal-flagged: "guaranteed," "risk-free," competitor's trademarked phrasing).
3. **Wrong attribution.** Quotes attributed to the wrong person, or a venture co-founder credited to the personal brand (or vice versa).

### HIGH (AMBER flags — surface in the daily report)

4. **AI-tell density.** More em dashes, triplets, or banned phrasings than the voice playbook permits per surface (e.g., 3+ em dashes in a single post).
5. **Off-pillar content.** Post does not match any defined content pillar.
6. **Voice mismatch.** Tone reads as another brand archetype than what the playbook locks (e.g., playbook locks "Sage + Creator," post reads as "Hero" or "Jester").

### MEDIUM (YELLOW flags — note in weekly summary, not pinged)

7. **Repeat angle.** Same hook used in 3+ posts within 14 days.
8. **CTA mismatch.** CTA does not match the current campaign or contradicts standard offers.
9. **Format drift.** Post format breaks the platform's documented spec in the social template kit.

### LOW (note only)

10. **Hashtag drift.** Off-system hashtags (not in the documented hashtag set).

---

## Step 4 · Write the report

Save the report to `reports/voice-drift/drift-{YYYY-MM-DD}.md` (committed if the repo is git-tracked).

Format:

```markdown
# Voice Drift Report — {YYYY-MM-DD}

## Summary
- Items scanned: {N}
- 🔴 Critical: {count}
- 🟠 High: {count}
- 🟡 Medium: {count}
- 🟢 Low: {count}

## 🔴 Critical findings
For each:
- Where: {platform / URL / draft path}
- What: quote the offending text
- Rule: which rule was broken (cite playbook section)
- Recommended action: edit, archive, unpublish, contact platform

## 🟠 High findings
Same format, less urgent.

## 🟡 Medium / 🟢 Low findings
Bulleted, terser.

## Pre-flight (drafts not yet shipped)
Any drafts in the repo `drafts/` folder that fail any check — surface BEFORE they ship.
```

---

## Step 5 · Send the review-channel pings

For RED flags only, ping `{{REVIEW_CHANNEL}}` immediately:

```
🔴 Voice drift — {date}

Where: {platform / link}
What: "{quoted offending text}"
Rule broken: {playbook section}
Recommended: {action}

Full report: reports/voice-drift/drift-{YYYY-MM-DD}.md
```

For days with only AMBER/YELLOW/GREEN findings, send a daily digest at end of day. For days with no findings at all, stay silent — no spam.

---

## What this skill explicitly does NOT do

- Does not edit, archive, unpublish, or modify any live content.
- Does not contact platforms on the owner's behalf.
- Does not invent voice rules — every check must trace back to a rule in the brand playbook or `brand-config.yml`.
- Does not auto-resolve flags — every fix is the owner's call.
- Does not commit secrets, tokens, or PII to the report.

---

## When to update this SKILL.md

- The brand playbook updates a banned-phrase list — re-read on next run.
- A new content pillar is added — add to off-pillar drift check.
- A new platform is added to the publish surfaces — extend Step 2.
- The review channel changes (e.g., Slack → Telegram) — update Step 5.
- A new severity tier is needed — extend Step 3.

---

## Examples

### Example 1 — daily scheduled run, nothing flagged

```
[skill auto-runs at 23:00 local]
Pulled: 3 LinkedIn posts, 2 X threads, 1 IG caption, 1 newsletter (sent)
Findings: 0 critical, 0 high, 0 medium, 1 low (hashtag drift on Tue post)
Action: report saved, no review-channel ping (low only)
```

### Example 2 — RED flag on entity-separation

```
[skill auto-runs]
Pulled: 4 LinkedIn posts
Findings: 1 CRITICAL — Tue 10:30 AM post mentions "Side Project LLC" (in excluded_entities)
Action:
  - Saved report
  - Sent immediate review-channel ping
  - Flagged for owner decision: edit live post, or archive
```
