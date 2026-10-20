---
name: content-quality-gate
description: Apply the canonical brand voice, remove AI tells and dash characters, and require factual and audience-specific editorial review before public or client-facing copy is considered ready.
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
---

# Content Quality Gate

Version-Timestamp: 2026-08-24 17:25:03 AST

Use as the final-phase skill for copy that a customer, prospect, client, audience, or stakeholder will read. It complements `content-development` or `copy-editing`. It is not an AI detector. It creates direct evidence that the copy follows the established voice and avoids known tells.

## Before drafting

1. Read the project Voice DNA source of truth: the voice playbook at `{{BRAND_PLAYBOOK_PATH}}` (see `brand-config.yml`), then any precedence chain the project `AGENTS.md` defines. If none exists, ask for the voice source before drafting; do not invent one.
2. Establish audience, purpose, desired action, offer, proof, and approved facts. Do not manufacture specificity, customer results, quotes, or claims.
3. Use `content-development` for a new substantial piece or `copy-editing` for an existing draft. Use only one as the primary skill.

## Required editorial passes

1. **Voice pass:** lead with the real point. Use direct language, concrete nouns, short sentences, and a cadence a human would say aloud.
2. **Evidence pass:** distinguish verified facts from opinion or promise. Replace vague claims with approved proof, a concrete example, or a narrower statement.
3. **AI-tell pass:** use `human-voice` and `avoid-ai-writing` to remove template openings, filler transitions, adjective stacks, automatic triplets, hedging, generic conclusions, and hype.
4. **Punctuation pass:** zero em dashes (`—`) and en dashes (`–`) in human-facing copy. Use periods, commas, parentheses, or “to” for ranges. Hyphens remain valid only in genuine compound terms such as “client-facing.”
5. **Read-aloud pass:** rewrite sentences that are hard to say, feel inflated, or could fit any company. Do not publish copy merely because it is grammatically correct.
6. **Mechanical pass:** run `python3 scripts/check-content.py <file>` when the draft is stored in a file. Resolve every hard failure before saying the content is ready.

## Model route

- Private research, source extraction, outlines, and variants: local workers first.
- Routine public draft with a clear brief: Terra, Medium, Standard.
- High-consequence brand direction, executive narrative, client deliverable, launch copy, or final independent critique: Sol High or Claude Max deliberately, after the brief and facts are ready.
- A premium model improves judgment and synthesis. It does not replace the editorial passes above.

## Completion evidence

State the voice source used, the intended audience and action, the fact basis, the result of the dash and banned-phrase scan, and whether a human read-aloud or owner review remains. Never claim that a model made content “undetectably human.”
