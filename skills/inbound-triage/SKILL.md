---
name: inbound-triage
description: "Polls the user's email + CRM conversations for new inbound, classifies intent, drafts replies using the brand's response playbook templates, and saves drafts (never sends). Pings the review channel with a digest plus immediate alerts for HIGH-priority messages. Triggers on 'triage my inbox', 'process my unread email', 'classify and draft replies', or as a scheduled run every 4 hours."
license: MIT
metadata:
  version: '2.0.0'
  author: New Minds Group
  sources: Field-tested inbound triage workflow; portable across email + CRM platforms via brand-config MCP prefixes
---

# Inbound Triage

You process the owner's inbound — email + CRM conversations + the website contact form (if it routes to the CRM). You classify, draft, and route. The owner approves and ships.

**Run discipline:**

- Apply the brand voice playbook as system context.
- **Never send. Never auto-reply.** Drafts only — saved in the email platform's Drafts folder and the CRM's conversation drafts.
- Filter out `{{EXCLUDED_ENTITIES}}` from every reply.
- For HIGH-priority messages, ping the review channel immediately. Don't wait for the digest.
- Maintain a triage log so the owner can audit what was drafted and why.

---

## Brand-config requirements

Reads `brand-config.yml`. Needs:

- `paths.brand_playbook` — voice + response playbook templates
- `paths.email_templates` (if defined) — additional templates
- `paths.content_strategy` — for context about what to say when someone references a pillar
- `mcp.email_prefix` — for the inbox
- `mcp.crm_prefix` — for CRM conversations
- `review.channel` — for HIGH-priority pings + daily digest
- `brand.excluded_entities`
- `owner.timezone` — for "business hours" filtering

Missing config → "missing config" message, no triage.

---

## Step 1 · Read the canon

| File | What you're looking for |
|---|---|
| `{{BRAND_PLAYBOOK_PATH}}` | Voice + Response Playbook (templates per inbound type) |
| `{{EMAIL_TEMPLATES_PATH}}` (if defined) | Cold outreach templates + email signatures |
| `{{CONTENT_STRATEGY_PATH}}` | Context for messages referencing pillars |
| `drafts/replies/last-30-days/` (if exists) | Recent replies so you don't contradict prior commitments |

---

## Step 2 · Pull the inbound

Use the configured MCPs.

**Email** (via `{{EMAIL_MCP_PREFIX}}`):
- `search_threads` with query `is:unread newer_than:1d -label:done -label:agent-handled`
- `get_thread` for each result to read the full content

**CRM conversations** (via `{{CRM_MCP_PREFIX}}`):
- `search_conversations` with `unread:true` filter
- `get_conversation` to load message thread

Skip messages that are clearly automated (no-reply senders, newsletter platforms, calendar invite confirmations, GitHub / Linear / etc. notifications). Process only human-originated inbound.

---

## Step 3 · Classify each message

Map each message to one of these intent categories. The brand's Response Playbook has a template per category.

| Intent | Signals | Priority | Template |
|---|---|---|---|
| Qualified prospect | Specific project, budget mention, decision-maker title, intro from a known referrer | HIGH | `prospect-discovery-call` |
| Speaking / podcast inquiry | Conference name, podcast name, paid mention, audience size | HIGH | `speaking-followup` |
| Partnership inquiry | "Collaborate on", "co-host", "joint webinar", agency-to-agency | HIGH | `partnership-discovery` |
| Existing client | Sender is in the CRM as a contact in an active opportunity | HIGH | `client-followup` |
| Refresh-the-relationship | Past contact resurfacing, no immediate ask | MEDIUM | `warm-touch` |
| Cold pitch (vendor) | Sales pitch from a vendor — SaaS, lead-gen, agency | LOW | `polite-decline` |
| Recruiter | Job offer, talent pitch | LOW | `recruiter-decline` (or `recruiter-redirect` if the brand has openings) |
| Newsletter / community | Subscribe, unsubscribe, list-management requests | LOW | `auto-handle` (often no reply needed) |
| Invoice / billing | Payment, contract, accounting | MEDIUM | flag for owner — no template, draft fact-only |
| Press / media | Reporter, PR pitch | HIGH | `press-acknowledgment` |
| Other / unclassifiable | Doesn't fit | MEDIUM | flag for owner, no draft |

Brand-config can override this matrix in `inbound.intents:` if defined.

---

## Step 4 · Draft a reply per message

For each classified message, draft a reply using the template named in the table. Voice rules apply:

- Brand voice playbook
- Universal AI-tells filter (em dashes, banned phrases, triplets, etc.)
- No `{{EXCLUDED_ENTITIES}}` mentions
- No invented facts — if the template has a `[BRACKET]`, fill it from the message context or leave the bracket and flag in the triage log
- Keep replies short. The longer the draft, the more friction in the owner's review.

Save the draft via the platform MCP:

```
Email: {{EMAIL_MCP_PREFIX}}create_draft
       (NOT send_email — never call send variants)

CRM:   {{CRM_MCP_PREFIX}}create_conversation_draft
       OR {{CRM_MCP_PREFIX}}send_email with sendImmediately:false
```

---

## Step 5 · Write the triage log

Save to `drafts/replies/{YYYY-MM-DD}-triage-log.md`:

```markdown
# Triage log — {YYYY-MM-DD}

## Run summary
- Run time: {HH:MM} {{TIMEZONE}}
- Messages processed: {N}
- Drafts created: {N}
- HIGH priority: {N}
- Skipped (automated): {N}
- Flagged for owner: {N}

## HIGH priority

### {sender name} — {subject}
- Source: email | crm
- Intent: {category}
- Template: {template name}
- Draft saved: ✅ Gmail Drafts / CRM conversation #{id}
- One-line summary of message
- One-line summary of drafted reply
- Editor flag: {anything the owner should review}

## MEDIUM / LOW priority
[same format, terser]

## Skipped
[brief: which sender, why skipped]

## Errors
[MCP failures, unmappable messages]
```

---

## Step 6 · Review-channel pings

**For HIGH priority, immediately:**

```
🔔 Inbound — {{REVIEW_CHANNEL}} ping

From: {sender}
Subject: {subject}
Intent: {category}
Why HIGH: {reason}

Draft saved to: {platform} Drafts
Open and review: {deep link if available}
```

**End of day, daily digest:**

```
📥 Inbound triage — {YYYY-MM-DD}

Processed: {N} messages
Drafts ready: {N}
  • {N} HIGH (already pinged)
  • {N} MEDIUM
  • {N} LOW

Flagged for your eyes: {N}
  • {sender} — {one-line reason}

Full log: drafts/replies/{YYYY-MM-DD}-triage-log.md
```

If nothing was processed (zero new inbound), stay silent. No spam.

---

## What this skill explicitly does NOT do

- **Never sends, never auto-replies.** Every reply requires owner approval inside the email platform / CRM.
- Does not invent commitments — never says "I'll send you the proposal Tuesday" if Tuesday hasn't been agreed.
- Does not commit replies to public channels (no draft posts to social, no press statements).
- Does not respond to legal threats, subpoenas, or regulatory inquiries — flags for owner attention with no draft.
- Does not handle billing disputes, contract negotiations, or anything with financial / legal stakes — flag and stop.
- Does not commit secrets, tokens, OR PII to the triage log. Sender names + subjects only.

---

## When to update this SKILL.md

- The Response Playbook adds a new template — update the intent table.
- A new inbound channel (LinkedIn DMs, contact form, etc.) — extend Step 2.
- The owner keeps editing the same kind of mistake out of drafts — pre-empt it in Step 4.
- A new HIGH-priority signal emerges (e.g., "AI consultancy inquiry" was missing) — add to the matrix.

---

## Examples

### Example 1 — 09:00 scheduled run

```
Pulled: 12 unread emails, 4 unread CRM conversations
Classified: 2 HIGH (1 prospect, 1 podcast), 5 MEDIUM, 3 LOW, 6 skipped (automated)
Drafted: 9 replies saved as drafts
Sent immediate Telegram ping for the 2 HIGH items
End-of-day digest queued for 17:00
```

### Example 2 — HIGH priority pre-empt

```
13:00 run — new email from @TechConference: paid keynote inquiry, $15K, May 2026
Skill action:
  - Classified HIGH (speaking/paid)
  - Used template `speaking-followup` with bracket filled from email body
  - Saved draft in Gmail
  - Pinged Telegram immediately with summary + deep link
  - Owner reviews + sends within an hour
```
