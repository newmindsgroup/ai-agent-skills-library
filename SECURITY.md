# Security Policy

## Reporting a vulnerability

Report security issues **privately** — do not open a public issue.

- Preferred: [GitHub private vulnerability reporting](https://github.com/newmindsgroup/ai-agent-skills-library/security/advisories/new)
- Or email: **info@newmindsgroup.com** with subject `SECURITY: ai-agent-skills-library`

Please include the affected skill/file path, a description, and reproduction steps. We aim to acknowledge within **3 business days** and to triage within **10 business days**. Please give us a reasonable window to remediate before public disclosure.

## Scope

This repository **redistributes third-party skills** under `sources/`. These are imported as-is and are **not independently security-audited by New Minds Group**. Treat any imported skill as untrusted third-party code:

- Skills under `sources/original/` are first-party (authored here).
- All other `sources/*` directories are vendored from external upstreams. See [`docs/SKILLS-TRUST.md`](docs/SKILLS-TRUST.md) for per-source provenance and risk flags.

A skill is **instructions an autonomous agent will act on**, and some skills bundle executable `scripts/`. Review a skill before installing it into an environment with access to secrets, production systems, or sensitive data.

## What counts as a vulnerability here

- A skill that exfiltrates data, secrets, or credentials.
- A skill or installer that executes unexpected remote code, or runs destructive/privileged commands without consent.
- Prompt-injection content designed to subvert the host agent's safety or the user's instructions.
- Hardcoded secrets committed to the repository.
- A supply-chain weakness in the install path (unpinned/unverified fetches that enable code injection).

## Installer trust

The one-line installers fetch this repository's own release archive over HTTPS. Inspect [`install.sh`](install.sh) / [`install.ps1`](install.ps1) before piping to a shell, and prefer the pinned release tag over `main` for reproducible installs.
