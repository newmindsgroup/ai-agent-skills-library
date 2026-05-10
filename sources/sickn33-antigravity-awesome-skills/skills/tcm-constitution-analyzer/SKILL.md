---
name: tcm-constitution-analyzer
description: '分析中医体质数据、识别体质类型、评估体质特征,并提供个性化养生建议。支持与营养、运动、睡眠等健康数据的关联分析。'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/tcm-constitution-analyzer/SKILL.md'
  imported_at: '2026-05-09'
---

# 中医体质辨识分析器技能

分析中医体质数据,识别体质类型,评估体质特征,并提供个性化养生改善建议。

## When to Use
- 你需要根据中医体质分类标准评估用户体质，并识别主导体质与兼夹体质。
- 你想结合营养、运动、睡眠等健康数据分析体质特征、风险和变化趋势。
- 你需要面向个体化调理的养生建议、趋势跟踪和相关性分析结果。

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- 功能
- 体质辨识评估
- 体质特征分析
- 体质变化趋势分析
- 相关性分析
- 个性化建议生成
- 使用说明
- 触发条件
- 执行步骤
- 输出格式
- 体质辨识评估报告
- 评估日期
- 评估结果
- 体质类型判定
- 各体质评分
- 气虚质特征
- 阳虚质特征
- 养生建议

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
