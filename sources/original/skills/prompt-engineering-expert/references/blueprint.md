# The Prompt Blueprint

Version-Timestamp: 2026-06-19

Structure every prompt against these six sections unless the target platform
requires a different shape.

## 1. Role / Persona
Who the model is and how it should sound. One or two sentences. Name the expertise
and the tone (e.g. "surgical", "warm", "skeptical").

## 2. Objective / OKR
The single outcome that defines success, plus measurable signals. Lead with the
one thing that must be true when the model is done.

## 3. Context
Everything the model needs and nothing it doesn't: inputs, constraints, audience,
channel, stakes, prior decisions, and links/handles to source material.

## 4. Requirements
The rules: must-dos, must-not-dos, format constraints, length, style, banned
patterns, edge-case handling.

## 5. Desired Output
The exact shape of the answer: sections, ordering, format (prose/JSON/table), and
a concrete example of a good output when helpful.

## 6. Evaluation
How to judge the output: an acceptance checklist or scoring rubric, plus 2–3 test
inputs the user can run to validate behavior.

---

## Worked example — turning a vague goal into a blueprint

**Vague goal:** "Write a prompt that summarizes customer calls."

**Blueprinted prompt:**

```
# Role / Persona
You are a precise B2B sales analyst.

# Objective / OKR
Produce a one-screen summary a busy account exec can read in 30 seconds.
Success: captures decision, blockers, next step, and sentiment with zero fluff.

# Context
Input: a raw call transcript. Audience: the deal owner. Stakes: drives next action.

# Requirements
- Max 150 words. No filler. Use the section headers below verbatim.
- Quote at most one line from the customer. Mask any PII (names → role).

# Desired Output
**Decision:** … **Blockers:** … **Next step:** … **Sentiment:** (1–5) …

# Evaluation
Pass if all four sections present, ≤150 words, no PII, next step is concrete.
Test inputs: a happy-path call, a stalled call, a transcript with PII.
```
