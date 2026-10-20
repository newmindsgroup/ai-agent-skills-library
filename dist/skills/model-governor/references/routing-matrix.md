# Routing Matrix

Version-Timestamp: 2026-09-08 17:50:39 AST

| Task signal | Primary route | Effort and speed | Fallback or gate |
| --- | --- | --- | --- |
| Test, build, lint, search, formatting, or deterministic inspection | Native tool | No LLM first | Route only if interpretation remains needed |
| Bulk extraction, classification, summaries, draft variants | `local-fast` | Low, local | `local-general` if output needs synthesis |
| Private routine analysis or document triage | `local-general` | Medium, local | `local-reasoning` for an independent critique |
| Bounded repository change or first-pass code review | `local-code-fast` | Medium, local | `local-code-deep` when cross-cutting or repeated failures appear |
| Larger refactor or deep code analysis | `local-code-deep` | High, local | Terra or Sol only when live tools or final review are required |
| Screenshot, document image, diagram, or UI visual pass | `local-vision` | Medium, local | Frontier visual review when user-facing approval depends on it |
| Narrow hosted task with clear acceptance criteria | Luna | Light by default, Standard | Terra if scope or ambiguity grows |
| Regular hosted work requiring tools | Terra | Medium, Standard | Astra for hard reasoning or final synthesis |
| Starting orchestration and substantial work | Astra | Low, Standard | Raise to Medium or High when evidence warrants; prefer Fable for substantial independent synthesis/review |
| Security, legal, production, client-facing final gate | Astra or Claude Max review | High, Standard | Verify with real tools and named human approval where required |

Use Fable 5.1 for substantial independent synthesis, critique and review across domains. Use Medium for bounded work and High for complex or consequential work. Use Opus 5 Medium for smaller focused reviews or an explicitly approved substitute. Do not use either to run deterministic checks. Start Astra at Low, then raise effort when needed. Sol remains an alternative. Run Fast only when a user explicitly values latency more than subscription usage.

OpenRouter is never a route selected by default. It requires public or sanitized material, `allow_openrouter = true` in the project policy, a verified free-only configuration, and an explicit user request for that overflow path.
