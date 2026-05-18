---
name: g6-patch-authoring
description: End-to-end procedure for authoring a Zoom G6 patch recipe from an isolated guitar DI .wav. Covers intake, FFmpeg/SoX analysis via VS Code tasks, chain proposal grounded in reference/g6-fx-catalog.yaml, subjective A/B iteration, and finalization. Use whenever the user wants to create, iterate on, or validate a patch recipe under patches/.
---
# Skill: Zoom G6 Patch Authoring

## When to invoke
- User drops a `.wav` into `samples/` and asks for a patch.
- User asks to "iterate", "tweak", or A/B an existing recipe in `patches/`.
- User asks to "validate" or "finalize" a recipe.

## Hard rules (re-state at the top of every response that proposes effects)
1. Effects and parameter ranges come **only** from [reference/g6-fx-catalog.yaml](../../../reference/g6-fx-catalog.yaml) (structured). For every effect cited, include category, the `page:` value, and the exact `raw:` range string for each parameter value used. If `typed.kind` is `special` or the effect has `notes:`, confirm against [reference/E_G6_FX-list_2.pdf](../../../reference/E_G6_FX-list_2.pdf) before committing.
2. Max 9 effect slots. One AMP, one CABINET/IR.
3. Default category order: DYNAMICS → FILTER → DRIVE → AMP → CABINET → MODULATION → SFX → DELAY → REVERB → PEDAL → SND-RTN → IR. Deviation requires written §5 justification.
4. Parameter values must lie inside the catalog's printed range. Never clamp silently — escalate.
5. Similarity is judged **by ear** by the user. Do not invent objective scores.

## Procedure

### Step 1 — Intake
- Confirm the sample path under `samples/`.
- Confirm the target tone in plain words (artist/track/timestamp, or a description). If absent, ask.
- Choose the recipe filename: `<artist>_<track>_<tone-tag>.md`.

### Step 2 — Analyze
- Run the `Analyze: All` VS Code task with the chosen `.wav`. (Tasks live in [.vscode/tasks.json](../../../.vscode/tasks.json).)
- Artifacts land in `analysis/<basename>/`: `spectrogram.png`, `loudness.txt`, `sox-stat.txt`.
- If FFmpeg or SoX is missing, tell the user the exact install command and stop. Do not fabricate analysis.

### Step 3 — Read the analysis
Pull concrete numbers into the draft recipe §2:
- Peak / true peak / integrated LUFS from `loudness.txt`.
- RMS amplitude, crest factor, DC offset, max delta from `sox-stat.txt`.
- Spectral characterization from `spectrogram.png` (where energy concentrates, harmonic density, attack transients).

### Step 4 — Propose a chain
- Look up candidate effects in [reference/g6-fx-catalog.yaml](../../../reference/g6-fx-catalog.yaml) by category. The YAML's `categories.<CATEGORY>.effects[]` is the only allowed pool.
- Map sonic observations to G6 effect categories. Examples:
  - Tight low end + fast attack → DYNAMICS compressor (cite which one + `page:`).
  - Saturated harmonics → DRIVE (cite model) → AMP (cite model).
  - Cab-like high-end rolloff → CABINET or IR.
  - Spatial tail → REVERB.
- Build the chain in category order. Stop at 9 slots. Drop the least-impactful slot if DSP budget seems tight.
- For each effect, fill the §3 table with the verbatim catalog name + page cite, and §4 with every parameter and a starting value inside the `raw:` range (or, for `kind: enum`, one of the listed `values`).
- For any param flagged `typed.kind: special` or sitting on an effect with `notes:`, copy the relevant note into the recipe so reviewers see the caveat.

### Step 5 — Hand to user for A/B
- Present the draft. Ask the user to dial it in on the G6 and A/B against the sample.
- Ask one direct question: "What's wrong with it?" (gain, EQ tilt, time-domain feel, spatial sense).

### Step 6 — Iterate
- For each piece of feedback, propose specific parameter deltas (which slot, which param, old → new). Stay in range.
- Append a new row to §7 with the feedback, deltas, and expected result.
- Loop Step 5/6 until user says it matches.

### Step 7 — Validate & finalize
- Run the `validate-patch` prompt mentally (or invoke it): every effect cited, every value in range, chain ≤ 9, category order or justification, A/B approval present.
- Set `Status: finalized` only when all §8 boxes are checked.

## Output style
- Be terse. Lead with the chain table. Cite the catalog every time. Ask one question per turn.
- Never claim a tone "matches" — only the user's ear decides.
