---
name: voice-agents
description: 'Voice agents represent the frontier of AI interaction - humans'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/voice-agents/SKILL.md'
  imported_at: '2026-05-09'
---

# Voice Agents

Voice agents represent the frontier of AI interaction - humans speaking naturally with AI systems. The challenge isn't just speech recognition and synthesis, it's achieving natural conversation flow with sub-800ms latency while handling interruptions, background noise, and emotional nuance.

This skill covers two architectures: speech-to-speech (OpenAI Realtime API, lowest latency, most natural) and pipeline (STT→LLM→TTS, more control, easier to debug). Key insight: latency is the constraint. Humans expect responses in 500ms. Every millisecond matters.

84% of organizations are increasing voice AI budgets in 2025. This is the year voice agents go mainstream.

## When to Use
- User mentions or implies: voice agent
- User mentions or implies: speech to text
- User mentions or implies: text to speech
- User mentions or implies: whisper
- User mentions or implies: elevenlabs
- User mentions or implies: deepgram
- User mentions or implies: realtime api
- User mentions or implies: voice assistant
- User mentions or implies: voice ai
- User mentions or implies: conversational ai

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Principles
- Capabilities
- Scope
- Tooling
- Speech_to_speech
- Speech_to_text
- Text_to_speech
- Frameworks
- Patterns
- Speech-to-Speech Architecture
- OpenAI Realtime API
- Use Cases:
- Pipeline Architecture
- Production Pipeline Example
- Optimization Tips:
- Voice Activity Detection Pattern
- Silero VAD (Popular Open Source)
- OpenAI Semantic VAD

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
