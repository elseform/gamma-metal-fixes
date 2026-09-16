---
schema: 1
kind: entry
entry: d3dmetal-3dss5-lens-nan-guard
repository: gamma-metal-fixes
---

# Metal - 3DSS5 - Lens NaN Guard TODO

## Active

- [ ] <!-- task:thermal-fix-no-effect-2026-09-17 --> 2026-09-17 in-game report: the `gbuffer_pixel_size()` fix (`c989f7e`) produced no visible change on SkeetIRx thermal, polarity invert, or T12W. Flat install carried the fixed files and the shader cache was rebuilt (01:11). Next: capture the same aimed scene post-fix and check the reticle draw's actual `s_heat` load coordinates and output. The heat buffer may be correct and something later (lens/overlay pass, IT_THERMAL branch not taken, a different reticle shader variant) may override it.

- [ ] <!-- task:re-evaluate-lens-nan-guard --> Clear shader cache and compare magnified scope and reflex-lens edges against the disabled baseline under GPTK40b1.

## Completed

- [x] <!-- task:dlss-gbuffer-pixel-space --> 2026-09-17: Thermal `Load()`s of `s_heat`/G-buffer now use the targets' own pixel size (`gbuffer_pixel_size()` in `thermal_utils.h`) instead of `screen_res`. The GAMMA engine renders the G-buffer at a DLSS internal resolution (1704x959 at 2560x1440 output), while HUD passes set `screen_res` to the output size, so the scope read the wrong texel or past the texture edge (undefined on Metal). Verified from DXMT GPU traces: at the scope center the heat buffer is 1.0 on an NPC at the correct coordinate and 0.0 at the `screen_res` coordinate. Explains SkeetIRx static, the polarity-invert flat white, and the T12W flat blue (cold palette).

- [x] <!-- task:split-from-3dss5-optics --> Split from `Metal - 3DSS5 - Optics` for independent re-evaluation.
