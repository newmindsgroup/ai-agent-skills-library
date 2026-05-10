#!/usr/bin/env bash
# Ensure generated exports, indexes, source docs, and manifests are in sync.
set -euo pipefail

cd "$(dirname "$0")/.."

paths=(
  dist
  docs/SKILL-SOURCES.md
  docs/SKILLS-TRUST.md
  docs/STARTER-PACKS.md
  manifests/skills-manifest.json
  sources
)

before_status="$(git status --porcelain --untracked-files=all -- "${paths[@]}")"
before_diff="$(mktemp)"
after_diff="$(mktemp)"
trap 'rm -f "$before_diff" "$after_diff"' EXIT
git diff --binary -- "${paths[@]}" > "$before_diff"

ruby scripts/sync-skill-library.rb >/tmp/ai-agent-skills-sync-check.log

after_status="$(git status --porcelain --untracked-files=all -- "${paths[@]}")"
git diff --binary -- "${paths[@]}" > "$after_diff"

if [[ "$before_status" != "$after_status" ]] || ! cmp -s "$before_diff" "$after_diff"; then
  echo "Generated files are out of sync. Run:"
  echo "  ruby scripts/sync-skill-library.rb"
  echo ""
  git diff --stat -- "${paths[@]}"
  exit 1
fi

echo "Generated files are in sync."
