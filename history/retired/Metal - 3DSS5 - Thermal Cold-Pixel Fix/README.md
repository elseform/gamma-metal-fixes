# Metal - 3DSS5 - Thermal Cold-Pixel Fix

Initializes 3DSS5 thermal `hot_color` for cold pixels, preventing black or
garbage thermal output caused by NaN propagation under Metal/DXMT.

## File

- `thermal_utils.h`

Load after 3D Shader Scopes for GAMMA 5.0 Beta 2. Clear
`appdata/shaders_cache/` after every toggle..
