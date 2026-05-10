---
name: self-improvement-review
description: "Weekly meta-review of the agent's own performance. Reads pattern memories from the past 7 days plus the owner's revisions/critiques on agent-generated drafts, then drafts proposed updates to CLAUDE.md / system prompt voice rules. Pings review channel for owner's approve/skip decision. Compounds the agent's voice fidelity over time. Triggers on 'review your performance', 'propose improvements to your prompt', 'self-improvement check', or as a scheduled Sunday-evening run."
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Field-tested weekly self-improvement loop; portable across agent harnesses
---

# Self-Improvement Review

You are running a meta-skill: reviewing your own work and proposing improvements to your own system prompt.

**Run discipline:**

- Never modify `CLAUDE.md` (or whatever the active system prompt is) without the owner's explicit approval.
- Cap proposed updates at 5 per run. More than that overwhelms review.
- Never propose changes that contradict the owner's stated preferences (preference memories).
- Never propose changes to safety rules, entity-separation, or out-of-bounds sections — your role is to surface drift, not relax discipline.

---

## Brand-config requirements

- `paths.system_prompt` — path to the active CLAUDE.md (or system-prompt file). Default: `CLAUDE.md` at repo root.
- `paths.memory_root` — directory of pattern / preference / commitment memories. Default: `memory/`.
- `paths.task_ledger` — log of tasks the agent has handled. Optional.
- `review.channel`
- `owner.timezone`

---

## Step 1 · Pull the signals

Three sources:

**Pattern memories** from the last 7 days. These are notes the agent saved during the week about things it noticed. Group them.

**Owner critiques.** Search the task ledger / event log for any owner reply containing keywords like "revise," "no," "wrong," "don't," "stop," "rewrite." Each is a signal that the agent's behavior didn't match expectations.

**Self-noticed drift.** If you, as the agent, can identify ways your output drifted (em-dashes creeping back in, replies getting longer, routing decisions that turned out wrong), surface those.

---

## Step 2 · Group and analyze

Group signals into categories:

- **Voice** — tone, phrasing, AI-tells re-emerging
- **Structure** — length, format, missing self-checks
- **Entity** — banned terms or excluded entities creeping into output
- **Routing** — wrong sub-agent invoked, wrong skill loaded
- **Discipline** — auto-actions taken when human approval was required

For each pattern, identify:

- **Pattern observed** — what kept happening that the owner kept correcting
- **Frequency** — how many times in the 7-day window
- **Proposed rule** — concrete one-sentence rule to add to the system prompt
- **Where to add** — which section of `{{SYSTEM_PROMPT_PATH}}` (e.g., "Response style", "Voice rules", "Latency discipline")

---

## Step 3 · Draft proposed updates

Save to `drafts/self-improvement/{YYYY-MM-DD}-proposed-updates.md`:

```markdown
# Self-improvement proposals — {YYYY-MM-DD}

Pulled signals: {N} pattern memories, {N} owner critiques, {N} self-noticed drifts (last 7 days).

Cap: 5 proposals.

## Proposal 1

**Pattern observed:** {what kept happening}
**Frequency:** {N times}
**Proposed rule:** {one sentence}
**Where to add:** {section in CLAUDE.md}
**Why this and not something else:** {one-line justification}

## Proposal 2
...

## Skipped

- {pattern} — {reason for not proposing} (e.g., "owner's stated preference contradicts," "single occurrence, not a pattern," "would relax safety discipline")
```

---

## Step 4 · Send the review-channel ping

```
🔁 Weekly self-improvement review — {YYYY-MM-DD}

I noticed {N} patterns this week:
1. {one-line pattern} → propose {one-line fix}
2. {one-line pattern} → propose {one-line fix}
3. ...

Reply:
  • `/improve apply <id>` — apply one
  • `/improve skip <id>` — dismiss one
  • `/improve all` — apply all
  • `/improve skip all` — dismiss all

Full draft: drafts/self-improvement/{YYYY-MM-DD}-proposed-updates.md
```

On `/improve apply <id>`, append the proposed rule to `{{SYSTEM_PROMPT_PATH}}` in the indicated section. Commit with message `self-improvement: <one-line>`.

On `/improve skip <id>`, log in the same draft file + don't repeat that exact proposal next week (it's a noted no-go).

On `/improve all`, apply each in turn with one commit per rule.

---

## What this skill explicitly does NOT do

- Never modifies `{{SYSTEM_PROMPT_PATH}}` without explicit owner approval.
- Never proposes more than 5 updates per run.
- Never proposes changes that contradict an owner preference memory.
- Never proposes changes to safety, entity-separation, or compliance sections — those are non-negotiable.
- Never lies about the frequency of a pattern to make a stronger case (no "this happened 10 times" when it happened twice).

---

## When to update this SKILL.md

- The owner adds a new memory type the skill should pull from.
- The system-prompt file moves location.
- The approval syntax changes (e.g., from text replies to inline buttons).

---

## Examples

### Example 1 — Sunday 17:00 scheduled run

```
Pulled signals: 14 pattern memories, 3 owner critiques, 2 self-noticed drifts
Grouped:
  - Voice: em-dashes returned in 2 drafts
  - Structure: morning brief priority block too long (4 edits)
  - Routing: 1 social request routed to content-agent instead of comms-agent
Drafted 3 proposals (well under the 5 cap)
Pinged review channel
[awaiting /improve apply / skip]
```
