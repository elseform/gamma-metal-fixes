# Metal - SSS24 - Terrain Parallax Loop Guard

GPU-hang guard for terrain parallax in Screen Space Shaders 24's copy of deffer_terrain_high_flat_d.ps: caps TerrainParallax and its refinement loop, which are otherwise unbounded and have no TDR recovery on macOS.

---

## What this mod fixes

### 1. P0 — Terrain Parallax-Occlusion Loop Hang Guard (`deffer_terrain_high_flat_d.ps`)
- Caps `TerrainParallax` at 128 iterations and the optional `SSFX_TERRA_POM_REFINE` refinement loop at 64. Same no-TDR-recovery rationale as the other parallax guards.
- The same unbounded loop ships in `Screen Space Shaders 23`, `Glossy Puddles` and `Atmospherics`; each source gets its own guarded copy in its own entry, and only one wins the file conflict at a time.
- `HeightBlending()` in this file is dead code, as in the SSS23 copy: its only call site is commented out.

---

## Current status in this install

Screen Space Shaders 24's copy of this file carries the unbounded loops, so this
guard exists for that source and is judged on that source alone.

As of 2026-09-25 the active profile resolves this file to
`Metal - Atmospherics 2.69 RC7.3 SSS24 - Core Fixes`, because
`Atmospherics 2.69 RC7.3 hotfix SSS24` wins it over Screen Space Shaders 24.
This entry is installed disabled for that reason: enabled above the
Atmospherics fix it would replace the Atmospherics base with the SSS24 one.
Enable it when Screen Space Shaders 24 is the file's winning source. See
[Metal shader compatibility](../../gamma-project/docs/engine/shaders-metal.md)
§ "Author per source mod, not per conflict winner".

Do not enable this alongside `Metal - SSS23 - Terrain Parallax Loop Guard`:
both override the same path and the higher-priority one wins whichever Screen
Space Shaders version is active, so the wrong base would apply. Enable the one
matching the active source.

---

## Source and Scope

`deffer_terrain_high_flat_d.ps` originates from `ScreenSpaceShaders_Update_24 - RC2` and is unmodified from that source aside from the tagged `[elseform]` fix (line endings normalized to LF and trailing whitespace stripped, as in the other entries).

Created 2026-09-25 as the SSS24 counterpart of `Metal - SSS23 - Terrain Parallax Loop Guard`, with the same three tagged edits.

---

## Installation & Load Order

Load after `ScreenSpaceShaders_Update_24 - RC2`, and below any Atmospherics fix entry that owns the same file. Purge `appdata/shaders_cache/` after installation, otherwise the previously compiled variant is reused.

## Validation

Nothing here reaches the DXMT run log: the shader compiles and links cleanly either way, so a capture cannot confirm or deny this fix. Validate by behaviour.

- Content to have on screen: Dry and wet terrain with terrain POM enabled.
- Do not validate by removal. Testing a hang guard by taking it away costs a machine restart per attempt and proves something already known from the code.
