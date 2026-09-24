---
schema: 1
kind: entry
entry: d3dmetal-3dss5-sss24-dlss-buffers
repository: gamma-metal-fixes
---

# Metal - 3DSS5 - SSS24 DLSS Buffers TODO

## Active

- [ ] <!-- task:non-precise-reticle-thermal --> Decide whether `models_scope_reticle.s`/`.ps` (non-precise lens) need the same fix; not covered by the 2026-09-19 traces.

## Completed

- [x] <!-- task:diagnose-magnifier-scene-final --> 2026-09-19: Diagnosed from DXMT GPU traces (EXPS3-2 + G33 combo, `e0t2_magd`). The lens samples `$user$generic_temp`, a render-resolution copy taken before the forward pass that draws the EOTech dot; `$user$scene_final` (identified via `postprocess.s`) holds the upscaled frame with the dot right before the lens draw.
- [x] <!-- task:diagnose-thermal-dlss-buffers --> 2026-09-19: Diagnosed from DXMT GPU traces (T12, cold wall and NPC). `s_position` is bound to the volumetric light buffer, and heat loads use the output-resolution `screen_res` against DLSS-resolution buffers.
