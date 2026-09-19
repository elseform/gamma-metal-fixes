# Metal - 3DSS5 - Reflex Reticle TAA Mask

Reflex and holographic reticles from 3D Shader Scopes are thin additive HUD
overlays drawn in the forward pass, before temporal anti-aliasing and the DLSS
upscale. Stock, they write no motion vectors: DLSS and SSS TAA treat the dot
as part of the moving world, so it loses brightness and smears while the
camera moves.

This entry gives the reticle its own HUD motion vectors and the TAA skip mask,
but only under the visible strokes:

- The seven `.s` files that use the reticle shaders switch from
  `blend(srcalpha, one)` to premultiplied alpha, `blend(one, invsrcalpha)`.
  Each render target then blends by its own output alpha.
- The pixel shaders output colour as `(rgb * a, 0)`, which gives exactly the
  old additive result, and motion vectors scaled by the reticle's visible
  coverage. Under the strokes the HUD vectors and skip mask replace the
  world's; behind the empty glass the world's vectors stay untouched.
- The vertex shader jitters the reticle like other HUD geometry and passes
  current/previous clip positions. Its outputs and the pixel-shader inputs use
  the same registers.

Version 1.0.0 wrote the vectors with the old additive blend, so they were
added onto the world's vectors across the whole reticle mesh (the entire
EOTech window); DLSS then smeared the dot while panning (2026-09-19 traces).

## Files

- `models_reflex_reticle.vs`
- `models_reflex_reticle.ps`, `models_reflex_reticle_3db.ps`,
  `models_reflex_reticle_simple.ps`, `models_reflex_reticle_simple_3db.ps`
- `models_reflex_reticle.s`, `models_reflex_reticle_3db.s`,
  `models_reflex_reticle_simple.s`, `models_reflex_reticle_simple_3db.s`,
  `models_reflex_reticle_thermal_overlay.s`,
  `models_reflex_reticle_3db_thermal_overlay.s`, `models_dummy_cutout.s`

Load after 3D Shader Scopes for GAMMA 5.0 Beta 2. Requires Screen Space
Shaders 24. `Metal - 3DSS5 - Reflex Reticle Semantics` is not needed with this
entry. Clear `appdata/shaders_cache/` after every toggle.
