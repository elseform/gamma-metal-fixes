# Metal - SSS23 - Terrain Parallax Loop Guard

GPU-hang guard for terrain parallax in Screen Space Shaders 23's copy of deffer_terrain_high_flat_d.ps: caps TerrainParallax and its refinement loop, which are otherwise unbounded and have no TDR recovery on macOS.

---

## What this mod fixes

### 1. P0 — Terrain Parallax-Occlusion Loop Hang Guard (`deffer_terrain_high_flat_d.ps`)
- Caps `TerrainParallax` at 128 iterations and the optional `SSFX_TERRA_POM_REFINE` refinement loop at 64. Same no-TDR-recovery rationale as the other parallax guards.
- The same unbounded loop ships in `Glossy Puddles` and `Atmospherics`; each source gets its own guarded copy in its own entry, and only one wins the file conflict at a time.
- `HeightBlending()` in this file has no div-by-zero guard, investigated 2026-09-08 and found moot: its only call site is commented out here and in every other owning mod's copy, so it is unreachable dead code.

---

## Current status in this install

Screen Space Shaders 23's copy of this file carries the unbounded loops, so this
guard exists for that source and is judged on that source alone.

Which fixed copy is active at runtime is a separate matter and changes with the
load order: as of 2026-09-10 the flat install carries `32a487eb`, the
`Metal - Glossy Puddles 1.5 - Terrain Loop Guards` copy, because Glossy
Puddles wins the file while it is installed. That does not make this entry
redundant — enable states and priorities move constantly during a validation
sweep, and a guard scoped to today's winner is a gap tomorrow. See
[Metal & Metal shader compatibility](../../../../gamma-project/docs/engine/shaders-d3dmetal.md)
§ "Author per source mod, not per conflict winner".

Do not enable this alongside `Metal - SSS24 - Terrain Parallax Loop Guard`:
both override the same path and the higher-priority one wins whichever Screen
Space Shaders version is active, so the wrong base would apply. Enable the one
matching the active source.

---

## Source and Scope

`deffer_terrain_high_flat_d.ps` originates from `190- Screen Space Shaders 23 - Ascii1457` and is unmodified in that source archive aside from the tagged `[elseform]` fix.

Added to `Metal - SSS23 - Core Fixes` on 2026-08-20, moved to the combined loop-guards entry and split out 2026-09-09. Split so that each guard can be installed, validated and — where the evidence supports it — retired on its own.

---

## Installation & Load Order

Load after `190- Screen Space Shaders 23 - Ascii1457`. Purge `appdata/shaders_cache/` after installation, otherwise the previously compiled variant is reused.

## Validation

Nothing here reaches the DXMT run log: the shader compiles and links cleanly either way, so a capture cannot confirm or deny this fix. Validate by behaviour.

- Content to have on screen: Dry and wet terrain with terrain POM enabled.
- Do not validate by removal. Testing a hang guard by taking it away costs a machine restart per attempt and proves something already known from the code.
