---
name: nutrition-analyzer
description: '分析营养数据、识别营养模式、评估营养状况，并提供个性化营养建议。支持与运动、睡眠、慢性病数据的关联分析。'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/nutrition-analyzer/SKILL.md'
  imported_at: '2026-05-09'
---

# 营养分析器技能

分析饮食和营养数据，识别营养模式，评估营养状况，并提供个性化营养改善建议。

## When to Use
- 需要分析营养摄入、饮食模式或营养素达标情况时使用。
- 任务涉及宏量/微量营养素评估、RDA 对比、饮食趋势或膳食改进建议。
- 需要把营养数据与运动、睡眠或慢性病数据关联分析时使用。

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- 功能
- 营养趋势分析
- 营养素摄入评估
- 营养状况评估
- 相关性分析
- 个性化建议生成
- 使用说明
- 触发条件
- 执行步骤
- 输出格式
- 营养趋势分析报告
- 分析周期
- 宏量营养素趋势
- 卡路里摄入
- 蛋白质
- 膳食纤维
- 脂肪
- 维生素状况趋势

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
