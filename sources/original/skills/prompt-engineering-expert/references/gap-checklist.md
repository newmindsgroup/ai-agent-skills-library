# Gap Checklist — what to infer, assume, or ask

Version-Timestamp: 2026-06-19

Run this during self-assessment, before drafting. Score the request against all
eight dimensions, then apply the decision rule.

## Dimensions

1. **Objective / definition of done** — what counts as success.
2. **Target model / platform / runtime** — Claude Code agent, Cursor rule, system
   prompt, end-user chat prompt, etc. (sets context window + cost).
3. **Audience & channel** — who reads/consumes the output, and where.
4. **Output shape / format** — prose, JSON, table, sectioned; exact schema if any.
5. **Constraints** — length, style, tone, banned patterns, must-dos/must-nots.
6. **Success criteria / evaluation** — how the output will be judged.
7. **Examples** — any gold/bad examples to anchor on.
8. **Stakes / risk** — low (draft/internal) vs high (client-facing, money, PII).

## Classification

- **✅ Known** — stated by the user, or confidently inferable from the project
  (files, AGENTS.md/CLAUDE.md, recent work).
- **🟡 Assumable** — unstated, but a safe, conventional default exists. Use it and
  state the assumption.
- **🔴 Blocking** — no safe default AND a wrong guess would materially change the
  output.

### Safe-default heuristics (🟡 vs 🔴)
- A dimension is 🟡 when the conventional default is low-regret (e.g. output format
  when the task implies one; tone when the channel is known).
- A dimension is 🔴 when guessing wrong wastes the work (e.g. unknown target model
  for a token-bound prompt; unknown audience for persuasive copy; unknown success
  criteria for an eval prompt; high stakes with ambiguous scope).

## Decision rule

- Any **🔴** → ask those as qualifying questions **before drafting**: batched,
  each with 2–4 concrete options **and a recommended default**, max ~3–4. Never
  open-ended. In Interactive mode, ask one at a time.
- Zero 🔴 → draft now; list 🟡 assumptions.
- User declines/stalls on a 🔴 → take the recommended default, mark it a flagged
  assumption, proceed.

## Worked examples

**Proceeds autonomously** — "Write a prompt to extract action items from meeting
transcripts." Objective ✅, output shape 🟡 (assume JSON list), audience 🟡 (assume
the meeting owner), model 🟡 (assume the current default), stakes ✅ low. Zero 🔴 →
draft + assumptions.

**Must ask** — "Write a prompt for our sales outreach." Objective 🔴 (book a call?
nurture? re-engage?), audience 🔴 (cold? existing?), stakes 🔴 (client-facing).
Three 🔴 → ask 3 batched multiple-choice questions with recommended defaults
before drafting.
