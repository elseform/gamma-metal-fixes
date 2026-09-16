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

- [x] <!-- task:root-cause --> Traced static to `pixelate` in the thermal branch of `models_scope_reticle(_precise).ps` being keyed to ADS-FOV `current_zoom` instead of the optic's own `zoom`/`IMAGE_SIZE`.
