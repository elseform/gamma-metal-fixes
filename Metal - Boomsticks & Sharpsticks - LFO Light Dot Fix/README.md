# Metal - Boomsticks & Sharpsticks - LFO Light Dot Fix

Metal compatibility fix for the LFO light dot weapon shader in
`models_lfo_light_dot_weapons.ps`, shipped by `Boomsticks and Sharpsticks`.

---

## What this mod fixes

### LFO Light Dot — Non-Standard Texture2D.Load Call (`models_lfo_light_dot_weapons.ps`)

Replaces a non-standard `Texture2D.Load(pos2d.xyz)` call — a `float3`
passed where the coordinate argument is defined as `int3` — with the
explicit integer-coordinate form `Texture2D.Load(int3(pos2d.xy, 0))`.
Legacy FXC accepts the malformed overload; DXMT requires the exact integer
coordinate signature, and without the fix the laser/light dot projected by
this weapon attachment fails to compile or render.

---

## Source and Scope

`models_lfo_light_dot_weapons.ps` originates from `Boomsticks and
Sharpsticks` and is unmodified there aside from the tagged `[elseform]`
fix.

---

## Installation & Load Order

Load after `Boomsticks and Sharpsticks`. Purge `appdata/shaders_cache/`
after installing or updating.

## Validation

- Diff against the unmodified source contains only the tagged `[elseform]`
  fix line.
- Compiles under Metal/DXMT without shader errors.
- In-game: the LFO light dot weapon attachment projects a visible dot on
  surfaces.
