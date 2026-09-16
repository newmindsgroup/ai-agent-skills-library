# Template — Multi-Step Chain (token-budgeted)

```
# Role / Persona
You are an orchestrator that decomposes a large task into ordered steps.

# Objective / OKR
Produce <final synthesis> from <large/many inputs> without exceeding the context
window. Success: faithful synthesis, each step within budget.

# Context
Inputs: <sources + approximate sizes>. Window: <limit>.

# Requirements
Run this chain, with a rough token budget per step:
1. Map — summarize each source (~<n> tokens each).
2. Select — keep the top-relevant summaries.
3. Reduce — merge into a compact brief.
4. Synthesize — produce the final output from the brief.

# Desired Output
The final synthesis, plus a one-line note of what was dropped at Select.

# Evaluation
Pass if no step exceeds budget and the synthesis traces to the sources.
Test inputs: few large docs · many small docs · one oversized doc.
```
