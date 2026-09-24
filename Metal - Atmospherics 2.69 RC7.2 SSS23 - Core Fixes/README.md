# Metal - Atmospherics 2.69 RC7.2 SSS23 - Core Fixes

Metal compatibility fixes for `Atmospherics 2.69 RC7.2_SSS23`.

---

## What this mod fixes

### 1. P2 — SSR Raymarch Branch Optimization (`screenspace_reflections.h`)
- Replaces dynamic variable unroll attributes (`[unroll (q_steps)]`) with explicit `[loop]` attributes and bounds to eliminate SIMD32 warp divergence execution penalties on Apple Silicon TBDR architecture, and to allow the Metal shader compiler to generate working SSR passes on scope lens reflections without hitting SIMD divergence or register spill limits.

### 2. P0 — Terrain Parallax-Occlusion Loop Hang Guard (`deffer_terrain_high_flat_d.ps`)
- Caps `TerrainParallax`'s main loop at 128 iterations and the optional `SSFX_TERRA_POM_REFINE` contact-refinement loop at 64 iterations.
- macOS has no TDR-style recovery — a fragment shader that spins forever takes down the GPU until the game or the machine restarts. Terrain POM normally terminates because `curr_step += _step` outgrows the sampled height; a degenerate `_step` (a division producing 0 or inf) or a NaN feeding the comparison can otherwise spin it indefinitely.
- Both limits sit well above the worst legitimate step count, so visuals are unaffected — a guard only fires if the loop is already misbehaving.
- Note (2026-09-08 audit): this file's `HeightBlending()` function was checked for a possible `sum_h` div-by-zero coverage gap and found moot — its only call site is commented out in this copy (and in every other owning mod's copy), so the function is dead code, never invoked. No fix needed.

### 3. P0 — GTAO `rsqrt` Domain Guards (`ssfx_ao.ps`) — added 2026-09-08
- These files are new to this entry: not part of the original `Atmospherics 2.69 RC7.2` core-fix scope, added after a project-wide Metal guard audit found the live, reachable GTAO shaders carried **zero** `[elseform]` guards. `Metal - Sams - GTAO`, which would have guarded them, is dead — its declared dependency ("Sam's Optimization Patches shaders 2026.08.12") isn't installed anywhere in the active MO2 profile, confirmed via the flattener inventory that `ssfx_ao.ps` and `ssfx_ao_blur.ps` are actually owned by this mod (`Atmospherics 2.69 RC7.2`) directly, not by Sam's pack.
- Two minimal `rsqrt` domain guards added to `ssfx_ao.ps`'s `calc_GTAO()` (both confirmed reachable — called unconditionally from `main()` for every non-sky pixel, every frame):
  - `proj_normal_length_sq = dot(proj_normal, proj_normal)` can legitimately reach 0 when the view normal is exactly aligned with the slice axis. Unguarded, `rsqrt(0) = Inf` propagates into a `0 * Inf = NaN`, corrupting this direction's contribution to `occ_weight`.
  - `s_vec_length = dot(s_vector, s_vector)` can reach 0 on a coincident horizon sample — same `NaN` propagation shape into `s_horizon`.
  - Both guards `continue` past the affected direction/sample on the degenerate case (skip rather than substitute a fallback value) — a truly zero-length vector naturally contributes nothing to the AO term, so skipping matches this project's visual-equivalence heuristic (value+slope continuity) better than clamping to an epsilon and continuing with a garbage direction.
- `ssfx_ao_blur.ps` was audited and needs no guard: its one candidate risk site (`r += 1.0f / r`, seeded at `r=2.0f`) is self-reinforcing and provably never reaches 0. It shipped here unmodified until 2026-09-10 and has since been dropped — an override that changes nothing still wins the file conflict, which would silently mask any future upstream change to it.

---

## Source and Scope

`deffer_terrain_high_flat_d.ps` and `screenspace_reflections.h` originate from `Atmospherics 2.69 RC7.2_SSS23` and are unmodified in that source archive aside from the tagged `[elseform]` fixes. Both files are content-identical (aside from CRLF/whitespace) to their `Atmospherics 2.69 RC6.92_SSS23`, `RC6.91_SSS23`, and `RC6.8_SSS23` counterparts — verified 2026-09-08 — so this rebase is metadata-only; no patch content changed. See `docs/mods/records/atmospherics-2.69-rc6.92-vs-rc6.91-sss23.md` and `docs/mods/records/atmospherics-2.69-rc6.91-vs-rc6.8-sss23.md` in `gamma-project`.

`ssfx_ao.ps` and `ssfx_ao_blur.ps` originate directly from the installed `Atmospherics 2.69 RC7.2` MO2 mod (copied 2026-09-08, confirmed the live/winning copy via the flattener inventory), not from a versioned `_SSS23` archive tier — added as new coverage per item 3 above.

`deffer_terrain_high_flat_d.ps` is also shipped identically (same unbounded `TerrainParallax` loop) by `Glossy Puddles 1.4` and `Screen Space Shaders 23 - Ascii1457`. `Glossy Puddles 1.4`'s copy is separately guarded by `Metal - Glossy Puddles - Terrain Loop Guards`; `Screen Space Shaders 23 - Ascii1457`'s copy is guarded here by folding into `Metal - SSS23 - Core Fixes` instead of a fourth standalone entry. Each guarded copy only wins the file conflict for its own source's active priority slot — see [Shaders & Metal](../../../docs/engine/shaders-d3dmetal.md) and the active `modlist.txt` for which copy actually wins today.

---

## Installation & Load Order

Load after `Atmospherics 2.69 RC7.2_SSS23`. Purge `appdata/shaders_cache/` after installation.

## Validation

- Confirm the diff against the source archive copies contains only the tagged `[elseform]` fix lines.
- Compile under Metal/DXMT without shader errors.
- In-game: validate SSR loop unrolling against Metal shader compiler on scope lens reflections. Check dry and wet terrain with terrain POM enabled.
- In-game (GTAO guards, added 2026-09-08): watch for AO flicker, black-square corruption, or history smearing at sky boundaries, thin foliage edges, weapon edges, or during rapid camera motion — the class of symptom the dead `Metal - Sams - GTAO` pack was originally built to prevent.

Static source comparison is complete for the original 2 files; the 2 new GTAO guards are hand-traced against the live MO2 source but not yet run through the offline `validate_shaders.py` pipeline. Runtime validation remains required for all 4 files.
