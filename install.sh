#!/usr/bin/env bash
#
# AI Agent Skills Library - universal installer
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/newmindsgroup/ai-agent-skills-library/main/install.sh | bash
#   curl -fsSL ... | bash -s -- newsletter-drafter
#   curl -fsSL ... | bash -s -- newsletter-drafter social-content-drafter
#   curl -fsSL ... | bash -s -- --bundle codex-essentials
#   curl -fsSL ... | bash -s -- --category "Frontend, UI, UX, Design"
#   curl -fsSL ... | bash -s -- --list
#   curl -fsSL ... | bash -s -- --search "business model"
#   curl -fsSL ... | bash -s -- --bundles
#   curl -fsSL ... | bash -s -- --dry-run --bundle agent-foundation
#   curl -fsSL ... | bash -s -- --force --tool codex --scope project newsletter-drafter
#
# Detects supported IDEs and copies skills into the correct folder for each.

set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/newmindsgroup/ai-agent-skills-library}"
TARBALL_URL="${TARBALL_URL:-https://github.com/newmindsgroup/ai-agent-skills-library/archive/refs/heads/main.tar.gz}"

SCOPE=""
FORCED_TOOL=""
BUNDLE_FILTER=""
CATEGORY_FILTER=""
SEARCH_QUERY=""
LIST_MODE=0
LIST_BUNDLES=0
LIST_CATEGORIES=0
DRY_RUN=0
FORCE=0
UPDATE=0
INSTALL_ALL=0
REQUESTED_SKILLS=()
TOOLS_DETECTED=()

usage() {
  cat <<'USAGE'
AI Agent Skills Library - universal installer

Usage:
  install.sh [skill-name ...]
  install.sh --bundle codex-essentials
  install.sh --category "Frontend, UI, UX, Design"
  install.sh --list
  install.sh --search "business model"
  install.sh --bundles
  install.sh --categories
  install.sh --dry-run --bundle agent-foundation
  install.sh --force --tool codex --scope project newsletter-drafter

Common options:
  --tool <name>              claude-code, cursor, codex, windsurf, opencode, antigravity
  --scope <project|global>   force project or global install target
  --bundle <name>            install a curated starter pack
  --category <name>          install all skills in a generated category
  --list                     list all skills and exit
  --search <query>           search names, categories, sources, bundles, and descriptions
  --bundles                  list starter packs and exit
  --categories               list categories and exit
  --dry-run                  show what would install without copying files
  --force                    overwrite selected existing skills
  --update                   refresh selected existing skills
  --all                      explicitly install the full library
USAGE
}

# ---------- argument parsing ----------
while [[ $# -gt 0 ]]; do
  case "$1" in
    --scope)
      [[ $# -ge 2 ]] || { echo "--scope requires project or global" >&2; exit 64; }
      SCOPE="$2"; shift 2 ;;
    --tool)
      [[ $# -ge 2 ]] || { echo "--tool requires a tool name" >&2; exit 64; }
      FORCED_TOOL="$2"; shift 2 ;;
    --bundle)
      [[ $# -ge 2 ]] || { echo "--bundle requires a bundle name" >&2; exit 64; }
      BUNDLE_FILTER="$2"; shift 2 ;;
    --category)
      [[ $# -ge 2 ]] || { echo "--category requires a category name" >&2; exit 64; }
      CATEGORY_FILTER="$2"; shift 2 ;;
    --search)
      [[ $# -ge 2 ]] || { echo "--search requires a query" >&2; exit 64; }
      SEARCH_QUERY="$2"; shift 2 ;;
    --list) LIST_MODE=1; shift ;;
    --bundles) LIST_BUNDLES=1; shift ;;
    --categories) LIST_CATEGORIES=1; shift ;;
    --dry-run) DRY_RUN=1; shift ;;
    --force) FORCE=1; shift ;;
    --update) UPDATE=1; FORCE=1; shift ;;
    --all) INSTALL_ALL=1; shift ;;
    --help|-h)
      usage
      exit 0
      ;;
    --)
      shift
      while [[ $# -gt 0 ]]; do REQUESTED_SKILLS+=("$1"); shift; done
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 64
      ;;
    *)
      REQUESTED_SKILLS+=("$1"); shift ;;
  esac
done

# ---------- pretty printing ----------
c_reset=$'\033[0m'; c_bold=$'\033[1m'
c_green=$'\033[32m'; c_yellow=$'\033[33m'; c_cyan=$'\033[36m'; c_red=$'\033[31m'

info()  { printf '%s[info]%s %s\n' "$c_cyan" "$c_reset" "$1"; }
ok()    { printf '%s[ ok ]%s %s\n' "$c_green" "$c_reset" "$1"; }
warn()  { printf '%s[warn]%s %s\n' "$c_yellow" "$c_reset" "$1"; }
err()   { printf '%s[err ]%s %s\n' "$c_red" "$c_reset" "$1" >&2; }
head1() { printf '\n%s%s%s\n' "$c_bold" "$1" "$c_reset"; }

dedupe() {
  awk 'NF && !seen[$0]++'
}

has_skill() {
  [[ -d "$SRC_DIR/$1" ]]
}

find_archive_root() {
  local found
  found="$(find "$TMPDIR" -maxdepth 3 -type d -path '*/dist/skills' | head -1)"
  if [[ -n "$found" ]]; then
    dirname "$(dirname "$found")"
    return
  fi

  found="$(find "$TMPDIR" -maxdepth 2 -type d -name 'skills' | head -1)"
  if [[ -n "$found" ]]; then
    dirname "$found"
    return
  fi

  return 1
}

list_skills() {
  if [[ -f "$INDEX_TSV" ]]; then
    awk -F '\t' 'NR > 1 { printf "%-36s %-38s %s\n", $1, $2, $9 }' "$INDEX_TSV"
  else
    find "$SRC_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort
  fi
}

list_categories() {
  if [[ -f "$INDEX_TSV" ]]; then
    awk -F '\t' 'NR > 1 { count[$2]++ } END { for (category in count) printf "%5d  %s\n", count[category], category }' "$INDEX_TSV" | sort -rn
  else
    warn "Category index not available in this archive."
  fi
}

list_bundles() {
  if [[ -d "$BUNDLES_DIR" ]]; then
    for bundle_file in "$BUNDLES_DIR"/*.txt; do
      [[ -f "$bundle_file" ]] || continue
      bundle_name="$(basename "$bundle_file" .txt)"
      printf "%-28s %s skills\n" "$bundle_name" "$(grep -cve '^[[:space:]]*$' "$bundle_file")"
    done | sort
  else
    warn "Bundle index not available in this archive."
  fi
}

search_skills() {
  local query
  query="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')"
  if [[ -f "$INDEX_TSV" ]]; then
    awk -F '\t' -v q="$query" '
      NR > 1 {
        haystack = tolower($1 " " $2 " " $3 " " $4 " " $5 " " $8 " " $9)
        if (index(haystack, q) > 0) {
          printf "%-36s %-38s %s\n", $1, $2, $9
        }
      }
    ' "$INDEX_TSV"
  else
    find "$SRC_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | grep -i -- "$query" || true
  fi
}

skills_for_category() {
  local category="$1"
  [[ -f "$INDEX_TSV" ]] || { err "Category filtering requires dist/skills-index.tsv."; exit 1; }
  awk -F '\t' -v category="$category" 'NR > 1 && $2 == category { print $1 }' "$INDEX_TSV" | sort
}

skills_for_bundle() {
  local bundle="$1"
  local bundle_file="$BUNDLES_DIR/$bundle.txt"
  [[ -f "$bundle_file" ]] || {
    err "Unknown bundle: $bundle"
    info "Available bundles:"
    list_bundles
    exit 1
  }
  grep -vE '^[[:space:]]*$' "$bundle_file"
}

# ---------- download skills ----------
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

head1 "AI Agent Skills Library installer"
info "Fetching skills from $REPO_URL"
if ! curl -fsSL "$TARBALL_URL" | tar -xz -C "$TMPDIR"; then
  err "Failed to download skills archive."
  exit 1
fi

ARCHIVE_ROOT="$(find_archive_root)" || {
  err "Could not locate dist/skills/ directory in archive."
  exit 1
}
SRC_DIR="$ARCHIVE_ROOT/dist/skills"
if [[ ! -d "$SRC_DIR" ]]; then
  SRC_DIR="$ARCHIVE_ROOT/skills"
fi
INDEX_TSV="$ARCHIVE_ROOT/dist/skills-index.tsv"
BUNDLES_DIR="$ARCHIVE_ROOT/dist/bundles"
[[ -d "$SRC_DIR" ]] || { err "Could not locate installable skills in archive."; exit 1; }

# ---------- discovery modes ----------
if [[ "$LIST_CATEGORIES" -eq 1 ]]; then
  head1 "Categories"
  list_categories
  exit 0
fi

if [[ "$LIST_BUNDLES" -eq 1 ]]; then
  head1 "Starter packs"
  list_bundles
  exit 0
fi

if [[ "$LIST_MODE" -eq 1 ]]; then
  head1 "Skills"
  list_skills
  exit 0
fi

if [[ -n "$SEARCH_QUERY" && ${#REQUESTED_SKILLS[@]} -eq 0 && -z "$BUNDLE_FILTER" && -z "$CATEGORY_FILTER" ]]; then
  head1 "Search results for \"$SEARCH_QUERY\""
  search_skills "$SEARCH_QUERY"
  exit 0
fi

# ---------- determine skills to install ----------
SKILLS=()
if [[ -n "$BUNDLE_FILTER" ]]; then
  while IFS= read -r skill; do SKILLS+=("$skill"); done < <(skills_for_bundle "$BUNDLE_FILTER")
fi
if [[ -n "$CATEGORY_FILTER" ]]; then
  while IFS= read -r skill; do SKILLS+=("$skill"); done < <(skills_for_category "$CATEGORY_FILTER")
fi
if [[ ${#REQUESTED_SKILLS[@]} -gt 0 ]]; then
  SKILLS+=("${REQUESTED_SKILLS[@]}")
fi
if [[ ${#SKILLS[@]} -eq 0 ]]; then
  if [[ "$INSTALL_ALL" -eq 0 ]]; then
    warn "No skill, bundle, or category selected. Installing the full library for backward compatibility."
    warn "For a smaller setup, use --bundle codex-essentials or run --bundles to see starter packs."
  fi
  while IFS= read -r d; do SKILLS+=("$(basename "$d")"); done < <(find "$SRC_DIR" -mindepth 1 -maxdepth 1 -type d | sort)
fi

DEDUPED_SKILLS=()
while IFS= read -r skill; do
  DEDUPED_SKILLS+=("$skill")
done < <(printf '%s\n' "${SKILLS[@]}" | dedupe)
SKILLS=("${DEDUPED_SKILLS[@]}")
for skill in "${SKILLS[@]}"; do
  if ! has_skill "$skill"; then
    err "Skill not found: $skill"
    info "Try --search \"$skill\" or --list."
    exit 1
  fi
done

info "Skills selected: ${#SKILLS[@]}"
if [[ ${#SKILLS[@]} -le 30 ]]; then
  printf '%s\n' "${SKILLS[@]}" | sed 's/^/  - /'
fi

# ---------- detect tools ----------
detect_tools() {
  local found=()
  [[ -d ".claude"        ]] && found+=("claude-code:project")
  [[ -d ".cursor"        ]] && found+=("cursor:project")
  [[ -f "AGENTS.md" || -d ".codex" ]] && found+=("codex:project")
  [[ -d ".windsurf"      ]] && found+=("windsurf:project")
  [[ -d ".opencode"      ]] && found+=("opencode:project")
  [[ -d ".agent"         ]] && found+=("antigravity:project")

  if [[ ${#found[@]} -eq 0 ]]; then
    command -v claude       >/dev/null 2>&1 && found+=("claude-code:global")
    command -v cursor       >/dev/null 2>&1 && found+=("cursor:global")
    command -v codex        >/dev/null 2>&1 && found+=("codex:global")
    command -v windsurf     >/dev/null 2>&1 && found+=("windsurf:global")
    command -v opencode     >/dev/null 2>&1 && found+=("opencode:global")
    [[ -d "$HOME/.gemini/antigravity" ]] && found+=("antigravity:global")
    [[ -d "$HOME/.claude"   ]] && found+=("claude-code:global")
    [[ -d "$HOME/.config/opencode" ]] && found+=("opencode:global")
  fi

  printf '%s\n' "${found[@]}" | dedupe
}

if [[ -n "$FORCED_TOOL" ]]; then
  effective_scope="${SCOPE:-project}"
  TOOLS_DETECTED=("${FORCED_TOOL}:${effective_scope}")
else
  while IFS= read -r line; do
    [[ -n "$line" ]] && TOOLS_DETECTED+=("$line")
  done < <(detect_tools)
fi

if [[ ${#TOOLS_DETECTED[@]} -eq 0 ]]; then
  warn "No supported IDE detected in this directory or on your PATH."
  warn "Supported tools: claude-code, cursor, codex, windsurf, opencode, antigravity"
  warn "Run from inside a configured project, or re-run with --tool <name> --scope <project|global>."
  exit 2
fi

head1 "Detected tools"
for t in "${TOOLS_DETECTED[@]}"; do info "  - $t"; done

target_dir() {
  local tool="$1" scope="$2"
  case "$tool:$scope" in
    claude-code:project)  echo ".claude/skills" ;;
    claude-code:global)   echo "$HOME/.claude/skills" ;;
    cursor:project)       echo ".cursor/skills" ;;
    cursor:global)        echo "$HOME/.cursor/skills" ;;
    codex:project)        echo "skills" ;;
    codex:global)         echo "$HOME/.codex/skills" ;;
    windsurf:project)     echo ".windsurf/skills" ;;
    windsurf:global)      echo "$HOME/.windsurf/skills" ;;
    opencode:project)     echo ".opencode/skills" ;;
    opencode:global)      echo "$HOME/.config/opencode/skills" ;;
    antigravity:project)  echo ".agent/skills" ;;
    antigravity:global)   echo "$HOME/.gemini/antigravity/skills" ;;
    *) return 1 ;;
  esac
}

if [[ "$DRY_RUN" -eq 1 ]]; then
  head1 "Dry run"
  for t in "${TOOLS_DETECTED[@]}"; do
    tool="${t%%:*}"
    scope="${t##*:}"
    [[ -n "$SCOPE" ]] && scope="$SCOPE"
    dest="$(target_dir "$tool" "$scope")" || { warn "Unknown tool:$tool"; continue; }
    info "Would install ${#SKILLS[@]} skill(s) into $tool ($scope) at $dest"
  done
  exit 0
fi

# ---------- install per tool ----------
install_count=0
for t in "${TOOLS_DETECTED[@]}"; do
  tool="${t%%:*}"
  scope="${t##*:}"
  [[ -n "$SCOPE" ]] && scope="$SCOPE"

  dest="$(target_dir "$tool" "$scope")" || { warn "Unknown tool:$tool"; continue; }

  head1 "Installing into $tool ($scope) -> $dest"
  mkdir -p "$dest"

  for skill in "${SKILLS[@]}"; do
    if [[ -d "$dest/$skill" ]]; then
      if [[ "$FORCE" -eq 1 ]]; then
        rm -rf "$dest/$skill"
      else
        warn "  $skill already exists at $dest/$skill - skipping (use --force or --update to reinstall)."
        continue
      fi
    fi
    cp -R "$SRC_DIR/$skill" "$dest/"
    ok "  Installed $skill"
    install_count=$((install_count+1))
  done

  if [[ "$tool" == "codex" && "$scope" == "project" && ! -f "AGENTS.md" ]]; then
    {
      echo "# AGENTS.md"
      echo ""
      echo "This project uses the AI Agent Skills Library ($REPO_URL)."
      echo ""
      echo "Skills live in \`skills/\`. Each skill is a folder with a \`SKILL.md\` file and optional \`references/\`, \`scripts/\`, and \`assets/\` directories. Apply the skill's instructions when the user's request matches the skill's description."
      echo ""
      echo "## Installed skills"
      echo ""
      for s in "${SKILLS[@]}"; do echo "- [\`$s\`](skills/$s/SKILL.md)"; done
      echo ""
      echo "Read each skill's \`SKILL.md\` frontmatter to know when to trigger it."
    } > AGENTS.md
    ok "  Wrote AGENTS.md"
  fi
done

head1 "Done"
ok "$install_count skill(s) installed across ${#TOOLS_DETECTED[@]} tool(s)."
[[ "$UPDATE" -eq 1 ]] && info "Update mode was enabled; existing selected skills were refreshed."
info "Restart your IDE or start a new session for skills to load."
info "See $REPO_URL for updates and new skills."
