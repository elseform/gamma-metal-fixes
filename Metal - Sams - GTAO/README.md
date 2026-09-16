# Metal - Sams - GTAO

Hardens the GTAO path shipped with Sam's Optimization Patches 2026.08.12 and
Atmospherics 2.69 RC6.8 SSS23 against NaN and infinity propagation under
Metal/DXMT.

## Technical problem

The source GTAO shader assumes every geometric and reprojection denominator is
finite and nonzero. Normal gameplay usually satisfies that assumption, but
sky boundaries, disocclusion, coincident samples, empty projected normals, and
invalid temporal history can produce these degenerate values:

- a zero projected-normal length passed to `rsqrt`;
- a zero sample-vector length passed to `rsqrt`;
- a zero or invalid AO radius or projection divisor;
- a zero current/previous clip-space `w` used for perspective division;
- a zero previous-frame depth used by the disocclusion ratio;
- a zero AO source scale or render-target dimension used by the paired blur
  shader.

Those operations can create NaN or infinity. Metal translation layers propagate
undefined floating-point results through later `sin`, `pow`, texture-coordinate,
temporal-history, and blend calculations. The visible result can be unstable or
black AO, flickering, history smearing, or a corrupted frame. These loops are
already bounded, so this is a numerical-correctness problem rather than the
unbounded-loop GPU-hang problem addressed by the separate Metal Loop Guards.

## Fix

The override preserves Sam's complete Atmospherics-based GTAO implementation,
scaled-AO reprojection, and scaled blur. It adds narrow numerical guards:

- rejects non-finite, zero-length, and unreasonably large vectors before
  normalization;
- avoids reciprocal square root and division with zero-length geometry;
- substitutes finite denominators for AO radius, projection scale, clip-space
  `w`, temporal-history depth, source scale, and render-target size;
- rejects invalid temporal history instead of blending it into current AO;
- falls back to unoccluded AO when GTAO has no valid directional weight;
- makes invalid bilateral depth comparisons retain the current pixel rather
  than importing an invalid neighbour.

Normal finite inputs keep the original equations. Fallbacks activate only for
degenerate input.

## Source and compatibility

Both shipped files come from `Sam-Optimization-Patches-Shaders.zip` dated
2026.08.12. That version already incorporates the Atmospherics 2.69 RC6.8
SSS23 GTAO code. `ssfx_ao_blur.ps` remains paired with `ssfx_ao.ps` because
Sam's matching executable enables their scaled-AO contract.

Required stack:

- Sam's Optimization Patches MT executables 2026.08.12;
- Sam's Optimization Patches shaders 2026.08.12;
- Atmospherics 2.69 RC6.8 SSS23;
- Screen Space Shaders 23.

Do not use this override with a different Sam build, SSS Update 24, or a later
Atmospherics release without rebasing and reviewing both files.

## Install and load order

Load this mod after Atmospherics and Sam's shader mod so its `ssfx_ao.ps` and
`ssfx_ao_blur.ps` win both conflicts. Sam's own shader mod must continue to win
its grass and detail shader conflicts.

After enabling or updating this mod, clear `appdata/shaders_cache/` before
launching the game.

## Validation

Static validation checks that both files retain Sam's scaled-AO contract and
that the source delta contains only documented numerical guards and comments.
Runtime validation remains required under Metal:

- confirm both shaders compile after clearing the cache;
- inspect AO on sky/geometry boundaries, thin foliage, weapon edges, and rapid
  camera motion;
- check for black AO, flicker, trails, or history smearing;
- compare representative scenes against unmodified Sam shaders to ensure
  normal finite-input appearance is unchanged.
