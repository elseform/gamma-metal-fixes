---
schema: 1
kind: entry
entry: d3dmetal-boomsticks-and-sharpsticks-nv-scope-tint-fix-elseform
repository: gamma-metal-fixes
---

# Metal - Boomsticks and Sharpsticks - NV Scope Tint Fix TODO

## Active

- [ ] <!-- task:runtime-validate-nv-scope-tint --> Runtime-validate NV scope tint across all 3 generations under DXMT after shader cache purge.

## Completed

- [x] <!-- task:split-from-3dss5-optics --> Split out 2026-08-20 from `Metal - 3DSS5 - Optics`: `models_scope_nv_1/2/3.ps` true source is `Boomsticks and Sharpsticks` 1.5.1, not 3D Shader Scopes for GAMMA. See parent entry TODO for the split rationale.
- [x] <!-- task:patch-nv-scope-tint-comma-operator --> Replaced comma-operator color constructor with explicit `float3(...)` in `models_scope_nv_1/2/3.ps`.
