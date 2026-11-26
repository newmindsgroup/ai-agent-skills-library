# Repeat a Claude Code skills and plugins cleanup on another computer

Version-Timestamp: 2026-11-26 10:26:42 AST

Status: draft for review. It has not been run on a second machine yet.

This runbook is a method. It lets you repeat a skills, agents and plugins cleanup on a computer that is clean, or on one that already has old skills installed. Every step is safe to run twice. Nothing is deleted: duplicates and retired items are moved into an archive folder, after a full backup.

Companion files:

- [`scripts/claude-cleanup-inventory.sh`](../scripts/claude-cleanup-inventory.sh): inventory and dry run. It changes nothing without `--apply`.
- [`retired/README.md`](../retired/README.md): the public register of retired and duplicate items.

Machine-specific inventories and lists (your own plugins, marketplaces and account settings) belong in a private configuration repository, not in this one. The script reads them from a local file (see section 5).

## Contents

1. [Principles](#1-principles)
2. [What this library lists as retired](#2-what-this-library-lists-as-retired)
3. [The keep list: official Anthropic plugins](#3-the-keep-list-official-anthropic-plugins)
4. [Steps for a new machine](#4-steps-for-a-new-machine)
5. [The script and its lists file](#5-the-script-and-its-lists-file)
6. [Vetting and the do-not-reinstall approach](#6-vetting-and-the-do-not-reinstall-approach)
7. [Caveats](#7-caveats)

## 1. Principles

- Take a backup before you touch anything.
- Move, never delete. Every moved item has a copy in the archive.
- Run a dry run first and read it.
- Install the keep list at user scope, so it applies to every project.
- Verify, then record what you did.
- Every command can be run twice with the same result.

Where things can live. Check all of these when you take an inventory:

| Place | Path or source | Touched by this cleanup |
|---|---|---|
| User skills | `~/.claude/skills/` | Yes |
| User agents | `~/.claude/agents/` | Yes |
| User commands | `~/.claude/commands/` | Backed up only |
| Project scope | `<project>/.claude/` | No. It is committed with the project. |
| Codex skills | `~/.codex/skills/` | No. Reported only. |
| Plugins | Plugin marketplaces, installed by `claude plugin install` | Keep list only |
| Plugins synced from your claude.ai account | Delivered at sync time | Reported only. Switch them off in the account. |
| MCP servers | `claude mcp list` | No |

## 2. What this library lists as retired

Source of truth: [`retired/README.md`](../retired/README.md). The script's built-in defaults match it. Archived on 2026-11-25.

Agents (10), in `~/.claude/agents/`:

| Agent | Reason | Replaced by |
|---|---|---|
| agentic-identity-trust | Retired for zero use in five months | None |
| agents-orchestrator | Same | Parallel subagents through the Agent tool |
| ai-engineer | Same | None |
| autonomous-optimization-architect | Same | A model-routing skill |
| carousel-growth-engine | Same | None |
| identity-graph-operator | Same | None |
| incident-response-commander | Same | `engineering:incident-response` |
| sre | Same | None |
| code-reviewer | Duplicate of the code-review plugin | code-review plugin, `/code-review`, `/security-review` |
| prompt-engineering-expert | Duplicate of the skill with the same name | The `prompt-engineering-expert` skill |

Duplicate skills (10), in `~/.claude/skills/`:

| Skill | Reason | Replaced by |
|---|---|---|
| frontend-design | Duplicate of Anthropic's frontend-design plugin | frontend-design plugin |
| grill-me | Duplicate of `grilling`; cannot trigger on its own | `grilling` |
| security-audit | Duplicate of `security-auditor` and the claude-security plugin | `security-auditor`, claude-security |
| business-model-canvas | Duplicate of `business-model-designer` | `business-model-designer` |
| ai-product | Outdated: truncated description | `ai-product-patterns`, `ai-startup-building` |
| code-review-excellence | Duplicate of the code-review plugin | code-review plugin, `/code-review` |
| bug-hunter | Duplicate of `engineering:debug` | `engineering:debug` |
| architecture | Duplicate of `engineering:architecture` | `engineering:architecture` |
| backend-architect | Duplicate of `engineering:system-design` | `engineering:system-design` |
| lint-and-validate | Duplicate of `engineering-quality-gate` | `engineering-quality-gate` |

Also retired: the global `graphify` skill and command (0.7.10 and 0.6.9), rejected by vetting. Use graphify only through a project's own isolated, pinned runtime.

Before you move a duplicate, make sure its replacement is installed. A replacement that is a plugin or a skill you do not have yet leaves a gap.

## 3. The keep list: official Anthropic plugins

Install these at user scope from `claude-plugins-official`. The reference versions below were current in 2026-11. They are a comparison point, not a guarantee.

| Plugin | Reference version | Why |
|---|---|---|
| typescript-lsp | 1.0.0 | TypeScript code intelligence through a language server |
| claude-security | 0.13.0 | Report-only security scans. Set `live_view` to false. |
| security-guidance | 2.0.21 | Reviews diffs for security problems |
| code-review | 1.0.1 | Replaces the archived code review skills and agent |
| claude-md-management | 1.0.0 | Audits and updates `CLAUDE.md` files. It edits only after you approve. |
| session-report | none; the commit `0fbfda5a91f4` is recorded as its version | Builds a local HTML report of session and token use from transcripts. Reports quote prompts and paths, so keep them local. |
| playground | none; the commit `6985b2d88dc0` is recorded as its version | One skill and Markdown templates for single-file HTML playgrounds |

Install commands:

```bash
claude plugin install typescript-lsp@claude-plugins-official --scope user
claude plugin install claude-security@claude-plugins-official --scope user --config live_view=false
claude plugin install security-guidance@claude-plugins-official --scope user
claude plugin install code-review@claude-plugins-official --scope user
claude plugin install claude-md-management@claude-plugins-official --scope user
claude plugin install session-report@claude-plugins-official --scope user
claude plugin install playground@claude-plugins-official --scope user
```

If your claude.ai account syncs plugins, `security-guidance` and `code-review` may already be present as `security-guidance@synced` and `code-review@synced`. Do not install a second copy. A second copy would review everything twice. The script checks for both forms.

### Pinning and updates

`claude plugin install` has no version flag. The official marketplace can update plugins on its own, and turning that off would affect every plugin from it. A fresh install gets whatever the marketplace holds that day.

To keep control:

1. After install, run `claude plugin list` and write down each version.
2. Compare it with your last recorded version, and with the reference versions above.
3. If a version changed, vet the new one before you rely on it (section 6), then record it.

The installed commit for each plugin is in `~/.claude/plugins/installed_plugins.json` (`gitCommitSha`). Keep it in your vetting log.

### claude-security: turn off live view

`live_view` would let the plugin read prompts, scanned files and settings inside Claude Code. Set it to false at install time. The install command in the list above does this with `--config live_view=false`. The CLI documents `--config <key=value>` for options a plugin declares, and `claude plugin install --help` shows it.

If the plugin is already installed, set the value afterwards:

```bash
claude plugin configure claude-security@claude-plugins-official
echo '{"live_view":"false"}' | claude plugin configure claude-security@claude-plugins-official --values-stdin
```

The first command shows the plugin's options. The second saves a JSON object of single-line string values. You can also use `/plugin configure` inside Claude Code. Confirm the result with the script. Its "claude-security setting" section reports `live_view is false`.

### typescript-lsp: install the language server

The plugin only starts `typescript-language-server`. Install it yourself, pinned and with install scripts off. Replace the versions with the ones you have vetted.

```bash
npm install --prefix ~/.local/tools/lsp --ignore-scripts --save-exact typescript-language-server@<version> typescript@<version>
mkdir -p ~/.local/bin
ln -sf ~/.local/tools/lsp/node_modules/.bin/typescript-language-server ~/.local/bin/typescript-language-server
npm audit --prefix ~/.local/tools/lsp
```

`~/.local/bin` must be on the PATH of whatever launches Claude Code, including a desktop app. A PATH set inside `settings.json` does not help here.

### What to check for each plugin

- Publisher and license.
- What it contains: hooks, MCP servers, scripts, dependencies.
- Where data goes. For example, security tools can send diffs to a hosted API.
- What it writes, and whether it applies changes or only reports.
- What telemetry it sends.

Run the `vetting-third-party-components` skill if you have it. Record the result in `~/.claude/vetting-log.md`.

## 4. Steps for a new machine

Run the steps in order. Close other Claude Code sessions first, so nothing writes to `~/.claude` during the run.

Requirements: Claude Code, signed in to your claude.ai account (so synced plugins can arrive), `bash`, `git`, and a checkout of this repository. The script needs only `bash` and standard Unix tools. It runs on macOS and Linux.

### a. Inventory what is there

1. From a checkout of this repository, run:

   ```bash
   bash scripts/claude-cleanup-inventory.sh --list --mcp --project <path-to-a-project> | tee ~/claude-cleanup-before.txt
   ```

   `--mcp` contacts every MCP server and prints names only. Leave it out if you do not want that.

2. Read the counts.
3. If `~/.claude` does not exist, stop. There is nothing to clean. Go to step e.
4. Compare the skill names with your own list of kept skills. This prints skills that are neither on your list nor retired:

   ```bash
   comm -23 <(ls -1 ~/.claude/skills | sort) <(sort my-kept-skills.txt)
   ```

   `my-kept-skills.txt` is a file you keep privately, one name per line. `comm` needs both inputs sorted and one name per line, so the example sorts both. A `synced` folder in `~/.claude/skills/` is a cache, not a skill. Decide unknown skills by hand.

### b. Back up everything first

The script does this itself when you run `--apply`. Do it by hand if you want the backup before you run even a dry run. `cp -a src/. dst/` copies the contents, preserves the structure and symlinks, and works even when `skills/` or `agents/` is itself a symlink. It never creates a nested `skills/skills` on a rerun, because the destination folder is created fresh each time.

```bash
BK=~/.claude/skill-archive/$(date +%Y-%m-%d)-backup
if [ -d "$BK" ]; then
  echo "backup exists, skipping"
else
  mkdir -p "$BK.partial"
  for p in skills agents commands; do
    if [ -d ~/.claude/$p ]; then
      mkdir "$BK.partial/$p"
      cp -a ~/.claude/$p/. "$BK.partial/$p/"
    fi
  done
  claude plugin list > "$BK.partial/plugin-list.txt"
  mv "$BK.partial" "$BK"
fi
```

Notes:

- Symlinks inside the folders stay symlinks in the copy. What they point to is not copied.
- If `skills/` or `agents/` is a symlink, the copy holds the real contents. The script compares entry counts and stops before moving anything if they differ.
- Copy `~/.claude/plugins/installed_plugins.json` to the backup too if you want a rollback record.
- Before you edit `settings.json`, copy it next to itself as `settings.json.bak-<date>`. It can hold secrets. Do not put it in the archive, do not commit it, and do not paste its contents anywhere.
- If `~/.claude` is under git, add `skill-archive/*-backup/` to `.git/info/exclude`.

### c. Dry run

1. Run the script with no flags:

   ```bash
   bash scripts/claude-cleanup-inventory.sh
   ```

2. Read "Items to move into skill-archive". Each `WOULD MOVE` line must be an item from section 2, or from your own lists file. If a line surprises you, stop.
3. Read "Keep-list plugins". `MISSING` lines are handled in step e.
4. On a machine that is already clean, the dry run says `nothing left to move`.

### d. Move duplicates and retired items into the archive

1. Run:

   ```bash
   bash scripts/claude-cleanup-inventory.sh --apply
   ```

2. The script copies `skills/`, `agents/` and `commands/` to `~/.claude/skill-archive/<date>-backup/`. It skips this if that folder exists.
3. It then moves each listed item into `~/.claude/skill-archive/skills/` or `~/.claude/skill-archive/agents/`.
4. If a target exists, it adds a numeric suffix (`bug-hunter-2`). It never overwrites and never deletes.
5. Run it a second time. It must report `nothing left to move` and `backup already exists`.

If the machine has local edits in a duplicate skill, they are inside the backup. Diff them before you drop the archive.

To restore one item, move it back: `mv ~/.claude/skill-archive/skills/<name> ~/.claude/skills/<name>`.

### e. Install the keep list at user scope

1. Run only the install commands the dry run printed for `MISSING` plugins (section 3).
2. Wait for the claude.ai sync before you install `security-guidance` or `code-review`. If they still do not appear, install them from the official marketplace.
3. Turn off claude-security's live view (section 3). Skip this if you installed it with `--config live_view=false`.
4. Install the TypeScript language server (section 3).
5. For plugins from your own marketplaces, add the marketplace first, then install:

   ```bash
   claude plugin marketplace add <github-repo-or-folder-path>
   claude plugin install <plugin>@<marketplace> --scope user
   ```

6. Switch off, in your claude.ai account, any synced plugin you have decided to drop. The script cannot do this. It only reports it.
7. Do not run any installer from section 6 as part of this step.

### f. Verify

1. Run `claude plugin list`. Compare it with the versions you recorded.
2. Run the script again with no flags. Expect `nothing left to move`, `no keep-list plugin is missing` and `live_view is false`.
3. In a new session, run `/context`. Check the Skills and Agents sections. No retired name should appear.
4. Start a test session in two different projects. Check that the kept plugins load and no retired agent shows. If a project has its own `.claude/` folder, confirm its skills and agents still load.
5. In a TypeScript project, ask Claude to list the symbols of one file through the language server. This confirms typescript-lsp finds its server.

### g. Record what you did

1. Append a dated section to the machine's `~/.claude/removed-log.md`. Use one row per item the script moved: name, type, old path, archive path, replaced by, date.
2. Add an entry to `~/.claude/vetting-log.md` for each plugin you installed: date and time, installed version and commit, scope, constraints.
3. Keep `~/claude-cleanup-before.txt` with the backup folder name beside it. Do not commit either.

## 5. The script and its lists file

`scripts/claude-cleanup-inventory.sh` is plain bash. It runs on macOS and Linux and is shellcheck clean.

| Option | Effect |
|---|---|
| none | Inventory and dry run. Changes nothing. |
| `--list` | Also prints every user skill name. |
| `--mcp` | Also prints MCP server names. It runs `claude mcp list` and filters the output to names. |
| `--project DIR` | Also counts skills, agents and commands in `DIR/.claude`. |
| `--apply` | Backs up, then moves. Never installs, never deletes. |
| `--help` | Prints usage. |

Environment: `CLAUDE_HOME` (default `~/.claude`) and `CODEX_SKILLS` (default `~/.codex/skills`). Point `CLAUDE_HOME` at a scratch folder to try `--apply` safely.

Safety properties:

- It never opens `~/.claude.json`.
- It never prints `settings.json`. It only tests whether `live_view` is set to false.
- It reduces MCP output to server names.
- It never installs a plugin. It prints the commands.
- It never overwrites an archive target. It adds a numeric suffix.
- It leaves anything not on its lists alone, including `skills/synced`. A listed symlink is moved as a link; its target is never touched.

### Lists file

Built-in defaults match [`retired/README.md`](../retired/README.md) and the keep list in section 3. To use your own lists, create `~/.claude/cleanup-lists.conf` (or `$CLAUDE_HOME/cleanup-lists.conf`). Keep it outside any public repository.

The file is data, not code. The script reads it one line at a time and never runs it. A line like `APPLY=1` or a shell command is rejected, not executed.

Each line has four fields separated by `|`:

```text
LIST|kind|name|note
```

| Field | Meaning |
|---|---|
| `LIST` | `DO_NOT_REINSTALL`, `DUPLICATES` or `KEEP_PLUGINS` |
| `kind` | For the first two lists: `skill` (a folder in `~/.claude/skills`), `agent` (a file stem in `~/.claude/agents`), or, for `DO_NOT_REINSTALL` only, `synced-plugin` (report only; you switch it off in your account). For `KEEP_PLUGINS`: `official` (install from claude-plugins-official), `either` (the official plugin or its `@synced` copy; install only if neither exists), or `custom` (your own marketplace; no install command is built). `none` gives an empty list. |
| `name` | The skill folder, the agent file stem (no `.md`), or the plugin id |
| `note` | The replacement, as free text. For `KEEP_PLUGINS`: `<version> <commit>`, separated by a space. |

Blank lines and lines that start with `#` are ignored. If a list appears in the file at all, it replaces that list's defaults entirely. A list you leave out keeps the defaults.

```text
# ~/.claude/cleanup-lists.conf
DO_NOT_REINSTALL|agent|example-retired-agent|none
DO_NOT_REINSTALL|skill|example-retired-skill|a replacement
DO_NOT_REINSTALL|synced-plugin|example-plugin@synced|why it is switched off
DUPLICATES|skill|example-duplicate|example-kept-skill
KEEP_PLUGINS|official|typescript-lsp@claude-plugins-official|1.0.0 6985b2d88dc0
KEEP_PLUGINS|either|security-guidance|2.0.21
KEEP_PLUGINS|custom|example-plugin@example-marketplace|0.1.0
```

Rules the script enforces before it reads, backs up or moves anything:

- A `skill` or `agent` name must be one plain name. It must start with a letter or digit and use only letters, digits and `. _ ~ @ + -` and spaces. It cannot hold a slash or a newline, and it cannot be `.` or `..`. A path such as `../settings.json` is refused.
- The same rules apply to the built-in defaults.
- Any bad line or entry (wrong field count, unknown list, unknown kind, bad name) refuses the whole run with exit code 65. Nothing is moved, not even the good entries.
- Before a move, the script resolves the final path and refuses anything that is not a direct entry of `~/.claude/skills` or `~/.claude/agents`.
- A listed symlink is moved as a link. The script never follows it, so its target stays where it is.
- The file should hold no secrets, tokens or URLs with credentials. The first lines of the output say which lists are in use.

### Testing the script

A regression test runs the script against throwaway folders with a fake `claude`. It covers path traversal, symlinks, the data-only lists file, backups, idempotence and plugin matching.

```bash
bash scripts/tests/claude-cleanup-inventory-test.sh
```

To try `--apply` by hand, point `CLAUDE_HOME` at a scratch copy. One thing does not follow `CLAUDE_HOME`: `claude plugin list` always reports the real Claude Code install. The plugin sections of the output therefore describe your real plugins, even in a scratch run. Plugin ids are compared exactly, and a keep-list plugin counts as present only when it is installed at user scope and enabled.

## 6. Vetting and the do-not-reinstall approach

Before you install anything new:

1. Search [`retired/README.md`](../retired/README.md), and your own lists file, for the name. If it is there, do not install it. Use the replacement.
2. Check the restore paths below.
3. Vet the component (section 3, "What to check") and log the result.
4. If you restore an item on purpose, remove its row from your lists in the same change, and say why.

Restore paths that can bring retired items back without anyone asking. Check them before you run an installer on a machine:

| Path | What it can restore | What to do |
|---|---|---|
| The agency-agents cherry-pick installer | The retired agents, if its manifest still lists them | Remove retired names from its manifest first. Never run it "to check" it: many installers have no help or dry-run flag and install everything in their manifest. |
| This library's superpowers-stack installer (`07-install-agency-agents.sh`) | The agents its manifest lists | Do not add a retired agent back to the manifest. |
| This library's `install.sh` and `dist/skills/` | Skills named `frontend-design`, `code-review-excellence`, `bug-hunter`, `architecture`, `backend-architect`, `lint-and-validate` and `ai-product` | Use `--dry-run` first and name skills explicitly. Never run `--all` or `--force` on a machine you are cleaning. |
| Plugins synced from your claude.ai account | Any plugin turned back on in the account | Keep dropped plugins off. List them in your lists file as `synced-plugin` so the script reports them. |
| Codex copies in `~/.codex/skills/` | Its own copies of several archived skills | They affect Codex only. The script reports them and never touches them. |
| Global graphify installs (`pip install graphifyy`, `uv tool install`) | The rejected 0.7.10 or 0.6.9 | Do not install it globally. Use a project's vetted runtime only. |

## 7. Caveats

- The official marketplace can update plugins on its own (section 3).
- Names here are folder names. A machine with a different install method may show different paths. The script only looks under `~/.claude` (or `CLAUDE_HOME`).
- `claude mcp list` can show URLs and command arguments. The script reduces its output to names. If you run it yourself, do not paste the raw output anywhere.
- This runbook has not been run on a second machine. Do the first run on a non-critical one.
