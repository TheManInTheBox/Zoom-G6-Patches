# Studio Inventory

Single source of truth for hardware + software in the Fat Man studio. Update when anything changes.

## DAW

| Item | Detail | Source naming |
|---|---|---|
| **Fender Studio Pro** | Model #S778400601, perpetual license | Rebrand of PreSonus Studio One Pro 8 (Fender acquired PreSonus). Drivers/tutorials may still use PreSonus naming. |
| Project format | `.song` | — |

## Audio Interface

| Item | Detail | Source naming |
|---|---|---|
| **Quantum HD 8** | USB-C, 8-channel | Chassis label reads "Quantum HD 8" (PreSonus naming; Fender bundle marketing uses "Fender Studio Quantum HD 8"). |
| Loopback | Supported via UC Surface routing | Used to route DAW master into OBS — see [signal-flow.md](signal-flow.md). |

## Guitar

| Item | Detail |
|---|---|
| **Gibson Les Paul Studio Modern** | 24.75" scale, modern weight-relieved body |
| Pickups | **498T** (bridge, ceramic, hot/bright) + **490R** (neck, alnico II, warmer) |
| Strings | **D'Addario EXL148** (12–60, Extra Heavy nickel-wound) |
| Tuning | **Drop C** (C-G-C-F-A-D) |
| Tension note | ~14.5 lbs on low C with 60ga. Slack side of optimal. Alternatives: 12-62 or 13-65 for tighter response. Not blocking. |
| Pickup voicing note | 498T is one of Gibson's hotter, brighter bridge humbuckers. G6 patches should NOT need extra HF drive — expect to tame 2.5–4 kHz on the patch if the bridge sounds harsh. |

## Guitar Processor

| Item | Detail |
|---|---|
| **Zoom G6** | Floor multi-FX. Up to 9 effect slots (DSP-budget limited). Patch recipes in [../patches/](../patches/). |
| FX catalog | [../reference/g6-fx-catalog.yaml](../reference/g6-fx-catalog.yaml) — source of truth. |

## Bass

| Item | Detail |
|---|---|
| **Source** | **Suno AI–generated** rendered bass stems |
| Implication | No physical bass, no DI. Bass arrives as a pre-mixed/pre-compressed stereo (or mono) stem. Processing strategy lives in [../sound/bass/chain.md](../sound/bass/chain.md). |

## Drums

| Item | Detail |
|---|---|
| **BFD3** | inMusic, in maintenance mode (no active development but still supported). VST + standalone. |
| Expansions installed | **BFD Crush** (heavy/compressed kits — *primary for Fat Man*), **BFD Metal Snares** (snare top candidate), **BFD Dark Farm** (alt heavy kit), **BFD 8 Bit Kit** (lo-fi flavor, FX use), **BFD Swan Percussion** (orchestral percussion, FX use). |
| Kits | See [../sound/drums/](../sound/drums/). Default kit build in [../sound/drums/bfd3-kits/fat-man-core.md](../sound/drums/bfd3-kits/fat-man-core.md). |

## Vocals

| Item | Detail | Role |
|---|---|---|
| **Phenyx Pro PDM35** | XLR cardioid dynamic, broadcast-style, budget tier (~$40) | **Primary — recorded vocals on Fat Man tracks.** Routes through Quantum HD preamp into Studio Pro. |
| **Shure SM7B Dynamic Studio Microphone** | XLR cardioid dynamic, industry-standard broadcast/studio vocal mic | **Available — pro vocal tracking option for Fat Man sessions.** Use Quantum HD preamp gain accordingly. |
| **HyperX QuadCast** | USB condenser, 4 polar patterns, 16-bit/48k, built-in pop filter + shock mount | **Secondary — OBS stream/commentary voice only.** Connects directly to PC USB, picked up as a separate audio source in OBS. Not used for music recording (USB single-device ASIO limitation; bypasses Quantum HD chain). |
| Preamp | Quantum HD 8 onboard preamp (for PDM35); QuadCast has internal preamp | Need to drive PDM35 gain high — dynamic mics are quiet; expect 45–60 dB of preamp gain. |
| Honest assessment | PDM35 is workable for demos and streams. For pro-tier vocal clarity on releases against this dense mix target, the PDM35 is the most likely upgrade item (candidates: Shure SM7B, ElectroVoice RE20, sE Electronics V7X). | — |

## Streaming / Video

| Item | Detail |
|---|---|
| **OBS Studio** | Streaming + local recording. Scene collections + profiles in [../obs/](../obs/). |

## Computer / OS

**TODO** — list machine + OS + key versions (Windows build, audio drivers, plugin format support).

## Update Log

- 2026-05-20 — Initial inventory.
- 2026-05-20 — Filled in: Quantum HD 8 confirmation, LP pickups (498T+490R), Suno bass source, PDM35 vocal mic, BFD3 expansion list. Computer specs still TODO.
- 2026-05-22 — Added Shure SM7B Dynamic Studio Microphone (XLR) to vocals inventory.
