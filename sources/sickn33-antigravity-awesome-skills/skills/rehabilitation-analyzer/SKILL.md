---
name: rehabilitation-analyzer
description: '分析康复训练数据、识别康复模式、评估康复进展，并提供个性化康复建议'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/rehabilitation-analyzer/SKILL.md'
  imported_at: '2026-05-09'
---

# 康复训练分析技能

分析康复训练数据、识别康复模式、评估康复进展，并提供个性化康复建议

## When to Use
- 需要分析康复训练记录、功能恢复趋势或康复阶段进展时使用。
- 任务涉及 ROM、肌力、疼痛、依从性或康复目标达成率分析。
- 用户请求康复报告、趋势分析或训练计划优化建议时使用。

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- 核心功能
- 触发条件
- 执行步骤
- 第1步：数据读取
- 第2步：功能评估趋势分析
- 第3步：疼痛模式分析
- 第4步：训练依从性计算
- 第5步：目标达成评估
- 第6步：康复阶段评估
- 第7步：生成报告
- 输出格式
- 康复进展报告结构
- 康复进展摘要
- 功能改善趋势
- 关节活动度（ROM）
- 肌力评估
- 平衡功能
- 疼痛控制情况

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
