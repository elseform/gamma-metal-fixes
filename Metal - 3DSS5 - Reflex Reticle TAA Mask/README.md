# Metal - 3DSS5 - Reflex Reticle TAA Mask

Reflex and holographic reticles from 3D Shader Scopes are thin additive HUD
overlays drawn in the forward pass, before temporal anti-aliasing and DLSS.
They wrote no motion vectors of their own, so SSS TAA and the DLSS upscaler
reprojected them with the motion of the world behind the sight glass, and the
reticle pulsed in brightness whenever the camera moved.

This entry makes the reticle vertex shader jitter its raster like other HUD
geometry and pass current/previous clip positions, and makes every reticle
pixel shader write HUD motion vectors plus the TAA skip mask into the
motion-vector target (`SV_Target2`), the same way `pda_overlay` does in
Screen Space Shaders 24.

Side effect: the world seen through the sight glass is excluded from TAA.

## Files

- `models_reflex_reticle.vs`
- `models_reflex_reticle.ps`
- `models_reflex_reticle_3db.ps`
- `models_reflex_reticle_simple.ps`
- `models_reflex_reticle_simple_3db.ps`

The pixel shaders include the semantic fixes from
`Metal - 3DSS5 - Reflex Reticle Semantics`; load this entry after it.
Clear `appdata/shaders_cache/` after every toggle.
