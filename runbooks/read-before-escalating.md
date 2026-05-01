# Read Before Escalating

**Failure mode this prevents:** an agent that asks the human a question whose answer is already in the codebase. Wastes the human's time, signals the agent didn't do due diligence.

**Pattern:** when an agent flags something as an "architectural question," "design decision," or "open question," check whether the codebase already answers it before bringing it to the human.

## The check

Before escalating to the human with any of these phrases:

- "Should we use X or Y?"
- "What's the convention here?"
- "How do we handle Z in this codebase?"
- "I'm not sure whether to..."
- "There's an architectural question..."
- "I'd recommend Y, but want your input..."

Run this checklist:

1. **Search the codebase.** `grep -r` for the concept. Most "decisions" already have prior art.
2. **Read existing patterns.** If three similar features exist, the convention is whatever those three did.
3. **Check the docs.** `README.md`, `CONTRIBUTING.md`, `docs/`, `AGENTS.md`, or wherever the project keeps decision records.
4. **Check `git log`.** A commit message often explains a decision better than any doc.
5. **Look at recent changes.** What did the last person to touch this area do? They probably had the same question.

If after all five steps the answer truly isn't in the codebase, then escalate. But MAKE the escalation higher-quality:

- "I checked X, Y, Z and didn't find a convention. Three options I see are A/B/C. I'd lean A because of {reason}. Want me to proceed?"

NOT:

- "Architectural question: should we use A or B?"

## Why this matters

Most "decisions" are unread code. Asking the human:

- Wastes their time on something they could have skipped reading.
- Signals the agent gave up on its own due diligence.
- Trains the human to expect low-quality questions, which makes them tune out the high-quality ones.
- Slows the work — every escalation costs 5–60 minutes of round-trip time.

## When to escalate anyway

Some questions truly require the human:

- **Strategic.** "Should we build this feature?" — the agent doesn't know the business priorities.
- **Stakeholder-sensitive.** "Should we deprecate the old API?" — the agent doesn't know the customer impact.
- **Risk-bearing.** "Should we deploy this on Friday afternoon?" — the agent shouldn't carry that risk alone.
- **Unprecedented.** Genuinely new direction the codebase has no analog for.

For those, escalate with a strong recommendation, not a multiple-choice. The agent's job is to do the homework AND propose the answer.

## The pattern in practice

Compare:

**Bad escalation:**
> I'm not sure whether to use a context manager or a try/finally for this resource. Want your input?

**Good escalation:**
> Looked at how `db.connect()` and `cache.connect()` are used elsewhere — both use `with` blocks. I'm going with `with` for consistency. Flagging in case you want me to do something different.

The first is a question the codebase already answered. The second is the agent doing the work AND telling the human the result, so the human can either ignore it (default) or correct it (if needed).

## Anti-pattern: the false dilemma

Beware escalations of the form "Should I do A or B?" when actually:

- A and B are both wrong; C is what the codebase wants.
- One of them is obviously right and you're just looking for permission.
- The question is mis-framed — the actual decision is something different.

If you find yourself reaching for "A or B?" — stop, re-check, and either propose a third option or commit to one with a one-line reason.
