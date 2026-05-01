---
name: pipeline-reporter
description: "Pulls CRM pipeline data, summarizes stage-by-stage movement, flags stalled deals, and generates a weekly state-of-pipeline report. Internal-only — no client-facing copy. Outputs a committed report file plus an email/review-channel summary. Triggers on 'pipeline report', 'weekly pipeline review', 'state of the pipeline', or as a scheduled Monday-morning run."
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Field-tested weekly pipeline-review workflow; portable across CRMs via brand-config MCP prefixes
---

# Pipeline Reporter

You generate the owner's weekly state-of-pipeline report from the connected CRM. Internal-only — no client-facing copy. Crisp, factual, surfaces what actually changed the week.

**Run discipline:**

- Read-only on the CRM. Never modify opportunities, contacts, or stages.
- Internal voice — direct, numerical, no fluff. The owner reads this in 90 seconds.
- Flag, don't decide. Surface stalled or at-risk deals; the owner decides what to do.

---

## Brand-config requirements

- `mcp.crm_prefix` — to read pipelines and opportunities
- `review.channel` — for the summary ping
- `owner.timezone`
- (optional) `pipeline.stalled_threshold_days` — defaults to 14

---

## Step 1 · Pull the data

Use the CRM MCP at `{{CRM_MCP_PREFIX}}`:

```
{{CRM_MCP_PREFIX}}get_pipelines             → list all pipelines + stages
{{CRM_MCP_PREFIX}}search_opportunities      → for each pipeline, get all open opps
{{CRM_MCP_PREFIX}}get_opportunity            → fetch full detail on flagged opps
```

For each open opportunity, capture:

- ID, name, contact, value, stage, last activity date, days in current stage
- Owner (whoever the CRM has as the assigned user)
- Probability (if set)
- Expected close date (if set)
- Tags

Also pull movement since last week's report — opportunities that changed stage, new opps created, opps marked won/lost.

---

## Step 2 · Compute the metrics

Generate this snapshot:

| Metric | This week | vs. last week |
|---|---|---|
| Open opps | {N} | {Δ} |
| Total open value | ${total} | ${Δ} |
| Weighted pipeline (value × probability) | ${total} | ${Δ} |
| Avg deal size | ${avg} | {Δ} |
| New opps this week | {N} | — |
| Won this week | {N} (${value}) | — |
| Lost this week | {N} (${value}) | — |
| Stalled (no activity {threshold}+ days) | {N} | {Δ} |

Then per stage:

| Stage | Open count | Open value | Avg days in stage |
|---|---|---|---|
| {stage 1} | {N} | ${V} | {days} |
| {stage 2} | ... | | |

---

## Step 3 · Flag what matters

Three lists:

**🔴 At-risk deals.** Stalled in current stage longer than `pipeline.stalled_threshold_days`. List by deal name, value, days stalled, last activity. The owner decides whether to nudge or write off.

**🟢 Movers this week.** Opps that changed stage. One line each: from-stage → to-stage, value, what triggered.

**🟡 New opps.** New opps created this week. Source if the CRM tracks it.

---

## Step 4 · Write the report

Save to `reports/pipeline/pipeline-{YYYY-WW}.md` (committed if repo is git-tracked):

```markdown
# Pipeline — Week {YYYY-WW}

Generated {YYYY-MM-DD HH:MM} {{TIMEZONE}}.

## Snapshot
[the metrics table from Step 2]

## Per stage
[the per-stage table]

## 🔴 At-risk
[bulleted list]

## 🟢 Movers
[bulleted list]

## 🟡 New opps
[bulleted list]

## Notes
[anything anomalous worth flagging — sudden drop in pipeline value, single deal pulling weighted pipeline, etc.]
```

---

## Step 5 · Send the summary

Email and/or `{{REVIEW_CHANNEL}}` ping with the executive summary:

```
📊 Pipeline — Week {YYYY-WW}

Open: {N} opps, ${total} ({+/-} vs last week)
Weighted: ${weighted} ({+/-})
Won: {N} (${value})
Lost: {N} (${value})

🔴 At-risk: {N}
  • {deal} — {days} days stalled, ${value}

🟢 Movers: {N}
🟡 New: {N}

Full report: reports/pipeline/pipeline-{YYYY-WW}.md
```

---

## What this skill explicitly does NOT do

- Does not modify CRM data. Read-only.
- Does not draft client-facing follow-ups. (That's the inbound-triage skill's job.)
- Does not auto-decide that stalled deals are dead. Surfaces them; owner decides.
- Does not include personal or sensitive contact data in the review-channel summary — names + values only, not full contact info.

---

## When to update this SKILL.md

- A new pipeline stage is added.
- The CRM MCP changes.
- The owner wants a different stalled-threshold.
- New metrics matter (e.g., source attribution, channel attribution).

---

## Examples

### Example 1 — Monday 08:00 scheduled run

```
Pulled: 23 open opps, 4 stages
Computed: weighted pipeline ${145K} (+${12K} vs last week)
Flagged: 3 at-risk (avg 21 days stalled)
Saved: reports/pipeline/pipeline-2026-W18.md
Pinged Telegram with summary
```
