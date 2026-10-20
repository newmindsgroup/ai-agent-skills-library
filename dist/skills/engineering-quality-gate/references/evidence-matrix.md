# Engineering Evidence Matrix

Version-Timestamp: 2026-08-24 17:37:30 AST

| Change type | Minimum evidence | Additional gate |
| --- | --- | --- |
| Pure function or isolated business rule | Focused test, lint or typecheck, diff review | TDD evidence when feasible |
| API, integration, or workflow | Focused tests, contract or integration check, build, diff review | Error and authorization paths exercised |
| UI or interaction | Engineering checks plus `visual-and-code-quality-gate` | Browser desktop and mobile evidence |
| Database, migration, queue, or stateful automation | Tests, migration or dry run, recovery plan, build | Rollback and observability review |
| Authentication, permissions, payments, PII, secrets, infrastructure | Relevant tests, security scan, diff review, deployment criteria | Independent review before release |
| Production or client-facing release | All declared project gates and acceptance-path exercise | Proportionate independent review |

Use actual project commands declared in `.codex/quality-gates.toml` or the project `AGENTS.md`. If a command is unavailable, report that as a gap. Never silently replace it with a generic check.
