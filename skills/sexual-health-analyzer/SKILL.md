---
name: sexual-health-analyzer
description: 'Provides the sexual-health-analyzer workflow for agent-assisted work. Use when the user''s request matches this skill''s domain or trigger language.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/sexual-health-analyzer/SKILL.md'
  imported_at: '2026-05-09'
---

# 性健康分析技能

Provides the sexual-health-analyzer workflow for agent-assisted work. Use when the user's request matches this skill's domain or trigger language.

## When to Use
- 需要分析性健康记录、筛查情况、避孕效果或相关风险模式时使用。
- 任务涉及 IIEF-5 评分、STD 筛查管理、性活动统计或跨模块关联分析。
- 用户请求性健康趋势报告或结构化风险分析时使用。

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- 技能概述
- 医学免责声明
- 核心功能
- IIEF-5 评分分析
- STD 筛查管理
- 避孕管理
- 性活动日志
- 关联分析
- 风险评估
- 个性化建议
- 预警系统
- 使用场景
- 场景1:定期性健康评估
- 场景2:ED诊断辅助
- 场景3:避孕方法选择
- 场景4:STD风险评估
- 场景5:多学科联合分析
- 数据分析方法

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
