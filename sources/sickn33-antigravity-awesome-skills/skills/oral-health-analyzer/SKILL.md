---
name: oral-health-analyzer
description: '分析口腔健康数据、识别口腔问题模式、评估口腔健康状况、提供个性化口腔健康建议。支持与营养、慢性病、用药等其他健康数据的关联分析。'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/oral-health-analyzer/SKILL.md'
  imported_at: '2026-05-09'
---

# 口腔健康分析技能

分析口腔健康数据、识别口腔问题模式、评估口腔健康状况、提供个性化口腔健康建议。支持与营养、慢性病、用药等其他健康数据的关联分析。

## When to Use
- 需要分析口腔健康趋势、龋齿风险、牙周问题或卫生习惯时使用。
- 任务涉及口腔健康评分、问题模式识别或个性化口腔护理建议。
- 用户请求口腔健康报告或长期口腔记录分析时使用。

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
- 趋势分析
- 风险评估
- 关联分析
- 个性化建议
- 目标管理
- 统计分析
- 预警系统
- 使用场景
- 场景1：定期健康评估
- 场景2：问题诊断辅助
- 场景3：治疗规划
- 场景4：多学科联合分析
- 场景5：预防性指导
- 数据分析方法
- 定量分析

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
