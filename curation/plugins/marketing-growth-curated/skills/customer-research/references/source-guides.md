<!-- Version-Timestamp: 2026-09-14 19:31:32 AST -->
<!-- Local evaluation copy. Quantitative examples require source verification before use. -->
# Customer Research, Source Guides

Detailed, source-by-source playbooks for gathering customer intelligence from online watering holes.

---

## Reddit Research

### Finding the Right Subreddits

Start by identifying where your ICP spends time, not where your product is discussed.

**Discovery methods:**
- Search `site:reddit.com "[job title] tools"` or `site:reddit.com "[problem category] software"`
- Use [subreddit search tools](https://www.reddit.com/subreddits/search) with problem-space keywords
- Look at what subreddits show up in Google results when you search ICP problems
- Check what subreddits competitors' customers mention in reviews

**Common high-value subreddits by category:**
- B2B SaaS: r/sales, r/marketing, r/entrepreneur, r/startups, r/smallbusiness
- Dev tools: r/programming, r/devops, r/webdev, r/cscareerquestions
- Analytics/data: r/analytics, r/dataengineering, r/BusinessIntelligence
- Marketing: r/PPC, r/SEO, r/emailmarketing, r/content_marketing
- HR/recruiting: r/recruiting, r/humanresources, r/jobs
- Finance/ops: r/accounting, r/financialplanning, r/projectmanagement

### Search Operators

```
site:reddit.com/r/[subreddit] "[keyword]"
site:reddit.com "[problem]" "recommend" OR "suggestion" OR "alternative"
site:reddit.com "[competitor name]" "vs" OR "alternative" OR "switched"
```

### What to Look For

**High-signal post types:**
- "What tools do you use for X?" → reveals alternatives and vocab
- "Frustrated with [competitor], looking for alternatives" → reveals pain and switching triggers
- "How do you handle X?" → reveals workflow and workarounds
- "Is [your category] worth it?" → reveals objections and evaluation criteria
- Complaint threads about competitors → reveals gaps you might fill

**What to extract:**
- The exact problem described in the post
- Top-voted solutions (what do practitioners actually recommend?)
- Complaints about existing solutions in comments
- The language used, note specific words and phrases
- Upvote patterns, consensus vs. controversy

### Tools
- Reddit's native search (limited but fast)
- Google: `site:reddit.com [query]` (better results)
- Pullpush.io, search archived Reddit posts (good for older threads)

---

## G2 and Review Site Mining

### Your Own Product Reviews

Inspect mixed ratings and compare the experiences rather than treating one rating as inherently more reliable:

1. **3-star reviews**, look for specific mixed experiences; the rating alone does not establish honesty or retention.
2. **1-star reviews**, understand the failure modes. Separate product issues from support/onboarding issues.
3. **5-star reviews**, extract the "what they love" language. These are candidate quotes, subject to verification, context and permission.
4. **4-star reviews**, often contain "the only thing I wish…" buried in praise.

**What to extract:**
- What they say they use it *for* (the job to be done)
- What they say is hardest or most frustrating
- What they compare it to ("coming from [X]", "better than [Y]")
- Industry and role signals in reviewer profiles

### Competitor Reviews on G2

The 4-star competitor reviews are gold, customers who like the product but still have complaints.

**G2 structure to exploit:**
- "What do you like best?" → their strengths (your battlecard intel)
- "What do you dislike?" → their weaknesses (your opportunities)
- "What problems are you solving?" → the job to be done

**Capterra** has similar structure. **Trustpilot** skews B2C. **AppSumo** reviews are useful for SMB/prosumer SaaS.

### Review Mining Template

For each competitor's 4-star reviews, extract:

| Category | Notes |
|----------|-------|
| Job to be done | Why do they use the product? |
| Top praise | What do they love (and might be hard for you to match)? |
| Top complaint | What frustrates them? |
| Switching context | Did they mention switching from something else? |
| Unmet need | "I wish it could…" or "It would be better if…" |

---

## Indie Hackers and Product Hunt

### Indie Hackers

Strong signal for founder/builder/SMB ICP.

**Where to look:**
- "Ask IH" posts: questions about problems your product solves
- Milestone posts: when founders describe their stack, they reveal tool preferences and pain
- Comment threads on product launches in your category

**Search:** `site:indiehackers.com "[problem]"` or use IH's native search.

### Product Hunt

**Discussion tabs** on competing products are a research goldmine:
- Questions asked = pre-sales concerns = objections
- Comments = early adopter reactions = leading indicators of reception
- "Alternatives to X" collections reveal the competitive landscape as users see it

---

## Hacker News

Strong signal for technical/developer ICP. Skews toward builders and skeptics.

**High-value searches:**
- `site:news.ycombinator.com "[competitor or category]"`
- HN "Ask HN: best tools for X" threads
- "Show HN" posts for competitors, read the skeptical comments

**What's different about HN:**
- Users are more likely to critique underlying architecture and business model
- Strong opinions about pricing models (especially anything subscription-based)
- First principles objections you might not hear elsewhere

---

## LinkedIn Research

### Posts and Comments

Search for posts by practitioners describing their workflows:
- "[Role] at [company size]" + problem keyword
- "We used to [old way] but now we [new way]" stories
- Posts asking for tool recommendations get comments from active buyers

### Job Postings

A job posting may suggest an organizational need, but may be aspirational or routine. Validate the inference before treating it as current pain.

**What to look for:**
- What tools are listed as "nice to have" vs. "required"? (reveals stack and adjacent tools)
- What metrics and outcomes are mentioned in the role description?
- What does the role spend most of its time doing? (reveals the job to be done)

**Search:** `site:linkedin.com/jobs "[role title]" "[relevant tool or category]"`

---

## YouTube Comments

### Finding High-Signal Videos

- Tutorial videos for problems your product solves
- "Best tools for X in [year]" roundup videos
- Competitor product demos and walkthroughs

**What to look for in comments:**
- "Does this work for [specific use case]?" → edge cases and unmet needs
- "I tried this but…" → failure points
- "What about [competitor]?" → active evaluation
- Timestamps with questions → confusion points in the workflow

---

## Twitter / X Research

### Search Operators

```
"[competitor]" -filter:replies min_faves:10
"[problem keyword]" "anyone know" OR "recommend" OR "alternative"
"[category] is broken" OR "frustrated with [category]"
```

### What to Find

- Real-time complaints about competitors
- Practitioners discussing their stack
- Influencers/thought leaders your ICP follows (useful for distribution)

---

## Blog Post and Forum Research

### Comparison Content

Google: `"[competitor 1] vs [competitor 2]"` or `"best [category] software [year]"`

Read the comments on these posts, people who find comparison content are actively evaluating. Their comments are questions your sales process should answer.

### Niche Communities

- **Slack communities**: Many industries have public or semi-public Slack groups. Search "[industry] Slack community".
- **Discord servers**: Growing for developer and creator communities.
- **Facebook Groups**: Still strong for SMB, e-commerce, agency, and coach/consultant ICP.
- **Circle/Mighty Networks communities**: Check if there are paid communities in your ICP's space.

---

## B2C and Consumer App Research

B2C research requires different sources than B2B SaaS. Consumer buyers don't congregate on LinkedIn or G2, they leave traces in app stores, social media, and communities built around the activity your product serves.

### App Store Reviews (iOS App Store / Google Play)

One of the richest unfiltered sources for mobile/consumer products.

**Read in this order:**
1. **1-2 star reviews**, failure modes, unmet expectations, frustration peaks
2. **3-star reviews**, honest tradeoffs and "it's good but…" feedback
3. **5-star reviews**, what they love in their own words (proof points and positioning)

**What to extract:**
- What job they hired the app to do ("I use this to…")
- The moment it stopped working for them
- What they compared it to or switched from
- Emotional language, "I love how…", "I'm so frustrated that…"

**Search tip:** Sort by "Most Recent" to get fresh signal, then "Most Critical" for pain themes.

### Amazon Reviews (for physical products or software with Amazon presence)

Same priority order as app stores: 3-star reviews first.

**G2 analog for consumer SaaS**: Trustpilot, Sitejabber, and product-specific review aggregators.

### Reddit Consumer Communities

B2C Reddit is highly vertical, go to the hobby/lifestyle subreddit, not the general ones.

**Examples by product type:**
- Fitness apps: r/running, r/loseit, r/fitness, r/MyFitnessPal
- Personal finance: r/personalfinance, r/financialindependence, r/ynab
- Productivity/notes: r/productivity, r/Notion, r/ObsidianMD
- Travel: r/travel, r/solotravel, r/digitalnomad
- Parenting: r/Parenting, r/beyondthebump, r/daddit

**Search pattern:** `site:reddit.com/r/[community] "[app name OR problem]"`

### TikTok and Instagram Comments

High-signal for consumer products with visual/lifestyle appeal.

**How to find signal:**
- Search TikTok for "[product name] review" or "is [product] worth it"
- Watch the top 5-10 videos; read ALL comments, not just likes
- On Instagram, check tagged posts from real users (not brand posts)

**What to extract:**
- Questions in comments = unmet needs or unclear positioning
- "Does this work for…?" = jobs they want to hire it for
- "I switched from X" comments = switching triggers
- Complaints about price, missing features, or broken promises

### YouTube Comments (Consumer)

Same approach as B2B but different video types:

- "X app honest review" or "X app after 6 months"
- "Best [category] apps [year]" comparison videos
- Unboxing or "setup" videos for hardware/physical products

Comments on review videos are especially valuable, these are people actively in the consideration phase.

### Consumer Community Platforms

- **Facebook Groups**: Still dominant for many consumer verticals (parenting, fitness, local services, hobbies)
- **Discord servers**: Growing for gaming, creator tools, productivity, crypto, lifestyle communities
- **Nextdoor**: Useful for local service businesses
- **Quora**: Long-form questions reveal decision anxiety and evaluation criteria

---

## SparkToro (Audience Intelligence)

SparkToro is a behavioral audience research tool. Instead of mining individual posts and comments, it aggregates clickstream, search, and social data to show what your audience does at scale, what they read, watch, listen to, follow, and search for.

### When to Use SparkToro vs. Manual Research

- **SparkToro first** when you need to understand where your ICP spends time, what content they consume, and which influencers they follow, it answers these questions in seconds with aggregated data
- **Manual research first** (Reddit, G2, communities) when you need raw language, exact quotes, emotional context, and the "why" behind behavior
- **Best together**: Use SparkToro to identify which podcasts, subreddits, and websites matter, then go mine those sources manually for voice-of-customer language

### Key Queries to Run

**By competitor:**
- "People who follow @competitor", reveals shared audience affinities
- "People who visit competitor.com", shows what else they consume

**By audience description:**
- "People who frequently talk about [topic]", finds audience behaviors
- "People whose bio contains [job title]", profiles a role-based segment

**By your own audience:**
- "People who visit yourdomain.com", understand your actual audience
- Compare against competitor audience profiles to find gaps

### What to Extract

| Data Type | What It Tells You | Use It For |
|-----------|------------------|------------|
| Top websites visited | Where your audience reads | Content partnerships, guest posting targets |
| Top podcasts | What they listen to | Podcast guesting, sponsorship decisions |
| Top YouTube channels | What they watch | Video content strategy, ad placements |
| Top subreddits | Where they discuss | Community participation, Reddit ad targeting |
| Search keywords | What they Google | SEO and content topic planning |
| AI prompt topics | What they ask AI tools | Emerging content opportunities |
| Social accounts followed | Who influences them | Influencer partnerships, co-marketing |
| Demographics | Who they are | Persona building, ad targeting |

### Evaluate the source before use

Audience-tool output is a possible research input, not an automatic confidence grade. Verify current capabilities, access, collection methods, sample coverage, recency and limitations in the provider's documentation. Availability of aggregated data does not establish that it represents the target audience or explains motivation.

Provider pricing, free limits, APIs and available fields change. Check them when needed rather than relying on this guide. Tool use and any data transfer need the applicable authorization.

---

## Organizing Your Research

Use a simple tagging system across all sources:

| Tag | Meaning |
|-----|---------|
| `#pain` | A problem or frustration |
| `#trigger` | An event that prompted the search |
| `#outcome` | What success looks like |
| `#language` | Exact phrases worth using in copy |
| `#alternative` | Another solution they considered or use |
| `#objection` | Reason to hesitate or not buy |
| `#competitor` | Anything about a competing product |

Keep a running doc with columns: Source | Date | Quote | Tags | Notes

Group findings by the underlying person, organization or event before counting independent evidence. A repost, syndicated article or quotation of the same anecdote is not independent confirmation. The same wording across unrelated websites can be duplication.

## Evidence strength

For every inference, state the independent-source count, recruitment/selection method, segment coverage, prompting, contradictory evidence and recency. Source type is a clue to possible bias, not a confidence grade. Interviews can be selectively recruited; reviews can overrepresent strong opinions; support tickets describe reported problems; job postings can describe aspirations rather than current pain.

Example: "One of two independently interviewed owners reported reporting friction. The other was satisfied. The sample is too small and its recruitment too unclear to infer market prevalence." Preserve the contrary finding instead of averaging it away.

Treat older evidence in relation to changes in the product and market. Recency alone does not prove reliability, and repetition over time does not prove independence. Name what additional evidence would change the decision. Do not invent persona attributes or force a numeric confidence score.
