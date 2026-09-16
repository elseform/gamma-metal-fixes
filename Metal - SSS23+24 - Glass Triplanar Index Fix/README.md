# Metal - SSS23+24 - Glass Triplanar Index Fix

Metal compatibility fix for `ssfx_glass.ps`: repairs an out-of-bounds
swizzle index in the fake-triplanar UV pick that the stricter Metal path
rejects.

---

## What this mod fixes

### Fake-Triplanar Out-of-Bounds Swizzle Index (`ssfx_glass.ps`)

```hlsl
int3 ma = (n.x > n.y && n.x > n.z)	? int3(0, 1, 2) : // [ yz ] Side
		  (n.y > n.z)				? int3(1, 2, 0) : // [ zx ] Top
									  int3(2, 0, 1) ; // [ xy ] Front

float2 uvs = float2(I.P.xy[ma.y], I.P.xy[ma.z]);
```

`ma` picks a fake-triplanar axis pair depending on which world axis the
surface normal points closest to, and always contains a `2` in one of its
components. But `I.P.xy` is a 2-component swizzle — valid indices `0`/`1`
only. Two of the three branches (surfaces facing sideways or upward — most
ordinary wall windows) end up indexing out of bounds; only a directly
camera-facing pane escapes it.

Legacy FXC tolerates the out-of-range index and reads unspecified adjacent
data; DXMT's stricter translation does not, and the result is the whole
draw going flat black instead of just one coordinate being wrong.

Fixed by indexing the full 3-component `I.P.xyz` instead of the
pre-truncated `I.P.xy`, so all three axis picks stay in range:

```hlsl
float2 uvs = float2(I.P.xyz[ma.y], I.P.xyz[ma.z]);
```

---

## Source and Scope

`ssfx_glass.ps` is byte-identical between `Screen Space Shaders 23` and
`ScreenSpaceShaders_Update_24`, including the bug at the same line in both,
so one fixed copy covers whichever of the two you have installed.
Unmodified aside from the tagged `[elseform]` fix.

## Installation & Load Order

Load after `Screen Space Shaders 23` and/or `ScreenSpaceShaders_Update_24`
(whichever you have enabled). Purge `appdata/shaders_cache/` after
installing or updating, otherwise the previously compiled variants are
reused.

## Validation

- Diff against the unmodified source contains only the tagged `[elseform]`
  fix lines.
- In-game: find a building with side- or top-facing window panes (not
  directly camera-facing) and confirm the glass no longer renders solid
  black in daylight, at any distance.
