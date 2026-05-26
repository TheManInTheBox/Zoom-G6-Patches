# Session Template

Copy this folder for every new song: `cp -r sessions/_TEMPLATE sessions/<song-name>`.

## Contents (intended)

- `notes.md` — song-specific notes (tempo, key, arrangement, references).
- `<song-name>.song` — Fender Studio Pro project file (binary, not in repo until git-lfs decision).
- `bounces/` — exported audio (rough mix, final mix, master).
- `analysis/` — link to the song's entry in the top-level `analysis/` dir.

## Standard track layout (target)

| Track | Source | Bus |
|---|---|---|
| Kick | BFD3 multi-out | Drum bus |
| Snare top | BFD3 multi-out | Drum bus |
| Snare bot | BFD3 multi-out | Drum bus |
| Toms | BFD3 multi-out | Drum bus |
| OH L/R | BFD3 multi-out | Drum bus |
| Room | BFD3 multi-out | Drum bus |
| Bass DI | Quantum HD input or VST | Bass bus (split clean/grind) |
| Guitar L (rhythm) | G6 → DAW | Guitar bus |
| Guitar R (rhythm) | G6 → DAW | Guitar bus |
| Guitar lead | G6 → DAW | Guitar bus |
| Lead vocal | Mic → preamp → DAW | Vocal bus |
| Vocal harmonies | Mic → preamp → DAW | Vocal bus |
| FX returns | Reverb / delay sends | FX bus |

All buses → mix bus → master.

## Studio One chain automation

The companion automation manifest lives at [../../studio/studio-one-automation.yaml](../../studio/studio-one-automation.yaml). Use it as the source of truth for reusable track presets, bus presets, and macro-style session setup.

| Preset name | Source doc | Build order |
|---|---|---|
| G6 Rhythm Guitar | [../../sound/guitar/README.md](../../sound/guitar/README.md) | G6 patch → mono DAW track → clip gain → HPF → subtractive EQ → light comp → optional saturation → guitar bus |
| G6 Lead Guitar | [../../sound/guitar/README.md](../../sound/guitar/README.md) | Same base chain as rhythm, with a little more sustain/cut and delay/reverb sends |
| SM7B Vocal Chain | [../../sound/vocals/chain.md](../../sound/vocals/chain.md) | HPF → subtractive EQ → fast comp → slow comp → de-esser → additive EQ → gentle saturation → sends |
| Suno Bass Stem | [../../sound/bass/chain.md](../../sound/bass/chain.md) | Trim gain → HPF → subtractive EQ → light comp → optional saturation → additive EQ → bass bus |
| Drum Multi-Out Bus | [../../sound/drums/README.md](../../sound/drums/README.md) | BFD3 outs → individual drum processing → drum bus |
| Mix Bus | [../../sound/mix-bus/chain.md](../../sound/mix-bus/chain.md) | Subtractive EQ → glue comp → gentle saturation → additive EQ → limiter |

### Reuse rule

1. Build the chain once in a template song.
2. Save the insert chain as a Studio One track preset or FX chain preset.
3. Mirror the manifest entries in [../../studio/studio-one-automation.yaml](../../studio/studio-one-automation.yaml).
4. Only change song-specific EQ, gain, and send levels after the template is loaded.

## Workflow

1. Duplicate this folder.
2. Open the prepared .song template in Fender Studio Pro and "Save As" into the new folder.
3. This is the practical auto-load step: the template should already contain the track and bus chains from [../../studio/studio-one-automation.yaml](../../studio/studio-one-automation.yaml).
4. Import the rough/reference track to the reference slot.
5. Track, mix, master per the chains in [../../sound/](../../sound/).
6. Bounce a -12.2 LUFS / -3.5 dBTP master.
7. Run [../../analysis/](../../analysis/) tasks on the master and confirm against [../../sound/reference-tracks.md](../../sound/reference-tracks.md).

## Notes for this song (replace per copy)

(none — this is the template)
