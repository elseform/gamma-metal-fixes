---
schema: 1
kind: entry
entry: d3dmetal-sss23-sams-gtao-elseform
repository: gamma-metal-fixes
---

# Metal - Sams - GTAO TODO

## Rescoped

- [x] <!-- task:drop-sss23-prefix-sams-gtao --> Renamed 2026-08-20 from the former SSS23/Sams GTAO name to `Metal - Sams - GTAO`: true shipping source is `Sam's Optimization Patches shaders` (per `gamma-entry.toml` `[[sources]]`); Atmospherics is credited there only as the GTAO algorithm's origin, not the winning file. Unrelated to Screen Space Shaders 23. The SSS23 prefix was a stale tier label.

## Active

- [ ] <!-- task:playtest-sams-atmos68-gtao-d3dmetal --> Clear the shader cache and validate GTAO compilation, stable AO boundaries, foliage, weapon edges, and temporal history under Metal.
- [ ] <!-- task:resolve-dead-sams-gtao-provenance --> This entry's declared dependency ("Sam's Optimization Patches shaders 2026.08.12") is not installed anywhere in the active MO2 profile (confirmed 2026-09-08 via `modlist.txt` and the flattener inventory). `ssfx_ao.ps`/`ssfx_ao_blur.ps` are actually owned by the raw `Atmospherics 2.69 RC7.2` mod instead — this entry never wins that file conflict and has been guarding nothing. Minimal `rsqrt` guards for the actually-reachable GTAO shader were added directly to the `Metal - Atmospherics 2.69 RC7.2 SSS23 - Core Fixes` and SSS24 entries (item 3, 2026-09-08). Consider retiring this entry or rebasing it directly onto Atmospherics RC7.2.

## Completed

- [x] <!-- task:preserve-sam-scaled-ao-pair --> Preserved Sam 2026.08.12's Atmospherics 2.69 RC6.8 GTAO and matching scaled-blur contract in the override.
- [x] <!-- task:harden-gtao-degenerate-math --> Guarded zero-length normalization, reciprocal square root, projection division, temporal depth, source scale, and render-target dimensions against NaN and infinity generation.
- [x] <!-- task:document-gtao-failure-path --> Documented the exact numerical failure paths, Metal consequences, load order, cache requirement, and runtime validation scope.
