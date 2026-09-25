# Metal - Glossy Puddles Overhaul - Terrain Loop Guards

Bounds the two unbounded terrain parallax-occlusion loops in Glossy Puddles
Overhaul's terrain shader so they cannot hang the GPU under **Metal / DXMT**
(macOS / Apple Silicon).

macOS has no TDR-style recovery — a fragment shader that spins forever takes
down the GPU until the game or the machine restarts, so data-dependent loops
with no iteration cap are the top hang risk in the shader stack. Terrain POM
normally terminates because `curr_step += _step` outgrows the sampled height; a
degenerate `_step` (a division producing 0 or inf) or a NaN feeding the
comparison can otherwise spin it.

## Source mod

| Source mod | Version this fix was built against | File |
| --- | --- | --- |
| Glossy Puddles Overhaul | 2.0 | `gamedata/shaders/r3/deffer_terrain_high_flat_d.ps` |

The shipped shader is Glossy Puddles Overhaul's own terrain shader — its
permanent puddles, water depth, damp ring and dynamic gloss — plus the two
guards. Line endings and trailing whitespace are normalized as in the other
entries; everything else that differs is a tagged `[elseform]` line. If the
Overhaul updates this file, re-copy it and re-apply the guards (search
`[elseform]`).

## What it changes

- Caps the terrain POM main loop at 128 iterations.
- Caps the optional `SSFX_TERRA_POM_REFINE` contact-refinement loop at 64
  iterations.

Both limits sit well above the worst legitimate step count, so visuals are
unaffected — a guard only fires if the loop is already misbehaving.
`HeightBlending()` is left as shipped: its only call site is commented out, as
in every other copy of this file.

## Install

1. Install as a normal MO2 mod, or drop its `gamedata` folder into the game
   directory.
2. Load it **after** Glossy Puddles Overhaul, and **above** any Atmospherics
   or Screen Space Shaders terrain fix entry, so this terrain shader wins the
   conflict. Those entries ship a different base shader without the Overhaul's
   puddles.
3. **Delete the `appdata/shaders_cache/` folder** so the game rebuilds the
   shaders. This step is required, not optional.

This entry is self-contained: it ships the complete terrain shader and does not
require any other loop-guard mod.

`Glossy Puddles 1.5`, `Screen Space Shaders 23`, `ScreenSpaceShaders_Update_24`
and `Atmospherics 2.69 RC7.3` ship the same unbounded terrain parallax loop in
their own copies of this file. Each has its own separately guarded entry; only
the one matching your active terrain-shader source should win the file
conflict.

## Validation

Static checks:

- Compare the override against Glossy Puddles Overhaul and verify the only
  additions are the two loop guards.

In-game checks:

- Compile the terrain shader under Metal/DXMT without errors.
- Check dry and wet terrain with terrain POM enabled, including puddles
  swelling in rain.
