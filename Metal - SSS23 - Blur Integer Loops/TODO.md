---
schema: 1
kind: entry
entry: d3dmetal-sss23-blur-integer-loops-elseform
repository: gamma-metal-fixes
---

# Metal - SSS23 - Blur Integer Loops TODO

## Active

- [ ] <!-- task:review-pp-blur-loop-sample-count --> Informational, not a defect to fix: the `blur_directions=12` passes (2 occurrences) now sample exactly 12 directions where the original float-accumulated loop ran 13 — FP rounding drift pushed `d < Pi` through one extra time. Unlike the `=8` (nightvision) and `=16` cases this one is not self-correcting, because normalisation divides by the nominal `blur_directions*blur_quality` rather than the actual sample count, leaving the `.rb` output roughly 7-8% dimmer per quality ring. Found 2026-09-08 by numeric simulation; judged imperceptible in an already-blurred pass and deliberately not fixed.

## Completed

- [x] <!-- task:split-from-sss23-core-fixes-2026-09-09 --> Split 2026-09-09 out of `Metal - SSS23 - Core Fixes` so this fix can be installed and validated on its own. The bundle's own analysis notes predate the split and cover the moved files' full history; read them in `history/retired/Metal - SSS23 - Core Fixes/TODO.md`.
