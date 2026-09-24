# Metal - 3DSS5 - Mark Switch Grid Loop Guard

Clamps the 3DSS5 Mark Switch reticle-grid side count, bounding its loop before
non-finite input can stall Metal/DXMT GPU work.

## File

- `mark_adjust.h`

Load after 3D Shader Scopes for GAMMA 5.0 Beta 2. Clear
`appdata/shaders_cache/` after every toggle..
