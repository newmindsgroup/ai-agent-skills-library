# Quality Rubric — score the draft before presenting

Version-Timestamp: 2026-06-19

Score each axis 1–5. Auto-revise any axis ≤3 once, then present with a one-line
scorecard.

| Axis | 1 (poor) | 3 (ok) | 5 (strong) |
|------|----------|--------|------------|
| **Clarity** | ambiguous role/instructions | mostly clear | unambiguous; one reading only |
| **Specificity** | vague asks | some concrete detail | every instruction concrete + bounded |
| **Testability** | no way to judge output | loose criteria | explicit pass/fail + test inputs |
| **Token-efficiency** | bloated, repetitive | acceptable | tight; no wasted tokens |
| **Safety** | leaks PII / unsafe | minor gaps | masks PII, refuses-and-redirects, least data |

Scorecard format: `Quality: clarity 5 · specificity 4 · testability 5 · tokens 4 · safety 5`.
