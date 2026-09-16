---
name: ai-reliability-evaluation
description: "Design and run AI reliability evaluations across prompts, models, tools, agents, RAG, vector search, observability, cost, latency, safety, security boundaries, and release thresholds. Use before shipping or materially changing AI behavior, retrieval, tool access, model routing, or autonomous workflows."
category: AI, Agents, LLMs, Data
license: MIT
metadata:
  version: '1.0.0'
  author: New Minds Group
  sources: Original New Minds Group AI reliability workflow created from evaluation and observability capability analysis; no third-party skill text copied
---

# AI Reliability Evaluation

Version-Timestamp: 2026-08-04 13:10:00 AST

Use this skill to replace subjective AI approval with measured behavior, clear thresholds, and controlled release decisions.

## Scope

Evaluate any combination of:

- Prompt behavior.
- Model choice and routing.
- Tool permissions and tool outputs.
- Agent planning and handoffs.
- RAG ingestion, chunking, embeddings, retrieval, reranking, citations, and freshness.
- Vector database design, metadata filters, updates, deletions, recall, latency, and tenant boundaries.
- Observability for quality, latency, cost, tokens, errors, traces, feedback, and incidents.

## Safety Rules

- Treat sending prompts, documents, traces, or evaluation rows to an external provider as data publication.
- Use synthetic, public, anonymized, or explicitly approved data.
- Do not test prompt injection, data extraction, tool misuse, privilege escalation, or denial-of-service behavior outside authorized scope.
- Do not rely on evaluator-model scores alone for high-impact safety, legal, financial, medical, or compliance claims.
- Never log secrets, private user content, raw credentials, or unnecessary personal data.

## Evaluation Design

Define:

- Task and user goal.
- Model, prompt, tool, retrieval, and policy versions.
- Success criteria and release thresholds.
- Representative cases.
- Edge cases.
- Refusal and safety cases.
- Unanswerable cases.
- Cross-tenant and access-boundary cases.
- Expected evidence or rubric.
- Human-review sampling plan.

## Metrics

Choose metrics that fit the system:

- Task success.
- Format compliance.
- Groundedness.
- Citation support.
- Retrieval precision and recall.
- Context relevance.
- Refusal correctness.
- Tool-call correctness.
- Latency.
- Cost.
- Consistency.
- Failure severity.

## Failure Triage

Classify failures by layer:

- Data source.
- Ingestion.
- Chunking.
- Embeddings.
- Vector search.
- Reranking.
- Prompt.
- Model.
- Tool contract.
- Authorization policy.
- User interface.
- Observability gap.

Fix the layer that caused the failure, then rerun the same evaluation slice.

## Observability Gate

Before production use, confirm:

- Trace IDs connect user request, retrieval, model call, tool call, guardrail, and final output.
- Content logging is minimized and justified.
- Sensitive fields are redacted.
- Cost and latency are visible.
- Error categories are actionable.
- Production incidents can map back to evaluation cases.

## Release Decision

Return:

- Baseline versus candidate result.
- Pass, conditional pass, or fail.
- Failed cases and severity.
- Versioned dataset location.
- Residual risks.
- Required fix before release.
