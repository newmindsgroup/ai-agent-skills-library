#!/usr/bin/env bash
# Smoke test the installer against a local archive of the current working tree.
set -euo pipefail

cd "$(dirname "$0")/.."

archive="$(mktemp -t ai-agent-skills-local.XXXXXX.tar.gz)"
project="$(mktemp -d)"
installer="$(pwd)/install.sh"

cleanup() {
  rm -rf "$archive" "$project"
}
trap cleanup EXIT

tar --exclude='./.git' -czf "$archive" .

(
  cd "$project"
  TARBALL_URL="file://$archive" bash "$installer" --list >/tmp/ai-agent-skills-install-list.log
  TARBALL_URL="file://$archive" bash "$installer" --bundles >/tmp/ai-agent-skills-install-bundles.log
  TARBALL_URL="file://$archive" bash "$installer" --search newsletter >/tmp/ai-agent-skills-install-search.log
  TARBALL_URL="file://$archive" bash "$installer" --tool codex --scope project --bundle agent-foundation --dry-run >/tmp/ai-agent-skills-install-dry-run.log
  TARBALL_URL="file://$archive" bash "$installer" --tool codex --scope project newsletter-drafter >/tmp/ai-agent-skills-install-single.log
  test -f skills/newsletter-drafter/SKILL.md
  test -f AGENTS.md
)

echo "Installer smoke test passed."
