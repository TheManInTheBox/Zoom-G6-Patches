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

## Workflow

1. Duplicate this folder.
2. Open the .song template in Fender Studio Pro and "Save As" into the new folder.
3. Import the rough/reference track to the reference slot.
4. Track, mix, master per the chains in [../../sound/](../../sound/).
5. Bounce a -12.2 LUFS / -3.5 dBTP master.
6. Run [../../analysis/](../../analysis/) tasks on the master and confirm against [../../sound/reference-tracks.md](../../sound/reference-tracks.md).

## Notes for this song (replace per copy)

(none — this is the template)
