---
schema: 1
kind: entry
entry: d3dmetal-3dss5-sss24-dlss-buffers
repository: gamma-metal-fixes
---

# Metal - 3DSS5 - SSS24 DLSS Buffers TODO

## Active

- [ ] <!-- task:trace-verify-magnifier-scene-final --> Post-fix GPU trace, G3 with EOTech EXPS3-2 + G33 magnifier in line: the lens draw samples the 2560x1440 `scene_final` copy and its output contains the magnified EOTech dot.
- [ ] <!-- task:runtime-validate-magnifier-scene-final --> Runtime-validate: the EOTech/holo reticle is visible through the G33 magnifier, the magnified image is as sharp as the rest of the screen, and ordinary 3DSS scopes (ACOG, LPVO, NV) still look correct.
- [ ] <!-- task:trace-verify-thermal-dlss-buffers --> Post-fix GPU trace of the T12 aimed at an NPC: heat under the NPC reaches the scope output (the scope-centre value moves off the cold background), and the cold background varies with surface normals instead of one flat value.
- [ ] <!-- task:runtime-validate-thermal-dlss-buffers --> Runtime-validate in game: NPC silhouettes visible in the T12, cold geometry shaded, no static or black output; check a second thermal optic that uses the precise reticle shader.
- [ ] <!-- task:non-precise-reticle-thermal --> Decide whether `models_scope_reticle.s`/`.ps` (non-precise lens) need the same fix; not covered by the 2026-09-19 traces.

## Completed

- [x] <!-- task:diagnose-magnifier-scene-final --> 2026-09-19: Diagnosed from DXMT GPU traces (G3, EXPS3-2 + G33). The lens samples `$user$generic_temp`, a render-resolution copy taken before the forward pass that draws the EOTech dot; `$user$scene_final` (identified via `postprocess.s`) holds the upscaled frame with the dot right before the lens draw.
- [x] <!-- task:diagnose-thermal-dlss-buffers --> 2026-09-19: Diagnosed from DXMT GPU traces (T12, cold wall and NPC). `s_position` is bound to the volumetric light buffer, and heat loads use the output-resolution `screen_res` against DLSS-resolution buffers.
