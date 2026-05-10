---
name: sleep-analyzer
description: '分析睡眠数据、识别睡眠模式、评估睡眠质量，并提供个性化睡眠改善建议。支持与其他健康数据的关联分析。'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/sleep-analyzer/SKILL.md'
  imported_at: '2026-05-09'
---

# 睡眠分析器技能

分析睡眠数据，识别睡眠模式，评估睡眠质量，并提供个性化睡眠改善建议。

## When to Use
- 需要分析睡眠时长、效率、作息规律或睡眠质量时使用。
- 任务涉及失眠模式、夜间觉醒、PSQI 评分或睡眠问题识别。
- 需要把睡眠数据与情绪、运动或其他健康因素做关联分析时使用。

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- 功能
- 睡眠趋势分析
- 睡眠质量评估
- 睡眠问题识别
- 相关性分析
- 个性化建议生成
- 使用说明
- 触发条件
- 执行步骤
- 输出格式
- 睡眠质量分析报告
- 分析周期
- 睡眠时长趋势
- 睡眠效率
- 作息规律性
- 睡眠质量分布
- 夜间觉醒分析
- PSQI 评估趋势

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
