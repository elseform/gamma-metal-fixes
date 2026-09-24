---
schema: 1
kind: entry
entry: d3dmetal-3dss5-reflex-reticle-taa-mask
repository: gamma-metal-fixes
---

# Metal - 3DSS5 - Reflex Sight Motion Vectors TODO

## Active



## Completed

- [x] <!-- task:diagnose-reticle-pulse --> 2026-09-17: Diagnosed from a DXMT GPU trace (EOTech, DLSS on). The reticle is drawn at render resolution in the forward pass (`SV_Target2` = motion vectors bound but unwritten) and loses about 30% of its peak through the temporal upscale. Reported by the user as present before DLSS too (SSS TAA), just milder.
