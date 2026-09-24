# Metal - Beef NVG's - NVG Bokeh Blur Fix

Metal compatibility fix for NVG bokeh blur in `nightvision_gen_1.ps`, `nightvision_gen_2.ps`, `nightvision_gen_3.ps`, shipped by `189- Beef's NVG - theRealBeef`.

---

## What this mod fixes

### 1. P1 — NVG Bokeh Blur Integer Loop Conversion (`nightvision_gen_1.ps`, `nightvision_gen_2.ps`, `nightvision_gen_3.ps`)
- Replaces floating-point loop counters and step increments (`for (float d = 0; d < Pi; d += Pi/dirs)`) with integer iteration loops and computed step angles. Prevents precision accumulation error and thread divergence under Metal compiler loop optimizations.

---

## Source and Scope

`nightvision_gen_1/2/3.ps` originate from `189- Beef's NVG - theRealBeef` and are unmodified in that source archive aside from the tagged `[elseform]` fix.

Split out 2026-08-20 from `Metal - SSS23 - Core Fixes`, which had bundled these under the `[SSS23]` bracket despite the true winning source being Beef's NVG, not Screen Space Shaders 23.

---

## Installation & Load Order

Load after `189- Beef's NVG - theRealBeef`. Purge `appdata/shaders_cache/` after installation.

## Validation

- Confirm diffs against the source archive copies contain only the tagged `[elseform]` fix lines.
- Compile all 3 files under Metal/DXMT without shader errors.
- In-game: toggle each NVG generation and check bokeh blur renders smoothly without thread-divergence artifacts.

Static source comparison is complete for all 3 files. Runtime validation remains required.
