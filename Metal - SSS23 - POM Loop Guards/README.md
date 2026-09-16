# Metal - SSS23 - POM Loop Guards

GPU-hang guard for parallax-occlusion mapping: caps sload.h's parallax and contact-refinement loops, which are otherwise unbounded and have no TDR recovery on macOS.

---

## What this mod fixes

### 1. P0 — Parallax-Occlusion Loop Hang Guards (`sload.h`)
- Caps the parallax main loop at 128 iterations and the contact-refinement loop at 64.
- macOS has no TDR-style recovery: a fragment shader that spins forever takes down the GPU until the game or the machine restarts. A degenerate `_step` (a division producing 0 or inf) or a NaN feeding the loop comparison can spin it indefinitely.
- Built on Screen Space Shaders 23's own `sload.h`. Enhanced Shaders also ships this file but loses the conflict in a standard G.A.M.M.A. load order.

---

## Current status in this install

Live as of 2026-09-09: the flat install's `sload.h` hashes `5f024733…`, matching this entry.

Earlier the same day it did not — the flat tree still carried Screen Space Shaders 23's unguarded copy, because this fix had never been flattened. That produced a finding, recorded here and since corrected: the install had run unguarded through extended play with no observed hang, so this guard's P0 label came from reading the code rather than from an observed failure. That remains true about the past and says nothing about whether the guard is needed going forward — an unbounded loop that has not yet met degenerate data is not a safe one, and today's page fault took roughly 11k frames to appear.

What it does mean: keep or retire is a live question rather than a settled one, and it should be answered on evidence rather than on the priority label.

---

## Source and Scope

`sload.h` originates from `190- Screen Space Shaders 23 - Ascii1457` and is unmodified in that source archive aside from the tagged `[elseform]` fix.

Was a standalone `Metal - SSS23 - POM Loop Guards` entry until 2026-08-20, folded into the Core Fixes bundle, then into the combined loop-guards entry on 2026-09-09. Restored to a standalone entry the same day. Split so that each guard can be installed, validated and — where the evidence supports it — retired on its own.

---

## Installation & Load Order

Load after `190- Screen Space Shaders 23 - Ascii1457`. Purge `appdata/shaders_cache/` after installation, otherwise the previously compiled variant is reused.

## Validation

Nothing here reaches the DXMT run log: the shader compiles and links cleanly either way, so a capture cannot confirm or deny this fix. Validate by behaviour.

- Content to have on screen: Surfaces using parallax-occlusion mapping — brick, rubble, detailed walls — at close range and grazing angles.
- Do not validate by removal. Testing a hang guard by taking it away costs a machine restart per attempt and proves something already known from the code.
