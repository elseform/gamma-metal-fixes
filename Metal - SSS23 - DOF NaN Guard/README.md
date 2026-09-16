# Metal - SSS23 - DOF NaN Guard

Metal compatibility fix for depth-of-field: clamps the smoothstep upper bound in screenspace_dof.h so a (0, 0) range from ssfx_weapons_dof.script cannot divide by zero and seed NaNs.

---

## What this mod fixes

### 1. P0 — DOF Smoothstep Division-by-Zero & NaN Explosion (`screenspace_dof.h`)
- `ssfx_weapons_dof.script` issues `ssfx_wpn_dof_1 (0, 0, smoothed, blur)` during mutant skinning/looting, reload, inventory, and PDA interactions, making `smoothstep(0, 0, depth.z)` divide by zero.
- Separable blur filters in post-combine then spread the resulting `NaN` across neighbouring pixels as expanding black boxes, up to a GPU hang.
- Clamps the upper bound to `max(dof_max, dof_min + 1e-4f)` so the delta is always positive.

---

## Source and Scope

`screenspace_dof.h` originate from `190- Screen Space Shaders 23 - Ascii1457` and are unmodified in that source archive aside from the tagged `[elseform]` fixes.

Split 2026-09-09 out of `Metal - SSS23 - Core Fixes`, which is now retired to `history/retired/`. That bundle carried nine unrelated fixes for this one source and could only be installed or validated as a unit — the reason a single-file fix had to be lifted out of it earlier the same day to be testable at all. It had itself absorbed the standalone `POM Loop Guards` and `Water Loop Guards` entries on 2026-08-20; that consolidation is deliberately reversed here in favour of per-fix entries, per [Metal & Metal shader compatibility](../../../../gamma-project/docs/engine/shaders-d3dmetal.md) § "Fix Mod Naming & Provenance Splitting".

---

## Installation & Load Order

Load after `190- Screen Space Shaders 23 - Ascii1457`. Purge `appdata/shaders_cache/` after installation, otherwise the previously compiled variants are reused.

## Validation

- Confirm the diff against the source archive copy contains only the tagged `[elseform]` fix lines.
- Compile under DXMT without shader errors; a failing pipeline names its shaders in the run log with the instrumented payload, per [Runtime Identification of a Failing Shader](../../../../gamma-project/docs/engine/shaders-d3dmetal.md).
