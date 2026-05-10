# Deployment Guide — How to install this skill in any AI tool

This skill is portable. Below are exact steps for every major AI environment. Pick the one you use. All options produce the same operational behavior.

---

## Option 1 — Claude Code (recommended for technical users)

Claude Code natively supports the Agent Skills format.

**Project-scoped (applies inside one repo):**
```bash
mkdir -p .claude/skills
cp -r institutional-ai-operating-principles .claude/skills/
```

**User-scoped (applies across all your projects):**
```bash
mkdir -p ~/.claude/skills
cp -r institutional-ai-operating-principles ~/.claude/skills/
```

Claude Code auto-discovers the skill on next session start. No restart needed for project-scoped installs.

---

## Option 2 — Cursor

Cursor supports both the Agent Skills format and its own `AGENTS.md` / `.cursor/rules/` conventions.

**Via Agent Skills (preferred):**
```bash
mkdir -p .cursor/skills
cp -r institutional-ai-operating-principles .cursor/skills/
```

**Via Cursor rules (fallback):**
1. Create `.cursor/rules/institutional-ai.md`
2. Paste the body of `SKILL.md` (drop the YAML frontmatter — Cursor rules don't use it)
3. Set the rule to "Always apply" in Cursor settings

---

## Option 3 — Codex CLI / Codex App (OpenAI)

Codex supports the `AGENTS.md` standard.

1. At repo root, create `AGENTS.md`
2. Paste the body of `SKILL.md` (drop the YAML frontmatter)
3. Reference the files in `references/` by relative path so Codex can load them on demand

---

## Option 4 — Claude Projects (claude.ai)

Claude Projects supports file uploads that become persistent context.

1. Create a new Project
2. Upload these files to the project knowledge:
   - `SKILL.md`
   - `references/knowledge-brief.md`
   - `references/agent-skills-spec.md`
   - `references/starter-skill-template.md`
3. In the Project's **Custom Instructions** field, paste: "Follow the operating principles in SKILL.md on every response. Consult the reference files when proposing new skills or when a task requires the knowledge brief's frameworks."
4. Every conversation in that Project now operates under the skill.

---

## Option 5 — ChatGPT Custom GPTs / Projects

ChatGPT supports attached files and custom instructions.

**Custom GPT:**
1. Create a new GPT
2. In **Instructions**, paste the body of `SKILL.md` (drop the YAML frontmatter)
3. In **Knowledge**, upload `references/knowledge-brief.md`, `references/agent-skills-spec.md`, and `references/starter-skill-template.md`
4. Save

**ChatGPT Projects:**
1. Create a new Project
2. Attach the same four files
3. In Project Instructions, paste the body of `SKILL.md`

---

## Option 6 — Gemini Gems (gemini.google.com)

Google Gemini's Gems are the equivalent of Custom GPTs.

1. Create a new Gem
2. In the **Instructions** field, paste the body of `SKILL.md` (drop the YAML frontmatter)
3. In the **Knowledge** / file-upload area, attach the reference files
4. Save

---

## Option 7 — Windsurf / Zed / other AI IDEs

Most modern AI IDEs now support either Agent Skills or `AGENTS.md`.

- **Windsurf:** Place the folder under `.windsurf/skills/` (or use Cascade Rules with the SKILL.md body).
- **Zed:** Place under `.zed/skills/` or use Zed's rules file.
- **Aider / Continue / Cline:** Use each tool's project-instructions file and paste the SKILL.md body.

When in doubt, treat the SKILL.md body as a standard system-prompt / project-instructions file — it is designed to work that way.

---

## Option 8 — Generic chat interface (no file support)

If the tool only accepts a prompt:

1. Paste the body of `SKILL.md` (everything below the YAML frontmatter) at the top of the conversation.
2. End with: "Confirm you understand by responding with: 'Operating under institutional-AI principles. Ready.' Then wait for my first task."
3. Proceed with your actual task.

For tools with a "system prompt" or "custom instructions" field, put it there instead of re-pasting each session.

---

## Option 9 — Team-wide deployment (Git-based skills library)

The Ramp Dojo model — a shared, versioned, code-reviewed skills repository.

```bash
# One-time setup
git init <org>-skills
cd <org>-skills
cp -r /path/to/institutional-ai-operating-principles .

# Add more skills over time
mkdir -p drafting-proposals
# ... populate SKILL.md and references

git add .
git commit -m "Add institutional-ai-operating-principles v1.0"
git push
```

Every teammate clones the repo and points their AI tool at it (project-scoped install from Options 1–3). Changes flow through pull requests like code.

---

## Validation

To confirm the skill is well-formed before installing:

```bash
# If you have the agentskills CLI installed
agentskills validate institutional-ai-operating-principles/
```

Or manually check:

- [ ] `SKILL.md` exists and starts with `---` on line 1
- [ ] YAML frontmatter has `name` and `description`
- [ ] Folder name matches the `name` field
- [ ] All references in SKILL.md point to real files

---

## Troubleshooting

**The AI isn't following the rules consistently.**
The skill is probably only loading at session start. Restart the conversation, or in tools without persistent skills, paste the SKILL.md body at the top of a fresh conversation.

**The AI cites rules but misquotes them.**
It is operating from summary tokens only (Level 1). Ask it to read the relevant reference file directly, or upload the file to the tool's knowledge base so it can be retrieved on demand.

**The tool doesn't support file uploads.**
Use Option 8 (paste the SKILL.md body directly). You will lose access to the reference files, but the operating principles themselves are self-contained in SKILL.md.
