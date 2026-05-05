#!/usr/bin/env python3
"""Install cherry-picked agency-agents into <CLAUDE_AGENTS_DIR>/ with:
  - kebab-case name (so `@name` invocation works cleanly)
  - explicit "Use PROACTIVELY when..." trigger phrases (so the harness auto-routes)
  - voice DNA paths injected into voice-aware agents from --voice-paths-file

Portable across Mac and Linux. Voice DNA paths come from a JSON file passed
at install time, NOT hardcoded here — same script runs on every host.

Usage:
  install.py --repo <agency-agents-clone> \\
             --target <claude-agents-dir> \\
             --voice-paths-file <json> \\
             [--manifest <manifest.json>]

The voice-paths-file format is:
  { "voice_dna_paths": [ "<absolute path 1>", "<absolute path 2>", ... ] }

If --voice-paths-file is omitted, voice-aware agents are still installed but
without the voice-DNA injection (they'll defer to user-level CLAUDE.md
precedence rules instead). Re-run with the file to add the injection.
"""

import argparse
import json
import re
import sys
from pathlib import Path

INSTALL_TAG = "agency-agents-cherry-pick"


def parse_frontmatter(text: str) -> tuple[dict, str]:
    m = re.match(r"^---\n(.*?)\n---\n(.*)$", text, re.DOTALL)
    if not m:
        return {}, text
    raw_yaml, body = m.group(1), m.group(2)
    fm: dict = {}
    for line in raw_yaml.splitlines():
        if ":" not in line:
            continue
        key, _, val = line.partition(":")
        fm[key.strip()] = val.strip().strip('"')
    return fm, body


def render_frontmatter(fm: dict) -> str:
    lines = ["---"]
    for k, v in fm.items():
        if any(c in str(v) for c in ":#\"'"):
            v = '"' + str(v).replace('"', '\\"') + '"'
        lines.append(f"{k}: {v}")
    lines.append("---")
    return "\n".join(lines)


def voice_block(paths: list[str]) -> str:
    refs = "\n".join(f"  - {p}" for p in paths)
    return f"""
## 🔒 Brand Voice Lock — READ FIRST (single source of truth)

Before producing ANY human-facing copy, read the brand voice from these files (in order):
{refs}

Apply the Voice DNA documented in those files. If your draft conflicts with the playbook, the playbook wins — rewrite, do not compromise. This rule overrides any tone/personality guidance below.

---
"""


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--repo", required=True, type=Path,
                    help="Path to msitarzewski/agency-agents clone")
    ap.add_argument("--target", required=True, type=Path,
                    help="Target ~/.claude/agents/ directory")
    ap.add_argument("--manifest", default=None, type=Path,
                    help="Path to manifest.json (default: alongside this script)")
    ap.add_argument("--voice-paths-file", default=None, type=Path,
                    help="JSON file with voice_dna_paths array")
    args = ap.parse_args()

    manifest_path = args.manifest or Path(__file__).parent / "manifest.json"
    manifest = json.loads(manifest_path.read_text())

    voice_paths: list[str] = []
    if args.voice_paths_file and args.voice_paths_file.exists():
        voice_paths = json.loads(args.voice_paths_file.read_text()).get("voice_dna_paths", [])

    if not args.repo.exists():
        print(f"  [ERR]  agency-agents repo not found at {args.repo}", file=sys.stderr)
        return 1

    args.target.mkdir(parents=True, exist_ok=True)

    installed: list[str] = []
    skipped: list[str] = []

    for agent in manifest["agents"]:
        src = args.repo / agent["src"]
        if not src.exists():
            print(f"  [MISS] {agent['src']}")
            skipped.append(agent["name"])
            continue

        text = src.read_text()
        fm, body = parse_frontmatter(text)

        original_desc = fm.get("description", "").strip()
        original_name = fm.get("name", agent["name"])
        new_desc = f"{original_desc} {agent['triggers']}"

        new_fm = {
            "name": agent["name"],
            "description": new_desc,
        }

        prefix = ""
        if agent.get("voice_aware") and voice_paths:
            prefix = voice_block(voice_paths)

        sentinel = (
            f"<!-- installed-by: {INSTALL_TAG} | "
            f"upstream-name: {original_name} | source: {agent['src']} -->\n"
        )

        out = render_frontmatter(new_fm) + "\n" + sentinel + prefix + body
        target = args.target / f"{agent['name']}.md"
        target.write_text(out)
        installed.append(agent["name"])
        marker = "  (voice-aware)" if agent.get("voice_aware") and voice_paths else ""
        print(f"  [OK]   {agent['name']}{marker}")

    print(f"\nInstalled {len(installed)} agents to {args.target}")
    if skipped:
        print(f"Skipped {len(skipped)}: {', '.join(skipped)}")
    if not voice_paths:
        print("(no voice paths provided — voice-aware agents installed without injection;")
        print(" they will defer to user-level CLAUDE.md voice precedence)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
