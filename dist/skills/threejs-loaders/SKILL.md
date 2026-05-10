---
name: threejs-loaders
description: 'Three.js asset loading - GLTF, textures, images, models, async patterns. Use when loading 3D models, textures, HDR environments, or managing loading progress.'
license: MIT
metadata:
  imported_from: 'codex-regular'
  source_repository: 'https://github.com/sickn33/antigravity-awesome-skills'
  source_path: '~/.codex/skills/threejs-loaders/SKILL.md'
  imported_at: '2026-05-09'
---

# Three.js Loaders

Three.js asset loading - GLTF, textures, images, models, async patterns. Use when loading 3D models, textures, HDR environments, or managing loading progress.

## When to Use
- You need to load models, textures, HDR assets, or other external resources in Three.js.
- The task involves `GLTFLoader`, `TextureLoader`, loading progress, or async asset orchestration.
- You are managing scene assets rather than authoring geometry or shaders directly.

## Core Workflow
1. Confirm the request matches this skill's trigger, scope, and risk profile.
2. Use the topic map to identify the relevant pattern, checklist, or example before writing detailed guidance or code.
3. Load `references/full-guidance.md` when implementation details, examples, anti-patterns, validation checks, or edge cases are needed.
4. Apply only the relevant guidance instead of loading or repeating the entire reference by default.
5. Verify the result against any validation checks, limitations, security notes, or platform constraints in the reference.

## Topic Map
- Quick Start
- LoadingManager
- Texture Loading
- TextureLoader
- Texture Configuration
- CubeTextureLoader
- HDR/EXR Loading
- PMREMGenerator
- GLTF/GLB Loading
- GLTF with Draco Compression
- GLTF with KTX2 Textures
- GLTF with Meshopt Compression (r183)
- Process GLTF Content
- Other Model Formats
- OBJ + MTL
- FBX
- STL
- PLY

## Reference Map
- `references/full-guidance.md` preserves the complete original guidance, including examples and detailed edge cases.

## Limitations
- Use this skill only when the task clearly matches the scope described above.
- Do not treat the output as a substitute for environment-specific validation, testing, or expert review.
- Stop and ask for clarification if required inputs, permissions, safety boundaries, or success criteria are missing.

## Progressive Loading
Keep this `SKILL.md` as the compact routing and workflow entrypoint. Load the reference file only when the user task requires the deeper implementation material.
