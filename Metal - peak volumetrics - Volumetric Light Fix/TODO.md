---
schema: 1
kind: entry
entry: d3dmetal-peak-volumetrics-volumetric-light-fix-elseform
repository: gamma-metal-fixes
---

# Metal - peak volumetrics - Volumetric Light Fix TODO

## Active

- [ ] <!-- task:runtime-validate-volumetric-light --> Runtime-validate volumetric light shafts near light source origins under DXMT after shader cache purge.

## Completed

- [x] <!-- task:split-from-sss23-core-fixes --> Split out 2026-08-20 from `Metal - SSS23 - Core Fixes`: `pfx_volumetric_light.ps` true source is `peak_volumetrics_1_2_no_bin`, not Screen Space Shaders 23. See parent entry TODO for the split rationale.
- [x] <!-- task:patch-volumetric-light-rsqrt --> Patched rsqrt division-by-zero guard in `pfx_volumetric_light.ps`.
