---
name: mental-health-analyzer
description: '分析心理健康数据、识别心理模式、评估心理健康状况、提供个性化心理健康建议。支持与睡眠、运动、营养等其他健康数据的关联分析。'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/mental-health-analyzer/SKILL.md'
  imported_at: '2026-05-09'
---

# 心理健康分析技能

分析心理健康数据、识别心理模式、评估心理健康状况、提供个性化心理健康建议。支持与睡眠、运动、营养等其他健康数据的关联分析。

## When to Use
- 需要分析情绪、焦虑、抑郁评分、治疗进展或危机风险时使用。
- 任务涉及心理健康趋势、情绪模式识别或与睡眠/运动/营养的关联分析。
- 用户请求心理健康报告、风险预警或治疗进展追踪时使用。

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- 核心功能
- 触发条件
- 医学安全边界
- 执行步骤
- 第1步：数据读取
- 第2步：心理健康评估趋势分析
- 第3步：情绪模式识别
- 第4步：心理治疗进展追踪
- 第5步：危机风险评估（优先级：最高）
- 第6步：睡眠-心理关联分析
- 第7步：运动-情绪关联分析
- 第8步：营养-心理关联分析
- 第9步：慢性病-心理关联分析
- 第10步：生成报告
- 输出格式
- 心理健康分析报告结构
- 危机风险预警
- 心理健康状况摘要

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
