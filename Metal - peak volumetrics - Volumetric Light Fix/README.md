# Metal - peak volumetrics - Volumetric Light Fix

Metal compatibility fix for volumetric light in `pfx_volumetric_light.ps`, shipped by `peak_volumetrics_1_2_no_bin`.

---

## What this mod fixes

### 1. P0 — Volumetric Light Sqrt/Rsqrt Div-by-Zero (`pfx_volumetric_light.ps`)
- Adds `max(1e-6, a)` guard to `rsqrt(dot(V, V))` preventing division by zero on light source origin intersections.

---

## Source and Scope

`pfx_volumetric_light.ps` originates from `peak_volumetrics_1_2_no_bin` and is unmodified in that source archive aside from the tagged `[elseform]` fix.

Split out 2026-08-20 from `Metal - SSS23 - Core Fixes`, which had bundled it under the `[SSS23]` bracket despite the true winning source being Peak Volumetrics, not Screen Space Shaders 23.

---

## Installation & Load Order

Load after `peak_volumetrics_1_2_no_bin`. Purge `appdata/shaders_cache/` after installation.

## Validation

- Confirm the diff against the source archive copy contains only the tagged `[elseform]` fix lines.
- Compile under Metal/DXMT without shader errors.
- In-game: check volumetric light shafts near a light source origin for NaN corruption or black-frame artifacts.

Static source comparison is complete. Runtime validation remains required.
