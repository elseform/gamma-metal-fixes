# Metal - SSS23 - Water Raymarch Bounds

Apple Silicon branch-divergence fix for water raymarching: replaces dynamic unroll attributes in screenspace_water.h with explicit loop attributes and bounds.

---

## What this mod fixes

### 1. P2 — Water Raymarch Branch Bounds (`screenspace_water.h`)
- Replaces dynamic unroll attributes (`[unroll (q_steps)]`) with explicit `[loop]` attributes and bounds.
- Removes SIMD32 warp-divergence penalties on Apple Silicon TBDR. This is a performance and codegen fix, not a hang guard — unlike the two parallax guards it does not protect against anything catastrophic.

---

## Current status in this install

Live as of 2026-09-09: the flat install's `screenspace_water.h` hashes `c4d14768…`, matching this entry.

Earlier the same day it did not — the flat tree still carried Screen Space Shaders 23's unguarded copy, because this fix had never been flattened. That produced a finding, recorded here and since corrected: the install had run unguarded through extended play with no observed hang, so this guard's P0 label came from reading the code rather than from an observed failure. That remains true about the past and says nothing about whether the guard is needed going forward — an unbounded loop that has not yet met degenerate data is not a safe one, and today's page fault took roughly 11k frames to appear.

What it does mean: keep or retire is a live question rather than a settled one, and it should be answered on evidence rather than on the priority label.

---

## Source and Scope

`screenspace_water.h` originates from `190- Screen Space Shaders 23 - Ascii1457` and is unmodified in that source archive aside from the tagged `[elseform]` fix.

Shipped inside `Metal - SSS23 - Core Fixes`, then the combined loop-guards entry, split out 2026-09-09. Split so that each guard can be installed, validated and — where the evidence supports it — retired on its own.

---

## Installation & Load Order

Load after `190- Screen Space Shaders 23 - Ascii1457`. Purge `appdata/shaders_cache/` after installation, otherwise the previously compiled variant is reused.

## Validation

Nothing here reaches the DXMT run log: the shader compiles and links cleanly either way, so a capture cannot confirm or deny this fix. Validate by behaviour.

- Content to have on screen: Water at a distance and at grazing angles, where the raymarch step count is highest. Judge by frame time, not by appearance.
- Do not validate by removal. Testing a hang guard by taking it away costs a machine restart per attempt and proves something already known from the code.
