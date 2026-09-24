# Metal - SSS23 - Blur Integer Loops

Metal compatibility fix for the post-process blur: replaces floating-point loop counters in pp_blur.ps with integer iteration to avoid precision drift and thread divergence under the Metal compiler.

---

## What this mod fixes

### 1. P1 — Post-Process Blur Integer Loop Conversion (`pp_blur.ps`)
- Replaces `for (float d = 0; d < Pi; d += Pi/dirs)` style loops with integer iteration and computed step angles, removing precision accumulation error and thread divergence under Metal loop optimisation.

---

## Source and Scope

`pp_blur.ps` originate from `190- Screen Space Shaders 23 - Ascii1457` and are unmodified in that source archive aside from the tagged `[elseform]` fixes.

Split 2026-09-09 out of `Metal - SSS23 - Core Fixes`, which is now retired to `history/retired/`. That bundle carried nine unrelated fixes for this one source and could only be installed or validated as a unit — the reason a single-file fix had to be lifted out of it earlier the same day to be testable at all. It had itself absorbed the standalone `POM Loop Guards` and `Water Loop Guards` entries on 2026-08-20; that consolidation is deliberately reversed here in favour of per-fix entries, per [Metal & Metal shader compatibility](../../../../gamma-project/docs/engine/shaders-d3dmetal.md) § "Fix Mod Naming & Provenance Splitting".

---

## Installation & Load Order

Load after `190- Screen Space Shaders 23 - Ascii1457`. Purge `appdata/shaders_cache/` after installation, otherwise the previously compiled variants are reused.

## Validation

- Confirm the diff against the source archive copy contains only the tagged `[elseform]` fix lines.
- Compile under DXMT without shader errors; a failing pipeline names its shaders in the run log with the instrumented payload, per [Runtime Identification of a Failing Shader](../../../../gamma-project/docs/engine/shaders-d3dmetal.md).
