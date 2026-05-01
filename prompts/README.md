# Reusable Prompt Templates

Standalone system-prompt templates and instruction blocks you can drop into any IDE, chat tool, or agent harness. Unlike skills, prompts here are not auto-loaded based on triggers — you paste them in (as a system prompt, a project instruction, a Cursor rule, a Claude Project context, etc.).

## What's here

| Prompt | What it does | Best place to paste |
|---|---|---|
| [`voice-dna-template.md`](voice-dna-template.md) | A fillable template for capturing a brand's voice DNA so any AI tool can apply it consistently. Replaces the typical "write in our brand voice" instruction with concrete rules. | Claude Project / Cursor rule / Chat-app system prompt |
| [`agent-skills-spec-summary.md`](agent-skills-spec-summary.md) | One-page summary of the Anthropic Agent Skills spec — paste into any conversation where you're authoring a skill. | When using skill-creator or hand-writing a SKILL.md |
| [`institutional-ai-stance.md`](institutional-ai-stance.md) | Compact version of the institutional-AI operating principles — for chat tools that don't load full skills. | ChatGPT / Gemini system prompt |

## How prompts differ from skills

| | Skill | Prompt |
|---|---|---|
| Loaded by | The agent harness, automatically, on trigger | You, manually, by pasting |
| Format | `SKILL.md` with frontmatter | Plain markdown |
| Scope | Narrow workflow ("draft this newsletter") | Broad stance ("here's how to write in our voice") |
| Output | Behavior: agent does the work | Configuration: agent applies a default |

## Adding a prompt

1. Write the prompt to be self-contained — no external file references.
2. Use `{{PLACEHOLDERS}}` where the user must fill in their own context.
3. Keep it under 1500 words. Long prompts get ignored.
4. Add a row to the table above.
