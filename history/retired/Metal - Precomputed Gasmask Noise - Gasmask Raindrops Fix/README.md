# Metal - Precomputed Gasmask Noise - Gasmask Raindrops Fix

Metal compatibility fix for gasmask raindrops in `gasmask_drops.ps`,
shipped by `Precomputed Gasmask Noise` (SoulCrystal & LVutner).

---

## What this mod fixes

### Gasmask Raindrops Sqrt & Smoothstep Div-by-Zero (`gasmask_drops.ps`)

- Adds `max(0.0, ...)` domain protection to a `sqrt(smoothstep(...))` call
  that can otherwise evaluate a negative domain.
- Guards a `smoothstep(0.23*r, 0.15*r*r, cd)` call against division by zero
  when the drop radius `r` is exactly `0.0`.

Both are legacy-tolerant operations that Metal does not tolerate; unguarded,
they produce NaNs that show up as full-screen black flashes or black-square
artifacts around raindrop impacts on the gasmask visor.

---

## Source and Scope

`gasmask_drops.ps` originates from `Precomputed Gasmask Noise` and is
unmodified there aside from the tagged `[elseform]` fix.

---

## Installation & Load Order

Load after `Precomputed Gasmask Noise`. Purge `appdata/shaders_cache/`
after installing or updating.

## Validation

- Diff against the unmodified source contains only the tagged `[elseform]`
  fix lines.
- Compiles under Metal/DXMT without shader errors.
- In-game: equip a gasmask in rain and confirm the raindrop overlay renders
  without black-frame or NaN corruption.
