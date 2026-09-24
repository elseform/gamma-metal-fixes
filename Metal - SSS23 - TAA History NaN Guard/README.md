# Metal - SSS23 - TAA History NaN Guard

Metal compatibility fix for temporal anti-aliasing: guards the kdop_clipping reciprocal in ssfx_taa.ps so stationary pixels cannot contaminate the persistent TAA history buffer with NaNs.

---

## What this mod fixes

### 1. P0 — TAA History Clipping Stationary-Pixel Division-by-Zero (`ssfx_taa.ps`)
- `kdop_clipping` computes `1.0f / dot(dir, axis)` with no check for stationary pixels, where previous and current colour match and `dir` is zero.
- The resulting `NaN` contaminates the persistent history buffer `rt_ssfx_prev_frame`, so the damage survives across frames.
- The first guard shipped here was itself wrong and was corrected in place on 2026-09-08: the `inv_dir = 0` fallback clamped `near`/`far` toward zero on any clip axis near-parallel to the frame-to-frame colour delta. Since `proj_pos` is inside `[extent.x, extent.y]` by construction, such an axis should contribute no constraint at all. It fired per pixel, per axis — not a rare edge case — and was causing scattered TAA flicker.

---

## Source and Scope

`ssfx_taa.ps` originate from `190- Screen Space Shaders 23 - Ascii1457` and are unmodified in that source archive aside from the tagged `[elseform]` fixes.

Split 2026-09-09 out of `Metal - SSS23 - Core Fixes`, which is now retired to `history/retired/`. That bundle carried nine unrelated fixes for this one source and could only be installed or validated as a unit — the reason a single-file fix had to be lifted out of it earlier the same day to be testable at all. It had itself absorbed the standalone `POM Loop Guards` and `Water Loop Guards` entries on 2026-08-20; that consolidation is deliberately reversed here in favour of per-fix entries, per [Metal & Metal shader compatibility](../../../../gamma-project/docs/engine/shaders-d3dmetal.md) § "Fix Mod Naming & Provenance Splitting".

---

## Installation & Load Order

Load after `190- Screen Space Shaders 23 - Ascii1457`. Purge `appdata/shaders_cache/` after installation, otherwise the previously compiled variants are reused.

## Validation

- Confirm the diff against the source archive copy contains only the tagged `[elseform]` fix lines.
- Compile under DXMT without shader errors; a failing pipeline names its shaders in the run log with the instrumented payload, per [Runtime Identification of a Failing Shader](../../../../gamma-project/docs/engine/shaders-d3dmetal.md).
