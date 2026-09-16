---
schema: 1
kind: entry
entry: d3dmetal-anomaly-shadow-aref-input-layout-elseform
repository: gamma-metal-fixes
---

# Metal - Anomaly - Shadow Aref Input Layout TODO

## Active

- [ ] <!-- task:validate-v2-trim --> Validate the v2 trim (`POSITION` + `TEXCOORD0`, `unpack_tc_base(I.tc, 0, 0)`), applied 2026-09-09 at the user's request: the `TANGENT_0` warning and the `Failed to create PSO (vs bb2e98ad…, ps 8155ca8c…)` failure should both be absent from the next capture, and shadowing should look no worse than under v1. Revert to v1 (`a93d1be6…`) if shadows are misplaced or the previously working pass degrades.
- [ ] <!-- task:identify-second-declaration --> Identify the geometry behind the still-failing draw, whose layout carries neither `NORMAL` nor `TANGENT`. Detail objects match the shape but are ruled out (`r2_sun_details off`, deliberate: SSS23 owns grass shadowing). Needed before deciding whether to narrow the struct to `POSITION` + `TEXCOORD0`, which would satisfy that layout but drop `du`/`dv` for the draw that already works.
- [ ] <!-- task:identify-failing-geometry --> Identify which geometry produces an input layout with neither `NORMAL` nor `TANGENT` in the sun-shadow phase, and verify it is reachable in this configuration before drawing conclusions. The detail-object declaration matches the shape but is ruled out: `r2_sun_details off` in `appdata/user.ltx` means detail objects are not rendered into the sun shadow map here. Resolving this decides the task above without guessing.

## Completed

- [x] <!-- task:check-aref-shadow-visuals --> Visually confirmed 2026-09-09: shadowing looks better with this fix live, so the restored pass is drawing and earning its GPU cost. Recorded as the reason this entry ships rather than being retired in favour of leaving the draw suppressed.

- [x] <!-- task:runtime-validate-shadow-aref-input-layout --> Partially validated 2026-09-09: after the flat sync and cache purge the `NORMAL_0` warning is gone, so removing the unread normal from the input struct worked as intended. The pipeline still fails, one semantic further along on `TANGENT_0` — DXMT reports only the first missing semantic per check, which is why this surfaced only after the first fix landed. Details in the README.

- [x] <!-- task:narrow-shadow-aref-input-struct --> Replaced the `v_static` input with a struct declaring only `POSITION`, `TANGENT`, `BINORMAL` and `TEXCOORD0`, the fields the shader actually reads. FXC keeps declared-but-unread inputs in the signature, which is why the unused `NORMAL` was breaking input-layout creation.
- [x] <!-- task:trace-shadow-aref-chain --> Traced the file through the full resolution chain 2026-09-09: no installed MO2 mod ships it, it is absent from the loose flat tree and from `db/mods/00_modded_exes_gamedata.db0`, and it resolves from `db/shaders.db0`. This entry is its first override.
