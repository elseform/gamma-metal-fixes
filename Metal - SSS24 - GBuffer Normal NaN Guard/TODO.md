---
schema: 1
kind: entry
entry: d3dmetal-sss24-gbuffer-normal-nan-guard-elseform
repository: gamma-metal-fixes
---

# Metal - SSS24 - GBuffer Normal NaN Guard TODO

## Active

- [ ] <!-- task:validate-gbuffer-normal-unpack-fix --> Validate the 2026-09-08 feathering in game: a rounded glossy surface under strong directional light, confirming no thin ring or banding where the normal sweeps through this basis's pole.

## Completed

- [x] <!-- task:rebase-sss23-to-sss24-2026-09-12 --> Renamed from `Metal - SSS23 - GBuffer Normal NaN Guard` after the profile moved from `190- Screen Space Shaders 23 - Ascii1457` to `ScreenSpaceShaders_Update_24 - RC1_hotfix2`. `diff -Bbw` confirmed `gbuffer_stage.h` is byte-identical between the two sources, so the fix itself needed no changes — only the entry name, `meta.ini`, and `gamma-entry.toml` source/dependency fields.
- [x] <!-- task:split-from-sss23-core-fixes-2026-09-09 --> Split 2026-09-09 out of `Metal - SSS23 - Core Fixes` so this fix can be installed and validated on its own. The bundle's own analysis notes predate the split and cover the moved files' full history; read them in `history/retired/Metal - SSS23 - Core Fixes/TODO.md`.
