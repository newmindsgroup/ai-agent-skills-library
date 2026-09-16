# Slash Commands

This folder contains Claude Code slash commands — thin, on-demand wrappers that
invoke a skill or run a fixed prompt. Unlike skills (which auto-trigger on matching
work) and sub-agents (which the harness delegates to), a slash command runs only
when you type it.

> **Skills vs sub-agents vs commands.** Skills load as directives the agent reads
> on matching work. Sub-agents are delegable specialist personas. **Commands** are
> explicit, user-typed triggers — reach for one when you want to fire a capability
> deliberately rather than wait for auto-routing.

## How to install

Slash commands are not installed by `install.sh` (which installs skills). Copy them
into your Claude Code commands directory:

```bash
# Install all commands (global — available in every session)
cp commands/*.md ~/.claude/commands/

# Or per-project
mkdir -p .claude/commands && cp commands/prompt-engineering-expert.md .claude/commands/
```

After install, type the command in any Claude Code session — e.g.
`/prompt-engineering-expert <your goal>`.

## Available commands

| Command | What it does |
|---------|--------------|
| `/prompt-engineering-expert` | Invokes the `prompt-engineering-expert` skill to design, improve, convert, debug, or operationalize a prompt or agent instruction. Defaults to autonomous mode; say "step by step" for the interactive loop. |
| `/pe` | Short alias for `/prompt-engineering-expert`. |

## Plugin install

These commands also ship in the `prompt-engineering-expert` plugin bundle (see
`.claude-plugin/marketplace.json`). Installing that plugin via Claude Code's
`/plugin` system installs the skill, sub-agent, and both commands together.
