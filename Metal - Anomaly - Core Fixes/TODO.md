---
schema: 1
kind: entry
entry: d3dmetal-anomaly-core-fixes-elseform
repository: gamma-metal-fixes
---

# Metal - Anomaly - Core Fixes TODO

## Status

- [x] <!-- task:identify-upstream-base-shader-syntax-and-preprocessor-errors --> Identify upstream base shader syntax and preprocessor errors.
- [x] <!-- task:implement-surgical-hlsl-fixes-tagged-with-elseform --> Implement surgical HLSL fixes tagged with `[elseform]`.
- [x] <!-- task:validate-compilation-through-offline-d3dcompile-airconv-two-stage-pipeli --> Validate compilation through offline D3DCompile + airconv two-stage pipeline.

## Rescoped

- [x] <!-- task:in-game-runtime-verification-on-apple-silicon-including-sunshaft-sun-fac --> In-game runtime verification on Apple Silicon, including sunshaft sun-facing views near dawn/dusk and steep look angles.

## Consolidated

- [x] <!-- task:absorb-mblur-wallmark-from-sss23-core-fixes --> Moved `mblur.h` and `effects_wallmark.s` in from `Metal - SSS23 - Core Fixes` (2026-08-20): both are vanilla/DB files, confirmed via flattener inventory to have no other contributing source mod, so they belong to the Base tier, not the SSS23-scoped entry.
- [x] <!-- task:absorb-sunshafts-nan-guard --> Folded `Metal - Base - Sunshafts NaN Guard` (retired 2026-08-20, see `history/retired/`) in: `ogse_sunshafts_blur.ps`/`ogse_sunshafts_final.ps` sqrt domain guard, tagged `[elseform]`. Same source tier (vanilla `shaders.db0`) as the rest of this bundle.
