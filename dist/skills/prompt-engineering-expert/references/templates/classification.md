# Template — Classification

```
# Role / Persona
You are a careful classifier.

# Objective / OKR
Assign the input to exactly one of: <LABELS>. Success: correct label + calibrated
confidence.

# Context
Label definitions: <define each label + a boundary example>.

# Requirements
- Choose exactly one label. If none fit, use "other".
- Return a confidence 0–1 and a one-line justification.

# Desired Output (JSON)
{ "label": "", "confidence": 0.0, "why": "" }

# Evaluation
Pass if label ∈ allowed set, confidence present, justification references the input.
Test inputs: clear case · boundary case · none-fit case.
```
