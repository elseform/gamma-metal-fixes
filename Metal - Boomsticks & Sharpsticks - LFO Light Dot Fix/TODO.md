---
schema: 1
kind: entry
entry: d3dmetal-boomsticks-and-sharpsticks-lfo-light-dot-fix-elseform
repository: gamma-metal-fixes
---

# Metal - Boomsticks & Sharpsticks - LFO Light Dot Fix TODO

## Active

- [ ] <!-- task:runtime-validate-lfo-light-dot-boomsticks --> Runtime-validate the LFO light dot weapon attachment under DXMT after shader cache purge (new shader body, prior Mark Switch validation doesn't carry over).

## Completed

- [x] <!-- task:retarget-mark-switch-to-boomsticks --> Retargeted 2026-09-08 from `Mark Switch` to `Boomsticks and Sharpsticks`: `Mark Switch` is disabled in the active profile, `Boomsticks and Sharpsticks` is active. Diffed the two mods' copies of `models_lfo_light_dot_weapons.ps` first — not the same shader (Boomsticks' copy has no `mark_adjust.h`/`MARK_ADJUST`/`mark_sides()` block and a differently-shaped malformed `Load` call). Rebased onto a fresh copy of Boomsticks' shader and re-applied the equivalent fix (`Load(pos2d.xyz)` → `Load(int3(pos2d.xy, 0))`). Renamed folder, `id`, and all metadata from `Metal - Mark Switch - LFO Light Dot Fix`. Bumped `0.1.0` → `0.2.0` and reset validation to `static-validated` since the runtime validation on record was for the old (Mark Switch) shader body.
- [x] <!-- task:runtime-validate-lfo-light-dot --> Runtime-validate the LFO light dot weapon attachment under DXMT after shader cache purge.
- [x] <!-- task:split-from-3dss5-optics --> Split out 2026-08-20 from `Metal - 3DSS5 - Optics`: `models_lfo_light_dot_weapons.ps` true source is `Mark Switch`, not 3D Shader Scopes for GAMMA. See parent entry TODO for the split rationale.
- [x] <!-- task:patch-lfo-texture-load-coords --> Replaced non-standard Texture2D.Load call with the defined integer-coordinate form in `models_lfo_light_dot_weapons.ps`.
