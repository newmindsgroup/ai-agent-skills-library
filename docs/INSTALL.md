# Detailed install guide

The one-line `install.sh` handles every supported IDE automatically. This doc is for teammates who want to understand what it's doing, or who use a tool the installer doesn't cover (Claude Projects, ChatGPT Custom GPTs, Gemini Gems).

This repo keeps canonical skills organized by source under `sources/<source-folder>/skills/`. The installer uses the generated flat export at `dist/skills/`, because IDEs expect `<skills-root>/<skill-name>/SKILL.md`.

## Native Agent Skills support

These tools read the Agent Skills format directly from the folder the installer writes to. Nothing else required.

### Claude Code

- **Project**: `.claude/skills/<name>/SKILL.md`
- **Global**: `~/.claude/skills/<name>/SKILL.md`
- Skills auto-load. Start a new session to pick them up.

### Cursor

- **Project**: `.cursor/skills/<name>/SKILL.md`
- Fallback: copy the body of `SKILL.md` into `.cursor/rules/<name>.md` (drop the YAML frontmatter) for Cursor Rules.

### Codex CLI (OpenAI)

- Uses `AGENTS.md` at the project root. The installer writes one if missing, pointing to skills in `skills/`.
- Global skills: `~/.codex/skills/<name>/` (if your Codex version supports it).

### Windsurf (Codeium)

- **Project**: `.windsurf/skills/<name>/SKILL.md`
- Alternative: paste the SKILL.md body into a Cascade Rule via Windsurf settings.

### OpenCode

- **Project**: `.opencode/skills/<name>/SKILL.md`
- **Global**: `~/.config/opencode/skills/<name>/SKILL.md`
- Loaded on demand via OpenCode's native skill discovery.

### Google Antigravity

- **Workspace**: `<workspace-root>/.agent/skills/<name>/SKILL.md`
- **Global**: `~/.gemini/antigravity/skills/<name>/SKILL.md`
- Workspace skills take priority over global skills with the same name.

## Non-IDE tools (manual setup)

These platforms don't have a filesystem-based skill discovery mechanism. You need to attach files and paste instructions manually.

### Claude Projects (claude.ai)

1. Create a new Project.
2. Upload these files to the Project's knowledge base:
   - `dist/skills/<name>/SKILL.md`
   - Every file under `dist/skills/<name>/references/`
3. In the **Custom Instructions** field, paste:
   > Follow the operating principles in `SKILL.md` on every response. Consult the reference files when a task matches the skill's description.

### ChatGPT Custom GPT

1. Create a new GPT.
2. In **Instructions**, paste the body of `SKILL.md` (drop the YAML frontmatter).
3. In **Knowledge**, upload every file under `references/`.

### ChatGPT Projects

Same as Claude Projects — attach files, paste SKILL.md body into Project Instructions.

### Gemini Gems

1. Create a new Gem.
2. Paste the SKILL.md body into the Instructions field.
3. Attach the reference files to the Gem's knowledge.

### Generic chat (no file support)

Paste the body of `SKILL.md` at the top of your conversation. End with: "Confirm by responding with: 'Ready.' Then await my first task."

## Validation

After install, verify at least one skill loaded:

```bash
# Claude Code
ls ~/.claude/skills/ || ls .claude/skills/

# OpenCode
ls ~/.config/opencode/skills/ || ls .opencode/skills/

# Antigravity
ls ~/.gemini/antigravity/skills/ || ls .agent/skills/
```

Then open your IDE and ask the AI a question that should trigger a skill (e.g., "What operating principles should you follow on this project?"). If the skill is loaded, the AI should reference it.

## Troubleshooting

**Nothing installed — "No supported IDE detected".**
Run from inside a folder that already has one of `.claude/`, `.cursor/`, `.windsurf/`, `.opencode/`, `.agent/`, or `AGENTS.md`. Or force it: `--tool claude-code --scope global`.

**The AI isn't following the skill's rules.**
Skill metadata loads at session start (Level 1), but the body only loads when the skill is *triggered* (Level 2). Ask a question that clearly matches the skill's description, or explicitly reference it by name.

**"Skill already exists, skipping."**
The installer never overwrites. Delete the existing folder first if you want to reinstall.

**Permission denied on install.sh.**
Use `bash install.sh` explicitly, or `chmod +x install.sh` if you've cloned the repo.
