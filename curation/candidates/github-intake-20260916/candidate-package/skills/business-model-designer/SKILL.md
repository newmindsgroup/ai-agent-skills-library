---
name: business-model-designer
description: 'Design a complete Business Model Canvas for a new or existing business, including customer segments, value propositions, channels, revenue streams, cost structure, unit economics, and strategic coherence. Use when the user wants to create or refine a business model, define revenue streams, map operating assumptions, or turn a validated idea into a scalable commercial blueprint.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/maigentic/stratarts'
  source_path: '~/.codex/skills/business-model-designer/SKILL.md'
  imported_at: '2026-05-09'
---

# Business Model Designer

Version-Timestamp: 2026-09-15 18:53:24 AST

Use this skill when the user needs to transform a business idea into a clear commercial model rather than just brainstorm loosely.

## When to Use

- Designing a business from scratch
- Defining or revising revenue streams
- Building a Business Model Canvas
- Clarifying monetization, channels, partners, or cost structure
- Stress-testing whether a concept is operationally and financially coherent

## Core Outcome

Produce a complete business model design that covers:

- Customer segments
- Value propositions
- Channels
- Customer relationships
- Revenue streams
- Key resources
- Key activities
- Key partners
- Cost structure

Also include:

- Unit economics assumptions where possible
- Strategic coherence check across all nine blocks
- Major risks, gaps, or contradictions
- Recommended next steps

## Workflow

1. Establish the project directory or workspace where strategy outputs should live.
2. Check for prior validation or market-sizing work that can be reused.
3. Gather the minimum missing inputs:
   - target customer
   - problem being solved
   - product or service concept
   - business model type
   - current stage
4. Build the full Business Model Canvas, block by block.
5. Evaluate monetization clarity, scalability, and internal consistency.
6. Summarize the strongest version of the model, the biggest weaknesses, and what needs validation next.

## Output Expectations

- Prefer a structured report over casual notes.
- Make assumptions explicit.
- Separate confirmed facts from inferred strategy.
- If financial inputs are weak, label unit economics as directional rather than definitive.

## Evidence and calculation rules

Respect the requested scope and format. A hypothesis canvas is useful before validation; mark each untested claim. Do not require a viability score, verdict, additional files or a full canvas when the user asks for a narrower calculation.

Calculate only from supplied or explicitly assumed inputs. Align periods and units before arithmetic. Monthly contribution per customer is monthly price minus monthly variable cost. Break-even customers are fixed monthly costs divided by positive contribution, rounded up. If contribution is zero or negative, adding customers does not cover positive fixed costs under that model. Separate stated operating surplus from founder compensation, taxes and omitted costs. Capacity is not demand.

For recurring lifetime value, align revenue, margin and lifetime periods and state the retention assumptions. If inputs are missing, leave the result unknown and identify the next evidence needed. Do not substitute universal LTV:CAC or payback targets for the business context.

## Supporting material

Historical upstream snapshots and templates are retained in the audit repository, excluded from this package. Their scoring and financial formulas are not part of this workflow.

For a requested HTML deliverable, read [assembly guidance](references/ASSEMBLY-WORKFLOW.md). Markdown is the default when no visual format is requested.

## Requested strategy stress test

Version-Timestamp: 2026-09-16 12:26:55 AST

When asked to challenge an existing business plan or its assumptions, use [strategy stress test](references/strategy-stress-test.md). A focused critique does not require rebuilding the canvas.
