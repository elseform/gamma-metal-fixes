# GAMMA Metal Fixes Public Release Adapter

## Project identity

- Project root: `../gamma-project`
- Repository: `gamma-metal-fixes`
- Role: `public-release`

Read `../gamma-project/AGENTS.md`, `../gamma-project/docs/architecture.md`, and
`../gamma-project/docs/mods/public-release.md` before work. Shared project policy
and private planning remain canonical in `gamma-project`.

This public repository owns Metal/D3DMetal shader-compatibility fix
payloads, their public documentation, versions, and release artifacts. It is
split out from `gamma-mods` so Metal fixes version and release independently
of the general mods bundle.

Unlike every other GAMMA repository, this one has no private counterpart:
development happens directly here, on the `dev` branch, public payloads and documentation only; internal `gamma-entry.toml` files
are excluded. `main` contains only the approved release selection; `dev` also retains active
fixes outside that selection. Promote only explicitly selected entries from
`dev`; never merge the whole development tree into `main`. Retired payloads
are not retained in this repository. Cutting a release or publishing assets
still requires the reviewed release gate and explicit user approval. Preserve
uncommitted work and stage only explicit task files.
Release assets are individual `.7z` archives built from `main`, one per mod.
Use each mod's `meta.ini` version; do not generate a combined FOMOD.
