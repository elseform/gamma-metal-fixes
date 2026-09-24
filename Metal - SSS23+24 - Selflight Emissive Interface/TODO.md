---
schema: 1
kind: entry
entry: d3dmetal-sss23-24-selflight-emissive-interface-elseform
repository: gamma-metal-fixes
---

# Metal - SSS23+24 - Selflight Emissive Interface TODO

## Active

- [ ] <!-- task:visually-validate-selflight --> Visually validate the self-illumination pass: self-lit surfaces (screens, lamps, emissive decals) must draw, and `l_special` binds no `s_base`, so check what the pass actually samples now that it runs. Pipeline creation is already confirmed (see Completed).
- [ ] <!-- task:check-selflight-base-texture --> Determine what `tbase` samples in Screen Space Shaders 23's `l_special` pass, which binds no `s_base` texture. Separate from the interface fix; only observable once the pipeline compiles.

## Completed

- [x] <!-- task:confirm-against-update-24 --> Confirmed 2026-09-10 against `ScreenSpaceShaders_Update_24 - RC1_hotfix2`: `models_selflight.vs` and `models_selflight.s` are byte-identical to Screen Space Shaders 23's, so this fix applies unchanged to either source. Entry renamed to `[SSS23+24]` to say so; a literal slash cannot appear in a folder name.

- [x] <!-- task:runtime-validate-selflight --> Pipeline creation confirmed 2026-09-09 from an instrumented capture with the digest-printing DXMT payload: after the flat-install sync and shader-cache purge, the `user(reg0_0)` failures for `models_selflight.vs` (`5bb8e3dc…`) and `models_selflight_1.vs` (`a5996267…`) against `accum_emissive.ps` (`dbb992fc…`) are absent, leaving only the unrelated `shadow_direct_base_aref` failure. Entry promoted past `e_d3dmetal_instrumented_verified_separator` in the active MO2 profile. Visual validation remains open above.

- [x] <!-- task:write-tcdh-in-selflight --> Added a `v2p_selflight` output carrying `tcdh` and wrote the model's texture coordinates, matching `p_flat`'s declaration including its `USE_R2_STATIC_SUN` variant. Preserves Screen Space Shaders 23's minimal pass shape; does not restore Enhanced Shaders' `deffer_model_flat` pairing.
- [x] <!-- task:create-standalone-entry --> Created 2026-09-09 as its own entry instead of shipping inside `Metal - SSS23 - Core Fixes`, so it can be installed and validated alone; that bundle carries nine further shader changes and is not installed.
