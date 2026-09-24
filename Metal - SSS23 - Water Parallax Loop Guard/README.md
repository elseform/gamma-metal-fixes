# Metal - SSS23 - Water Parallax Loop Guard

GPU-hang guard for water parallax: caps Water_DoParallax's otherwise unbounded iteration count in ssfx_water.ps.

---

## What this mod fixes

### 1. P0 — Water Parallax Loop Hang Guard (`ssfx_water.ps`)
- Caps `Water_DoParallax` at 128 iterations. Same rationale as the POM guard: no TDR recovery on macOS, and a data-dependent loop with no bound is the top hang risk in the shader stack.
- Runtime-validated 2026-08-12 while this was the standalone `Metal - SSS23 - Water Loop Guards` entry.
- Not for SSS Update 24, which needs the separate ALPHA18-based override.

---

## Current status in this install

Live as of 2026-09-09: the flat install's `ssfx_water.ps` hashes `555fda10…`, matching this entry.

Earlier the same day it did not — the flat tree still carried Screen Space Shaders 23's unguarded copy, because this fix had never been flattened. That produced a finding, recorded here and since corrected: the install had run unguarded through extended play with no observed hang, so this guard's P0 label came from reading the code rather than from an observed failure. That remains true about the past and says nothing about whether the guard is needed going forward — an unbounded loop that has not yet met degenerate data is not a safe one, and today's page fault took roughly 11k frames to appear.

What it does mean: keep or retire is a live question rather than a settled one, and it should be answered on evidence rather than on the priority label.

---

## Source and Scope

`ssfx_water.ps` originates from `190- Screen Space Shaders 23 - Ascii1457` and is unmodified in that source archive aside from the tagged `[elseform]` fix.

Was a standalone `Metal - SSS23 - Water Loop Guards` entry until 2026-08-20, folded into the Core Fixes bundle, then into the combined loop-guards entry on 2026-09-09. Restored to a standalone entry the same day. Split so that each guard can be installed, validated and — where the evidence supports it — retired on its own.

---

## Installation & Load Order

Load after `190- Screen Space Shaders 23 - Ascii1457`. Purge `appdata/shaders_cache/` after installation, otherwise the previously compiled variant is reused.

## Validation

Nothing here reaches the DXMT run log: the shader compiles and links cleanly either way, so a capture cannot confirm or deny this fix. Validate by behaviour.

- Content to have on screen: Still and disturbed water, daylight and night.
- Do not validate by removal. Testing a hang guard by taking it away costs a machine restart per attempt and proves something already known from the code.
