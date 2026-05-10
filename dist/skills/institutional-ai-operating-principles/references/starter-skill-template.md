---
name: drafting-client-proposals
description: Drafts client proposals and scopes of work for New Minds Group engagements. Use whenever the user asks to write, draft, outline, or revise a proposal, RFP response, SOW, engagement letter, or project brief. Produces a structured document with assumptions, deliverables, timeline, pricing placeholders, and a clear handoff to the account lead.
version: 1.0.0
---

# Drafting Client Proposals

This is an **example skill** showing the exact shape every New Minds skill should take. Copy this file, rename the folder, and replace the body to create a new one.

## When to trigger this skill

The user's request mentions any of: "proposal", "RFP", "scope of work", "SOW", "engagement letter", "project brief", "statement of work", "pitch deck outline".

## Required inputs

Before drafting, confirm you have or ask for:

1. **Client name and industry**
2. **Engagement type** (UX audit, redesign, research, ongoing retainer, etc.)
3. **Known budget range or pricing model** (fixed, retainer, T&M)
4. **Timeline constraint**, if any
5. **Stakeholders and decision-makers**

If any of these are missing and material, ask for the single most important one, then proceed on reasonable defaults for the rest and flag them.

## Workflow

1. **Pull context first.** Check connected tools (Google Drive, Notion, Trello) for prior engagements with this client. If found, match the tone, scope shape, and pricing model from the most recent one.
2. **Identify the economic leverage point** (McKinsey theme 2): what is the one business outcome this engagement most improves for the client? State it in one sentence at the top.
3. **Write the proposal** using the structure below.
4. **Flag risks** in a dedicated section. Do not hide them.
5. **Declare handoff:** who reviews this next, and what's the deadline.

## Proposal structure

```
# [Client Name] — [Engagement Title]
Prepared by New Minds Group | [Date] | v[0.1]

## Executive summary
[One paragraph. What problem, what outcome, what investment.]

## Objectives
- Business outcome: [revenue, margin, retention, acquisition — be specific]
- Measurable success criteria: [numbers]

## Scope of work
### In scope
### Out of scope  ← always include this section

## Deliverables
| # | Deliverable | Format | Owner |

## Timeline
| Phase | Dates | Milestones |

## Team and roles
## Investment
[Placeholder. Account lead fills in.]

## Assumptions
## Risks and dependencies
## Next steps and handoff
```

## Guardrails

- Never invent client history, prior work, or testimonials.
- Never commit to a delivery date without confirming with the account lead.
- Never include pricing numbers. Leave `[ACCOUNT LEAD TO CONFIRM]` placeholders.
- Every deliverable line item must map to at least one objective.

## Examples

**Trigger:** "Draft a proposal for Acme Co. — they want a UX audit of their checkout flow."
**Expected behavior:** Skill activates. Agent asks one clarifying question (budget or timeline, whichever is more material). Produces the structured draft above, with placeholders for pricing and account-lead sign-off.

**Trigger:** "Write an SOW for the ongoing design retainer with BlueHouse."
**Expected behavior:** Skill activates. Agent searches connected tools for prior BlueHouse engagements, matches structure, and drafts the SOW in the same voice.

## Handoff

After drafting, output:

> **Ready for review by:** [account lead name]
> **Suggested next step:** [review → client send / revise / combine with deck]
> **Worth remembering:** [any new durable fact learned about the client]
