#!/usr/bin/env bash
# Lightweight validator for SKILL.md frontmatter that doesn't require the agentskills CLI.
# Checks: file exists, name field present + matches folder, description present and 1-1024 chars,
# license present, file under 500 lines (warning).
set -euo pipefail

cd "$(dirname "$0")/.."

SKILLS_ROOT="${1:-${SKILLS_ROOT:-dist/skills}}"
if [[ ! -d "$SKILLS_ROOT" && -d "skills" ]]; then
  SKILLS_ROOT="skills"
fi
if [[ ! -d "$SKILLS_ROOT" ]]; then
  echo "[fail] skills root not found: $SKILLS_ROOT"
  exit 1
fi

fail=0
warn=0

for skill in "$SKILLS_ROOT"/*/; do
  name="$(basename "$skill")"
  skillmd="${skill}SKILL.md"

  if [[ ! -f "$skillmd" ]]; then
    echo "[fail] $name — no SKILL.md"
    fail=$((fail+1))
    continue
  fi

  # Pull frontmatter (between first two --- lines)
  fm=$(awk '/^---$/{c++; next} c==1{print} c>=2{exit}' "$skillmd")
  if [[ -z "$fm" ]]; then
    echo "[fail] $name — no frontmatter"
    fail=$((fail+1))
    continue
  fi

  # name field present + matches folder
  fm_name=$(echo "$fm" | grep -E '^name:' | head -1 | sed 's/^name: *//; s/[" ]//g')
  if [[ -z "$fm_name" ]]; then
    echo "[fail] $name — frontmatter missing 'name'"
    fail=$((fail+1))
    continue
  fi
  if [[ "$fm_name" != "$name" ]]; then
    echo "[fail] $name — frontmatter name='$fm_name' does not match folder"
    fail=$((fail+1))
    continue
  fi

  # description present and reasonable length
  desc=$(echo "$fm" | awk '/^description:/{found=1; sub(/^description: */, ""); print; next} found && /^[a-z_]+:/{exit} found{print}' | tr -d '\n' | sed 's/^ *//; s/ *$//')
  if [[ -z "$desc" ]]; then
    echo "[fail] $name — frontmatter missing 'description'"
    fail=$((fail+1))
    continue
  fi
  desclen=${#desc}
  if (( desclen < 30 )); then
    echo "[fail] $name — description too short ($desclen chars; min 30)"
    fail=$((fail+1))
    continue
  fi
  if (( desclen > 1500 )); then
    echo "[fail] $name — description too long ($desclen chars; max 1500)"
    fail=$((fail+1))
    continue
  fi
  if [[ "$desc" == "One sentence - what this skill does and when to invoke it" || "$desc" =~ ^Use\ when\ working\ with\ [a-z0-9\ -]+$ ]]; then
    echo "[fail] $name — description looks like a placeholder; write a specific trigger-focused description"
    fail=$((fail+1))
    continue
  fi

  # license field
  if ! echo "$fm" | grep -qE '^license:'; then
    echo "[warn] $name — frontmatter missing 'license' (add 'license: MIT')"
    warn=$((warn+1))
  fi

  # body length (warning at 500)
  bodylen=$(wc -l < "$skillmd")
  if (( bodylen > 500 )); then
    echo "[warn] $name — SKILL.md is $bodylen lines (recommended max 500; move depth to references/)"
    warn=$((warn+1))
  fi

  echo "[ ok ] $name"
done

echo ""
if (( fail > 0 )); then
  echo "$fail skill(s) failed validation; $warn warning(s)."
  exit 1
fi
echo "All skills valid; $warn warning(s)."
