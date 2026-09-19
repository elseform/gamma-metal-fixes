# Metal - SSS24 - GBuffer Normal NaN Guard

Metal compatibility fix for deferred normal unpacking: feathers the
spherical reconstruction domain in `gbuffer_stage.h` so bilinear overshoot
can't produce NaNs, without the ring artifact a hard clamp would leave
behind.

---

## What this mod fixes

### GBuffer Normal Unpack NaN Protection (`gbuffer_stage.h`)

Spherical normal reconstruction evaluates `sqrt(1.0 - norm.y * norm.y)`,
which goes negative when texture bilinear interpolation overshoots past
`1.0`, producing NaNs that spread through deferred lighting on every
surface, every frame.

A hard `max(0.0, ...)` clamp fixes the NaN but matches the unguarded
expression's limit value without matching its slope, leaving a faint but
visible ring artifact — the same shape as the fix in
`Metal - 3DSS5 - Lens NaN Guard`. This entry feathers the clamp with
`smoothstep` instead, avoiding that ring.

---

## Source and Scope

`gbuffer_stage.h` comes from `ScreenSpaceShaders_Update_24 - RC1_hotfix2`
(SSS24), unmodified there aside from the tagged `[elseform]` fixes. The
same fix applies unchanged to the SSS23 build of this file.

---

## Installation & Load Order

Load after `ScreenSpaceShaders_Update_24 - RC1_hotfix2`. Purge
`appdata/shaders_cache/` after installing or updating, otherwise the
previously compiled variants are reused.

## Validation

- Diff against the unmodified source contains only the tagged `[elseform]`
  fix lines.
- Compiles under DXMT without shader errors.
- In-game: no black speckling or NaN corruption on any lit surface, and no
  visible ring artifact at the normal-unpack boundary.
