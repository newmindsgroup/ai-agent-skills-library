---
name: yann-lecun-tecnico
description: 'Sub-skill técnica de Yann LeCun. Cobre CNNs, LeNet, backpropagation, JEPA (I-JEPA, V-JEPA, MC-JEPA), AMI (Advanced Machinery of Intelligence), Self-Supervised Learning (SimCLR, MAE, BYOL), Energy-Based Models (EBMs) e código PyTorch completo.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/yann-lecun-tecnico/SKILL.md'
  imported_at: '2026-05-09'
---

# YANN LECUN — MÓDULO TÉCNICO v3.0

Sub-skill técnica de Yann LeCun. Cobre CNNs, LeNet, backpropagation, JEPA (I-JEPA, V-JEPA, MC-JEPA), AMI (Advanced Machinery of Intelligence), Self-Supervised Learning (SimCLR, MAE, BYOL), Energy-Based Models (EBMs) e código PyTorch completo.

## When to Use
- The request matches the skill description: Sub-skill técnica de Yann LeCun. Cobre CNNs, LeNet, backpropagation, JEPA (I-JEPA, V-JEPA, MC-JEPA), AMI (Advanced Machinery of Intelligence), Self-Supervised Learning (SimCLR, MAE, BYOL), Energy-Based Models (EBMs) e código PyTorch completo.
- The task needs the implementation patterns, examples, validation checks, or edge cases listed in the topic map.
- The work would benefit from the complete guidance preserved in `references/full-guidance.md`.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Overview
- When to Use This Skill
- Do Not Use This Skill When
- How It Works
- Convolutional Neural Networks: Do Princípio
- Antes (Fully Connected): Neurônio I -> Todos Os Pixels
- Cnns: Neurônio -> Região Local [K X K]
- Fisicamente Motivado: Features Visuais São Locais
- Resultado: Translation Equivariance
- Total: ~60,000 Parâmetros
- Backpropagation: A Equação Central
- Self-Supervised Learning: Objetivos E Formalização
- Para Imagens: Cada Pixel. Desperdiçador De Capacidade.
- Tau: Temperature Hyperparameter
- Formulação Central
- Dois Encoders (Ou Um Com Stop-Gradient):
- Predictor:
- Objetivo:

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
