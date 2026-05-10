---
name: competitive-monitor
description: "Daily scan of curated competitor / peer / inspiration sites for new posts, pricing changes, positioning shifts, and hiring signals. Diffs each fetch against the previous snapshot and surfaces material changes via the review channel. Compounds intel without manual checking. Triggers on 'competitive scan', 'check competitor changes', 'monitor [domain]', or as a scheduled daily run."
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Field-tested daily competitive-intel workflow; portable across deployment environments
---

# Competitive Monitor

You scan a curated list of competitor, peer, and inspiration sites and surface meaningful changes. Read-only. Insight-first, dump-last.

---

## Brand-config requirements

- `paths.competitor_targets` — path to a markdown file listing target sites (default: `competitive-targets.md` at repo root)
- `review.channel` — for RED/AMBER alerts
- `owner.timezone`
- (optional) `competitive.scan_frequency` — defaults to daily
- (optional) `competitive.target_count` — defaults to 5–10

If `paths.competitor_targets` doesn't exist, the skill creates a starter file with example entries and asks the owner to fill it in.

---

## What you read

The competitor-target list. Format:

```markdown
# Competitive targets

## Tier 1 — direct competitors
- {Brand name} — {URL} — {one-line why we track}
  Pages: /, /services, /pricing, /blog

## Tier 2 — peers / inspiration
- {Brand name} — {URL} — {one-line why we track}
  Pages: /, /work

## Tier 3 — adjacent / aspirational
- {Brand name} — {URL} — {one-line why we track}
  Pages: /
```

5–10 entries works best. More than 15 and the daily noise overwhelms the signal.

If RSS feeds are exposed for any target (most blogs do), include those for richer diffs.

---

## What you do

For each target site:

1. WebFetch the configured pages (homepage + /services + /blog or whatever's listed).
2. Compare against yesterday's snapshot at `reports/competitive/{YYYY-MM-DD-1}-snapshot.json`.
3. Flag changes:
   - **🔴 RED**: pricing change, new offer, new positioning headline, executive announcement, fundraise, partnership announcement
   - **🟠 AMBER**: new blog post, new case study, new hire, content cadence shift, new public-facing page
   - **🟢 GREEN**: no material change

---

## Output rules

- Save raw snapshot to `reports/competitive/{YYYY-MM-DD}-snapshot.json` (URL → first 4096 chars of fetched HTML, normalized — strip whitespace, comments, dynamic timestamps).
- Save changes summary to `reports/competitive/{YYYY-MM-DD}-changes.md` with:
  - One section per target with detected changes
  - Quote the changed text (before/after)
  - One-line implication for the brand's positioning
- Send `{{REVIEW_CHANNEL}}` if RED/AMBER changes detected:
  ```
  *Competitive intel — {YYYY-MM-DD}*

  🔴 *{Target name}* — new pricing on services page
  Was: "$15K minimum"
  Now: "$10K starting"
  → Implication: pricing pressure in our segment.

  🟠 *{Target name}* — published a 4000-word post on "voice AI for consulting"
  → Implication: angle to consider differentiating against.
  ```
- If nothing material: silent. No spam on GREEN-only days.

---

## Hard rules

- **Read-only.** Never click, fill forms, or interact with target sites.
- **Respect robots.txt.** If a target's robots.txt disallows the path, skip and log.
- **Rate-limit yourself.** 1 request per second per domain max. Spread the scan across 5+ minutes if needed.
- **No scraping logged-in / paid content.** Public, unauthenticated pages only.
- **Don't store images, videos, full HTML.** First 4096 chars of normalized text per page.
- **Don't quote anything more than 30 words from a target page.** Summarize the rest.

---

## When to update this SKILL.md

- The target list grows past 15 — split into multiple targeted scans.
- A target consistently produces false positives (dynamic headers, A/B tests) — refine the normalization step.
- The brand wants the scan to focus on a specific signal (e.g., only pricing changes) — narrow Step 3.

---

## Examples

### Example 1 — daily 07:00 run, 5 targets, 1 AMBER

```
Pulled 14 pages across 5 targets
Diffed against yesterday's snapshot
Findings: 1 AMBER (Target #3 published a new case study)
Saved snapshot + changes file
Pinged review channel with the AMBER summary
```

### Example 2 — daily run, all GREEN

```
Pulled 14 pages, no material changes
Saved snapshot
Stayed silent — no spam
```
