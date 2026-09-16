---
schema: 1
kind: entry
entry: d3dmetal-mask-reflections-gasmask-overlay-fix-elseform
repository: gamma-metal-fixes
---

# Metal - Mask Reflections - Gasmask Overlay Fix TODO

## Active

- [ ] <!-- task:runtime-validate-gasmask-overlay --> Runtime-validate gasmask overlay rendering under DXMT after shader cache purge.

## Completed

- [x] <!-- task:nvg-tube-reflection-bleed --> 2026-09-17: Visor reflection skips samples inside Beef's NVG tube mask. Beef's `combine_1.ps` writes encoded channel data (R luma, G light, B albedo) into the tube before `phase_gasmask_dudv`, and the reflection smeared it into the screen corners as red/purple. Diagnosed from a DXMT GPU trace (gasmask pass raised corner R-G from 0.019 to 0.133; later passes carry it unchanged). Cross-mod ordering issue, not Metal-specific; folded here by user decision.

- [x] <!-- task:split-from-sss23-core-fixes --> Split out 2026-08-20 from `Metal - SSS23 - Core Fixes`: `gasmask_dudv.ps` true source is `129- Mask Reflections - shader fix - Grokitach`, not Screen Space Shaders 23. See parent entry TODO for the split rationale.
- [x] <!-- task:patch-gasmask-dudv-vectors --> Patched comma-operator constructor and float3/float4 arithmetic mismatch in `gasmask_dudv.ps`.
