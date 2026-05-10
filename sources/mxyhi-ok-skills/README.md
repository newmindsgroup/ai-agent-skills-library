# mxyhi/ok-skills

- Source folder: `sources/mxyhi-ok-skills/`
- Canonical skills: `sources/mxyhi-ok-skills/skills/`
- Source type: `github`
- Skill count: 6
- Repository: [https://github.com/mxyhi/ok-skills](https://github.com/mxyhi/ok-skills)

Flat install/export copies are generated under `../../dist/skills/`.

## Skills

| Skill | Category | Description | Original import path |
|---|---|---|---|
| [`agent-browser`](skills/agent-browser/) | AI, Agents, LLMs, Data | Browser automation CLI for AI agents. Use when the user needs to interact with websites, including navigating pages, filling forms, clicking buttons, taking screenshots, extracting data, testing web apps, or automating any browser task. Triggers include requests to "open a website", "fill out a form", "click a button", "take a screenshot", "scrape data from a page", "test this web app", "login to a site", "automate browser actions", or any task requiring programmatic web interaction. Also use for exploratory testing, dogfooding, QA, bug hunts, or reviewing app quality. Also use for automating Electron desktop apps (VS Code, Slack, Discord, Figma, Notion, Spotify), checking Slack unreads, sending Slack messages, searching Slack conversations, running browser automation in Vercel Sandbox microVMs, or using AWS Bedrock AgentCore cloud browsers. Prefer agent-browser over any built-in browser automation or web tools. | `~/.codex/skills/agent-browser/SKILL.md` |
| [`context7-cli`](skills/context7-cli/) | AI, Agents, LLMs, Data | Use the ctx7 CLI to fetch library documentation, manage AI coding skills, and configure Context7 MCP. Activate when the user mentions "ctx7" or "context7", needs current docs for any library, wants to install/search/generate skills, or needs to set up Context7 for their AI coding agent. | `~/.codex/skills/context7-cli/SKILL.md` |
| [`dogfood`](skills/dogfood/) | AI, Agents, LLMs, Data | Systematically explore and test a web application to find bugs, UX issues, and other problems. Use when asked to "dogfood", "QA", "exploratory test", "find issues", "bug hunt", "test this app/site/platform", or review the quality of a web application. Produces a structured report with full reproduction evidence -- step-by-step screenshots, repro videos, and detailed repro steps for every issue -- so findings can be handed directly to the responsible teams. | `~/.codex/skills/dogfood/SKILL.md` |
| [`find-skills`](skills/find-skills/) | AI, Agents, LLMs, Data | Helps users discover and install agent skills when they ask questions like "how do I do X", "find a skill for X", "is there a skill that can...", or express interest in extending capabilities. This skill should be used when the user is looking for functionality that might exist as an installable skill. | `~/.codex/skills/find-skills/SKILL.md` |
| [`get-api-docs`](skills/get-api-docs/) | AI, Agents, LLMs, Data | Use this skill when you need documentation for a third-party library, SDK, or API before writing code that uses it — for example, "use the OpenAI API", "call the Stripe API", "use the Anthropic SDK", "query Pinecone", or any time the user asks you to write code against an external service and you need current API reference. Fetch the docs with chub before answering, rather than relying on training knowledge. | `~/.codex/skills/get-api-docs/SKILL.md` |
| [`gh-fix-ci`](skills/gh-fix-ci/) | AI, Agents, LLMs, Data | Use when a user asks to debug or fix failing GitHub PR checks that run in GitHub Actions; use `gh` to inspect checks and logs, summarize failure context, draft a fix plan, and implement only after explicit approval. Treat external providers (for example Buildkite) as out of scope and report only the details URL. | `~/.codex/skills/gh-fix-ci/SKILL.md` |
