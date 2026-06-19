# Model Guide — task → model

Version-Timestamp: 2026-06-19

Recommend a model in ≤2 sentences, justified by the task. Default to the latest,
most capable model for the platform in use. Pick by task type, not habit.

## Claude (default for Claude Code work)
- **Opus 4.8** — hardest reasoning: architecture, strategy, deep multi-step
  analysis, ambiguous problems.
- **Sonnet 4.6** — balanced default for agent + coding work; strong quality at
  lower cost/latency.
- **Haiku 4.5** — cheap, fast classification, extraction, and lightweight drafts.
- **Fable 5** — latest-family model; consider for its current strengths when its
  positioning fits the task.

## OpenAI (when targeting GPT)
- Use the current flagship GPT tier for general execution and the current
  reasoning tier for STEM/logic/exacting math. Use a mini tier for low-cost
  drafts and high-volume Q&A. (Confirm current model names at build time.)

## Google (when targeting Gemini)
- Use the current Gemini Pro tier for large-context document synthesis and the
  current Flash tier for fast, low-cost work. (Confirm current names at build time.)

## Selection heuristics
- **Largest context need** → pick the model with the biggest reliable window, but
  prefer retrieval/summarize-first over pasting everything inline.
- **Cost-sensitive, well-defined task** → smallest model that clears the quality bar.
- **High stakes / ambiguous** → most capable reasoning model.
- Re-evaluate when the task type changes mid-project.
