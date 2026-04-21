#!/usr/bin/env bash
# Scaffold a new skill folder.
# Usage: ./scripts/new-skill.sh <skill-name> ["one-line description"]

set -euo pipefail
cd "$(dirname "$0")/.."

name="${1:-}"
desc="${2:-"Describe what this skill does and WHEN to trigger it. Written in third person."}"

if [[ -z "$name" ]]; then
  echo "Usage: $0 <skill-name> [description]" >&2
  exit 1
fi

if ! [[ "$name" =~ ^[a-z0-9]([a-z0-9-]*[a-z0-9])?$ ]]; then
  echo "[err] name must be lowercase, hyphens/digits only, no leading/trailing hyphen." >&2
  exit 1
fi

dest="skills/$name"
if [[ -d "$dest" ]]; then
  echo "[err] skills/$name already exists." >&2
  exit 1
fi

mkdir -p "$dest/references"

cat > "$dest/SKILL.md" <<EOF
---
name: $name
description: "$desc"
license: MIT
metadata:
  version: '0.1.0'
  author: ''
---

# $(echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)$i=toupper(substr($i,1,1)) substr($i,2)} 1')

## When to use this skill

Describe the trigger conditions. Be specific about the phrases a user would say that should activate this skill.

## Instructions

1. Step one.
2. Step two.
3. Step three.

## Examples

### Example 1
**User:** "…"
**Expected response:** …

### Example 2
**User:** "…"
**Expected response:** …
EOF

echo "[ ok ] Created $dest/"
echo "       Edit $dest/SKILL.md to fill in the content."
echo "       Validate with: ./scripts/validate-all.sh"
