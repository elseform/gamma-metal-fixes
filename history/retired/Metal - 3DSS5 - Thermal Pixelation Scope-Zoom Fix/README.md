# Metal - 3DSS5 - Thermal Pixelation Scope-Zoom Fix

Thermal image types skip the pre-rendered scope camera texture and read the
main-screen GBuffer/heat render target directly, per-pixel, unfiltered. The
only noise mitigation for that path is a pixelation block-snap keyed to
`current_zoom`, which tracks ADS FOV, not the optic's own magnification. On a
high-magnification day scope carrying a 1x thermal clip-on (e.g. a
clip-on thermal monocular mounted in front of an existing sight), the block
size stayed small while the scope's own zoom kept climbing, leaving
per-texel GBuffer noise optically magnified into visible static.

Scales the pixelation block size to `max(current_zoom, zoom)`, where `zoom`
is the optic's own magnification already computed earlier in the same
function, so pixelation keeps pace with whichever zoom is actually driving
the image.

## Files

- `models_scope_reticle.ps`
- `models_scope_reticle_precise.ps`

Load after 3D Shader Scopes for GAMMA 5.0 Beta 2 and after
Metal - 3DSS5 - Lens NaN Guard (this mod's copies of these two files carry
that fix forward). Clear `appdata/shaders_cache/` after every toggle.
