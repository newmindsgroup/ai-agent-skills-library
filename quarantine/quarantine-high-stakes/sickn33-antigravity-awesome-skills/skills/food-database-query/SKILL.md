---
name: food-database-query
description: 'Provides the food-database-query workflow for agent-assisted work. Use when the user''s request matches this skill''s domain or trigger language.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/food-database-query/SKILL.md'
  imported_at: '2026-05-09'
---

# 食物数据库查询技能

**技能名称**: Food Database Query **技能类型**: 数据查询与分析 **创建日期**: 2026-01-06 **版本**: v1.0

## When to Use
- 需要查询食物营养成分、比较食物差异或做营养计算时使用。
- 任务涉及食物数据库检索、食物推荐、份量换算或分类筛选。
- 需要基于结构化食物数据生成分析结果而不是自由文本建议时使用。

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- 技能概述
- 数据源
- 主数据库
- 分类体系
- 功能模块
- 食物查询 (Food Query)
- 食物比较 (Food Comparison)
- 食物推荐 (Food Recommendation)
- 自动营养计算 (Auto Nutrition Calculation)
- 智能搜索 (Smart Search)
- 数据结构
- 食物数据结构
- RDA参考值
- 成年男性 (19-50岁)
- 成年女性 (19-50岁)
- 集成功能
- 与营养模块集成
- 与健康模块集成

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
