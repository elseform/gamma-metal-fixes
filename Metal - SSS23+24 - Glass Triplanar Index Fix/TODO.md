---
schema: 1
kind: entry
entry: d3dmetal-sss23-24-glass-triplanar-index-fix-elseform
repository: gamma-metal-fixes
---

# Metal - SSS23+24 - Glass Triplanar Index Fix TODO

## Active

- [ ] <!-- task:runtime-validate-glass-triplanar-fix --> Runtime-validate under DXMT after a shader-cache purge: a side/top-facing building window in daylight, at close and long range. Found via the l02_garbage warehouse's side-wall windows (`models\window`, shader `glas`, texture `glas_dirt`).
- [ ] <!-- task:confirm-front-facing-unaffected --> Confirm a directly camera-facing glass pane (Front branch, `ma=(2,0,1)`) was already fine before this fix, to make sure the bug is isolated to Side/Top and this change doesn't regress it.
