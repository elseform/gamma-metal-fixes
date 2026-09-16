# Metal - 3DSS5 - Reflex Reticle Semantics

Matches reflex-reticle pixel-shader `TEXCOORD` semantics to the 3DSS5 vertex
shader outputs, restoring red-dot and holographic reticles under Metal/DXMT.

## Files

- `models_reflex_reticle.ps`
- `models_reflex_reticle_3db.ps`
- `models_reflex_reticle_simple.ps`
- `models_reflex_reticle_simple_3db.ps`

Load after 3D Shader Scopes for GAMMA 5.0 Beta 2. Clear
`appdata/shaders_cache/` after every toggle..
