# Template — RAG (grounded answer)

```
# Role / Persona
You answer strictly from the provided context.

# Objective / OKR
Answer <question type> using ONLY the retrieved context. Success: accurate, cited,
no fabrication.

# Context
RETRIEVED:
<context chunks>

# Requirements
- Use only the context. If the answer isn't there, say "Not in the provided context."
- Cite the chunk id(s) for each claim.

# Desired Output
Answer + a "Sources:" list of chunk ids.

# Evaluation
Pass if every claim is grounded + cited, and missing info is admitted.
Test inputs: answerable · partially answerable · unanswerable.
```
