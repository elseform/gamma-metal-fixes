---
schema: 1
kind: entry
entry: d3dmetal-3dss5-thermal-dlss-buffers
repository: gamma-metal-fixes
---

# Metal - 3DSS5 - Thermal DLSS Buffers TODO

## Active

- [ ] <!-- task:trace-verify-thermal-dlss-buffers --> Post-fix GPU trace of the T12 aimed at an NPC: heat under the NPC reaches the scope output (the scope-centre value moves off the cold background), and the cold background varies with surface normals instead of one flat value.
- [ ] <!-- task:runtime-validate-thermal-dlss-buffers --> Runtime-validate in game: NPC silhouettes visible in the T12, cold geometry shaded, no static or black output; check a second thermal optic that uses the precise reticle shader.
- [ ] <!-- task:non-precise-reticle-thermal --> Decide whether `models_scope_reticle.s`/`.ps` (non-precise lens) need the same fix; not covered by the 2026-09-19 traces.

## Completed

- [x] <!-- task:diagnose-thermal-dlss-buffers --> 2026-09-19: Diagnosed from DXMT GPU traces (T12, cold wall and NPC). `s_position` is bound to the volumetric light buffer, and heat loads use the output-resolution `screen_res` against DLSS-resolution buffers.
