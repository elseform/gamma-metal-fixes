---
schema: 1
kind: entry
entry: d3dmetal-glossy-puddles-1-5-terrain-loop-guards-elseform
repository: gamma-metal-fixes
---

# Metal - Glossy Puddles 1.5 - Terrain Loop Guards TODO

FOMOD development sync preset: **Glossy Puddles loop guards**. This installer offers only that
one option, so the preset is the whole payload.

Promoted from `COMPAT FIX - Glossy Puddles - Metal Loop Guards` in the private
`gamma-misc` repository. First public version is `1.0.0`.

## Active

Nothing currently active.

## Planned

Nothing else planned. Released at `1.0.0`; the pre-packaging verification items were
closed out with the release.

## Rescoped

- [x] <!-- task:review-sum-h-fallback --> Investigated 2026-09-08 (project-wide Metal guard audit): `sum_h` div-by-zero fallback (`float4(1,0,0,0)`) in `HeightBlending` hard-picks the first heightmap layer at full weight, initially flagged as a possible wrong/flickering texture at terrain blend seams. Found moot — `HeightBlending()`'s only call site is commented out in this file (and in every other owning mod's copy of the same file), so the function and its fallback never execute. A Second Pass A/B variant with a neutral fallback was built, found to produce byte-identical rendered output (dead code either way), and removed rather than shipped.
- [x] <!-- task:rebase-and-rename-to-1-5 --> Rebased 2026-09-08 from `Glossy Puddles 1.4` to `Glossy Puddles 1.5`: copied 1.5's `deffer_terrain_high_flat_d.ps` fresh and re-applied the three tagged `[elseform]` edits (division-by-zero guard in `HeightBlending`, and the two `TerrainParallax` loop guards) — diffed clean against the fresh 1.5 copy, no other content drift. Confirmed 1.5 independently moved the puddle-gloss read from `shader_param_5.w` to `.z`; the rebase preserved 1.5's own `.z`, it isn't something this fix controls. Renamed `gamma-wip` folder from `Metal - Glossy Puddles - Terrain Loop Guards` to `Metal - Glossy Puddles 1.5 - Terrain Loop Guards` and updated `id` to `d3dmetal-glossy-puddles-1-5-terrain-loop-guards-elseform` (was `d3dmetal-fix-glossy-puddles-metal-loop-guards`). Published `gamma-mods` copy (`D3DMetal - [Glossy Puddles] - POM Loop Guards`, still built against 1.4) intentionally left untouched — that requires the reviewed release gate, not done here.
- [x] <!-- task:rename-wip-dir-drop-sss23-bracket --> Renamed 2026-08-20 in `gamma-wip` from the former SSS23/Puddles Terrain Loop Guards name to `Metal - Glossy Puddles - Terrain Loop Guards`: the true source has always been Glossy Puddles (`gamma-entry.toml` `[[sources]]` already said so), not Screen Space Shaders 23 — the SSS23 prefix was a mislabel. `id` left unchanged (stable). The WIP name still does not match the published `gamma-mods` copy, `D3DMetal - [Glossy Puddles] - POM Loop Guards` (different suffix: "Terrain" vs "POM"); reconciling public naming requires the reviewed release gate and is not part of this private rebrand.

## History

- [x] <!-- task:package-and-publish-1-0-0 --> Package and publish `1.0.0`.

- [x] <!-- task:moved-to-gamma-mods-d3dmetal-compat-and-renamed-to-the --> Moved to `gamma-mods/d3dmetal-compat/` and renamed to the
  `Metal - <source> - <fix>` pattern.
- [x] <!-- task:recorded-glossy-puddles-1-4-as-the-source-version-in-meta-ini-and-the --> Recorded Glossy Puddles 1.4 as the source version in `meta.ini` and the
  README.
- [x] <!-- task:made-the-readme-self-contained-it-no-longer-instructs-installing-the --> Made the README self-contained; it no longer instructs installing the
  unreleased Metal Loop Guards mod alongside it.
