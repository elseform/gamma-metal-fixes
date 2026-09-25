# Metal - Atmospherics 2.69 RC7.3 SSS24 - Core Fixes

Metal compatibility fixes for `Atmospherics 2.69 RC7.3 hotfix SSS24`.

---

## What this mod fixes

### 1. SSR Raymarch Branch Optimization (`screenspace_reflections.h`)

Replaces a dynamic-length `[unroll]` loop with an explicit `[loop]` and a hard
bound. The dynamic unroll causes heavy SIMD divergence and register spills on
Apple Silicon's tile-based GPUs, which can stall compilation or tank
framerate for screen-space reflections on wet surfaces and scope lenses.

### 2. Terrain Parallax-Occlusion Loop Hang Guard (`deffer_terrain_high_flat_d.ps`)

Caps the terrain parallax-occlusion loop at 128 iterations (64 for its
optional contact-refinement pass). macOS has no GPU timeout recovery, so a
fragment shader that loops forever hangs the GPU until the game or the
machine is restarted. The loop normally terminates on its own, but a
degenerate step value (from a division that produces `0` or `inf`) or a
stray `NaN` can make it spin indefinitely. Both caps sit well above any
legitimate iteration count, so normal rendering is unaffected — the guard
only fires once the loop is already broken.

### 3. GTAO `rsqrt` Domain Guards (`ssfx_ao.ps`)

Two small guards in the ambient-occlusion pass, which runs on every non-sky
pixel every frame:

- A projected-normal length that can legitimately reach exactly zero (when
  the view normal aligns with the slice axis), which otherwise turns
  `rsqrt(0) = Inf` into a `0 * Inf = NaN`.
- The same failure shape on a coincident horizon-sample vector.

Both guards skip the degenerate sample rather than substitute a fallback
value — a truly zero-length vector should contribute nothing to the AO term
anyway.

---

## Relationship to the SSS23 variant

Atmospherics ships two variants, SSS23 and SSS24; they're separate source
mods, so each gets its own fixed copy of these files. Enable only the entry
matching whichever Atmospherics variant you have installed — enabling both
just means the higher-priority one wins and the other does nothing.

---

## Source and Scope

`deffer_terrain_high_flat_d.ps` and `screenspace_reflections.h` come from
`Atmospherics 2.69 RC7.3 hotfix SSS24`, unmodified aside from the tagged
`[elseform]` fixes. `ssfx_ao.ps` comes from `Atmospherics 2.69 RC7.3 hotfix SSS24`
directly, not from a versioned SSS23/SSS24 tier.

`deffer_terrain_high_flat_d.ps`'s unbounded loop also ships, unfixed, in
`Glossy Puddles` and `Screen Space Shaders 23` — each of those has its own
separately guarded copy (`Metal - Glossy Puddles 1.5 - Terrain Loop Guards`,
`Metal - SSS23 - Terrain Parallax Loop Guard`), since only one copy wins the
file conflict depending on your load order.

---

## Installation & Load Order

Load after `Atmospherics 2.69 RC7.3 hotfix SSS24`. Purge `appdata/shaders_cache/`
after installing or updating.

## Validation

- Diff against the unmodified source contains only the tagged `[elseform]`
  lines.
- Compiles under Metal/DXMT without shader errors.
- In-game: scope lens reflections render correctly; terrain parallax
  occlusion is stable on both dry and wet ground.
- In-game: no AO flicker, black-square corruption, or smearing at sky
  boundaries, thin foliage edges, or during fast camera motion.
