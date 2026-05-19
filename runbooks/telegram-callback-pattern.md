# Telegram Callback Pattern (channels-plugin patches)

**Failure mode this prevents:** an inline-keyboard button that does nothing because the bot doesn't recognize the callback_data prefix, OR a hack-patched plugin that breaks on the next upstream update.

This pattern lets you add ARBITRARY new approval flows (Ship/Hold/Revise on drafts, Run/Skip on proposed moves, Reply/Archive/Snooze on emails, etc.) by patching the vendored Telegram channels plugin in an idempotent, sentinel-checked way.

## Background

The upstream `claude-plugins-official/telegram` plugin's `callback_query:data` handler ONLY recognizes `^perm:(allow|deny|more):...$`. Anything else gets `answerCallbackQuery()`'d silently and dropped. To route a new pattern (`deploy:`, `draft:`, `prop:`, `email:`, etc.), you patch the plugin to add a sibling handler BEFORE the perm: check.

## The patch architecture

```
patch-channels-plugin.sh
├── PASS 1: deploy: callbacks (Ship/Cancel on /deploy)
├── PASS 2: draft: callbacks (Ship/Hold/Revise on every draft)
├── PASS 3: prop: callbacks (Run/Skip on Proposed Moves)
├── PASS 4: forward_origin metadata (auto-detect forwarded messages)
└── PASS 5: email: callbacks (Reply/Archive/Snooze on /inbox triage)
```

Each pass:
- Has its own sentinel string (e.g. `v2.27.2: proposal approval callbacks`)
- Is idempotent — re-runs are no-ops if the sentinel is already in the file
- Anchors on a stable upstream line (typically `const m = /^perm:.../`) so it works across patch reapplications

The patch script is wired as `ExecStartPre=` on `claude-agent.service`, so every service restart re-applies cleanly. Survives upstream plugin reinstalls because the cache directory is per-user, not per-system.

## Rules

### Rule 1 — Sentinel-checked idempotency

Every pass starts with:

```bash
SENTINEL_FOO="v2.X.Y: foo callbacks"

if grep -q "$SENTINEL_FOO" "$PLUGIN"; then
  echo "  pass N (foo:) already applied — no-op"
else
  cp "$PLUGIN" "$PLUGIN.bak-passN-$(date -u +%Y%m%dT%H%M%SZ)"
  # ... apply via Python
fi
```

The sentinel is in a code comment inside the patch itself. The grep is fast. Re-running the script is safe.

### Rule 2 — Anchor on a stable upstream line

The most stable line in the upstream handler is the `perm:` regex check. It hasn't changed in many releases. Anchor your patch INSERT to land BEFORE that line:

```python
needle = "\n  const m = /^perm:(allow|deny|more):([a-km-z]{5})$/.exec(data)"
new = f"""

  // {SENTINEL} — route foo taps...
  const fm = /^foo:(action):(payload)$/.exec(data)
  if (fm) {{
    // handler body
    return
  }}

  const m = /^perm:(allow|deny|more):([a-km-z]{{5}})$/.exec(data)"""

if needle not in src:
    print(f"FATAL: anchor not found"); raise SystemExit(2)
patched = src.replace(needle, new, 1)
```

The `^/^perm.*` line is the universal anchor. Don't try to anchor "after the previous patch I applied" — that creates fragile pass-order dependencies.

### Rule 3 — Route through `notifications/claude/channel`

The patched handler does NOT call any bot logic directly. It routes the callback through the standard channel-notification path so the agent receives it AS A SYNTHETIC CHAT MESSAGE:

```typescript
const [, action, id] = fm
void mcp.notification({
  method: 'notifications/claude/channel',
  params: {
    content: `${action} ${id}`,
    meta: {
      chat_id: String(ctx.chat?.id ?? ''),
      ...(msg && 'message_id' in msg ? { message_id: String(msg.message_id) } : {}),
      user: ctx.from.username ?? String(ctx.from.id),
      user_id: String(ctx.from.id),
      ts: new Date().toISOString(),
      source: 'callback_query:foo',
    },
  },
}).catch(() => {})
```

This means **the agent's existing CLAUDE.md handlers** (the ones that respond to "ship v1.2.3" typed messages) ALSO handle button taps. One handler, two trigger surfaces. Test once, work everywhere.

### Rule 4 — Sender allowlist BEFORE routing

```typescript
const access = loadAccess()
const senderId = String(ctx.from.id)
if (!access.allowFrom.includes(senderId)) {
  await ctx.answerCallbackQuery({ text: 'Not authorized.' }).catch(() => {})
  return
}
```

A button tap from outside the allowlist must be rejected with the same rigor as a text message from outside the allowlist. Don't trust callback_query inputs.

### Rule 5 — Immediate `answerCallbackQuery` for UX

Telegram shows a spinner on the tapped button until you answer the callback. Answer fast:

```typescript
const label = action === 'ship' ? '✅ Shipped' : '⏸️ On hold'
await ctx.answerCallbackQuery({ text: label }).catch(() => {})
```

The actual work happens via the synthetic chat message routed in Rule 3. The user sees instant feedback ("✅ Shipped") in the toast, plus the agent's downstream confirmation when it processes the synthetic message.

### Rule 6 — Optional: edit the original message to show terminal state

```typescript
if (msg && 'text' in msg && msg.text) {
  await ctx.editMessageText(`${msg.text}\n\n${label}: ${id}`).catch(() => {})
}
```

Strikes the buttons from the original message so it can't be tapped twice. Optional but improves UX.

### Rule 7 — Document the callback_data → synthetic-message contract in CLAUDE.md

The agent's CLAUDE.md must explain what synthetic messages to expect:

```markdown
- `run p-YYYYMMDD-xxxx` → Proposed Move approval. Match on `p-[0-9]{8}-[a-z]{4}` pattern.
  Look up the proposal in `proposals/<DATE>.json`, dispatch to the named executor sub-agent.
- `skip p-YYYYMMDD-xxxx` → Proposed Move dismissal. Mark state=skipped, log to rejected.jsonl.
```

This is the contract between the channels-plugin patch and the agent's handlers. Documenting both sides prevents the "I added a button but the agent ignores it" failure mode.

### Rule 8 — Verify after every patch run

The patch script ends with a verify block:

```bash
echo "=== verify ==="
for s in "$SENTINEL_DEPLOY" "$SENTINEL_DRAFT" "$SENTINEL_PROP" "$SENTINEL_FWD" "$SENTINEL_EMAIL"; do
  if grep -q "$s" "$PLUGIN"; then
    echo "  ✓ $s"
  else
    echo "  ✗ MISSING: $s"
    exit 1
  fi
done
if grep -q 'perm:(allow|deny|more)' "$PLUGIN"; then
  echo "  ✓ perm: handler intact"
else
  echo "  ✗ perm: handler MISSING — patch corrupted"
  exit 1
fi
```

PLUS a TypeScript compile check:

```bash
if command -v bun >/dev/null 2>&1; then
  bun build "$PLUGIN" --target=bun --outfile /tmp/server-test-$$.js >/dev/null 2>&1 \
    && echo "  ✓ ts compiles" \
    || { echo "  ✗ ts BROKEN — restore from .bak-* and investigate"; exit 1; }
fi
```

If TS doesn't compile, your patch broke something. Restore from `.bak-*` (which the script creates automatically).

## Adding a sixth pass

1. Pick a prefix that doesn't collide: `recap:`, `report:`, `pin:`, whatever.
2. Pick a payload format: `prefix:action:opaque-id` where action is a fixed set and opaque-id is what the agent needs to look up the entity.
3. Copy a PASS block in the patch script. Update sentinel, regex, label strings, source field.
4. Add `SENTINEL_NEW` to the verify loop.
5. Run the patch script. If verify passes, restart claude-agent.service (the patch script runs as ExecStartPre).
6. Update CLAUDE.md.tmpl with the new synthetic-message handler.
7. Send a test message with the new buttons via `tg-send.sh send --callback-buttons "✅|prefix:action:test-id"`. Tap. Verify the agent receives the synthetic.

## Anti-patterns

❌ **Modifying the upstream plugin file directly** — gets clobbered on next plugin update. ALWAYS use the patch script.

❌ **Anchoring on a previous patch's output** — creates ordering dependencies. Always anchor on the upstream `perm:` line.

❌ **Skipping the allowlist check** — anyone with the bot's username can tap your button via deeplinks. Always validate sender.

❌ **Putting business logic in the patch handler** — the patch ROUTES; the agent ACTS. Don't write GHL calls in TypeScript inside server.ts.

❌ **Using a callback_data string > 64 bytes** — Telegram silently truncates. Keep payloads short. Use opaque IDs the agent can resolve, not long strings.

❌ **Forgetting the ExecStartPre wiring** — without it, the patch is a one-time edit that survives until the next plugin reinstall, then disappears.
