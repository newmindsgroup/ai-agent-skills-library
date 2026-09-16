---
name: skill-creator
description: 'To create new CLI skills following Anthropic''s official best practices with zero manual configuration. This skill automates brainstorming, template application, validation, and installation processes while maintaining progressive disclosure patterns and writing style standards.'
license: Apache-2.0
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/skill-creator/SKILL.md'
  imported_at: '2026-05-09'
---
# skill-creator

To create new CLI skills following Anthropic's official best practices with zero manual configuration. This skill automates brainstorming, template application, validation, and installation processes while maintaining progressive disclosure patterns and writing style standards.

## When to Use
- The request matches the skill description: To create new CLI skills following Anthropic's official best practices with zero manual configuration. This skill automates brainstorming, template application, validation, and installation processes while maintaining progressive disclosure patterns and writing style standards.
- The task needs the implementation patterns, examples, validation checks, or edge cases listed in the topic map.
- The work would benefit from the complete guidance preserved in `references/full-guidance.md`.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Purpose
- When to Use This Skill
- Core Capabilities
- Step 0: Discovery
- Main Workflow
- Progress Tracking Guidelines
- Phase 1: Brainstorming & Planning
- Phase 2: Prompt Enhancement (Optional)
- Phase 3: File Generation
- Phase 4: Validation
- Phase 5: Installation
- Phase 6: Completion
- Error Handling
- Platform Detection Issues
- Template Not Found
- Validation Failures
- Installation Conflicts
- Bundled Resources

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
