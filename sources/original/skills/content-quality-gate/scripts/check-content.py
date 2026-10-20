#!/usr/bin/env python3
"""Check a content file for direct punctuation and phrase violations.

Version-Timestamp: 2026-08-24 17:25:03 AST
"""

from __future__ import annotations

import argparse
from pathlib import Path
import sys


HARD_PATTERNS = {
    "em dash": "—",
    "en dash": "–",
    "banned phrase: thrilled to": "thrilled to",
    "banned phrase: excited to share": "excited to share",
    "banned phrase: in today's fast-paced world": "in today's fast-paced world",
    "banned phrase: humbled to": "humbled to",
    "banned phrase: delve into": "delve into",
    "banned phrase: in the realm of": "in the realm of",
}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("file", type=Path)
    args = parser.parse_args()
    text = args.file.read_text(encoding="utf-8")
    failures = 0
    for line_number, line in enumerate(text.splitlines(), start=1):
        line_lower = line.lower()
        for label, pattern in HARD_PATTERNS.items():
            candidate = line if pattern in {"—", "–"} else line_lower
            if pattern in candidate:
                print(f"FAIL {args.file}:{line_number}: {label}")
                failures += 1
    if failures:
        return 1
    print(f"PASS {args.file}: no em dashes, en dashes, or global banned phrases")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
