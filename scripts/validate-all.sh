#!/usr/bin/env bash
# Validate every exported skill in dist/skills/.
#
# Strategy:
#   1. Always run the lightweight frontmatter validator (no external deps,
#      works in any CI / dev environment).
#   2. Optionally run Agent Skills CLI full-spec validation with FULL_SPEC=1.
#
# The lightweight validator covers the core frontmatter requirements (name
# matches folder, description present + length-bounded, license present, file
# under 500 lines). The full-spec pass can be slow for the whole library, so it
# is explicit instead of surprising every local/CI validation run.
#
# Exits non-zero on any failure.
set -euo pipefail

cd "$(dirname "$0")/.."

SKILLS_ROOT="${SKILLS_ROOT:-dist/skills}"
if [[ ! -d "$SKILLS_ROOT" && -d "skills" ]]; then
  SKILLS_ROOT="skills"
fi

# Always run the lightweight pass first — covers frontmatter integrity for every skill
bash scripts/validate-frontmatter.sh "$SKILLS_ROOT"

# Ensure quarantined/gated skills cannot quietly re-enter the default install path
ruby scripts/validate-safety-policy.rb

# Optional second pass with the Agent Skills CLI.
if [[ "${FULL_SPEC:-0}" == "1" ]]; then
  validator=()
  if command -v agentskills >/dev/null 2>&1; then
    validator=(agentskills validate)
  elif command -v agent-skills >/dev/null 2>&1; then
    validator=(agent-skills validate)
  elif command -v npx >/dev/null 2>&1; then
    validator=(npx -y agent-skills-cli validate)
  else
    echo ""
    echo "FULL_SPEC=1 requested, but no Agent Skills CLI runner was found."
    echo "Install with: npm install -g agent-skills-cli"
    exit 1
  fi

  echo ""
  echo "Running full Agent Skills spec validation..."
  fail=0
  for skill in "$SKILLS_ROOT"/*/; do
    name="$(basename "$skill")"
    if "${validator[@]}" "$skill" >/dev/null 2>&1; then
      echo "[ ok ] $name (full spec)"
    else
      echo "[fail] $name (full spec)"
      "${validator[@]}" "$skill" || true
      fail=$((fail+1))
    fi
  done
  if [[ $fail -gt 0 ]]; then
    echo ""
    echo "$fail skill(s) failed full-spec validation."
    exit 1
  fi
  echo ""
  echo "All skills pass full spec validation."
else
  echo ""
  echo "(Full-spec validation skipped. Run FULL_SPEC=1 ./scripts/validate-all.sh to use the Agent Skills CLI.)"
fi
