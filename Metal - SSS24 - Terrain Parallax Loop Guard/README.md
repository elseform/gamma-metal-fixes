# Metal - SSS24 - Terrain Parallax Loop Guard

GPU-hang guard for terrain parallax in `deffer_terrain_high_flat_d.ps`,
shipped by `ScreenSpaceShaders_Update_24 - RC1_hotfix2`.

---

## What this mod fixes

### Terrain Parallax-Occlusion Loop Hang Guard (`deffer_terrain_high_flat_d.ps`)

Caps the terrain parallax-occlusion loop at 128 iterations (64 for its
optional contact-refinement pass). Both loops normally exit once the ray
converges, but a degenerate step value (from a division that produces `0`
or `inf`) or a stray `NaN` can make either loop spin forever. macOS has no
GPU timeout recovery, so the GPU stays hung until the game or the machine is
restarted. Both caps sit well above any legitimate iteration count, so
normal rendering is unaffected — the guard only fires once the loop is
already broken.

---

## Source and Scope

This file is shipped, with the same unguarded loop, by three different
mods: `Screen Space Shaders 23`, `ScreenSpaceShaders_Update_24`, and
`Glossy Puddles`. Each one's copy differs slightly (a puddle-gloss
coefficient changed between the SSS23 and SSS24 releases, for example), so
each gets its own guarded copy built against its own source rather than one
shared patch:

- `Metal - SSS23 - Terrain Parallax Loop Guard` — for Screen Space Shaders 23
- `Metal - SSS24 - Terrain Parallax Loop Guard` (this entry) — for
  ScreenSpaceShaders_Update_24
- `Metal - Glossy Puddles 1.5 - Terrain Loop Guards` — for Glossy Puddles

Enable only the entry matching whichever of the three mods you actually have
installed. Enabling more than one just means the higher-priority entry wins
the file conflict, and the others do nothing.

---

## Installation & Load Order

Load after `ScreenSpaceShaders_Update_24 - RC1_hotfix2`. Purge
`appdata/shaders_cache/` after installing or updating, otherwise the
previously compiled variant is reused.

## Validation

This is a hang guard: the shader compiles and runs identically with or
without it under normal conditions, so there's no visual difference to
check for directly. Validate by behavior instead:

- Test dry and wet terrain with terrain parallax occlusion enabled, at
  grazing camera angles where the iteration count is highest.
- Confirm the diff against the unmodified source touches only the loop
  counter and its two loop conditions.
