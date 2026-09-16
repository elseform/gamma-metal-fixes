# Metal - Mask Reflections - Gasmask Overlay Fix

Metal compatibility fix for the gasmask overlay shader in
`gasmask_dudv.ps`, shipped by `Mask Reflections` (Grokitach).

---

## What this mod fixes

### Gasmask Overlay Comma Operator & Type Mismatch (`gasmask_dudv.ps`)

- Fixes a comma-operator bug: `float4 final = (0.0, 0.0, 0.0, 0.0);`
  evaluates to the last scalar and collapses to a broken value instead of a
  zero vector. Replaced with the explicit constructor
  `float4(0.0, 0.0, 0.0, 0.0)`.
- Fixes a `float3 + float4` dimension mismatch in the final blend.

Legacy FXC tolerates both; Metal does not, and the visor glass either turns
completely black or the shader fails to compile.

---

## Source and Scope

`gasmask_dudv.ps` originates from `Mask Reflections` and is unmodified
there aside from the tagged `[elseform]` fix.

---

## Installation & Load Order

Load after `Mask Reflections`. Purge `appdata/shaders_cache/` after
installing or updating.

## Validation

- Diff against the unmodified source contains only the tagged `[elseform]`
  fix lines.
- Compiles under Metal/DXMT without shader errors.
- In-game: equip a gasmask and confirm the visor overlay renders without
  black or corrupted regions.
