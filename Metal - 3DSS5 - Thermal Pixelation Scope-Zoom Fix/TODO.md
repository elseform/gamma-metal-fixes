---
schema: 1
kind: entry
entry: d3dmetal-3dss5-thermal-pixelation-scope-zoom-fix
repository: gamma-metal-fixes
---

# Metal - 3DSS5 - Thermal Pixelation Scope-Zoom Fix TODO

## Active

- [ ] <!-- task:confirm-static-cleared --> Confirm static clears on a clip-on thermal (e.g. OASYS SkeetIRx) over a high-magnification day scope (k98 `_skeet` profile) under GPTK40b1.
- [ ] <!-- task:check-non-chained-thermal --> Check a non-chained, dedicated thermal scope at high zoom for the same regression, since this touches shared code.

## Completed

- [x] <!-- task:dlss-gbuffer-pixel-space --> 2026-09-17: Thermal `Load()`s of `s_heat`/G-buffer now use the targets' own pixel size (`gbuffer_pixel_size()` in `thermal_utils.h`) instead of `screen_res`. The GAMMA engine renders the G-buffer at a DLSS internal resolution (1704x959 at 2560x1440 output), while HUD passes set `screen_res` to the output size, so the scope read the wrong texel or past the texture edge (undefined on Metal). Verified from DXMT GPU traces: at the scope center the heat buffer is 1.0 on an NPC at the correct coordinate and 0.0 at the `screen_res` coordinate. Explains SkeetIRx static, the polarity-invert flat white, and the T12W flat blue (cold palette).

- [x] <!-- task:root-cause --> Traced static to `pixelate` in the thermal branch of `models_scope_reticle(_precise).ps` being keyed to ADS-FOV `current_zoom` instead of the optic's own `zoom`/`IMAGE_SIZE`.
