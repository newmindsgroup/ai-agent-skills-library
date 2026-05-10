---
name: audio-transcriber
description: 'Transform audio recordings into professional Markdown documentation with intelligent summaries using LLM integration'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/audio-transcriber/SKILL.md'
  imported_at: '2026-05-09'
---

# Check for Faster-Whisper (preferred - 4-5x faster)

if python3 -c "import faster_whisper" 2>/dev/null; then TRANSCRIBER="faster-whisper" echo "✅ Faster-Whisper detected (optimized)" # Fallback to original Whisper elif python3 -c "import whisper" 2>/dev/null; then TRANSCRIBER="whisper" echo "✅ OpenAI Whisper detected" else TRANSCRIBER="none" echo "⚠️  No transcription tool found" fi

# Check for ffmpeg (audio format conversion) if command -v ffmpeg &>/dev/null; then echo "✅ ffmpeg available (format conversion enabled)" else echo "ℹ️  ffmpeg not found (limited format support)" fi

**If no transcriber found:**

Offer automatic installation using the provided script:

echo "⚠️  No transcription tool found" echo "" echo "🔧 Auto-install...

## When to Use
- Invoke this skill when:
- User needs to transcribe audio/video files to text
- User wants meeting minutes automatically generated from recordings
- User requires speaker identification (diarization) in conversations
- User needs subtitles/captions (SRT, VTT formats)
- User wants executive summaries of long audio content
- User asks variations of "transcribe this audio", "convert audio to text", "generate meeting notes from recording"
- User has audio files in common formats (MP3, WAV, M4A, OGG, FLAC, WEBM)

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Purpose
- Workflow
- Step 0: Discovery (Auto-detect Transcription Tools)
- Step 1: Validate Audio File
- Step 3: Generate Markdown Output
- 📊 Metadata
- 📋 Meeting Minutes
- Participants
- Topics Discussed
- Decisions Made
- Action Items
- Step 5: Display Results Summary
- Example Usage
- **Example 1: Basic Transcription**
- **Example 3: Batch Processing**
- **Example 5: Large File Warning**

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
