# Replaying an append-only memory log

Many agent memory vaults are event logs rather than record stores. Each line is something that *happened* to a memory, not the memory itself. Mirroring such a log by copying every line produces a vault that is actively wrong: deleted memories reappear, and the real ones are buried under bookkeeping.

## Why this matters more than it sounds

A representative log from a production agent, after about four months:

| Event | Count |
| --- | --- |
| `access` | 1,271 |
| `add` | 88 |
| `forget` | 21 |
| `superseded_by` | 4 |

1,384 records, 88 memories, 76 of them still live. A naive copy yields a folder that is 92% read receipts, and it resurrects everything the user deliberately forgot. Replay is not an optimization here, it is the difference between a useful mirror and a misleading one.

## Event semantics

Names vary by implementation. The shapes recur.

| Event | Meaning | Handling |
| --- | --- | --- |
| `add` / `create` / `upsert` | the memory itself | create or replace by id |
| `access` / `read` / `recall` | read receipt | count it, never render as content |
| `forget` / `delete` | deliberate removal | drop entirely, do not mirror |
| `superseded_by` / `replaced_by` | a newer entry replaces this one | keep, flag, link to the successor |
| `update` / `patch` | partial edit | merge onto the existing record |

Two judgment calls worth making deliberately:

**Forgotten memories stay gone.** Someone chose to forget them. Preserving them "for completeness" quietly overrides that decision. Report the count so the deletion is visible, but do not mirror the content.

**Superseded memories stay, flagged.** Unlike a forget, a supersede is a version bump. The old entry still explains why the new one exists. Keep it with a visible callout and a link forward, so a reader who lands on it from a search knows to move on.

## The access counter is free signal

`access` events are noise as content and genuinely useful as metadata. Counting them per id gives you a usage ranking for nothing: which memories the agent actually leans on versus which it wrote once and never consulted. Surface it in frontmatter as `access_count`. A memory with 20 reads is doing work; one with 0 after months is a candidate for review.

## Worked example

```python
mem, accesses, superseded, forgotten = {}, {}, {}, set()
for line in log.splitlines():
    if not line.strip():
        continue
    try:
        d = json.loads(line)
    except json.JSONDecodeError:
        bad += 1          # count, do not crash: a truncated tail is normal
        continue          # on a log being appended to while you read it
    mid, event = d.get("id"), d.get("event")
    if not mid:
        continue
    if event == "add":
        mem[mid] = d
    elif event == "access":
        accesses[mid] = accesses.get(mid, 0) + 1
    elif event == "forget":
        forgotten.add(mid)
    elif event == "superseded_by":
        superseded[mid] = d.get("superseded_by")

live = {k: v for k, v in mem.items() if k not in forgotten}
```

Order matters only in that later `add` events replace earlier ones for the same id, which falls out of dict assignment as long as you read the log in order. Do not sort by timestamp unless the log is genuinely out of order; append order is the ground truth.

## Reporting

Print the full accounting, not just the success number. `live=76 written=0 unchanged=77 forgotten=12 superseded=4 unparseable=0` tells you at a glance that the sync was a no-op, that a dozen memories are intentionally gone, and that the log parsed cleanly. A bare "synced 76 memories" hides all of that.

Note that `forgotten` counted from the log will often exceed the number of memories actually removed, because forget events can target ids that were never added or were already forgotten. That discrepancy is expected and worth not "fixing".
