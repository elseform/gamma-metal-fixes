---
schema: 1
kind: entry
entry: d3dmetal-sss23-pom-loop-guards-elseform
repository: gamma-metal-fixes
---

# Metal - SSS23 - POM Loop Guards TODO

## Active

- [ ] <!-- task:decide-keep-or-retire --> Decide keep or retire against evidence, not against the P0 label. See "Current status in this install" in the README: this guard's real-world exposure is documented there as of 2026-09-09.
- [ ] <!-- task:validate-pom-loop-guards --> Validate by behaviour, not by log: Surfaces using parallax-occlusion mapping — brick, rubble, detailed walls — at close range and grazing angles.

## Completed

- [x] <!-- task:split-from-combined-loop-guards --> Split 2026-09-09 out of `Metal - SSS23 - Parallax & Raymarch Loop Guards`, which had briefly grouped four files that share a rationale but not a validation pass, a defect class, or a live/dead status. Fuller history of these files is in `history/retired/Metal - SSS23 - Core Fixes/TODO.md`.
