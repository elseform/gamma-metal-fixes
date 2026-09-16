# Metal - SSS23+24 - Selflight Emissive Interface

Metal compatibility fix for the self-illumination pass in
`models_selflight.vs`, shipped by `Screen Space Shaders 23`.

---

## What this mod fixes

### Self-Illumination Vertex/Pixel Interface Mismatch (`models_selflight.vs`)

The self-illumination pass pairs this vertex shader with a pixel shader that
samples a texture using `TEXCOORD0`, but the vertex shader never writes that
interpolator — it only outputs a clip-space position. Legacy D3D11 tolerates
a pixel-shader input the vertex shader never writes (the value is simply
undefined), which is why this was invisible on Windows/DXVK. Metal refuses
to create the pipeline at all, and the whole self-lit pass — screens, lamps,
emissive decals — is lost as a result.

The fix adds the missing texture-coordinate output to the vertex shader, so
both sides of the interface agree. Nothing else changes: the pass stays as
minimal as its author designed it (no GBuffer output, no motion vectors,
TAA jitter only).

---

## Source and Scope

`models_selflight.vs` comes from `Screen Space Shaders 23`; the pixel shader
it pairs with comes from a different mod. Only the vertex shader is
overridden here, unmodified aside from the tagged fix. The same file is
byte-identical between Screen Space Shaders 23 and
`ScreenSpaceShaders_Update_24`, so this one entry covers both — hence the
`SSS23+24` name.

---

## Installation & Load Order

Load after `Screen Space Shaders 23`. Purge `appdata/shaders_cache/` after
installing or updating, otherwise the previously compiled variants are
reused.

## Validation

- Diff against the unmodified source adds only the missing texture-coordinate
  output.
- Compiles under Metal/DXMT without shader errors.
- In-game: self-lit surfaces (screens, lamps, emissive decals) render
  correctly.
