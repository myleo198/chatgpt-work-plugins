# img2threejs upstream

- Source: https://github.com/img2threejs/img2threejs
- Pinned revision: `d6673386f89673a58736f8d398dd16ece67874f5`
- License: Apache-2.0
- Runtime: Python 3.10+ standard library; browser-side Three.js project required to render generated TypeScript.

## Checkout

Keep the upstream source outside a user project and clone it once:

```bash
git clone https://github.com/img2threejs/img2threejs.git <tool-root>/img2threejs
cd <tool-root>/img2threejs
git checkout d6673386f89673a58736f8d398dd16ece67874f5
```

Run `forge/...` commands from this checkout. Put `.img2threejs/`, generated specs, rendered previews, comparison sheets, and generated TypeScript in the target project so they can be reviewed and version controlled with that project.

## Canonical stages

1. `forge/state.py init` and `forge/next.py --state` establish/resume the ordered checklist.
2. `forge/stage1_intake/probe_image.py` checks technical image suitability.
3. `forge/stage2_spec/new_pre_spec_assessment.py` creates the quality contract and evidence bundle.
4. `forge/stage2_spec/new_sculpt_spec.py` authors the ObjectSculptSpec.
5. `forge/stage2_spec/validate_sculpt_spec.py --strict-quality` blocks shallow specs.
6. `forge/stage3_build/generate_threejs_factory.py` emits only the unlocked procedural factory pass.
7. The stage-4 review scripts record comparison evidence and the decision to continue, refine, request input, or stop.

Read upstream `SKILL.md` and `docs/ARCHITECTURE.md` before using advanced character, CS2, material, visual-hull, or GLB-mediated tracks. The project is explicit that one image cannot prove unseen geometry.
