---
schema: 1
kind: entry
entry: d3dmetal-sss24-terrain-parallax-loop-guard-elseform
repository: gamma-metal-fixes
---

# Metal - SSS24 - Terrain Parallax Loop Guard TODO

## Active

- [ ] <!-- task:offline-compile-check --> Run the offline two-stage shader validation (`tools/shader_work/validate_shaders.py`) with this entry layered in; not run at creation because no `airconv` build was available.
- [ ] <!-- task:validate-terrain-parallax-loop-guard --> Validate by behaviour, not by log, once Screen Space Shaders 24 wins the file: Dry and wet terrain with terrain POM enabled.

## Completed

- [x] <!-- task:create-sss24-counterpart --> Created 2026-09-25 from `ScreenSpaceShaders_Update_24 - RC2`'s copy with the same tagged edits as the SSS23 entry.
