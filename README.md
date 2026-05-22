# Fat Man Studio Ops

Engineering repo for the **Fat Man** band sound. Everything here exists to deliver records, videos, and streams that match the sonic target in [sound/reference-tracks.md](sound/reference-tracks.md).

Scope: guitar tone, drum tone, vocal chain, mix bus, master, session templates, studio inventory, OBS streaming setup.
Not in scope: visual branding, press kit, social media, release art — those live in the separate `fat-man-brand` repo.

## Tonal Target (the measuring stick)

All output is judged against [sound/reference-tracks.md](sound/reference-tracks.md). Numbers, not vibes.

- Integrated loudness: **-12.2 ±0.3 LUFS-I**
- True peak ceiling: **-3.5 to -4.0 dBTP**
- LRA: **≤ 5.5 LU**
- Spectral centroid: **4.2–5.8 kHz**

## Repo Map

| Folder | Purpose |
|---|---|
| [studio/](studio/) | Hardware inventory, signal flow, maintenance log. |
| [sound/](sound/) | Tonal target spec + per-instrument chain designs (guitar, drums, bass, vocals, mix bus). |
| [patches/](patches/) | Zoom G6 patch recipes (Markdown/YAML, no .zptc binaries). |
| [sessions/](sessions/) | Per-song DAW project notes + reusable session template. |
| [reference/](reference/) | Authoritative gear references (G6 FX catalog, etc.). |
| [analysis/](analysis/) | FFmpeg / SoX analysis artifacts per audio file. |
| [samples/](samples/) | Source audio: DIs, stems, reference mixes. |
| [obs/](obs/) | OBS scene collections, profiles, streaming/recording configs. |

## Workflow

1. Drop new source audio into `samples/`.
2. Run the analysis tasks (VS Code task: `Analyze: All`).
3. For G6 patches: use the **Patch Engineer** chat mode and the `new-patch` / `iterate-patch` / `validate-patch` prompts.
4. Every artifact gets checked against [sound/reference-tracks.md](sound/reference-tracks.md) before it's called done.

## Hard Rules

- **Source of truth for G6 effects:** [reference/g6-fx-catalog.yaml](reference/g6-fx-catalog.yaml). Never invent effect names or parameter ranges.
- **No `.zptc` binary editing.** Patch recipes are Markdown only; transcribe into the G6 by hand.
- **No objective similarity scoring.** A/B by ear, log each iteration.
- **Cite everything.** Catalog page + raw range for every G6 parameter. Measured value + tolerance for every mix target.
