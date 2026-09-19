# Metal - 3DSS5 - Lens NaN Guard

Guards the 3DSS5 lens sphere-projection square root against a negative domain,
preventing NaN artifacts at scope and reflex-lens edges under Metal/DXMT.

## Files

- `scope_3dss_common.h`
- `models_scope_reticle.ps`
- `models_scope_reticle_precise.ps`
- `models_reflex_lens.ps`

Load after 3D Shader Scopes for GAMMA 5.0 Beta 2. Clear
`appdata/shaders_cache/` after every toggle..
