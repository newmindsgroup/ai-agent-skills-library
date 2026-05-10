---
name: goal-analyzer
description: '分析健康目标数据、识别目标模式、评估目标进度,并提供个性化目标管理建议。支持与营养、运动、睡眠等健康数据的关联分析。'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/goal-analyzer/SKILL.md'
  imported_at: '2026-05-09'
---

# 健康目标分析器技能

分析健康目标数据,识别目标模式和进度,评估目标达成情况,并提供个性化目标管理建议。

## When to Use
- 你需要评估健康目标是否符合 SMART 原则，并识别目标设定中的薄弱点。
- 你想跟踪目标进度，并结合营养、运动、睡眠等健康数据做关联分析。
- 你需要面向个人健康管理的目标优化建议、风险提示和阶段性调整方案。

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- 功能
- SMART目标验证
- 目标进度追踪
- 习惯养成分析
- 动机评估与管理
- 成就系统管理
- 障碍识别与建议
- 数据关联分析
- 可视化报告生成
- 医学安全边界
- 能力范围声明
- 危险信号识别
- 输出格式
- 目标分析报告
- 目标概览
- SMART评估
- 进度分析
- 趋势分析

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
