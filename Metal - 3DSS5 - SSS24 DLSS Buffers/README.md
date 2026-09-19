# Metal - 3DSS5 - Thermal DLSS Buffers

3D Shader Scopes 5 thermal optics (for example the Torrey Pines T12) show one
flat colour with no heat signatures on the Screen Space Shaders 24 engine with
DLSS. A GPU trace of the scope draw shows two independent input faults:

- `models_scope_reticle_precise.s` binds `s_position` to `$user$generic2`.
  On this engine that name is the volumetric light buffer (the combine
  volumetric pass reads it next to `$user$position`), not a copy of the
  position G-buffer. The thermal image took depth and normals from lighting
  data, read depth 0, and treated the whole view as sky.
- The scope draw runs after the upscale, where `screen_res` is the output
  resolution, while the heat buffer and G-buffer stay at the DLSS render
  resolution. `Load()` positions built from `screen_res` pointed at the wrong
  texels or past the buffer edge, so heat was lost.

This entry binds `s_position` to `$user$position` and derives every heat and
G-buffer pixel position (heat reads, contour offsets, the pixelation grid)
from the heat buffer's own dimensions. It also initializes `hot_color` in
`infrared()`, which was read uninitialized when a pixel had no heat.

This is an engine/mod interaction, not a Metal translation defect; the same
engine would show it on Windows.

## Files

- `models_scope_reticle_precise.s`
- `models_scope_reticle_precise.ps`
- `thermal_utils.h`

Load after 3D Shader Scopes for GAMMA 5.0 Beta 2. It replaces files that
`Metal - 3DSS5 - Thermal Cold-Pixel Fix`, `Metal - 3DSS5 - Thermal Pixelation
Scope-Zoom Fix` and `Metal - 3DSS5 - Lens NaN Guard` also replace; keep those
disabled while this entry is active. Clear `appdata/shaders_cache/` after
every toggle.
