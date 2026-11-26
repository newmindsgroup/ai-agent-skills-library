#!/usr/bin/env bash
#
# Regression tests for scripts/claude-cleanup-inventory.sh.
# Everything runs in a throwaway CLAUDE_HOME under a temp folder, with a fake
# `claude` on PATH. It never touches the real ~/.claude.
#
# Usage: bash scripts/tests/claude-cleanup-inventory-test.sh

set -uo pipefail

SCRIPT="$(cd "$(dirname "$0")/.." && pwd)/claude-cleanup-inventory.sh"
ROOT="$(mktemp -d)"
STUB="$ROOT/stub"
PASS=0
FAIL=0
OUT=""
CODE=0

cleanup() { rm -rf "${ROOT:?}"; }
trap cleanup EXIT

mkdir -p "$STUB"
cat >"$STUB/claude" <<'STUBEOF'
#!/usr/bin/env bash
# Fake claude: canned `plugin list` output, nothing else.
if [[ "${1:-}" == "plugin" && "${2:-}" == "list" ]]; then
  cat <<'LIST'
Installed plugins:

  ❯ typescript-lsp@claude-plugins-official
    Version: 1.0.0
    Scope: user
    Status: ✔ enabled

  ❯ claude-security@claude-plugins-official
    Version: 0.13.0
    Scope: project
    Status: ✔ enabled

Synced from claude.ai:

  ⚠ "superpowers@synced" from claude.ai not loaded: "superpowers@claude-plugins-official" on this machine has the same name and takes precedence

  ❯ design-superpowers@synced
    Version: 1.0.0
    Path: /somewhere
    Status: ✔ loaded
LIST
fi
exit 0
STUBEOF
chmod +x "$STUB/claude"

ok() { PASS=$((PASS + 1)); printf 'ok   %s\n' "$1"; }
bad() { FAIL=$((FAIL + 1)); printf 'FAIL %s\n' "$1"; printf '%s\n' "$OUT" | sed 's/^/     | /' | head -20; }
check() { # check "description" command...
  local d="$1"
  shift
  if "$@"; then ok "$d"; else bad "$d"; fi
}

# Fresh fixture: $ROOT/home is CLAUDE_HOME, $ROOT/victim.txt is outside it.
mkhome() {
  rm -rf "${ROOT:?}/home" "${ROOT:?}/victim.txt" "${ROOT:?}/target" "${ROOT:?}/real-skills" "${ROOT:?}/pwned" "${ROOT:?}/pwned2"
  mkdir -p "$ROOT/home/skills/keep" "$ROOT/home/skills/bug-hunter" "$ROOT/home/agents" "$ROOT/home/commands"
  printf -- '---\nname: keep\n---\n' >"$ROOT/home/skills/keep/SKILL.md"
  printf -- '---\nname: bug-hunter\n---\n' >"$ROOT/home/skills/bug-hunter/SKILL.md"
  echo a >"$ROOT/home/agents/sre.md"
  echo k >"$ROOT/home/agents/keep.md"
  echo w >"$ROOT/home/commands/wizard.md"
  echo '{"sentinel":"settings","live_view":false}' >"$ROOT/home/settings.json"
  echo claude-md >"$ROOT/home/CLAUDE.md"
  echo victim >"$ROOT/victim.txt"
}

run() { # run [args...]  (uses $ROOT/home)
  OUT="$(CLAUDE_HOME="$ROOT/home" PATH="$STUB:$PATH" bash "$SCRIPT" "$@" 2>&1)"
  CODE=$?
}

lists() { printf '%s\n' "$@" >"$ROOT/home/cleanup-lists.conf"; }

intact() {
  [[ -f "$ROOT/home/settings.json" && -f "$ROOT/home/CLAUDE.md" && -f "$ROOT/victim.txt" \
    && -d "$ROOT/home/skills/keep" && -f "$ROOT/home/agents/keep.md" && ! -e "$ROOT/home/skill-archive" ]]
}

# --- 1. Path traversal and bad names: the whole run is refused, nothing moves.
refuse_case() { # refuse_case "LIST|kind|name|note"
  mkhome
  lists "$1"
  run --apply
  if [[ "$CODE" -eq 65 ]] && intact; then ok "refused: $1"; else bad "refused: $1 (exit $CODE)"; fi
}
refuse_case 'DO_NOT_REINSTALL|skill|../settings.json|x'
refuse_case 'DO_NOT_REINSTALL|agent|../CLAUDE|x'
refuse_case 'DO_NOT_REINSTALL|skill|../../victim.txt|x'
refuse_case 'DO_NOT_REINSTALL|skill||x'
refuse_case 'DO_NOT_REINSTALL|skill|keep/|x'
refuse_case 'DO_NOT_REINSTALL|skill|a/b|x'
refuse_case 'DO_NOT_REINSTALL|skill|.|x'
refuse_case 'DO_NOT_REINSTALL|skill|..|x'
refuse_case 'DUPLICATES|agent|../CLAUDE|x'
refuse_case 'DUPLICATES|skill|/etc/passwd|x'
refuse_case 'DO_NOT_REINSTALL|skill| leading-space|x'
refuse_case 'DO_NOT_REINSTALL|skill|name'
refuse_case 'NOT_A_LIST|skill|x|y'
refuse_case 'DO_NOT_REINSTALL|oops|x|y'

# A bad entry among good ones refuses the whole run: the good one must not move.
mkhome
lists 'DO_NOT_REINSTALL|skill|bug-hunter|x' 'DO_NOT_REINSTALL|skill|../settings.json|x'
run --apply
if [[ "$CODE" -eq 65 && -d "$ROOT/home/skills/bug-hunter" && ! -e "$ROOT/home/skill-archive" ]]; then
  ok "one bad entry stops the good ones too"
else bad "one bad entry stops the good ones too (exit $CODE)"; fi

# --- 2. Symlinked skill with a trailing slash must not move the link target.
mkhome
mkdir -p "$ROOT/target"
echo precious >"$ROOT/target/data.txt"
ln -s "$ROOT/target" "$ROOT/home/skills/linked"
lists 'DO_NOT_REINSTALL|skill|linked/|x'
run --apply
if [[ "$CODE" -eq 65 && -L "$ROOT/home/skills/linked" && -f "$ROOT/target/data.txt" ]]; then
  ok "linked/ is refused, link and target intact"
else bad "linked/ is refused, link and target intact (exit $CODE)"; fi

# --- 3. A listed symlink moves as a link; the target is never followed.
mkhome
mkdir -p "$ROOT/target"
echo precious >"$ROOT/target/data.txt"
ln -s "$ROOT/target" "$ROOT/home/skills/linked"
lists 'DO_NOT_REINSTALL|skill|linked|x'
run --apply
if [[ "$CODE" -eq 0 && -L "$ROOT/home/skill-archive/skills/linked" && ! -e "$ROOT/home/skills/linked" \
  && -f "$ROOT/target/data.txt" ]]; then
  ok "symlink is moved as a link, target untouched"
else bad "symlink is moved as a link, target untouched (exit $CODE)"; fi

# --- 4. The lists file is data: code in it never runs.
mkhome
printf 'APPLY=1\ntouch "%s/pwned"\n' "$ROOT" >"$ROOT/home/cleanup-lists.conf"
run
if [[ "$CODE" -eq 65 && ! -e "$ROOT/pwned" ]]; then ok "shell lines in the lists file are rejected, not run"
else bad "shell lines in the lists file are rejected, not run (exit $CODE)"; fi

mkhome
lists "DUPLICATES|skill|bug-hunter|\$(touch $ROOT/pwned2) \`touch $ROOT/pwned2\`"
run
if [[ "$CODE" -eq 0 && ! -e "$ROOT/pwned2" && "$OUT" == *"WOULD MOVE skills/bug-hunter"* ]]; then
  ok "substitutions in a note are plain text"
else bad "substitutions in a note are plain text (exit $CODE)"; fi

# --- 5. A valid file works, comments are ignored, "none" empties a list.
mkhome
lists '# a comment' '' 'DUPLICATES|skill|bug-hunter|engineering:debug' 'DO_NOT_REINSTALL|none||'
run
if [[ "$CODE" -eq 0 && "$OUT" == *"WOULD MOVE skills/bug-hunter"* && "$OUT" != *"agents/sre.md"* ]]; then
  ok "valid lists file: per-list replacement, comments, none"
else bad "valid lists file: per-list replacement, comments, none (exit $CODE)"; fi

# --- 6. Dry run changes nothing.
mkhome
before="$(find "$ROOT/home" | sort | tr '\n' ' ')"
run
after="$(find "$ROOT/home" | sort | tr '\n' ' ')"
check "dry run changes nothing" test "$before" = "$after"

# --- 7. Apply, then apply again: backup once, move once, second run is a no-op.
mkhome
run --apply
first="$CODE"
moved_ok=0
if [[ -d "$ROOT/home/skill-archive/skills/bug-hunter" && -f "$ROOT/home/skill-archive/agents/sre.md" \
  && ! -e "$ROOT/home/skills/bug-hunter" && -d "$ROOT/home/skills/keep" ]]; then moved_ok=1; fi
run --apply
if [[ "$first" -eq 0 && "$CODE" -eq 0 && "$moved_ok" -eq 1 && "$OUT" == *"nothing left to move"* \
  && "$OUT" == *"backup already exists"* ]]; then ok "apply is idempotent"
else bad "apply is idempotent (exit $first/$CODE)"; fi

# --- 8. Name collision in the archive gets a numeric suffix, never overwritten.
mkhome
mkdir -p "$ROOT/home/skill-archive/skills/bug-hunter"
echo old >"$ROOT/home/skill-archive/skills/bug-hunter/OLD.md"
run --apply
if [[ -f "$ROOT/home/skill-archive/skills/bug-hunter/OLD.md" && -d "$ROOT/home/skill-archive/skills/bug-hunter-2" ]]; then
  ok "archive collision gets a suffix"
else bad "archive collision gets a suffix"; fi

# --- 9. skills/ itself a symlink: the backup holds real contents.
mkhome
mv "$ROOT/home/skills" "$ROOT/real-skills"
ln -s "$ROOT/real-skills" "$ROOT/home/skills"
run --apply
bk="$(find "$ROOT/home/skill-archive" -maxdepth 1 -name '*-backup' | head -1)"
if [[ "$CODE" -eq 0 && -n "$bk" && -d "$bk/skills" && ! -L "$bk/skills" && -f "$bk/skills/keep/SKILL.md" \
  && -f "$bk/skills/bug-hunter/SKILL.md" && "$OUT" == *"backed up skills ("* ]]; then
  ok "symlinked skills/ is backed up as real contents"
else bad "symlinked skills/ is backed up as real contents (exit $CODE)"; fi

# --- 10. Plugin ids are compared exactly, and scope and status matter.
mkhome
lists 'DO_NOT_REINSTALL|synced-plugin|superpowers@synced|a' \
  'DO_NOT_REINSTALL|synced-plugin|design-superpowers@synced|b' \
  'KEEP_PLUGINS|official|typescript-lsp@claude-plugins-official|1.0.0 abc' \
  'KEEP_PLUGINS|official|claude-security@claude-plugins-official|0.13.0 abc' \
  'KEEP_PLUGINS|official|superpowers@claude-plugins-official|7.0.2 abc'
run
if [[ "$OUT" == *"still synced  design-superpowers@synced"* && "$OUT" != *"still synced  superpowers@synced"* ]]; then
  ok "superpowers@synced does not match design-superpowers@synced or a warning line"
else bad "superpowers@synced does not match design-superpowers@synced or a warning line"; fi
if [[ "$OUT" == *"present  typescript-lsp@claude-plugins-official"* ]]; then ok "user-scope enabled plugin is present"
else bad "user-scope enabled plugin is present"; fi
if [[ "$OUT" == *"MISSING  claude-security@claude-plugins-official"* && "$OUT" == *"not at user scope"* ]]; then
  ok "project-scope plugin is reported as missing at user scope"
else bad "project-scope plugin is reported as missing at user scope"; fi
if [[ "$OUT" == *"MISSING  superpowers@claude-plugins-official"* ]]; then
  ok "an id named only in a warning line is not present"
else bad "an id named only in a warning line is not present"; fi
if [[ "$OUT" == *"--scope user --config live_view=false"* ]]; then ok "claude-security install command sets live_view=false"
else bad "claude-security install command sets live_view=false"; fi

printf '\n%d passed, %d failed\n' "$PASS" "$FAIL"
[[ "$FAIL" -eq 0 ]]
