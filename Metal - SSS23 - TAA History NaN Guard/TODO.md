---
schema: 1
kind: entry
entry: d3dmetal-sss23-taa-history-nan-guard-elseform
repository: gamma-metal-fixes
---

# Metal - SSS23 - TAA History NaN Guard TODO

## Active

- [ ] <!-- task:validate-ssfx-taa-clip-fallback-fix --> Validate the 2026-09-08 `kdop_clipping` correction in game: watch fast pans over high-frequency detail and confirm reduced flicker/shimmer versus the previous guard.

## Completed

- [x] <!-- task:split-from-sss23-core-fixes-2026-09-09 --> Split 2026-09-09 out of `Metal - SSS23 - Core Fixes` so this fix can be installed and validated on its own. The bundle's own analysis notes predate the split and cover the moved files' full history; read them in `history/retired/Metal - SSS23 - Core Fixes/TODO.md`.
