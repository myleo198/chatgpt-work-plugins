---
name: img2threejs-work
description: Rebuild an object, character, creature, prop, or scene reference image as a quality-gated, animation-ready procedural Three.js model written in TypeScript. Use when the user asks to convert an image to 3D, create a Three.js asset from a reference, generate an ObjectSculptSpec, assess image-to-3D feasibility, iterate rendered-model fidelity, or prepare a real-time interactive model.
---

# img2threejs Work

Use the upstream img2threejs checkout pinned in [references/upstream.md](references/upstream.md). It produces procedural TypeScript and JSON specifications, not downloaded meshes, photogrammetry, or hidden geometry claims.

## Core workflow

1. Inspect the reference image and state its usable views, intended runtime, scale, and hidden-area uncertainty. Request more views when identity-critical geometry is not visible.
2. Clone or update the pinned upstream checkout if its `forge/` scripts are unavailable. Use Python 3.10+; the core pipeline has no third-party Python dependencies.
3. Initialize the resumable state under the working project, never in the source checkout:

   ```bash
   python3 forge/state.py init --state .img2threejs/state.json --reference <image> --profile <generic|character|cs2>
   python3 forge/next.py --state .img2threejs/state.json
   ```

4. Run image probing and pre-spec assessment. Build an `ObjectSculptSpec` that records component hierarchy, material regions, transforms, pivots, sockets, colliders, detail inventory, confidence, and build passes.
5. Validate with `--strict-quality`. Treat a blocked result as a specification defect; do not bypass it for production output.
6. Generate only the unlocked Three.js pass. Render it in a browser, compare against the reference, record evidence, and correct one problem group at a time: camera, silhouette, form, material, lighting, interaction.
7. Report exact changes, remaining mismatches, and inferred regions. Do not represent a single-image reconstruction as exact 3D truth.

## Required rules

- Keep the output as editable TypeScript plus JSON artifacts; do not substitute unreviewed mesh downloads.
- Use the state file as the cross-session progress record. Follow hard stops reported by `forge/next.py`.
- Require visual evidence before advancing a build pass. A numeric gate alone is not proof of visual fidelity.
- Preserve generated specs, review records, comparison sheets, and source provenance in the user's project.
- Use authority or user-supplied evidence for copyrighted or branded subjects; do not claim rights from the reference image itself.

## References

- Read [references/upstream.md](references/upstream.md) before setup, updates, or version-sensitive commands.
- Read the upstream `docs/ARCHITECTURE.md` when selecting a profile, material path, GLB-mediated workflow, or review gates.
