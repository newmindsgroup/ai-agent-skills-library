# Prompt Anti-Patterns ("smells") — scan and fix before finalizing

Version-Timestamp: 2026-06-19

| Smell | Fix |
|-------|-----|
| Vague role ("you are a helpful assistant") | Name the expertise + tone. |
| No output format | Specify shape (prose/JSON/table) + example. |
| Conflicting instructions | Remove or reconcile; state precedence. |
| Unbounded length | Set a hard limit (words/tokens/items). |
| Untestable success criteria | Add a pass/fail checklist + test inputs. |
| Buried key instruction | Move the critical rule to its own line near the top. |
| Over-stuffed context | Summarize or move to attachments/retrieval. |
| No examples when the task is nuanced | Add 1 gold (and 1 bad) example. |
| PII left inline | Mask to roles/placeholders. |
| "Don't" without "do" | Pair each prohibition with the desired behavior. |
