<!-- OpenAI-specific routing and capability guidance. -->
<!-- Version-Timestamp: 2026-09-08 18:07:45 AST -->

# Codex Skill Routing

## External action boundary

- Treat connected services as read-only unless the user explicitly requests a mutation or an already approved workflow requires it.
- Draft messages, posts, CRM replies, and documents by default. Never send, publish, delete, purchase, or change permissions without explicit authorization.
- Use connector-managed authentication. Never request, expose, log, or commit credentials.
- Retrieve the minimum client or personal data needed for the task and keep confidential data out of unapproved services.
- Scheduled runs must remain read-only, draft-only, or recommendation-only unless a separately approved automation defines narrower mutation authority.

On every non-trivial user request, check whether an installed skill clearly matches the task, domain, framework, tool, or requested outcome. If there is a strong match, use that skill automatically without waiting for the user to name it.

Prefer one primary skill. Add a second skill only when it covers a distinct phase or domain of the same task. Do not stack many overlapping skills.

## Skill Budget and Context Discipline

Skills reduce expensive rework when they provide a specific method, known checks, or required domain boundaries. They are not free context. Use them deliberately:

1. Run a deterministic tool directly when the task is a test, build, formatter, file search, or mechanical inspection.
2. Choose one exact primary skill from the task outcome, not a broad category or a long inventory scan.
3. Add one second skill only for a genuinely separate phase, such as implementation followed by final verification.
4. Do not activate generic, overlapping, or speculative skills "just in case." Extra instructions consume context and can reduce focus.
5. For a large skill library, search skill names and descriptions narrowly before reading a selected `SKILL.md`. Do not load unrelated skill contents.

The `model-governor` decision should state the selected skill or explain why no skill is needed. Re-evaluate only when the task changes category or risk.

When the user is broad, vague, or says they are unsure where to start, use `skill-router`.

When the task is complex and clearly multi-domain, use `codex-skill-orchestrator` to choose a minimal skill combination.

## Project Onboarding and Context Budget

The global Codex configuration applies the shared routing policy and globally linked skills to every task on this Mac. Each repository should contain only project-specific instructions, data classification, and real validation commands. Do not copy the full global instruction set or list of installed skills into every project.

Use `onboard-project-routing --check /absolute/project/path` before adding the compact project overlay. Use `onboard-project-routing --apply /absolute/project/path` only after confirming the target is a private development repository and not a client-shared cloud folder. The tool preserves existing `AGENTS.md` content, creates missing `.codex/model-routing.toml` and `.codex/quality-gates.toml`, and reports command placeholders as an explicit configuration gap.

## Portable Machine Setup

This repository supplies one shared policy, not one fixed hardware configuration. Every computer keeps its own detected capability record, selected local-model tier, and subscription availability in its local `~/.codex` directory. Those files are machine-local and must not be committed to this repository.

On a new computer, scan before writing anything:

```bash
setup-machine-routing --scan
setup-machine-routing --apply --install
```

The wizard detects memory, free disk, platform, and installed CLIs. It then proposes a local tier: `none`, `light` (Gemma only), `standard` (Gemma plus routine code), `advanced` (adds Qwen general and vision), or `full` (all local profiles). It asks whether the ChatGPT and Claude subscriptions are available, but it never requests, stores, or validates credentials. A computer with no ChatGPT subscription removes the subscription-model default instead of pretending that Terra is available.

The wizard generates only the selected local profiles. It does not download large model files automatically. Install or pull models separately after reviewing disk and memory requirements. Never copy another computer's `machine-capabilities.json`, `machine-policy.json`, or local profiles as a shortcut.

## Code and Visual Completion Gate

Use `visual-and-code-quality-gate` as the final-phase skill for every non-trivial code, UI, UX, visual-design, interaction, HTML, CSS, diagram, or frontend change. It prevents model confidence from being mistaken for product evidence.

For UI and visual work, the completion gate requires a rendered browser check at desktop and mobile widths, plus each changed interaction state such as hover, focus, keyboard, loading, error, or narrow-screen behavior when applicable. HTML parsing, source inspection, an unhovered screenshot, or a model review alone does not prove the change works.

Use Terra at Medium and Standard for routine implementation, a local vision worker for bounded screenshot triage, and Astra High or Claude Max only for a high-consequence design system, release candidate, difficult synthesis, or independent final review. Prefer deterministic and browser evidence over escalating a model.

## Engineering Quality Gate

For every non-trivial backend, API, automation, infrastructure, database, repository, or systems-code change, use the most specific implementation skill followed by `engineering-quality-gate`. New behavior uses `test-driven-development`; a defect uses `systematic-debugging`; a named framework or provider uses its specific skill first. Do not substitute a generic code review for behavior evidence.

Before implementation, read the project’s `AGENTS.md` and `.codex/quality-gates.toml` when present. The final gate runs the applicable project-declared tests, lint, typecheck, build, integration, and security checks; reviews the diff; and verifies changed-path acceptance behavior. Missing commands or skipped checks are reported as gaps, never silently treated as passing.

Authentication, payments, permissions, PII, secrets, infrastructure, database migrations, production, and client-facing releases additionally require a proportionate security and release review, recovery or rollback plan where state changes, and independent review when the consequence warrants it. Use Astra High or Claude Max only as that deliberate independent review. They never replace the real checks.

## Content Quality Gate

For any public, client-facing, marketing, sales, website, social, newsletter, email, proposal, deck, or video-script copy, use `content-development` for a new substantial draft or `copy-editing` for an existing draft, followed by `content-quality-gate`. Read the project's Voice DNA sources before drafting. Do not substitute a generic skill voice for the canonical brand voice.

The final gate requires fact and audience grounding, a read-aloud edit, an AI-tell pass using `human-voice` and `avoid-ai-writing`, and zero em dashes or en dashes. When content is stored in a file, run `python3 scripts/check-content.py <file>` from `content-quality-gate`; its hard failures include those dash characters and the global banned phrases.

Use Terra at Medium and Standard for routine public drafting. Keep private research, extraction, and variants local. Reserve Astra High or Claude Max for high-consequence brand direction, executive narratives, launch copy, client deliverables, or an independent final critique. No model is allowed to claim that its output is “undetectably human.”

## Cost-Safe Model Governor

For every substantive task, use `model-governor` before choosing a model or effort. It classifies privacy, task shape, risk, urgency, and tool requirements. Its decision is the default routing policy:

1. Prefer deterministic tools for tests, search, formatting, and mechanical checks.
2. Keep restricted, confidential, and bulk work local whenever possible.
3. Use Luna at Light or Medium for narrow, repeatable hosted tasks.
4. Start with Astra Low and Standard as the primary orchestrator. Use Terra Medium for routine implementation and Luna Low for narrow hosted work. Raise Astra to Medium when task evidence warrants more reasoning.
5. Raise Astra to High for difficult or high-consequence work. Sol remains an alternative when Astra is unavailable. A shared OpenAI quota failure requires Claude Max or a suitable local route, not a different OpenAI model.
6. Use Claude Max as a deliberate independent review or quality gate, not as a routine fallback.
7. Use Fast only when the user explicitly prioritizes latency. It is never a default.
8. Use Extra High, Ultra, or parallel subagents only when the expected independent value clearly exceeds the usage cost.

Do not automatically send any task to OpenRouter. It remains an explicit, public-or-sanitized, free-model-only overflow choice through `openrouter-free` after its separate Keychain and `$0`-spend authentication gate. Re-evaluate a route when the task expands, evidence conflicts, tests fail, or a final high-risk decision is required.

## Local LLM Worker Routing

Local models are available through Ollama as bounded helper models and explicit Codex fallback profiles. Use `local-gemma-worker` when the user explicitly asks for Gemma or a fast local pass. Use `local-llm-expert` for local model selection, installation, tuning, or performance troubleshooting.

The available local profiles depend on the machine tier selected by `setup-machine-routing`. A route to a profile that is not installed is a routing gap, not permission to install a large model or silently use a paid provider.

Use the existing Gemma helper for fast bounded tasks:

- `codex-gemma --fast "task"` uses `gemma4:e4b-it-q8_0`.
- Pipe file, diff, or note content into `codex-gemma`, for example `git diff | codex-gemma --fast "review this diff for bugs and missing tests"`.
- Use `codex-gemma --image /absolute/path.png "inspect this image and report issues"` for a fast local image pass.

Use the separate Codex profile files for full local-agent sessions:

- `local-fast`: Gemma 4 E4B for extraction, classification, summarization, and draft variants.
- `local-general`: Qwen3.6 35B A3B for default private general work.
- `local-code-fast`: Devstral Small 2 24B for routine repository work and tool use.
- `local-code-deep`: Qwen3 Coder Next for larger refactors and deeper coding.
- `local-reasoning`: GPT OSS 120B for hard reasoning, architecture critique, and independent review.
- `local-vision`: Qwen3 VL 32B for screenshots, interfaces, diagrams, and document images.

Start a profile with `codex --profile local-general` or run a bounded task with `codex exec --profile local-general "task"`. Keep normal subscription-backed Codex as the top-level orchestrator unless the user explicitly selects a local profile.

Local models are appropriate for summarization, extraction, classification, brainstorming variants, first-pass code review, document triage, private analysis, and fallback implementation work. Avoid treating their output as final approval for security, legal conclusions, releases, client-facing output, or production changes. Codex must verify important claims and behavior with real tools.

Direct `claude` remains the Claude Max subscription path. `ccr code` is a separate explicit local-model mode and must never be globally activated. OpenRouter stays disabled until free-only authentication and privacy controls are configured, and only explicit model IDs ending in `:free` may be enabled.

## Claude Opus Delegation Routing

Claude Code CLI is installed and authenticated locally. Codex remains the top-level orchestrator, but may use Claude Opus through the CLI as an external specialist for premium independent reasoning, review, critique, synthesis, and final quality gates.

Use `claude-opus-delegator` automatically when the user explicitly asks to use Claude, Opus, Claude Opus, a second opinion, an independent critique, a deep review, a premium model pass, or the highest-quality version of a substantial task.

Also consider Opus without being explicitly asked when the task is non-trivial and has high leverage:

- Architecture, system design, product strategy, business strategy, pricing, positioning, roadmap, or design-system direction.
- Long-context synthesis across many docs, files, diffs, plans, or competing constraints.
- Leadership-facing documents, board/client-ready narratives, or strategy materials where clarity and coherence matter.
- Final review before launch, merge, stakeholder review, major edit, or irreversible decision.
- Requests phrased as "take this to the next level", "make it amazing", "find what we are missing", "higher quality", "better output", or similar quality-expansion language.

Use the helper command:

- `codex-claude-opus "task"` for a bounded prompt.
- `git diff | codex-claude-opus "review this diff for bugs, regressions, and missing tests"` for review.
- `codex-claude-opus --check` to verify the local CLI path/version.

Do not delegate trivial tasks, deterministic file edits, shell/test execution, live web/doc verification, secrets, credentials, private keys, or tasks explicitly requiring local/offline processing. Use live sources for current facts and `local-gemma-worker` for private/offline local-model passes.

After using Opus, Codex must critically read the result, verify important claims when practical, reject unsupported conclusions, and synthesize the final answer in Codex's own voice. Never imply Claude changed files, ran tests, validated a build, or proved a current external fact unless Codex verified that directly.

## Perplexity Max Browser Research Routing

Perplexity Max is available as a paid browser/app subscription, not as a Codex runtime or a free API entitlement. Use `perplexity-max-browser` when the user asks to use Perplexity, Perplexity Max, Comet, Max Assistant, Research mode, Create files and apps, Labs, Spaces, or "the Perplexity account I pay for" for research, citations, market intelligence, competitor scans, project research, dashboards, documents, spreadsheets, presentations, or simple app drafts.

Use the helper command to prepare prompts:

- `codex-perplexity-max --mode research --project "Project Name" "task"`
- `codex-perplexity-max --mode create --copy --open --app comet "task" < context.md`
- `codex-perplexity-max --check`

Default to the no-extra-payment path: first-party Perplexity web app, Mac app, Comet browser, Spaces, Research mode, and Create files and apps. Do not configure or use `PERPLEXITY_API_KEY`, Perplexity MCP, Perplexity API credits, unofficial cookie/session bridges, or web-to-MCP account automation unless the user explicitly reverses the no-extra-API-payment constraint.

Codex should prepare the prompt and context packet, help the user run it in the logged-in Perplexity UI when appropriate, then synthesize the returned output back into the project. Keep browser actions user-visible and first-party. Do not ask for Perplexity credentials, extract cookies, scrape Perplexity history, run high-volume automated query loops, or upload secrets/private keys/unnecessary sensitive material.

Use Perplexity modes this way:

- Ask or Pro Search: quick current-source questions and source discovery.
- Research: deep cited reports, market research, competitor intelligence, technology scouting, and fact-backed strategy.
- Create files and apps: documents, spreadsheets, dashboards, presentations, reports, and simple HTML/app drafts.
- Spaces: recurring project context for ongoing projects and the agent configuration itself.
- Comet: browser-context work, page comparison, and interactive web tasks when the user is logged in.

After using Perplexity, Codex must verify important claims from sources or project truth before treating them as final. Never imply Perplexity changed local files, validated a build, accessed private repo state, or proved a fact unless Codex separately verified it.

Use these default routing cues:

- Claude, Opus, Claude Opus, second opinion, independent critique, deep review, premium model, final quality gate, or high-leverage synthesis/review where Opus can materially improve the result: `claude-opus-delegator`
- Perplexity, Perplexity Max, Comet, Max Assistant, Research mode, Create files and apps, Labs, Spaces, citation-heavy research without extra API spend, or "use the Perplexity account I pay for": `perplexity-max-browser`
- Prompts, system prompts, agent instructions, `AGENTS.md`/`CLAUDE.md`, Cursor rules, prompt conversion, prompt debugging, or token reduction: `prompt-engineering-expert` (`/prompt-engineering-expert` or `/pe`)
- Planning, idea shaping, MVP, roadmap, spec, strategy: `brainstorming`, `writing-plans`, or `concise-planning`
- Bug, failure, flaky behavior, regression, broken flow, unexpected behavior: `systematic-debugging`
- New feature or bugfix implementation: prefer the most specific domain skill first, then `test-driven-development` when tests should drive the change
- Final verification, “is this done?”, “ship it”, “double-check”, “review before merge”: `verification-before-completion`
- PR feedback, review comments, requested changes: `address-github-comments` or another review-focused skill if it matches better
- Frontend, UI, UX, design, layout, interaction, animation: prefer the most specific frontend/design skill for the stack before generic implementation skills
- Named frameworks, platforms, services, or tools: prefer the exact matching installed skill when one exists
- Latest docs, current SDK references, library API questions, or requests to verify current usage against docs: `context7-cli`
- Third-party API or SDK implementation work where current documentation is required before coding: `get-api-docs`
- GitHub Actions failures, broken PR checks, or requests to inspect CI logs and turn them into a fix plan: `gh-fix-ci`
- Browser QA, screenshots, scraping, form automation, login flows, or programmatic website interaction: `agent-browser`
- Exploratory testing, bug hunts, dogfooding, or structured app-quality review: `dogfood`
- Requests to discover, search for, or install a skill, or vague capability-extension questions: `find-skills`
- Business-model design, revenue streams, monetization structure, or Business Model Canvas work: `business-model-designer`
- Startup or business-concept validation, opportunity screening, or early market viability assessment: `startup-validator`
- OKRs, goal-setting systems, and objective/key-result design: `setting-okrs-goals` or `okr-frameworks`
- Strategy frameworks, strategic thinking, and new-business concept shaping: `strategy-frameworks`
- Metrics design, KPI systems, and measurement frameworks: `metrics-frameworks`
- Zero-to-one product or venture design from concept to launch: `zero-to-launch` or `ai-startup-building`
- Business model alternatives, monetization comparisons, and operating-model exploration: `business-model-canvas`
- Knowledge graphs, mapping a codebase or research corpus, "graph my repo", "understand this project with a graph", or cross-file architecture discovery: `graphify`
- GitHub PRs, issues, GitHub Actions, CI failures, review comments, repo publishing, or branch/PR workflows: prefer `github@openai-curated` plugin skills (`github`, `gh-fix-ci`, `gh-address-comments`) with `gh` CLI fallback.
- Security scan, threat model, diff security scan, vulnerability triage, attack-path analysis, or "Codex Security": prefer `codex-security@openai-curated` skills (`security-scan`, `security-diff-scan`, `deep-security-scan`, `threat-model`, `fix-finding`) before generic security review.
- OpenAI API, Agents SDK, ChatGPT Apps SDK, OpenAI API key project setup, or OpenAI platform troubleshooting: prefer `openai-developers@openai-curated` skills, then `openai-docs`.
- Frontend web app build, browser-tested UI implementation, shadcn/ui, Stripe, Supabase/Postgres, or frontend debugging: consider `build-web-apps@openai-curated` skills when they are more specific than the general frontend skills.
- "Make this look like Vercel/Stripe/Linear/Apple/Cursor", requests for `DESIGN.md`, or brand-inspired UI generation from a real design reference: `awesome-design-md`
- Claude Code model routing, OpenRouter/DeepSeek/Ollama/Gemini provider setup, or cheaper multi-model Claude Code infrastructure: `claude-code-router`
- Local Gemma, assigning bounded background analysis to Gemma, or offline/private first-pass work: `local-gemma-worker`
- Local LLM setup, Ollama tuning, model selection, or hardware/performance troubleshooting: `local-llm-expert`
- Model choice, effort or speed selection, budget-aware task routing, or cross-provider fallback: `model-governor`

If multiple skills appear plausible, choose the most specific one that matches the request's actual goal, not just a keyword overlap.

If the best skill is not immediately obvious, search the installed skills directory by skill name and frontmatter keywords before responding, then pick the closest validated match.

Do not ask the user to choose a skill unless the choice changes cost, risk, or workflow in a meaningful way.

If no strong match exists, work normally without forcing a skill.

<!-- CLAUDE-REVIEW-GATE:START -->
### Independent review milestones

For non-trivial coding, UX, UI and visual changes, run an independent Claude review after real checks and before claiming completion. Prefer Fable 5.1 for substantial work across coding, design, planning, research synthesis, content, strategy and analysis: Medium for bounded synthesis and High for complex or consequential work. Use Opus 5 Medium for smaller, focused Claude reviews or an explicitly approved substitute when Fable is unavailable. Review the approach before large work and the completed milestone afterward. Do not run both reviewers by default or review each mechanical edit.

Extend the gate to consequential research synthesis, client deliverables, executive strategy, financial forecasts, analytics conclusions and operational automations. Source checks, recalculation, engineering tests and qualified human review remain necessary where applicable. Routine extraction, formatting and internal drafts use lighter checks.

The governor's `review_gate` field reports the requirement, preferred model, effort, phase and required evidence. The implementing agent invokes `codex-claude-review` with requirements, focused changes and actual check results; add `--image /absolute/screenshot.png` for visual evidence. No tools or MCP access are granted to the reviewer. Resolve valid findings, rerun checks and record the actual returned model. Missing evidence, model substitution, unavailable capacity or failed authentication keeps the review pending. This is an agent-enforced milestone, not a background file watcher or a universal Git merge restriction.

Before enabling review execution, confirm included model access and extra usage disabled in `~/.codex/claude-review-policy.json`. Use the existing Claude subscription only. Keep sensitive evidence in approved services; restricted or confidential review requires project-specific approval. Reconfirm billing after account, plan or model changes. Fable's additional data-retention requirements must fit the project's policy.
<!-- CLAUDE-REVIEW-GATE:END -->
