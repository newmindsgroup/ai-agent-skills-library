---
name: inbound-triage
description: "Polls the user's email + CRM conversations for new inbound, classifies intent, drafts replies using the brand's response playbook templates, and saves drafts (never sends). Pings the review channel with a digest plus immediate alerts for HIGH-priority messages. Triggers on 'triage my inbox', 'process my unread email', 'classify and draft replies', or as a scheduled run every 4 hours."
license: MIT
metadata:
  version: '2.1.0'
  author: New Minds Group
  sources: Field-tested inbound triage workflow; portable across email + CRM platforms via brand-config MCP prefixes
---

<!-- Version-Timestamp: 2026-10-19 18:34:32 AST | computer=NMG-MBP-M5.local | tool=Claude Code 2.1.296 -->

# Inbound Triage

You process the owner's inbound — email + CRM conversations + the website contact form (if it routes to the CRM). You classify, draft, and route. The owner approves and ships.

**Run discipline:**

- Apply the brand voice playbook as system context.
- **Never send. Never auto-reply.** Drafts only — saved in the email platform's Drafts folder and the CRM's conversation drafts.
- Filter out `{{EXCLUDED_ENTITIES}}` from every reply.
- For HIGH-priority messages, ping the review channel immediately. Don't wait for the digest.
- Maintain a triage log so the owner can audit what was drafted and why.
- **Scam gate first.** No message gets a draft until Step 2b has answered "no" to scam or phishing.
- **Pricing hold.** A draft that mentions price, discount, refund, warranty or money back is saved with a `HOLD: pricing` flag for the owner's eyes; it is never the default template reply.

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

## Step 2b · Scam and phishing gate (yes / no, before any draft)

Ask one question per human-originated message: **is this a scam, phishing or fraud attempt?** Answer `yes`, `no` or `unsure`. Only `no` continues to Step 3.

Signals that make it `yes` (any one is enough):
- Display name or signature claims a known contact or client, but the sending domain or reply-to address differs from that contact's record in the CRM.
- Urgency plus a request for money, credentials, a code, a gift card, a wire or a changed payment destination.
- A link whose visible text differs from its target, or a lookalike domain (one letter off, extra hyphen, odd TLD).
- An attachment that asks to enable macros or to "log in to view".
- Invoice or payment details that differ from the vendor's last known details (see the invoice screen in Step 3).

On `yes` or `unsure`:
- No draft, no reply, no link opened, no attachment opened.
- Log the message under **Suspected scam** with the signal that fired and `outcome: flagged-scam`.
- Ping the review channel immediately when it impersonates a client, a vendor or the owner, or asks for money. Otherwise it goes in the digest.
- Never move it to spam or delete it on the owner's behalf; the owner decides.

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

**One label, one confidence.** Each message gets exactly one intent from the table plus a confidence of `high`, `medium` or `low`. Run this classification on the cheapest Claude model that holds accuracy for it (`model-governor` decides; Haiku-class is usually enough for labelling, drafting stays on the model the run uses). Anything below `high` takes the "flag for owner, no draft" path, with the two candidate intents named in the log. Confidence never rounds up to get a draft out.

**Invoice screen (advisory only).** For an `Invoice / billing` message, add one label, `pay`, `file` or `check`, and one line of reason:
- Compare the payment details in the message (account, IBAN, routing, payee name, remittance address) with the vendor's last known details in the CRM or the previous invoice. A difference is `check` with the flag `bank details changed`, and it also trips the Step 2b gate.
- No vendor record, a first invoice, or an amount outside the agreed scope: `check`.
- Matching details, known vendor, amount inside scope: `pay` with the reason.
- Statements, receipts and confirmations with nothing to pay: `file`.
The label is advice for the owner. This skill never pays, approves, schedules or confirms a payment, and never replies to the sender about payment details.

---

## Step 4 · Draft a reply per message

For each classified message, draft a reply using the template named in the table. Voice rules apply:

- Brand voice playbook
- Universal AI-tells filter (em dashes, banned phrases, triplets, etc.)
- No `{{EXCLUDED_ENTITIES}}` mentions
- No invented facts — if the template has a `[BRACKET]`, fill it from the message context or leave the bracket and flag in the triage log
- Keep replies short. The longer the draft, the more friction in the owner's review.
- **Pricing hold.** If the draft, or the message it answers, mentions price, pricing, a quote amount, discount, refund, money back, credit, warranty or guarantee: still save the draft, but prefix its triage-log entry with `HOLD: pricing`, put the exact sentence in the editor flag, and never fill a number the template did not already carry. Test the keyword match against synonyms the owner uses ("money back" as well as "refund"). If sending is ever enabled for any skill, this hold must become a PreToolUse hook on the send tool (roadmap six-tricks-claude-07), not a prompt rule.

Save the draft via the platform MCP:

```
Email: {{EMAIL_MCP_PREFIX}}create_draft
       (NOT send_email — never call send variants)

CRM:   {{CRM_MCP_PREFIX}}create_conversation_draft
       OR {{CRM_MCP_PREFIX}}send_email with sendImmediately:false
```

---

## Step 5 · Write the triage log

**One ledger line per handled message**, appended to `drafts/replies/triage-ledger.jsonl` before the human-readable log is written. One JSON object per line, fixed keys, so a dashboard or the weekly review can read it without parsing prose:

```json
{"ts":"2026-10-19T09:02:11-04:00","source":"email","sender":"Jane Doe","subject":"Keynote inquiry","intent":"speaking","confidence":"high","scam_gate":"no","quoted":"15000 USD","hold":"pricing","outcome":"drafted","draft":"gmail-drafts"}
```

- `scam_gate`: `no`, `yes` or `unsure`.
- `quoted`: the amount named in the draft or the message, or `none`.
- `hold`: `pricing` or `none`.
- `outcome`: `drafted`, `held`, `flagged-owner`, `flagged-scam`, `skipped-automated`, `error`.
- Sender name and subject only, as in the log: no addresses, no message bodies, no account numbers.

Then save the readable log to `drafts/replies/{YYYY-MM-DD}-triage-log.md`:

```markdown
# Triage log — {YYYY-MM-DD}

## Run summary
- Run time: {HH:MM} {{TIMEZONE}}
- Messages processed: {N}
- Drafts created: {N}
- HIGH priority: {N}
- Skipped (automated): {N}
- Flagged for owner: {N}
- Suspected scam: {N}
- Held (pricing): {N}

## Suspected scam
[sender name, subject, the signal that fired; no draft]

## HIGH priority

### {sender name} — {subject}
- Source: email | crm
- Intent: {category} ({confidence})
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
- Does not commit secrets, tokens, OR PII to the triage log or the ledger. Sender names + subjects only.
- Does not reply to, click inside, or file a suspected scam or phishing message. Flags it; the owner decides.
- Does not pay, approve or confirm an invoice. The invoice screen is advice.

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
