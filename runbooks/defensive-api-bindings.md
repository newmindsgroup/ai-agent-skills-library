# Defensive API Bindings (Vanilla-JS Substitute for TypeScript)

**Failure mode this prevents:** dashboards that crash or display "undefined" when an API response shape changes, when a field is occasionally null, or when the backend rolls out a v2 of an endpoint while v1 is still in flight.

**Context:** single-file vanilla-JS dashboards / admin tools where bringing in TypeScript would be heavier than the file itself. The cost of the missing type system can be paid back with a few defensive helpers.

## The pattern

Every UI helper that reads from an API response uses three rules:

1. **Tolerate multiple shapes.** Look in the most likely place first, then fall back.
2. **Render missing as `—`** (em-dash or `n/a`), never as `undefined`, `null`, or empty string.
3. **Coerce types defensively.** Numbers might come back as strings; dates as ISO strings or Unix timestamps.

```js
// helpers.js — the entire defensive layer for a small dashboard

function pick(obj, ...paths) {
  // Try each path in order, return the first non-nullish value, or '—'.
  for (const path of paths) {
    const parts = path.split('.');
    let cur = obj;
    for (const p of parts) {
      if (cur == null) break;
      cur = cur[p];
    }
    if (cur != null && cur !== '') return cur;
  }
  return '—';
}

function num(value, fallback = '—') {
  if (value == null || value === '') return fallback;
  const n = Number(value);
  return Number.isFinite(n) ? n : fallback;
}

function fmtMoney(value) {
  const n = num(value, null);
  if (n == null) return '—';
  return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(n);
}

function fmtDate(value) {
  if (value == null || value === '') return '—';
  const d = typeof value === 'number' ? new Date(value) : new Date(String(value));
  if (isNaN(d.getTime())) return '—';
  return d.toLocaleDateString();
}

function arr(value) {
  if (Array.isArray(value)) return value;
  if (value == null) return [];
  return [value];   // single object → wrap as array
}
```

## Usage

Suppose the API used to return `{ deal: { value: 5000, ... }}` and now sometimes returns `{ deal: { amount: "5000", ... }}`. With `pick`:

```js
const dealValue = pick(payload, 'deal.value', 'deal.amount', 'value', 'amount');
const dealValueDisplay = fmtMoney(dealValue);
```

The component renders correctly under the old shape, the new shape, and any future shape that uses any of those four field names. When the backend rolls out a different field name without coordinating, your UI quietly keeps working until you notice the new field name and add it to the `pick` call.

## When to use

- Single-file vanilla-JS dashboards (no build step, no bundler, no TypeScript).
- Admin tools with a small surface area where TypeScript would be ceremony.
- Prototypes where the API shape is still in flux.
- Internal tools with low traffic where "render `—` instead of crashing" is the right tradeoff.

## When NOT to use

- Production user-facing apps. Use TypeScript or Zod.
- Anywhere correctness matters more than display robustness (transactional UIs, financial calculations).
- Anything that goes through a CI pipeline where a build step is already required.

## The defensive-render principle

The reason this works: every UI cell is a function that takes an API response and returns either a rendered value or `—`. If the input is malformed, the output is `—`, never an exception. The page renders. The user sees what's missing. They can refresh, file a ticket, or fall back to the underlying data source.

This is a substitute for static types in environments where the type system isn't worth its cost. It's not a replacement for static types where types DO carry their cost — when correctness needs to be enforced at compile time, use the real thing.
