# Metal - 3DSS5 - SSS24 DLSS Buffers

3D Shader Scopes 5 was written for the stock engine's pass order and render
targets. On the Screen Space Shaders 24 engine with DLSS, the precise scope
lens (`models_scope_reticle_precise`) is drawn after the upscale, and two of
the render targets it names hold something else at that point. GPU traces of
the lens draw show three faults:

- **Lens image.** `s_prev_frame` is bound to `$user$generic_temp`. On this
  engine that is a render-resolution copy taken before the forward pass, so it
  misses everything the forward pass draws, including reflex/holographic
  reticles, and it never went through DLSS. A magnifier behind an EOTech
  showed no reticle, and every magnified image was softer than the rest of the
  screen. The lens now samples `$user$scene_final`, the upscaled frame the
  engine copies right before the lens draw.
- **Thermal depth.** `s_position` is bound to `$user$generic2`. On this engine
  that is the volumetric light buffer, not a copy of the position G-buffer.
  Thermal optics took depth and normals from lighting data and showed one flat
  colour. It is now bound to `$user$position`.
- **Thermal heat.** `screen_res` in the lens draw is the output resolution,
  while the heat buffer and G-buffer stay at the DLSS render resolution.
  `Load()` positions built from `screen_res` pointed at the wrong texels or
  past the buffer edge. Heat and G-buffer pixel positions now come from the
  heat buffer's own dimensions (heat reads, contour offsets, the pixelation
  grid), and `hot_color` in `infrared()` is initialized.

This is an engine/mod interaction, not a Metal translation defect; the same
engine would show it on Windows.

## Files

- `models_scope_reticle_precise.s`
- `models_scope_reticle_precise.ps`
- `thermal_utils.h`

Load after 3D Shader Scopes for GAMMA 5.0 Beta 2. It supersedes the retired
`Metal - 3DSS5 - Thermal Cold-Pixel Fix` and `Metal - 3DSS5 - Thermal
Pixelation Scope-Zoom Fix`. Clear `appdata/shaders_cache/` after every toggle.
