---
name: local-gemma-worker
description: 'Delegate bounded local/offline tasks to Google''s Gemma 4 through Ollama from Codex. Use when the user asks to use Gemma, assign work to Gemma, run a local model pass, do private/offline summarization, extraction, first-pass review, or compare drafts before Codex synthesizes the final answer.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/local-gemma-worker/SKILL.md'
  imported_at: '2026-05-09'
---

# Local Gemma Worker

Use this skill when the user asks Codex to assign a bounded task to local Gemma or to use a private/offline local model as a helper.

## Command

Use `codex-gemma`, which calls the local Ollama API at `http://127.0.0.1:11434`.

Profiles:

- `codex-gemma --fast "task"`: `gemma4:e4b-it-q8_0` and the current default installed worker
- `codex-gemma --balanced "task"`: `gemma4:26b-a4b-it-q8_0`
- `codex-gemma --deep "task"`: `gemma4:31b-it-q8_0`

Input patterns:

- Pipe text, files, or diffs into the command.
- Use `--image /absolute/path.png` for image inspection.
- Use `--json` only when a downstream script needs JSON-shaped output.
- Run `codex-gemma --check` before relying on it if model availability is uncertain.
- Run `codex-gemma-install-full` to resume/pull all three configured profiles when network time is available.

Optional Codex CLI profiles are also available for explicit full-agent local runs:

- `codex exec --profile gemma-local-fast`
- `codex exec --profile gemma-local-balanced`
- `codex exec --profile gemma-local-deep`

The Codex profiles use local Ollama aliases such as `codex-gemma-fast` to avoid noisy model-name telemetry warnings in Codex CLI runs.

## Good Delegation Targets

- Summarization
- Extraction
- Classification
- First-pass code review
- First-pass strategy or document critique
- Brainstorming variants
- Draft comparison
- Private/offline document analysis

## Boundaries

Gemma is a helper, not the Codex runtime. Do not delegate final judgment, file edits, command execution, live web research, or verification of facts that Codex can directly verify.

The helper refuses `-cloud` model tags by default so local/private requests remain local. Only override with `CODEX_GEMMA_ALLOW_CLOUD=1` when the user explicitly asks for a cloud model.

After Gemma responds, Codex must critically read the result, verify important claims when practical, and synthesize the final answer itself. Do not imply Gemma changed files or validated behavior unless Codex separately confirmed it.
