#!/usr/bin/env bash
#
# AI Agent Skills Library — universal installer
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/newmindsgroup/ai-agent-skills-library/main/install.sh | bash
#   curl -fsSL ... | bash -s -- <skill-name>                  # install a single skill
#   curl -fsSL ... | bash -s -- --scope global                # force global install
#   curl -fsSL ... | bash -s -- --scope project               # force project install
#   curl -fsSL ... | bash -s -- --tool claude-code            # force a specific tool
#
# Detects installed IDEs and copies skills into the correct folder for each.

set -euo pipefail

REPO_URL="https://github.com/newmindsgroup/ai-agent-skills-library"
REPO_RAW="https://raw.githubusercontent.com/newmindsgroup/ai-agent-skills-library/main"
TARBALL_URL="https://github.com/newmindsgroup/ai-agent-skills-library/archive/refs/heads/main.tar.gz"

SCOPE=""
SKILL_FILTER=""
FORCED_TOOL=""
TOOLS_DETECTED=()

# ---------- argument parsing ----------
while [[ $# -gt 0 ]]; do
  case "$1" in
    --scope) SCOPE="$2"; shift 2 ;;
    --tool) FORCED_TOOL="$2"; shift 2 ;;
    --help|-h)
      grep '^#' "$0" | sed 's/^#//'
      exit 0
      ;;
    *) SKILL_FILTER="$1"; shift ;;
  esac
done

# ---------- pretty printing ----------
c_reset=$'\033[0m'; c_bold=$'\033[1m'; c_dim=$'\033[2m'
c_green=$'\033[32m'; c_yellow=$'\033[33m'; c_cyan=$'\033[36m'; c_red=$'\033[31m'

info()  { printf '%s[info]%s %s\n' "$c_cyan" "$c_reset" "$1"; }
ok()    { printf '%s[ ok ]%s %s\n' "$c_green" "$c_reset" "$1"; }
warn()  { printf '%s[warn]%s %s\n' "$c_yellow" "$c_reset" "$1"; }
err()   { printf '%s[err ]%s %s\n' "$c_red" "$c_reset" "$1" >&2; }
head1() { printf '\n%s%s%s\n' "$c_bold" "$1" "$c_reset"; }

# ---------- download skills ----------
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

head1 "AI Agent Skills Library installer"
info "Fetching skills from $REPO_URL"
if ! curl -fsSL "$TARBALL_URL" | tar -xz -C "$TMPDIR"; then
  err "Failed to download skills archive."
  exit 1
fi
SRC_DIR="$(find "$TMPDIR" -maxdepth 2 -type d -name 'skills' | head -1)"
if [[ -z "$SRC_DIR" ]]; then
  err "Could not locate skills/ directory in archive."
  exit 1
fi

# ---------- detect which skills to install ----------
SKILLS=()
if [[ -n "$SKILL_FILTER" ]]; then
  if [[ -d "$SRC_DIR/$SKILL_FILTER" ]]; then
    SKILLS=("$SKILL_FILTER")
  else
    err "Skill not found: $SKILL_FILTER"
    info "Available skills:"
    ls -1 "$SRC_DIR"
    exit 1
  fi
else
  while IFS= read -r d; do
    SKILLS+=("$(basename "$d")")
  done < <(find "$SRC_DIR" -mindepth 1 -maxdepth 1 -type d | sort)
fi
info "Skills to install: ${SKILLS[*]}"

# ---------- detect tools ----------
# A tool is considered "detected project-scoped" if its project config folder
# already exists in the current working directory. Otherwise it's candidate for global.
detect_tools() {
  local found=()
  # Project-scoped signals (current dir):
  [[ -d ".claude"        ]] && found+=("claude-code:project")
  [[ -d ".cursor"        ]] && found+=("cursor:project")
  [[ -f "AGENTS.md" || -d ".codex" ]] && found+=("codex:project")
  [[ -d ".windsurf"      ]] && found+=("windsurf:project")
  [[ -d ".opencode"      ]] && found+=("opencode:project")
  [[ -d ".agent"         ]] && found+=("antigravity:project")

  # If nothing project-scoped, consider global installs based on binary presence / home dirs.
  if [[ ${#found[@]} -eq 0 ]]; then
    command -v claude       >/dev/null 2>&1 && found+=("claude-code:global")
    command -v cursor       >/dev/null 2>&1 && found+=("cursor:global")
    command -v codex        >/dev/null 2>&1 && found+=("codex:global")
    command -v windsurf     >/dev/null 2>&1 && found+=("windsurf:global")
    command -v opencode     >/dev/null 2>&1 && found+=("opencode:global")
    [[ -d "$HOME/.gemini/antigravity" ]] && found+=("antigravity:global")

    # Home-dir fallback signals
    [[ -d "$HOME/.claude"   ]] && found+=("claude-code:global")
    [[ -d "$HOME/.config/opencode" ]] && found+=("opencode:global")
  fi

  # Deduplicate
  printf '%s\n' "${found[@]}" | awk '!seen[$0]++'
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
  warn "Run from inside a project that already has one of these configured,"
  warn "or re-run with --tool <name> --scope <project|global>."
  exit 2
fi

head1 "Detected tools"
for t in "${TOOLS_DETECTED[@]}"; do info "  - $t"; done

# ---------- installation targets ----------
target_dir() {
  local tool="$1" scope="$2"
  case "$tool:$scope" in
    claude-code:project)  echo ".claude/skills" ;;
    claude-code:global)   echo "$HOME/.claude/skills" ;;
    cursor:project)       echo ".cursor/skills" ;;
    cursor:global)        echo "$HOME/.cursor/skills" ;;
    codex:project)        echo "skills" ;;  # codex reads AGENTS.md which we generate
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

# ---------- install per tool ----------
install_count=0
for t in "${TOOLS_DETECTED[@]}"; do
  tool="${t%%:*}"
  scope="${t##*:}"
  # honor --scope override
  [[ -n "$SCOPE" ]] && scope="$SCOPE"

  dest="$(target_dir "$tool" "$scope")" || { warn "Unknown tool:$tool"; continue; }

  head1 "Installing into $tool ($scope) → $dest"
  mkdir -p "$dest"

  for skill in "${SKILLS[@]}"; do
    if [[ -d "$dest/$skill" ]]; then
      warn "  $skill already exists at $dest/$skill — skipping (remove it to reinstall)."
      continue
    fi
    cp -R "$SRC_DIR/$skill" "$dest/"
    ok  "  Installed $skill"
    install_count=$((install_count+1))
  done

  # Generate AGENTS.md for codex if missing
  if [[ "$tool" == "codex" && "$scope" == "project" && ! -f "AGENTS.md" ]]; then
    cat > AGENTS.md <<EOF
# AGENTS.md

This project uses the AI Agent Skills Library ($REPO_URL).

Skills live in \`skills/\`. Each skill is a folder with a \`SKILL.md\` file and optional \`references/\`, \`scripts/\`, and \`assets/\` directories. Apply the skill's instructions when the user's request matches the skill's description.

## Installed skills

$(for s in "${SKILLS[@]}"; do echo "- [\`$s\`](skills/$s/SKILL.md)"; done)

Read each skill's \`SKILL.md\` frontmatter to know when to trigger it.
EOF
    ok "  Wrote AGENTS.md"
  fi
done

head1 "Done"
ok "$install_count skill(s) installed across ${#TOOLS_DETECTED[@]} tool(s)."
info "Restart your IDE or start a new session for skills to load."
info "See $REPO_URL for updates and new skills."
