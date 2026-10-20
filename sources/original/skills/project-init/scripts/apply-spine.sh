#!/usr/bin/env bash
# apply-spine.sh — inject or refresh the shared operating standard (four pillars +
# working style) into a project's AGENTS.md, preserving all existing content.
#
# Idempotent:
#   - no AGENTS.md            -> create it with a header + the SPINE block
#   - AGENTS.md w/ SPINE markers -> replace only the block between the markers
#   - AGENTS.md w/o markers   -> append the SPINE block at the end
#
# Usage: apply-spine.sh [TARGET_DIR]   (default: current directory)
#        apply-spine.sh --check [DIR]  (report status, write nothing; exit 0 in-sync, 3 drift)
# Version-Timestamp: 2026-06-25
set -euo pipefail

CHECK=0
if [ "${1:-}" = "--check" ]; then CHECK=1; shift; fi
TARGET="${1:-$PWD}"
[ -d "$TARGET" ] || { echo "ERROR: not a directory: $TARGET" >&2; exit 2; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SPINE_FILE="$SCRIPT_DIR/../references/operating-spine.md"
[ -f "$SPINE_FILE" ] || { echo "ERROR: spine source missing: $SPINE_FILE" >&2; exit 2; }

AGENTS="$TARGET/AGENTS.md"
START='<!-- SPINE:START'
END='<!-- SPINE:END'

has_markers() { [ -f "$AGENTS" ] && grep -qF "$START" "$AGENTS" && grep -qF "$END" "$AGENTS"; }
in_sync() {
  has_markers || return 1
  # Compare current between-markers block to the canonical one.
  awk -v s="$START" -v e="$END" 'index($0,s){f=1} f{print} index($0,e){f=0}' "$AGENTS" \
    | diff -q - "$SPINE_FILE" >/dev/null 2>&1
}

if [ "$CHECK" -eq 1 ]; then
  if [ ! -f "$AGENTS" ]; then echo "DRIFT - no AGENTS.md in $TARGET"; exit 3; fi
  if in_sync; then echo "IN SYNC - $AGENTS"; exit 0; fi
  echo "DRIFT - $AGENTS missing/stale operating standard"; exit 3
fi

if [ ! -f "$AGENTS" ]; then
  {
    echo "# Agent Instructions"
    echo
    echo "Project-specific notes go outside the SPINE markers. The block between them is"
    echo "the shared operating standard (synced from ide-config-template); your edits"
    echo "above and below the markers are preserved."
    echo
    cat "$SPINE_FILE"
  } > "$AGENTS"
  echo "CREATED  - $AGENTS"
elif has_markers; then
  if in_sync; then echo "IN SYNC  - $AGENTS"; exit 0; fi
  # Replace content between markers (inclusive) with the canonical block.
  tmp="$(mktemp)"
  awk -v s="$START" -v e="$END" -v rf="$SPINE_FILE" '
    index($0,s){ while((getline line < rf)>0) print line; close(rf); skip=1; next }
    index($0,e){ skip=0; next }
    !skip{ print }
  ' "$AGENTS" > "$tmp"
  mv "$tmp" "$AGENTS"
  echo "REFRESHED - $AGENTS"
else
  # Existing AGENTS.md with no markers: append the standard, preserve everything.
  { echo; cat "$SPINE_FILE"; } >> "$AGENTS"
  echo "MERGED   - appended standard to $AGENTS (existing content preserved)"
fi
