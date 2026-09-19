# Metal - 3DSS5 - Scope Depth-Restore MRT Fix

Writes all render targets in the 3DSS5 scope depth-restore pass and uses alpha
blending to preserve the first three GBuffer targets under Metal/DXMT.

## Files

- `models_scope_zwrite.ps`
- `models_scope_zwrite.s`

Load after 3D Shader Scopes for GAMMA 5.0 Beta 2. Clear
`appdata/shaders_cache/` after every toggle..
