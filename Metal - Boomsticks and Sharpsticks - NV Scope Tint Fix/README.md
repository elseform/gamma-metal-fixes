# Metal - Boomsticks and Sharpsticks - NV Scope Tint Fix

Metal compatibility fix for night-vision scope tint in
`models_scope_nv_1.ps`, `models_scope_nv_2.ps`, `models_scope_nv_3.ps`,
shipped by `Boomsticks and Sharpsticks`.

---

## What this mod fixes

### NV Scope Tint — Comma-Operator Bug (`models_scope_nv_1/2/3.ps`)

```
- float3 BAS_NV_COLOR = (0.1, 1.0, 0.1);
+ float3 BAS_NV_COLOR = float3(0.1, 1.0, 0.1);
```

`(0.1, 1.0, 0.1)` is the HLSL comma operator, not a vector constructor — it
evaluates to the last scalar (`0.1`) and splats to `(0.1, 0.1, 0.1)`, so
the night-vision tint silently collapses from green to grey. Legacy FXC
compiles it anyway; DXMT can hard-error on it. The `float3(...)`
constructor is the unambiguously correct form.

---

## Source and Scope

`models_scope_nv_1/2/3.ps` originate from `Boomsticks and Sharpsticks` and
are unmodified there aside from the tagged `[elseform]` fix.

---

## Installation & Load Order

Load after `Boomsticks and Sharpsticks`. Purge `appdata/shaders_cache/`
after installing or updating.

## Validation

- Diff against the unmodified source contains only the tagged `[elseform]`
  fix lines, for all 3 files.
- Compiles under Metal/DXMT without shader errors.
- In-game: each NV scope generation shows the correct green tint, not grey.
