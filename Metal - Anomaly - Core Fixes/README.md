# Metal - Anomaly - Core Fixes

Upstream HLSL syntax, preprocessor, and recursion bug fixes for base Anomaly shaders under Metal, DXMT, and DirectX 11.

---

## What this mod fixes

### 1. Static Tree Detail Bump Infinite Include Recursion (`deffer_tree_s_bump_d.vs`)
- **Problem**: `deffer_tree_s_bump_d.vs` had `#include "deffer_tree_s_bump_d.vs"`, creating an infinite recursive include loop that exceeded the preprocessor include depth limit and failed compilation (`error X1506: too many nested #includes`).
- **Fix**: Replaced recursive self-include with `#define USE_TDETAIL` followed by `#include "deffer_tree_s_bump.vs"` to match the implementation pattern of `deffer_tree_s_flat_d.vs` and `deffer_tree_bump_d.vs`.

### 2. Hard Particle Distortion Preprocessor Syntax Error (`particle_distort_hard.ps`)
- **Problem**: Line 1 contained an isolated `#` character without a directive, failing compilation (`error X1500: syntax error : unexpected end of line`).
- **Fix**: Removed the stray `#` character.

### 3. Volumetric Sun Normal Preprocessor Typo (`accum_volumetric_sun_normal .ps`)
- **Problem**: Line 1 had `#unfdef USE_MINMAX_SM` instead of `#undef USE_MINMAX_SM` (`error X1504: invalid preprocessor command 'unfdef'`).
- **Fix**: Corrected `#unfdef` to `#undef`.

### 4. Legacy Fluid Texture Drawing Variable Declaration (`fluid_draw_texture.ps`)
- **Problem**: `textureNumber` was used without declaration (`error X3004: undeclared identifier 'textureNumber'`).
- **Fix**: Declared `uniform int textureNumber;`.

### 5. Legacy Fluid Obstacle CBuffer Redefinition (`fluid_obststaticbox.ps`)
- **Problem**: Local `cbuffer BoxBounds { float4 boxLBDcorner; float4 boxRTUcorner; }` collided with `cbuffer AABBBounds`, already declaring the same `boxLBDcorner`/`boxRTUcorner` members, in `fluid_common.h` (`error X3003: redefinition of 'boxLBDcorner'`).
- **Fix**: Removed the redundant local `cbuffer BoxBounds` block only. `main()` logic (two-tier inner/outer box test, `clip(-1)` discard to preserve other obstacle boxes drawn into the same shared target) is unchanged from vanilla.

### 6. Legacy Motion Blur Comma Operator (`mblur.h`)
- **Problem**: `float3 accum = (0.0, 0.0, 0.0);` used the comma constructor, which collapses to a scalar under Metal IR instead of a zero vector.
- **Fix**: `float3 accum = (0.0, 0.0, 0.0);` -> `float3(0.0, 0.0, 0.0)`.

### 7. Wallmark Sampler Descriptor Binding (`effects_wallmark.s`)
- **Problem**: Missing explicit sampler binding for non-blood static wallmarks caused null sampler descriptor crashes under Metal.
- **Fix**: Explicitly binds `smp_base` to match `stub_default_ma.ps` texture sampling.

### 8. Sunshafts Sun-Distance NaN Guard (`ogse_sunshafts_blur.ps`, `ogse_sunshafts_final.ps`)
- **Problem**: Both files compute `sun_dist = FARPLANE / (sqrt(1 - L_sun_dir_w.y * L_sun_dir_w.y))`, which assumes `L_sun_dir_w.y` never exceeds `+-1`. Near-zenith sun angles during GAMMA's normal day-night cycle can push it past that bound on precision overshoot, sending the `sqrt` argument negative. Legacy FXC/DXVK tolerate this; Metal IR does not, and the resulting NaN propagates through `sun_dist` into `sun_pos_world`, `sun_pos_screen`, and `sun_vec_screen`, poisoning the ray-accumulation loop in `_blur.ps` and the full-screen additive blend in `_final.ps` — corrupting the whole frame, not just the sunshaft effect.
- **Fix**: `sqrt(1 - L_sun_dir_w.y * L_sun_dir_w.y)` -> `sqrt(max(0.0, 1 - L_sun_dir_w.y * L_sun_dir_w.y))` in both files. Normal finite sun angles keep the original result; the guard only activates for the degenerate overshoot case.
- **Note**: both files are invoked directly by the engine's sunshaft render pass rather than through a `.s` technique file, gated by the `r2_sunshafts_mode` console variable (needs to be on, e.g. `combined`, for this pass to run at all). Neither file is overridden by any other installed mod.

---

## Source and Scope

All 9 files originate from base Anomaly (`shaders.db0`) and are unmodified in the vanilla archive.

---

## Installation & Load Order

Load after base Anomaly and before specialized shader overrides. Purge `appdata/shaders_cache/` after installation.

## Validation

- Confirm diffs against the unpacked vanilla base contain only the tagged `[elseform]` fix lines.
- Compile all 9 files under Metal/DXMT without shader errors.
- In-game: sunshaft fix specifically needs sun-facing views near dawn/dusk and steep look angles (highest-risk range for `L_sun_dir_w.y` to approach +-1) checked for correct rendering with no black-frame/NaN corruption.

Verified against all 9 files; runtime-confirmed stable in play.
