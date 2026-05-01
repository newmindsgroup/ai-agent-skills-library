# Superpowers — Operational Notes

## What it is

A Claude Code plugin from Anthropic's official marketplace. Installs 12 agentic skills that auto-fire when relevant tasks are detected.

- **Repo:** https://github.com/obra/superpowers
- **Author:** Jesse Vincent (@obra), Prime Radiant
- **License:** MIT
- **Marketplace:** `claude-plugins-official` (Anthropic) or `superpowers-marketplace` (author fallback)

## Skills installed

| Skill | Fires on |
|---|---|
| `brainstorming` | Open-ended product/strategy questions |
| `writing-plans` | Any non-trivial code task |
| `subagent-driven-development` | Multi-step builds |
| `executing-plans` | After a plan exists |
| `test-driven-development` | New features / refactors |
| `requesting-code-review` | Before merge |
| `finishing-a-development-branch` | End of feature work |
| `systematic-debugging` | Bug reports / failing tests |
| `verification-before-completion` | Before "done" |
| `dispatching-parallel-agents` | Independent workstreams |
| `using-git-worktrees` | Parallel branch work |
| `writing-skills` | When a reusable pattern emerges |

## Installation

Automated:

```bash
bash scripts/01-install-superpowers.sh
```

Manual fallback (interactive Claude Code session):

```
/plugin install superpowers@claude-plugins-official
```

If the official marketplace install fails:

```
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

## Verification

```bash
claude plugin list | grep superpowers
```

Should show the plugin name and version. To verify skills are loaded, in any Claude Code session ask: "what skills are available?" — Superpowers' skills should be listed.

## Configuration

The plugin itself has no per-VPS configuration. What controls its behavior is the `CLAUDE.md` file in each project where you want skills to fire. See `config/CLAUDE.md.template` for the directive block.

**Critical:** Without the CLAUDE.md directive in a project, skills will not auto-fire on tasks in that project. The plugin is "loaded" but "dormant" until invoked.

## What it changes on the VPS

- Adds skill files under `~/.claude/plugins/superpowers/`
- Updates `~/.claude/settings.json` to register the plugin
- No system-wide changes, no daemons, no background processes

## Where it fires (and where it should NOT)

**Fire on:**
- Code work in any repo with the CLAUDE.md directive
- Bug investigation
- Refactors
- New feature work
- OSS-tool scaffolding

**Do NOT fire on:**
- Pure markdown / content edits
- Configuration-only changes (one-line edits to env files, etc.)
- One-off shell commands
- Non-code workflows (GHL automation, content drafting)

The user can override skill activation per session by saying "skip TDD, this is a one-off" or similar.

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| `/plugin install` fails with "marketplace not found" | Older Claude Code | Update Claude Code; rerun |
| Skills installed but never fire | Project has no CLAUDE.md directive | Append `config/CLAUDE.md.template` to project's CLAUDE.md |
| TDD over-fires on config-only changes | Working as designed | Override per-session: "skip TDD" |
| Plugin disappears after Claude Code update | Some Claude Code updates reset plugins | Re-run `01-install-superpowers.sh` (idempotent) |

## Updating

Periodically check for updates:

```bash
claude plugin update superpowers
```

Or re-run the install script — it's idempotent and will pull the latest version.

## Related files in this repo

- `scripts/01-install-superpowers.sh` — installer
- `config/CLAUDE.md.template` — the directive block that activates skills per-project
