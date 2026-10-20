---
name: model-governor
description: Select the lowest-cost safe model, effort, and speed for a substantive task using sensitivity, task shape, risk, urgency, and tool requirements. Use for model choice, token conservation, provider fallback, local versus subscription routing, or cross-project LLM policy.
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
---

# Model Governor

Version-Timestamp: 2026-10-01 20:49:21 AST

Classify the task before routing. Treat the following as hard boundaries:

- Use deterministic tools before an LLM when the task is a test, search, format, build, lint, or mechanical transformation.
- Keep restricted, confidential, and bulk material local unless the user explicitly authorizes an approved external provider for that data.
- Never automatically enable OpenRouter, paid APIs, or CCR. OpenRouter is allowed only after its separate free-only and privacy gate.
- Never use Fast, Extra High, Ultra, or parallel subagents by default.

Run the included classifier when a task is non-trivial or ambiguous:

```bash
python3 scripts/route-task.py --task "<task>" --privacy internal --risk medium --format text
```

Astra Low Standard is the starting orchestrator; raise to Medium or High when task evidence warrants it. Terra handles routine work and Luna handles narrow hosted tasks. Prefer Fable 5.1 for substantial independent synthesis and review across domains, and Opus 5 for smaller focused reviews. Availability is caller-declared, not quota telemetry. On quota failure, checkpoint first, mark OpenAI unavailable, and select an approved Claude or suitable local route. Never retry a state-changing task automatically.

Read [the routing matrix](references/routing-matrix.md) before overriding a classifier result. Use a project `.codex/model-routing.toml` when present, but do not allow it to weaken the hard boundaries above.

Return the decision in this compact form: route, model, effort, speed, why, data boundary, fallback, and re-evaluation trigger. Escalate only when task scope expands, evidence conflicts, tests fail, tools are required, or the outcome becomes security, legal, production, or client-facing.

## Skill selection

Include one primary skill only when it supplies a concrete method the task needs. Skip skills for deterministic work. Add a second only for a distinct phase such as final verification. Never load broad skill collections or stack overlapping generic skills, because instructions consume context and can make a worker less focused.

## Evidence and measurement

Supply `--artifact code|visual|content|analysis|mechanical` when known, `--failed-attempts N` for actual unsuccessful attempts, and `--requires-live-tools` when needed. These add requirements without weakening privacy/risk. The classifier is deterministic, not self-learning. Read [tool-routing.md](references/tool-routing.md) only for the relevant provider recipe; current global policy takes precedence over historical recipe wording.

Use a stable opaque milestone ID with `codex-claude-review --task-id ID --phase approach|milestone`. Duplicate evidence is refused; at most two calls per phase, including uncertain/failed attempts. Never change the ID just to bypass the budget. After substantial tasks, record approved metadata through `scripts/routing_ledger.py` in the configuration source. Evaluate ten real outcomes before changing defaults; do not repeat paid tasks to manufacture metrics.

## Receiving-stage check

Version-Timestamp: 2026-09-10 14:16:48 AST

For each substantive stage, classify the receiving task afresh. A skill is a method, not a permanently assigned model. Prefer the exact project capability entry over a generic keyword suggestion. Assess its required inputs, expected artifact, ambiguity, risk, data destination, available tools and acceptance criteria. Keep missing prerequisites and partial external actions visible. Mechanical subtasks still use native tools.

Use the existing classifier with `--stage STAGE-ID --skill-entry /absolute/path/SKILL.md` and explicit artifact/privacy/risk signals. `--skill-entry` requires `--stage`; it checks a UTF-8 regular SKILL.md file with one plain frontmatter name and a one MiB size limit. It records the resolved path and SHA-256 of the parsed bytes. Names are self-declared, not publisher verification. Recheck the hash and read the full skill before use. Paths can be explicit authorized local paths, including resolved symlinks; no directory trust or permission is inferred.

The selection override changes only the primary-skill label. Model, effort, privacy, completion and review gates remain conservative. Analysis about code need not invoke a coding method. If the named skill needs additional safeguards, retain those too. Reject an unsuitable skill rather than treating a CLI result as proof of relevance.

Store the recommendation in the existing stage/work record alongside actual model/effort, runtime evidence, input readiness, checks, fallback and reason for any departure. The CLI's actual model remains unverified and model_switched false because it performs no launch; this says nothing about other actors. The agent must establish actual runtime separately. If the current model is suitable, keep it with a reason; otherwise use an authorized supported handoff. Never claim prose switched an active model.

Reassess at the next stage, changed scope/data/tools, failed checks or unavailable capacity. Preserve permissions and review budgets. No fixed quality winner, automatic quota telemetry, automatic skill invocation or guaranteed optimal model is provided. Evaluate real outcomes before revising shared defaults.

## Quality-first app profile

Version-Timestamp: 2026-10-01 20:08:45 AST

For owner-selected app projects, `[development] quality_first = true` selects
GPT-6.1 Sol Medium for explicitly bounded code only when `availability.sol_current = true`
records verified access on the exact execution path. Otherwise use Astra Medium.
Complex or ambiguous app work uses Astra Medium. Security, authentication, authorization,
permissions, PII, migrations, payments and release work uses Astra High.
Keep privacy, native tools and shared quota rules above intact. This profile is
provisional; measure ten real tasks per role before another default change.
Public benchmarks do not establish a universal mobile-stack winner or prove the
chosen efforts optimal. The router does not switch an active task.

For app code, the current review choice is explicit `claude-opus-5-5`, Medium
for focused changes and High for complex or consequential changes. Fable keeps
the general substantial synthesis role. New Claude 5.5 routes require CLI 2.1.287
and a billing receipt within 24 hours; a selectable UI model is not CLI proof.
Record approved provider and data per task. Set `--touches-sensitive-surface` when
planned files or behavior touch secrets, signing, identity, privacy or permissions;
this structured signal raises effort without relying on task wording. Classifiers
are advisory and cannot inspect every changed path or authorize confidential data.

For approved public/internal app tasks without a project policy, the machine-local
profile is `~/.codex/app-development-routing.toml`. Use:
`llm-route --dry-run --project-policy ~/.codex/app-development-routing.toml --artifact code "task"`.
Prefer the project's `.codex/model-routing.toml` when present, and pass the actual
privacy/risk rather than relying on the machine default. This profile grants no
data approval. Do not add "simple" or "small" to reduce task difficulty. Launch a
fresh session only after preserving state; existing desktop turns stay unchanged.
