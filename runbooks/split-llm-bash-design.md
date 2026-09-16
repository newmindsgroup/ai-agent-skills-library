# Split LLM/Bash Design

**Failure mode this prevents:** an LLM-driven script that "succeeds" but returns the wrong answer because the model short-circuited on sparse data. Or one that pays $0.05 per run for work that bash could do for free.

When you put an LLM inside a watcher or cron job, give it ONE job — the thing only it can do. Move all downstream logic (filtering, cross-referencing, formatting, sending) into bash. Single-purpose prompts succeed reliably; multi-step prompts under sparse data sometimes lie.

## The pattern in one diagram

```
┌──────────────────────────────────────┐
│  LLM (claude --print)                │
│                                      │
│  Input:  "Call mcp__X__list_things"  │
│  Output: {"things": [...]}           │   ← strict JSON schema
└──────────────────────┬───────────────┘
                       │
                       ▼
┌──────────────────────────────────────┐
│  bash                                │
│                                      │
│  - parse JSON                        │
│  - cross-reference against local     │
│    state or another REST endpoint    │
│  - filter / dedup / format           │
│  - send (Telegram, file, ledger)     │
└──────────────────────────────────────┘
```

## Why this works

LLMs short-circuit on multi-step prompts when intermediate results are sparse. A real example from this codebase: the original hot-lead-inbox-watcher prompt was "Call Gmail. Then for each sender, call GHL. Then format the matches." When Gmail returned 0 threads matching the criteria, the LLM rationalized "0 threads, so I'll skip the GHL step too" and reported tools as unavailable — even though the GHL tool was perfectly callable.

The refactor: LLM only does "Call Gmail → return threads as JSON." Bash does GHL cross-ref via direct REST. Same data, deterministic. **First-try success.**

## When to use the LLM step

Use `claude --print` for things that ARE actually LLM-shaped:
- Calling a Claude.ai-hosted MCP that's not available locally (Gmail, Calendar, Drive, Notion connectors)
- Natural-language extraction from unstructured text (summary, sentiment, key entities)
- Calling a local MCP that requires interpretation (Firecrawl with dynamic page extraction)

DON'T use `claude --print` for things bash can do:
- HTTP requests to documented REST APIs (`curl` is faster, free, more reliable)
- File I/O, JSON parsing, regex matching
- Arithmetic, dedup, deduplication, sorting
- Sending Telegram messages, writing files

## Hard rules for the LLM step

1. **Single tool call.** "Call mcp__X. Return the result as JSON. Schema: {...}." That's it. No conditional logic, no "if N>0 then also call Y."

2. **Strict JSON schema in the prompt.** Spell out every field. Add `"NEVER skip the tool call"`-style explicit instructions. The LLM will sometimes try to be clever — pre-empt it.

3. **Permission mode `bypassPermissions` for non-Gmail Claude.ai-hosted MCPs.** Gmail works under `dontAsk`, but Google Calendar / Drive / Notion sometimes return "tool denied" under `dontAsk`. See `feedback_claude_print_permissions.md` (memory) for the specifics. Both modes still honor `settings.json` deny list.

4. **Tight timeout.** A simple "list things" call should finish in 30s. A 360s timeout means something went wrong — fail fast, alert, try next run.

5. **Validate the JSON before trusting it.** `jq -e .things >/dev/null` first. If invalid, log the raw output (truncated) for debugging and exit cleanly. The next scheduled run will retry.

## Hard rules for the bash step

1. **All filtering / cross-ref / formatting in bash.** REST APIs are deterministic. `jq` is deterministic. `grep`, `sort`, `awk` are deterministic. Use them.

2. **Read credentials from the same source the LLM step would.** Typically `.mcp.json` for GHL keys, `.gmail-oauth.json` for Google. Single source of truth.

3. **Append-only dedup logs.** See `proactive-watcher-pattern.md`.

4. **Idempotent.** Same input → same output. No "first run vs subsequent run" branches.

## Cost comparison — real numbers

From the hot-lead-inbox-watcher:

| Design | Wall time | Cost/run | Reliability |
|---|---|---|---|
| LLM does Gmail+GHL+format+send | ~30s | ~$0.03 | ~70% (hallucination + short-circuit) |
| LLM does Gmail only; bash does the rest | ~30s LLM + 0.5s bash | ~$0.01 | ~99% |
| Direct REST (post Google OAuth setup) | ~1s total | $0 | ~99% |

The split design lifts reliability from ~70% to ~99% while cutting cost by 3x. The OAuth REST upgrade is a further 30x latency improvement + cost-to-zero, but requires one-time credential setup.

## Anti-patterns

❌ **LLM in the middle of a deterministic pipeline.** If the only thing the LLM is doing is reformatting a JSON object, you don't need it. Use `jq`.

❌ **"Have the LLM decide whether to call the next tool."** Encode the decision in bash. The LLM's job is to RETURN data, not to make pipeline decisions.

❌ **Long prompts trying to constrain LLM behavior.** Shorter prompts succeed more reliably. If your prompt is >50 lines, you're probably asking the LLM to do bash's work.

❌ **No JSON schema in the prompt.** The LLM will improvise. Sometimes great, sometimes catastrophic. Define the schema.

❌ **Re-running LLM on parse failure.** Log + fail. The next scheduled run will re-call. Don't sit in a retry loop that costs $0.01 per attempt.
