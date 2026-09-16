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

- [x] <!-- task:split-from-sss23-core-fixes --> Split out 2026-08-20 from `Metal - SSS23 - Core Fixes`: `gasmask_dudv.ps` true source is `129- Mask Reflections - shader fix - Grokitach`, not Screen Space Shaders 23. See parent entry TODO for the split rationale.
- [x] <!-- task:patch-gasmask-dudv-vectors --> Patched comma-operator constructor and float3/float4 arithmetic mismatch in `gasmask_dudv.ps`.
