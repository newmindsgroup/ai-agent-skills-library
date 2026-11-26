#!/usr/bin/env bash
#
# claude-cleanup-inventory.sh
#
# Inventory and dry run for a Claude Code skills and plugins cleanup, so the
# same cleanup can be repeated on another computer. See
# docs/cleanup-another-computer.md for the runbook.
#
# Default mode changes nothing. It prints:
#   1. what is installed (skills, agents, commands, plugins, archive, Codex),
#   2. which do-not-reinstall and duplicate items it WOULD move,
#   3. which keep-list plugins are missing, with the exact install commands.
#
# With --apply it first copies ~/.claude/skills, agents and commands into
# ~/.claude/skill-archive/<date>-backup/ (skipped if that folder exists), then
# MOVES each listed item into ~/.claude/skill-archive/. It never deletes,
# never overwrites, and never installs plugins (it prints the commands).
#
# It never reads or prints secrets: it does not open ~/.claude.json, it does
# not print settings.json, and MCP output is reduced to server names.
#
# Lists: the public defaults below match retired/README.md. To use your own
# lists, put bash arrays in ~/.claude/cleanup-lists.conf (outside this
# repository). See "Lists file" in docs/cleanup-another-computer.md.
#
# Usage:
#   scripts/claude-cleanup-inventory.sh [--list] [--mcp] [--project DIR]
#   scripts/claude-cleanup-inventory.sh --apply
#   scripts/claude-cleanup-inventory.sh --help
#
# Environment:
#   CLAUDE_HOME    default ~/.claude (set it to a scratch copy to test --apply)
#   CODEX_SKILLS   default ~/.codex/skills (read only, names only)

set -euo pipefail

# ---------------------------------------------------------------------------
# Built-in default lists. Keep them in step with retired/README.md.
#
# DO_NOT_REINSTALL and DUPLICATES entries: "kind|name|replacement"
#   kind: skill (a folder in ~/.claude/skills), agent (a file stem in
#         ~/.claude/agents), or synced-plugin (report only; switch it off in
#         your claude.ai account, the script cannot).
# KEEP_PLUGINS entries: "plugin-id|version|commit|kind"
#   official : install from claude-plugins-official at user scope.
#   either   : the official plugin, or the claude.ai-synced copy of it
#              (<name>@synced). Install only if neither is present.
#   custom   : from a marketplace you add yourself; no install command is
#              built, because the marketplace source is yours to supply.
# ---------------------------------------------------------------------------

DEFAULT_DO_NOT_REINSTALL=(
  "agent|agentic-identity-trust|none"
  "agent|agents-orchestrator|parallel subagents through the Agent tool"
  "agent|ai-engineer|none"
  "agent|autonomous-optimization-architect|a model-routing skill"
  "agent|carousel-growth-engine|none"
  "agent|identity-graph-operator|none"
  "agent|incident-response-commander|engineering:incident-response"
  "agent|sre|none"
  "skill|graphify|a project's own vetted runtime; never a global install"
)
DEFAULT_DUPLICATES=(
  "skill|frontend-design|frontend-design plugin (Anthropic)"
  "skill|grill-me|grilling"
  "skill|security-audit|security-auditor skill and claude-security plugin"
  "skill|business-model-canvas|business-model-designer"
  "skill|ai-product|ai-product-patterns and ai-startup-building"
  "skill|code-review-excellence|code-review plugin and /code-review"
  "skill|bug-hunter|engineering:debug"
  "skill|architecture|engineering:architecture"
  "skill|backend-architect|engineering:system-design"
  "skill|lint-and-validate|engineering-quality-gate"
  "agent|code-reviewer|code-review plugin and /code-review"
  "agent|prompt-engineering-expert|prompt-engineering-expert skill"
)
DEFAULT_KEEP_PLUGINS=(
  "typescript-lsp@claude-plugins-official|1.0.0|6985b2d88dc0|official"
  "claude-security@claude-plugins-official|0.13.0|6985b2d88dc0|official"
  "playground@claude-plugins-official|6985b2d88dc0|6985b2d88dc0|official"
  "security-guidance|2.0.21|none|either"
  "code-review|1.0.1|none|either"
)

# ---------------------------------------------------------------------------
# Arguments
# ---------------------------------------------------------------------------

APPLY=0
LIST_NAMES=0
SHOW_MCP=0
PROJECT_DIR=""

usage() {
  cat <<'USAGE'
claude-cleanup-inventory.sh - inventory and dry run for a Claude Code cleanup

Default mode changes nothing.

  --list           also print every user skill name
  --mcp            also list MCP server names (runs `claude mcp list`, which
                   contacts the servers; only names are printed)
  --project DIR    also count skills, agents and commands in DIR/.claude
  --apply          back up skills, agents and commands, then MOVE the listed
                   items into ~/.claude/skill-archive/ (never deletes)
  -h, --help       show this help

Environment: CLAUDE_HOME (default ~/.claude), CODEX_SKILLS (default ~/.codex/skills)
Lists: built-in defaults, or arrays in $CLAUDE_HOME/cleanup-lists.conf
       (DO_NOT_REINSTALL, DUPLICATES, KEEP_PLUGINS).
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --apply) APPLY=1; shift ;;
    --list) LIST_NAMES=1; shift ;;
    --mcp) SHOW_MCP=1; shift ;;
    --project)
      [[ $# -ge 2 ]] || { echo "--project needs a directory" >&2; exit 64; }
      PROJECT_DIR="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 64 ;;
  esac
done

CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
CODEX_SKILLS="${CODEX_SKILLS:-$HOME/.codex/skills}"
ARCHIVE="$CLAUDE_HOME/skill-archive"
LISTS_FILE="$CLAUDE_HOME/cleanup-lists.conf"
TODAY="$(date '+%Y-%m-%d')"

# ---------------------------------------------------------------------------
# Lists: built-in defaults, optionally replaced per array by the lists file.
# The file is plain bash and is sourced, so it must be yours and private.
# ---------------------------------------------------------------------------

DO_NOT_REINSTALL=("${DEFAULT_DO_NOT_REINSTALL[@]}")
DUPLICATES=("${DEFAULT_DUPLICATES[@]}")
KEEP_PLUGINS=("${DEFAULT_KEEP_PLUGINS[@]}")
LISTS_SOURCE="built-in defaults"

if [[ -f "$LISTS_FILE" ]]; then
  if [[ -n "$(find "$LISTS_FILE" -maxdepth 0 \( -perm -g+w -o -perm -o+w \) -print 2>/dev/null)" ]]; then
    echo "Refusing to read $LISTS_FILE: it is writable by group or others. Run: chmod go-w \"$LISTS_FILE\"" >&2
    exit 78
  fi
  unset DO_NOT_REINSTALL DUPLICATES KEEP_PLUGINS
  # shellcheck source=/dev/null
  source "$LISTS_FILE"
  FROM_FILE=""
  if declare -p DO_NOT_REINSTALL >/dev/null 2>&1; then
    FROM_FILE="$FROM_FILE DO_NOT_REINSTALL"
  else
    DO_NOT_REINSTALL=("${DEFAULT_DO_NOT_REINSTALL[@]}")
  fi
  if declare -p DUPLICATES >/dev/null 2>&1; then
    FROM_FILE="$FROM_FILE DUPLICATES"
  else
    DUPLICATES=("${DEFAULT_DUPLICATES[@]}")
  fi
  if declare -p KEEP_PLUGINS >/dev/null 2>&1; then
    FROM_FILE="$FROM_FILE KEEP_PLUGINS"
  else
    KEEP_PLUGINS=("${DEFAULT_KEEP_PLUGINS[@]}")
  fi
  LISTS_SOURCE="$LISTS_FILE (from file:$FROM_FILE; the rest are defaults)"
fi

# Reject malformed entries early, so a typo cannot silently skip an item.
check_entries() {
  # $1 array name, $2 pattern of allowed kinds, $3 expected field count, then entries
  local label="$1" kinds="$2" fields="$3" entry n kind
  shift 3
  for entry in "$@"; do
    n="$(awk -F'|' '{print NF}' <<<"$entry")"
    kind="${entry%%|*}"
    if [[ "$n" -ne "$fields" ]]; then
      echo "Bad $label entry (expected $fields fields separated by |): $entry" >&2
      exit 65
    fi
    if [[ "$label" == "KEEP_PLUGINS" ]]; then
      kind="${entry##*|}"
    fi
    if ! grep -Eq -- "^($kinds)\$" <<<"$kind"; then
      echo "Bad $label entry (kind '$kind' is not one of: $kinds): $entry" >&2
      exit 65
    fi
  done
}
check_entries DO_NOT_REINSTALL "skill|agent|synced-plugin" 3 ${DO_NOT_REINSTALL[@]+"${DO_NOT_REINSTALL[@]}"}
check_entries DUPLICATES "skill|agent" 3 ${DUPLICATES[@]+"${DUPLICATES[@]}"}
check_entries KEEP_PLUGINS "official|either|custom" 4 ${KEEP_PLUGINS[@]+"${KEEP_PLUGINS[@]}"}

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

section() { printf '\n== %s ==\n' "$1"; }
note() { printf '  %s\n' "$1"; }

# Count direct entries of a directory (0 if it does not exist).
count_entries() {
  local d="$1"
  if [[ -d "$d" ]]; then
    find "$d" -mindepth 1 -maxdepth 1 | wc -l | tr -d ' '
  else
    echo 0
  fi
}

# Count subfolders that hold a SKILL.md (symlinked folders count too).
count_skills() {
  local d="$1" n=0 e
  [[ -d "$d" ]] || { echo 0; return; }
  for e in "$d"/*; do
    if [[ -f "$e/SKILL.md" ]]; then
      n=$((n + 1))
    fi
  done
  echo "$n"
}

# Print the base names of the entries of a directory, one per line.
names_in() {
  local d="$1" e
  [[ -d "$d" ]] || return 0
  for e in "$d"/*; do
    [[ -e "$e" || -L "$e" ]] || continue
    basename "$e"
  done
}

join_lines() { tr '\n' ' ' | sed 's/ *$//'; }

# Plugin text: `claude plugin list` plus installed_plugins.json (ids only
# matter; neither holds secrets). grep -F on a here-string avoids pipefail
# false negatives from grep -q closing a pipe early.
CLAUDE_LIST=""
HAVE_CLAUDE=0
if command -v claude >/dev/null 2>&1; then
  HAVE_CLAUDE=1
  CLAUDE_LIST="$(claude plugin list 2>/dev/null || true)"
fi
PLUGIN_TEXT="$CLAUDE_LIST"
if [[ -f "$CLAUDE_HOME/plugins/installed_plugins.json" ]]; then
  PLUGIN_TEXT="$PLUGIN_TEXT
$(cat "$CLAUDE_HOME/plugins/installed_plugins.json")"
fi

has_plugin() { grep -Fq -- "$1" <<<"$PLUGIN_TEXT"; }

# ---------------------------------------------------------------------------
# 1. Inventory
# ---------------------------------------------------------------------------

printf 'Claude Code cleanup inventory (%s)\n' "$TODAY"
printf 'Home: %s\n' "$CLAUDE_HOME"
printf 'Lists: %s\n' "$LISTS_SOURCE"
if [[ ! -d "$CLAUDE_HOME" ]]; then
  echo "No such folder: $CLAUDE_HOME. Nothing to inventory."
  exit 0
fi
if [[ "$APPLY" -eq 1 ]]; then
  echo "Mode: APPLY (backs up, then moves; never deletes)"
else
  echo "Mode: dry run (changes nothing)"
fi

section "Inventory"
SKILL_N="$(count_skills "$CLAUDE_HOME/skills")"
SKILL_ALL="$(count_entries "$CLAUDE_HOME/skills")"
note "user skills (folders with SKILL.md): $SKILL_N of $SKILL_ALL entries in skills/"
OTHER="$(
  for e in "$CLAUDE_HOME"/skills/*; do
    if [[ -e "$e" && ! -f "$e/SKILL.md" ]]; then
      basename "$e"
    fi
  done | join_lines
)"
if [[ -n "$OTHER" ]]; then
  note "entries without SKILL.md (left alone): $OTHER"
fi
if [[ "$LIST_NAMES" -eq 1 ]]; then
  note "skill names: $(
    for e in "$CLAUDE_HOME"/skills/*; do
      if [[ -f "$e/SKILL.md" ]]; then
        basename "$e"
      fi
    done | join_lines
  )"
fi
note "user agents: $(count_entries "$CLAUDE_HOME/agents") ($(names_in "$CLAUDE_HOME/agents" | sed 's/\.md$//' | join_lines))"
note "user commands: $(count_entries "$CLAUDE_HOME/commands") ($(names_in "$CLAUDE_HOME/commands" | sed 's/\.md$//' | join_lines))"
archive_other() {
  local e b
  for e in "$ARCHIVE"/*; do
    [[ -e "$e" ]] || continue
    b="$(basename "$e")"
    if [[ "$b" != "skills" && "$b" != "agents" ]]; then
      echo "$b"
    fi
  done
}
note "skill-archive: skills=$(count_entries "$ARCHIVE/skills") agents=$(count_entries "$ARCHIVE/agents") other=$(archive_other | join_lines)"
if [[ -d "$CODEX_SKILLS" ]]; then
  note "Codex skills (never touched): $(count_entries "$CODEX_SKILLS")"
else
  note "Codex skills: folder not found"
fi
if [[ -n "$PROJECT_DIR" ]]; then
  note "project scope $PROJECT_DIR/.claude: skills=$(count_skills "$PROJECT_DIR/.claude/skills") agents=$(count_entries "$PROJECT_DIR/.claude/agents") commands=$(count_entries "$PROJECT_DIR/.claude/commands")"
else
  note "project scope: pass --project DIR to count DIR/.claude"
fi

if [[ "$HAVE_CLAUDE" -eq 1 ]]; then
  note "plugins (id, version, scope):"
  awk '
    $2 ~ /@/ && $1 !~ /:/ { id=$2; v="?"; s=""; next }
    /Version:/ { v=$2 }
    /Scope:/   { s=$2 }
    /Status:/  { if (id != "") { if (s == "") s="synced"; printf "    %s %s %s\n", id, v, s; id="" } }
  ' <<<"$CLAUDE_LIST"
else
  note "claude not on PATH: plugin ids come from installed_plugins.json only"
fi

if [[ "$SHOW_MCP" -eq 1 ]]; then
  if [[ "$HAVE_CLAUDE" -eq 1 ]]; then
    note "MCP servers (names only):"
    claude mcp list 2>/dev/null | sed -nE \
      's/^((claude\.ai [A-Za-z0-9 ._+-]+)|(plugin:[a-z0-9-]+:[A-Za-z0-9 ._-]+)|([A-Za-z0-9._-]+)): .*$/    \1/p' || true
  else
    note "MCP servers: claude not on PATH"
  fi
else
  note "MCP servers: skipped (pass --mcp; it contacts every server)"
fi

# ---------------------------------------------------------------------------
# 2. Dry run: what would move
# ---------------------------------------------------------------------------

section "Items to move into skill-archive"
TO_MOVE=()   # entries "kind|name|reason"

collect() {
  # $1 label, then the list entries (kind|name|replacement)
  local label="$1" entry kind name reason path
  shift
  for entry in "$@"; do
    IFS='|' read -r kind name reason <<<"$entry"
    case "$kind" in
      agent) path="$CLAUDE_HOME/agents/$name.md" ;;
      skill) path="$CLAUDE_HOME/skills/$name" ;;
      *) continue ;;
    esac
    if [[ -e "$path" || -L "$path" ]]; then
      TO_MOVE+=("$kind|$name|$label; replacement: $reason")
    fi
  done
}

collect "do not reinstall" ${DO_NOT_REINSTALL[@]+"${DO_NOT_REINSTALL[@]}"}
collect "duplicate" ${DUPLICATES[@]+"${DUPLICATES[@]}"}

if [[ "${#TO_MOVE[@]}" -eq 0 ]]; then
  note "nothing left to move: every listed item is already out of skills/ and agents/"
else
  for entry in "${TO_MOVE[@]}"; do
    IFS='|' read -r kind name reason <<<"$entry"
    if [[ "$kind" == "agent" ]]; then
      note "WOULD MOVE agents/$name.md -> skill-archive/agents/ ($reason)"
    else
      note "WOULD MOVE skills/$name -> skill-archive/skills/ ($reason)"
    fi
  done
fi

section "Keep-list plugins"
MISSING=0
for entry in ${KEEP_PLUGINS[@]+"${KEEP_PLUGINS[@]}"}; do
  IFS='|' read -r id ver sha kind <<<"$entry"
  case "$kind" in
    official)
      if has_plugin "$id"; then
        note "present  $id (reference $ver, commit $sha)"
      else
        MISSING=$((MISSING + 1))
        note "MISSING  $id (reference $ver, commit $sha)"
        note "         claude plugin install $id --scope user"
      fi
      ;;
    either)
      if has_plugin "$id@claude-plugins-official"; then
        note "present  $id@claude-plugins-official (reference $ver)"
      elif has_plugin "$id@synced"; then
        note "present  $id@synced via claude.ai sync (reference $ver); do not install a second copy"
      else
        MISSING=$((MISSING + 1))
        note "MISSING  $id (reference $ver); sign in to claude.ai and wait for the sync, or:"
        note "         claude plugin install $id@claude-plugins-official --scope user"
      fi
      ;;
    custom)
      if has_plugin "$id"; then
        note "present  $id (reference $ver, commit $sha)"
      else
        MISSING=$((MISSING + 1))
        note "MISSING  $id (reference $ver, commit $sha); add its marketplace first, then:"
        note "         claude plugin install $id --scope user"
      fi
      ;;
  esac
done
if [[ "$MISSING" -eq 0 ]]; then
  note "no keep-list plugin is missing"
fi

section "claude-security setting"
if has_plugin "claude-security@claude-plugins-official"; then
  if [[ -f "$CLAUDE_HOME/settings.json" ]] \
     && grep -Eq '"live_view"[[:space:]]*:[[:space:]]*("false"|false)' "$CLAUDE_HOME/settings.json"; then
    note "live_view is false in settings.json"
  else
    note "live_view is NOT set to false: see the runbook, step e"
  fi
else
  note "claude-security not installed; set live_view to false right after installing it"
fi

section "Synced plugins to switch off in your claude.ai account (manual)"
SYNC_LEFT=0
SYNC_LISTED=0
for entry in ${DO_NOT_REINSTALL[@]+"${DO_NOT_REINSTALL[@]}"}; do
  IFS='|' read -r kind name reason <<<"$entry"
  if [[ "$kind" != "synced-plugin" ]]; then
    continue
  fi
  SYNC_LISTED=$((SYNC_LISTED + 1))
  if grep -Fq -- "$name" <<<"$PLUGIN_TEXT"; then
    SYNC_LEFT=$((SYNC_LEFT + 1))
    note "still synced  $name ($reason)"
  fi
done
if [[ "$SYNC_LISTED" -eq 0 ]]; then
  note "no synced plugin is listed in the lists in use"
elif [[ "$SYNC_LEFT" -eq 0 ]]; then
  note "none of the listed synced plugins is present"
fi

section "Restore paths that could bring retired items back"
if command -v graphify >/dev/null 2>&1; then
  note "WARNING: a global graphify command is on PATH; it is a rejected install. Do not use it."
else
  note "no global graphify command on PATH"
fi
if [[ -d "$CODEX_SKILLS" ]]; then
  CODEX_HITS="$(
    for entry in ${DO_NOT_REINSTALL[@]+"${DO_NOT_REINSTALL[@]}"} ${DUPLICATES[@]+"${DUPLICATES[@]}"}; do
      IFS='|' read -r kind name _reason <<<"$entry"
      if [[ "$kind" == "skill" && -e "$CODEX_SKILLS/$name" ]]; then
        echo "$name"
      fi
    done | join_lines
  )"
  if [[ -n "$CODEX_HITS" ]]; then
    note "Codex has its own copies (Codex only, left alone): $CODEX_HITS"
  else
    note "no listed skill names in the Codex skills folder"
  fi
fi
note "never run an installer just to see what it does: many have no help or dry-run flag and install everything in their manifest"

# ---------------------------------------------------------------------------
# 3. Apply (only with --apply)
# ---------------------------------------------------------------------------

if [[ "$APPLY" -ne 1 ]]; then
  section "Summary"
  note "dry run only: ${#TO_MOVE[@]} item(s) to move, $MISSING keep-list plugin(s) missing, $SYNC_LEFT synced plugin(s) to switch off"
  note "run with --apply to back up and move; plugins are never installed by this script"
  exit 0
fi

section "Apply"
BACKUP="$ARCHIVE/$TODAY-backup"
if [[ -d "$BACKUP" ]]; then
  note "backup already exists, skipping: $BACKUP"
else
  mkdir -p "$ARCHIVE"
  PARTIAL="$BACKUP.partial"
  if [[ -e "$PARTIAL" ]]; then
    echo "A half-finished backup exists at $PARTIAL. Move it aside and run again." >&2
    exit 1
  fi
  mkdir -p "$PARTIAL"
  for part in skills agents commands; do
    if [[ -d "$CLAUDE_HOME/$part" ]]; then
      cp -a "$CLAUDE_HOME/$part" "$PARTIAL/$part"
      note "backed up $part"
    else
      note "no $part folder to back up"
    fi
  done
  if [[ "$HAVE_CLAUDE" -eq 1 ]]; then
    printf '%s\n' "$CLAUDE_LIST" > "$PARTIAL/plugin-list.txt"
    note "saved plugin-list.txt"
  fi
  mv "$PARTIAL" "$BACKUP"
  note "backup complete: $BACKUP"
fi

# Pick a target that does not exist: name, then name-2, name-3, and so on.
free_target() {
  local dir="$1" stem="$2" ext="$3" n=2 t
  t="$dir/$stem$ext"
  while [[ -e "$t" || -L "$t" ]]; do
    t="$dir/$stem-$n$ext"
    n=$((n + 1))
  done
  printf '%s\n' "$t"
}

MOVED=0
if [[ "${#TO_MOVE[@]}" -gt 0 ]]; then
  for entry in "${TO_MOVE[@]}"; do
    IFS='|' read -r kind name _reason <<<"$entry"
    if [[ "$kind" == "agent" ]]; then
      src="$CLAUDE_HOME/agents/$name.md"
      mkdir -p "$ARCHIVE/agents"
      dst="$(free_target "$ARCHIVE/agents" "$name" ".md")"
    else
      src="$CLAUDE_HOME/skills/$name"
      mkdir -p "$ARCHIVE/skills"
      dst="$(free_target "$ARCHIVE/skills" "$name" "")"
    fi
    mv -- "$src" "$dst"
    MOVED=$((MOVED + 1))
    note "moved $src -> $dst"
  done
fi

section "Summary"
note "moved $MOVED item(s); nothing was deleted; backup at $BACKUP"
note "next: install missing keep-list plugins with the commands above, then follow runbook step f"
