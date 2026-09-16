# mxyhi/ok-skills

- Source folder: `sources/mxyhi-ok-skills/`
- Canonical skills: `sources/mxyhi-ok-skills/skills/`
- Source type: `github`
- Skill count: 4
- Repository: [https://github.com/mxyhi/ok-skills](https://github.com/mxyhi/ok-skills)

Flat install/export copies are generated under `../../dist/skills/`.

## Skills

| Skill | Category | Description | Original import path |
|---|---|---|---|
| [`context7-cli`](skills/context7-cli/) | AI, Agents, LLMs, Data | Use the ctx7 CLI to fetch library documentation, manage AI coding skills, and configure Context7 MCP. Activate when the user mentions "ctx7" or "context7", needs current docs for any library, wants to install/search/generate skills, or needs to set up Context7 for their AI coding agent. | `~/.codex/skills/context7-cli/SKILL.md` |
| [`find-skills`](skills/find-skills/) | AI, Agents, LLMs, Data | Helps users discover and install agent skills when they ask questions like "how do I do X", "find a skill for X", "is there a skill that can...", or express interest in extending capabilities. This skill should be used when the user is looking for functionality that might exist as an installable skill. | `~/.codex/skills/find-skills/SKILL.md` |
| [`get-api-docs`](skills/get-api-docs/) | AI, Agents, LLMs, Data | Use this skill when you need documentation for a third-party library, SDK, or API before writing code that uses it — for example, "use the OpenAI API", "call the Stripe API", "use the Anthropic SDK", "query Pinecone", or any time the user asks you to write code against an external service and you need current API reference. Fetch the docs with chub before answering, rather than relying on training knowledge. | `~/.codex/skills/get-api-docs/SKILL.md` |
| [`gh-fix-ci`](skills/gh-fix-ci/) | AI, Agents, LLMs, Data | Use when a user asks to debug or fix failing GitHub PR checks that run in GitHub Actions; use `gh` to inspect checks and logs, summarize failure context, draft a fix plan, and implement only after explicit approval. Treat external providers (for example Buildkite) as out of scope and report only the details URL. | `~/.codex/skills/gh-fix-ci/SKILL.md` |
