# OpenAI Codex bundled system skills

- Source folder: `sources/openai-codex-bundled-system-skills/`
- Source type: `runtime`
- Skill count: 3
- Repository: OpenAI Codex bundled system skills
- Note: Bundled with the local Codex runtime rather than imported from a public repo.

Canonical skill folders remain under `../../skills/`.

## Skills

| Skill | Category | Description | Source path |
|---|---|---|---|
| [`imagegen`](../../skills/imagegen/) | AI, Agents, LLMs, Data | Generate or edit raster images when the task benefits from AI-created bitmap visuals such as photos, illustrations, textures, sprites, mockups, or transparent-background cutouts. Use when Codex should create a brand-new image, transform an existing image, or derive visual variants from references, and the output should be a bitmap asset rather than repo-native code or vector. Do not use when the task is better handled by editing existing SVG/vector/code-native assets, extending an established icon or logo system, or building the visual directly in HTML/CSS/canvas. | `~/.codex/skills/.system/imagegen/SKILL.md` |
| [`openai-docs`](../../skills/openai-docs/) | AI, Agents, LLMs, Data | Use when the user asks how to build with OpenAI products or APIs and needs up-to-date official documentation with citations, help choosing the latest model for a use case, or model upgrade and prompt-upgrade guidance; prioritize OpenAI docs MCP tools, use bundled references only as helper context, and restrict any fallback browsing to official OpenAI domains. | `~/.codex/skills/.system/openai-docs/SKILL.md` |
| [`plugin-creator`](../../skills/plugin-creator/) | AI, Agents, LLMs, Data | Create and scaffold plugin directories for Codex with a required `.codex-plugin/plugin.json`, optional plugin folders/files, and baseline placeholders you can edit before publishing or testing. Use when Codex needs to create a new local plugin, add optional plugin structure, or generate or update repo-root `.agents/plugins/marketplace.json` entries for plugin ordering and availability metadata. | `~/.codex/skills/.system/plugin-creator/SKILL.md` |
