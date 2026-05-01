# Drive ↔ Code-Clone Handoff Pattern

**Failure mode this prevents:** files written by one AI session (in a Drive-mounted folder) silently disappearing when the next AI session can't see them, OR a chain of edits that the user can't re-create on their own machine because the changes only exist in cloud.

**Context:** common in Cowork / Claude Code workflows where the IDE / chat tool writes to one path (often a cloud-synced Drive folder) and follow-up sessions or human teammates need to act on the changes from a different path (a local clone, a CI runner, a teammate's checkout).

## The rule

When an AI session writes files into a Drive-synced folder that's NOT the same as the user's git working tree:

1. **Log every new or modified file path** at session close.
2. **Provide explicit `cp` or `rsync` commands** the user runs in their terminal to bring the changes into their git working tree.
3. **Tell the user the order to apply them in** if order matters.
4. **Confirm** that the next session (or human) needs to run those commands before continuing.

## Why this matters

Drive folders are convenient: they sync without thinking. But they have failure modes that break the chain:

- **`.git` corruption.** Drive's sync logic mangles `.git/` directories on macOS. A folder that was a git working tree becomes a folder with a `.git-broken-{timestamp}/` rename.
- **Different mount paths in different environments.** The path the AI sees is not the path the human's other tools see.
- **Sandbox isolation.** AI sandboxes mount the Drive folder read-only or via a different mount path, so files created in the sandbox might not appear in Drive at all.
- **Sync delay.** A file written to Drive may not be visible to other clients for 30+ seconds.

Result: the AI says "I added the new file at `/path/in/drive/`," the user looks at their checkout, sees nothing, gets confused.

## The handoff template

At session close, paste this:

```markdown
## Handoff to your local clone

I wrote {N} files into the Drive folder. To bring them into your git checkout at `~/code/{repo}`, run:

```bash
cd ~/code/{repo}
cp -v "{drive_folder}/path/to/new-file-1" .
cp -v "{drive_folder}/path/to/new-file-2" subdir/
# OR for a whole tree:
rsync -av --exclude='.git*' "{drive_folder}/path/to/changed-tree/" subdir/

# Then verify and commit:
git status
git add .
git commit -m "{summary of what these files do}"
git push
```

Note: my session writes to Drive but cannot push from here — you control the commit and push.
```

## Variations

**If the user has a watch-folder script** that auto-syncs Drive → local clone, mention it explicitly: "your watcher should pick this up within {N} seconds; verify with `git status`."

**If files were renamed or deleted**, include `git rm` / `git mv` commands, not just `cp`.

**If the changes need to be applied in a specific order** (e.g., schema migration before app code), number the steps and tell the user to wait between them.

## What goes wrong if you skip this

- The user pulls from `origin/main`, sees no new files, and asks "did the change ship?"
- The next AI session reads the local clone, doesn't see the new files, and starts re-creating work.
- A human teammate clones the repo and is missing files that the previous session "added."
- A CI run fails because the build needs files that only exist in Drive.

In every case the fix is the same — give the user an explicit `cp` / `rsync` recipe at session close.
