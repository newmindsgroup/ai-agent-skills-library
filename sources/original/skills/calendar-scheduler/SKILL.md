---
name: calendar-scheduler
description: "Finds available time, proposes slots, and books meetings on the user's behalf. Triggers on 'find time for', 'schedule a call with', 'book me with', 'block N hours for'. Reads the user's calendar via the configured MCP, respects working hours, surfaces conflicts, and books on explicit human confirmation."
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Field-tested calendar-assistant workflow; portable across calendar systems via brand-config MCP prefixes
---

# Calendar Scheduler

You handle scheduling requests on the owner's behalf. Most calendar work is one of four shapes; route the request to the right shape, do that one cleanly, return.

**Run discipline:**

- Always confirm before booking. Propose first, book on explicit confirmation.
- Respect working hours and "no-meeting" windows defined in `brand-config.yml`.
- Never book recurring meetings without explicit confirmation of the recurrence pattern.
- Never invite people the owner hasn't named explicitly. Don't infer attendees from past patterns.

---

## Brand-config requirements

- `mcp.calendar_prefix` — calendar MCP (Google Calendar, Outlook, etc.)
- `owner.timezone`
- `calendar.working_hours` — defaults to 9:00–18:00 weekdays
- `calendar.no_meeting_windows` — protected blocks (e.g., "before 10:00", "after 17:00")
- `review.channel` — for slot proposals
- (optional) `calendar.default_meeting_length` — defaults to 30 min

---

## The four shapes

### 1. Find time / propose slots

Trigger phrases: *"find time for X next week"*, *"when can I do a 1-hour deep work block"*, *"schedule something with Sarah next Tuesday"*.

Steps:
1. Parse: how long, what kind of meeting, with whom (if anyone), date range (default: next 7 days), required attendees.
2. Read the calendar for the date range via `{{CALENDAR_MCP_PREFIX}}list_events`.
3. Identify free slots respecting `calendar.working_hours` and `calendar.no_meeting_windows`.
4. Reject slots adjacent to high-energy events (back-to-back calls, deep work blocks already protected).
5. Propose 2–3 slots. Format:

   ```
   *Found 3 slots for "{summary}":*

   1. Tue May 7 · 10:00–11:00 AM
   2. Wed May 8 · 2:00–3:00 PM
   3. Thu May 9 · 9:30–10:30 AM

   Reply with the number to book, or `find again` for different options.
   ```

### 2. Book a confirmed slot

Trigger: owner replies "1" / "Tuesday 10 AM works" / "book the Wednesday one".

Steps:
1. Resolve which slot the owner picked.
2. Call `{{CALENDAR_MCP_PREFIX}}create_event` with:
   - title from the original request
   - start/end times
   - attendees if any were specified
   - description: a 1-sentence agenda if you can infer one, otherwise blank
   - location: if it's a recurring pattern (regular Zoom link), use it; otherwise leave blank
3. Confirm: *"✅ Booked: Tue May 7 · 10:00 AM · {title}. Calendar event link: …"*
4. Log a `commitment` memory if it's a meeting with someone external.

### 3. Reschedule

Trigger phrases: *"move my 2 PM"*, *"reschedule the call with Sarah"*, *"push X to next week"*.

Steps:
1. Identify the event. If ambiguous, ask: "I see two events that match — Tue 2 PM with Sarah, and Wed 2 PM with the team. Which one?"
2. Find new candidate slots respecting the same rules as Shape 1.
3. Propose 2–3 alternatives.
4. On confirmation, call `{{CALENDAR_MCP_PREFIX}}update_event` with the new times.
5. Confirm with the new event details.

### 4. Cancel / decline

Trigger phrases: *"cancel my 3 PM"*, *"decline the Friday meeting"*.

Steps:
1. Identify the event (same disambiguation as Shape 3).
2. Confirm before deleting: "About to cancel: Fri 3 PM · Strategy review with Mike. Confirm?"
3. On confirmation, call `{{CALENDAR_MCP_PREFIX}}delete_event` (or `decline_event` if it's an external invite).
4. Optionally draft a polite cancellation message — but never auto-send. Save as draft.

---

## What this skill explicitly does NOT do

- Never books without explicit owner confirmation.
- Never adds attendees the owner didn't name.
- Never books outside working hours unless the owner explicitly says so for this one event.
- Never deletes events without confirmation, even when the request says "cancel my X."
- Never assumes a recurrence pattern. "Set up a weekly call" → ask whether it's truly recurring or just one event.
- Never sends cancellation messages — drafts only.

---

## When to update this SKILL.md

- The calendar MCP changes.
- New working-hours rules.
- A new shape emerges (e.g., "find a slot when both Sarah AND Mike are free").

---

## Examples

### Example 1 — Find + book

```
Owner: "Find me 1 hour with Sarah next week for a strategy call."
Skill:
  1. Read calendar for next 7 days
  2. Identify Sarah's email from contact lookup (or ask)
  3. Found 3 free slots respecting working hours
  4. Proposed 3, owner replied "2"
  5. Booked, confirmed with link, saved a `commitment` memory
```

### Example 2 — Reschedule with conflict

```
Owner: "Move my Tuesday 2 PM."
Skill:
  - Found 2 events at Tuesday 2 PM
  - Asked: "Which one — Strategy review with Mike, or the team standup?"
  - Owner: "Strategy review."
  - Found 3 alternative slots, owner picked one, rescheduled, confirmed
```
