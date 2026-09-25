---
schema: 1
kind: entry
entry: d3dmetal-glossy-puddles-overhaul-terrain-loop-guards-elseform
repository: gamma-metal-fixes
---

# Metal - Glossy Puddles Overhaul - Terrain Loop Guards TODO

## Active

- [ ] <!-- task:offline-compile-check --> Run the offline two-stage shader validation (`tools/shader_work/validate_shaders.py`) with this entry layered in; not run at creation because no `airconv` build was available.
- [ ] <!-- task:validate-terrain-loop-guards --> Validate by behaviour: dry and wet terrain with terrain POM enabled, puddles swelling in rain.

## Completed

- [x] <!-- task:create-overhaul-entry --> Created 2026-09-25 from Glossy Puddles Overhaul 2.0's copy of `deffer_terrain_high_flat_d.ps` with the same two tagged loop caps as the other terrain entries. The Overhaul sits above Atmospherics in the profile, so it is this file's source; before this entry, `Metal - Atmospherics 2.69 RC7.3 SSS24 - Core Fixes` overrode it with the Atmospherics base and the Overhaul's terrain shader never loaded.
