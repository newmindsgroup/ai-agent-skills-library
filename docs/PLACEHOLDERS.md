# Brand-Config Placeholder System

Some skills in this library reference brand-specific context — voice rules, content pillars, entity-separation rules, scheduled-task cadences. To stay portable across organizations, these skills read a project-local `brand-config.yml` (or `.brand-config.yml`) at the user's repo root, and substitute placeholders when they exist.

If `brand-config.yml` is not present, the skill falls back to generic behavior and asks the user to fill in any missing fields the first time it runs.

## Standard placeholders

| Placeholder | Description | Example |
|---|---|---|
| `{{OWNER_NAME}}` | The person or org the brand belongs to | `Jane Doe`, `Acme Corp` |
| `{{OWNER_HANDLE}}` | Short handle used across surfaces | `janedoe`, `acme` |
| `{{PRIMARY_BRAND}}` | The customer-facing brand identity | `Jane Doe` (personal), `Acme` (corporate) |
| `{{EXCLUDED_ENTITIES}}` | Comma-separated entities NOT to mention in client-facing output | `Holding Co LLC, SisterBrand` |
| `{{BRAND_PLAYBOOK_PATH}}` | Path to the brand voice playbook | `brand-voice-playbook.md` |
| `{{CONTENT_STRATEGY_PATH}}` | Path to the content strategy doc | `content-strategy.md` |
| `{{NEWSLETTER_TEMPLATE_PATH}}` | Path to the newsletter master HTML | `templates/newsletter.html` |
| `{{NEWSLETTER_NAME}}` | Newsletter publication name | `The Weekly Memo` |
| `{{TIMEZONE}}` | IANA timezone for the user | `America/New_York`, `Europe/London` |
| `{{CRM_MCP_PREFIX}}` | MCP server prefix for the user's CRM | `mcp__ghl-mcp__`, `mcp__hubspot__` |
| `{{EMAIL_MCP_PREFIX}}` | MCP server prefix for email inbox | `mcp__gmail__`, `mcp__outlook__` |
| `{{CALENDAR_MCP_PREFIX}}` | MCP server prefix for calendar | `mcp__google-calendar__` |
| `{{REVIEW_CHANNEL}}` | Where the agent pings for human review | `Telegram`, `Slack`, `email` |
| `{{REPO_ROOT}}` | Absolute path to the user's project repo | `/Users/jane/code/my-project` |

## Example `brand-config.yml`

See `brand-config.example.yml` at the repo root for the full annotated template.

## How skills use it

Every skill that needs branding context:

1. Looks for `brand-config.yml` at the project root, then `.brand-config.yml`, then `~/.config/agent-skills/brand-config.yml`.
2. If found, substitutes placeholders into its instructions before acting.
3. If not found, asks the user to either create one or to provide the values inline for this run.
4. Never invents brand context. If a value is missing, the skill flags it rather than guessing.

## Authoring guidance

When you write a new skill that needs brand context:

- Use `{{PLACEHOLDER}}` syntax inline. Do not hard-code names, paths, or schedules.
- Document every placeholder you reference in the skill's `SKILL.md` under a `## Brand-config requirements` section.
- Provide a sensible fallback for each placeholder (or surface an explicit "missing config" message) — the skill must remain functional in a fresh repo.

See `sources/original/skills/newsletter-drafter/SKILL.md` for a worked example.
