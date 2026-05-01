# Portability Guide — Deploying This Stack for a New Client

This stack was built so it can be carried from one VPS to another with a single configuration file change. This guide walks through the full process of standing up the same stack for a new client / company.

## Mental model

The repo is the *recipe*. Each client gets their own *batch* of the recipe — same ingredients, same steps, different oven (their VPS) and different garnish (their `client.env`).

Three things change per client:

1. **`config/client.env`** — paths, organization name, knowledge-library locations, optional service keys
2. **The CLAUDE.md project-instructions block** that gets added to that client's repos
3. **The implementation log** — each VPS has its own log of what was installed when

Everything else — the install scripts, the operational docs, the architecture — is identical.

## Step 1: Extract this folder to its own dedicated GitHub repo

If this folder currently lives inside a parent project (e.g. `personal-brand/agent-stack/`), extract it before going further. Future clients should clone a clean repo, not a subfolder.

```bash
# from the parent project
mv agent-stack ~/code/agent-stack
cd ~/code/agent-stack
git init
git add .
git commit -m "Initial agent-stack baseline"

# Create a private GitHub repo and push
gh repo create <your-org>/agent-stack --private --source=. --push

# (Optional) make it public when stable
gh repo edit <your-org>/agent-stack --visibility public
```

After this, every client deployment clones from this canonical repo.

## Step 2: For each new client

### 2.1 Clone onto the client's VPS

SSH into the client's VPS as a non-root user with sudo, then:

```bash
git clone https://github.com/<your-org>/agent-stack.git ~/agent-stack
cd ~/agent-stack
```

### 2.2 Confirm Claude Code is installed and authenticated

```bash
claude --version
claude auth status
```

If not logged in, run `claude login` and complete the browser flow against the client's Anthropic subscription (Max, Pro, or Team).

### 2.3 Create the client config

```bash
cp config/client.example.env config/client.env
$EDITOR config/client.env
```

Fill in:

- `CLIENT_NAME` — short slug for the client / company (used in log entries and naming)
- `CLAUDE_PROJECT_ROOT` — absolute path to the working directory on this VPS
- `KNOWLEDGE_LIBRARY_ROOTS` — comma-separated list of directories Claude should be able to read (e.g. content drafts, brand books, transcripts)
- `MEMORY_STORE_PATH` — where the Memory MCP's JSON file lives
- `CHROMA_DB_PATH` — where the Chroma vector store lives
- Optional: external service keys (only needed for Tier 2 servers; leave blank if not applicable)

### 2.4 Run the prereqs check

```bash
bash scripts/00-prereqs-check.sh
```

This verifies Node ≥ 18, Python ≥ 3.10, git, and Claude Code authentication. Fix anything it flags before continuing.

### 2.5 Run the installs

```bash
bash scripts/install-all.sh
```

Or run individually if you want to inspect each step:

```bash
bash scripts/01-install-superpowers.sh
bash scripts/02-install-mcp-memory.sh
bash scripts/03-install-mcp-fetch.sh
bash scripts/04-install-mcp-filesystem.sh
bash scripts/05-install-mcp-playwright.sh
bash scripts/06-install-mcp-chroma.sh
```

### 2.6 Verify

```bash
bash scripts/99-verify-all.sh
```

### 2.7 Wire the CLAUDE.md project-instructions block

For each repo on this VPS where you want Superpowers to fire, append the contents of `config/CLAUDE.md.template` to that repo's `CLAUDE.md` file. Customize the "project-specific quality bar" section per project.

### 2.8 Initialize the client's implementation log

```bash
cp implementation-log.md.template implementation-log.md
$EDITOR implementation-log.md
# Record the install date, versions, and any client-specific config deviations
```

The implementation log is per-VPS, not per-repo. Don't push this back to the agent-stack repo — it stays local on the client's VPS as a deployment record.

## Per-client checklist

A condensed version of the above, for paste-into-runbooks:

- [ ] Anthropic subscription active for client (Max / Pro / Team)
- [ ] Client VPS provisioned (≥1 vCPU, ≥1 GB RAM, ≥20 GB disk; ≥2 GB RAM if running Playwright)
- [ ] Outbound HTTPS verified
- [ ] Claude Code installed and `claude login` completed
- [ ] Repo cloned to `~/agent-stack`
- [ ] `client.env` filled in
- [ ] `00-prereqs-check.sh` passes
- [ ] `install-all.sh` completes without error
- [ ] `99-verify-all.sh` passes
- [ ] `CLAUDE.md.template` block added to relevant client repos
- [ ] `implementation-log.md` initialized with install record
- [ ] (Client memory) update the client's auto-memory or CLAUDE.md context with stack details
- [ ] Smoke test: in a Claude Code session on the VPS, run a low-stakes task that exercises one MCP server (e.g. "fetch this URL and summarize")

## What does NOT carry across clients

These are explicitly per-client and must be set fresh for each deployment:

- Anthropic subscription auth (browser-based `claude login` per VPS)
- Any external service keys (Stripe, Cloudflare, Notion, etc. — each client has their own)
- Memory store contents (`memory.json` is private, never copied between clients)
- Chroma vector store (`chroma_db/` is private, contains client knowledge embeddings)
- The implementation log itself
- Custom skills or hooks the client adds beyond this baseline

## What MUST stay current across clients

These are the parts of the agent stack that should be kept synchronized:

- The install scripts (`scripts/*.sh`) — source of truth in this repo
- The CLAUDE.md template — source of truth in this repo
- Per-server operational docs — source of truth in this repo
- Version pins in install scripts — bump centrally, redeploy clients on a cadence

When you bump a version or fix a script, redeploy each client by:

```bash
cd ~/agent-stack
git pull
bash scripts/<the-changed-script>.sh   # idempotent — safe to re-run
```

## Backup expectations

The stack itself is reproducible from this repo, so the *configuration* is not what you're backing up. What you back up per VPS:

- `~/.claude/` — Claude Code's auth and config
- The Memory MCP's JSON store (path set in `client.env`)
- The Chroma DB directory (path set in `client.env`)
- Any client-specific repos under their normal git remotes
- The implementation log

Restic, rsnapshot, or Borg work fine. Snapshots once a day, retained 30 days, tested quarterly.

## When this guide is wrong

This guide reflects the stack at the time of writing. If a script's behavior diverges from this document — trust the script, not the document, and update the document. The scripts are the source of truth; this guide is an operator's reference.
