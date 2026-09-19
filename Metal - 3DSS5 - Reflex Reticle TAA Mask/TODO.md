---
schema: 1
kind: entry
entry: d3dmetal-3dss5-reflex-reticle-taa-mask
repository: gamma-metal-fixes
---

# Metal - 3DSS5 - Reflex Reticle TAA Mask TODO

## Active

- [ ] <!-- task:runtime-validate-premultiplied-rework --> Runtime-validate 1.1.0: EOTech/red-dot reticle as bright as with 1.0.0, no smudge while panning, mark switch works; thermal-overlay and dummy-cutout reticles still render (their .s use aref(true, 1)/(true, 0), and colour alpha is now 0).
- [ ] <!-- task:trace-verify-premultiplied-rework --> Post-fix panning trace: the motion-vector target changes only under the visible reticle strokes, not across the whole reticle mesh.
- [ ] <!-- task:reflex-lens-motion-vectors --> Next: `models_reflex_lens` (glass dirt/reflections) writes no motion vectors and smears with the world while panning; give it coverage-weighted HUD vectors (its blend is already srcalpha/invsrcalpha).

- [ ] <!-- task:runtime-validate-reticle-taa-mask --> Runtime-validate: holographic/red-dot reticle brightness stays stable while moving the camera, with SSS TAA and DLSS on; check thermal-overlay and dummy-cutout reticle variants still render.

## Completed

- [x] <!-- task:diagnose-reticle-pulse --> 2026-09-17: Diagnosed from a DXMT GPU trace (EOTech, DLSS on). The reticle is drawn at render resolution in the forward pass (`SV_Target2` = motion vectors bound but unwritten) and loses about 30% of its peak through the temporal upscale. Reported by the user as present before DLSS too (SSS TAA), just milder.
