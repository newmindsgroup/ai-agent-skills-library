#!/usr/bin/env bash
# Validate every skill in skills/ using the agentskills CLI.
set -euo pipefail

cd "$(dirname "$0")/.."

if ! command -v agentskills >/dev/null 2>&1; then
  echo "[err] agentskills CLI not found. Install with: pip install agentskills" >&2
  exit 1
fi

fail=0
for skill in skills/*/; do
  name="$(basename "$skill")"
  if agentskills validate "$skill" >/dev/null 2>&1; then
    echo "[ ok ] $name"
  else
    echo "[fail] $name"
    agentskills validate "$skill" || true
    fail=$((fail+1))
  fi
done

if [[ $fail -gt 0 ]]; then
  echo ""
  echo "$fail skill(s) failed validation."
  exit 1
fi
echo ""
echo "All skills valid."
