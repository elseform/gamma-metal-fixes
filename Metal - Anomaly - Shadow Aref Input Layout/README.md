# Metal - Anomaly - Shadow Aref Input Layout

Metal compatibility fix for the sun-shadow alpha-ref pass in
`shadow_direct_base_aref.vs`, a base Anomaly shader.

---

## What this mod fixes

### Vertex Input Signature Demands Unused Attributes (`shadow_direct_base_aref.vs`)

The shader declares a wide vertex input (position, normal, tangent, binormal,
texture coordinates) but its body only ever reads position and texture
coordinates. Legacy D3D11 compilers keep every declared input in the
shader's signature whether or not it's actually read, so the compiled shader
ends up demanding vertex attributes that the actual draw's vertex layout
doesn't supply. Under Metal that fails input-layout creation outright, and
the whole pass is lost: alpha-tested static geometry — fences, railings,
foliage baked into level geometry — casts no sun shadow.

The fix narrows the shader's declared input struct to just position and
texture coordinates, matching what it actually uses, so it stops demanding
attributes the vertex layout doesn't provide.

---

## Source and Scope

`shadow_direct_base_aref.vs` is unmodified base Anomaly content and isn't
shipped by any other installed mod — this is the first override of it. It
only affects the sun-shadow pass for alpha-tested static geometry; trees and
skinned models use a different vertex shader paired with the same pixel
shader, and aren't touched by this fix.

---

## Installation & Load Order

Base-tier file: load after any mod that overrides `shaders/r3`. Purge
`appdata/shaders_cache/` after installing or updating.

## Validation

- Compiles under Metal/DXMT without shader errors or input-layout warnings.
- In-game: sun shadows render correctly on alpha-tested static geometry
  (fences, railings, foliage baked into level geometry).
