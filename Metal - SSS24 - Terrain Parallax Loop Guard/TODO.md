---
schema: 1
kind: entry
entry: d3dmetal-sss24-terrain-parallax-loop-guard-elseform
repository: gamma-metal-fixes
---

# Metal - SSS24 - Terrain Parallax Loop Guard TODO

## Active

- [ ] <!-- task:install-when-update-24-goes-live --> Install and enable only when `ScreenSpaceShaders_Update_24` is the active source, and disable the Screen Space Shaders 23 terrain guard at the same time. Both override the same file and the higher-priority entry wins regardless of which source mod is enabled.
- [ ] <!-- task:validate-terrain-guard-24 --> Validate by behaviour: dry and wet terrain with terrain POM enabled, at grazing angles. Not visible in a DXMT capture — the shader compiles either way.
- [ ] <!-- task:decide-keep-or-retire-24 --> Decide keep or retire on evidence rather than the P0 label, as for the other loop guards: the equivalent Screen Space Shaders 23 guard was absent from the flat install through extended play with no observed hang.

## Completed

- [x] <!-- task:rebase-guard-onto-update-24 --> Rebased 2026-09-10 onto `ScreenSpaceShaders_Update_24 - RC1_hotfix2`'s copy, preserving CRLF. Diff against that source contains only the `_guard` counter, its reset before the refinement loop, and the two loop conditions.
- [x] <!-- task:establish-why-a-separate-entry --> Established that the Screen Space Shaders 23 guard cannot be reused: Update 24 changed `G = max(G, puddles * 0.4f)` to `0.8f`, so the older guarded copy would revert that change if it won the file conflict.
