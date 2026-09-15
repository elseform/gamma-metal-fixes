# GAMMA Metal Fixes Public Release Adapter

## Project identity

- Project root: `../gamma-project`
- Repository: `gamma-metal-fixes`
- Role: `public-release`

Read `../gamma-project/AGENTS.md`, `../gamma-project/docs/architecture.md`, and
`../gamma-project/docs/mods/public-release.md` before work. Shared project policy
and private planning remain canonical in `gamma-project`.

This public repository owns released Metal/D3DMetal shader-compatibility fix
payloads, their public documentation, versions, and release artifacts. It is
split out from `gamma-mods` so Metal fixes version and release independently
of the general mods bundle. Unreleased work belongs in `gamma-wip`
(`mods/metal/`). Never promote or publish a release without the reviewed
release gate and explicit user approval. Preserve uncommitted work and stage
only explicit task files.
