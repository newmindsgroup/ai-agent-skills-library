# Evidence Matrix

Version-Timestamp: 2026-08-24 16:41:09 AST

| Change type | Minimum proof | Escalate when |
| --- | --- | --- |
| CSS or UI behavior | Browser render of the changed state at desktop and mobile widths | The interaction affects a conversion path, accessibility, or a client-facing release |
| Component logic | Focused test plus lint or typecheck | State handling, a public API, or shared component behavior changes |
| Feature or workflow | Relevant test suite, build, and acceptance-path exercise | It writes data, moves money, changes permissions, or affects customers |
| Visual system or design direction | Rendered comparison against `DESIGN.md` or tokens, plus accessible interaction check | It will become a reusable client or company standard |
| Security or production release | Relevant automated checks, diff review, and independent review | Always use the project's release or security gate |

The right answer is not always a stronger model. Prefer direct evidence first. Use Sol High or Claude Max only for difficult synthesis, high-consequence judgment, or an independent final review.
