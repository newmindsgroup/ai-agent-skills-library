#!/usr/bin/env bash
# Validate every skill in skills/.
#
# Strategy:
#   1. Always run the lightweight frontmatter validator (no external deps,
#      works in any CI / dev environment).
#   2. If the agentskills CLI is available locally, also run the full validator
#      for deeper spec compliance.
#
# The agentskills CLI is not yet on PyPI as of this commit; the lightweight
# validator covers the core frontmatter requirements (name matches folder,
# description present + length-bounded, license present, file under 500 lines).
#
# Exits non-zero on any failure.
set -euo pipefail

cd "$(dirname "$0")/.."

# Always run the lightweight pass first — covers frontmatter integrity for every skill
bash scripts/validate-frontmatter.sh

# Optional second pass with the agentskills CLI if it's installed
if command -v agentskills >/dev/null 2>&1; then
  echo ""
  echo "agentskills CLI detected — running full spec validation..."
  fail=0
  for skill in skills/*/; do
    name="$(basename "$skill")"
    if agentskills validate "$skill" >/dev/null 2>&1; then
      echo "[ ok ] $name (full spec)"
    else
      echo "[fail] $name (full spec)"
      agentskills validate "$skill" || true
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
  echo "(agentskills CLI not installed — frontmatter pass only.)"
  echo "To run full-spec validation, install the agentskills CLI from https://agentskills.io"
fi
