---
schema: 1
kind: entry
entry: d3dmetal-precomputed-gasmask-noise-raindrops-fix-elseform
repository: gamma-metal-fixes
---

# Metal - Precomputed Gasmask Noise - Gasmask Raindrops Fix TODO

## Active

- [ ] <!-- task:retire-not-needed-2026-09-19 --> Retire: user report 2026-09-19, the effect breaks with this entry enabled and works without it; DXMT's own NaN handling appears sufficient. Supersedes the validation tasks below.

- [ ] <!-- task:runtime-validate-gasmask-raindrops --> Runtime-validate gasmask raindrop overlay under DXMT after shader cache purge, in rain.

## Completed

- [x] <!-- task:split-from-sss23-core-fixes --> Split out 2026-08-20 from `Metal - SSS23 - Core Fixes`: `gasmask_drops.ps` true source is `476- Precomputed Gasmask Noise - SoulCrystal & LVutner`, not Screen Space Shaders 23. See parent entry TODO for the split rationale.
- [x] <!-- task:patch-gasmask-drops-domain --> Patched sqrt/smoothstep domain guards in `gasmask_drops.ps`.
