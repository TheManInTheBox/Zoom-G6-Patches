# Patch Recipe — Suno "Abyssal Riff" Drop-A# Rhythm

> **Source sample:** `samples/_reference/fat-man/abyssal-riff.wav`
> **Analysis artifacts:** `analysis/abyssal-riff/`
> **Reference song / target:** Suno — "Abyssal Riff" (user-confirmed Drop A#)
> **Author / date:** GitHub Copilot (Patch Engineer mode) / 2026-05-21
> **Status:** draft

## 1. Target Tone Summary
Tight, modern high-gain rhythm tone for **Drop A#** riffing with controlled sub-lows, hard pick attack, and clear upper-mid bite that still avoids brittle fizz. The goal is aggressive low-string punch around A#1 while keeping palm mutes percussive and avoiding muddy collapse in the 100-250 Hz band. Current pass is compensated for a Gibson middle toggle position (neck + bridge in parallel), targeting a balanced, open Les Paul combined-pickup voice.

## 2. Analysis Snapshot
Objective facts from `analysis/abyssal-riff/`:

- **Duration / format:** 222.72 s (3:42.72), 48 kHz stereo WAV.
- **Loudness (EBU R128):** Integrated **-12.2 LUFS** (`loudness.txt` summary).
- **Loudness range:** **LRA 3.5 LU** (`loudness.txt` summary).
- **True peak / sample peak:** **-3.7 dBFS** (`loudness.txt` summary).
- **SoX RMS amplitude:** **0.204486** (dense modern level profile).
- **SoX max/min amplitude:** +0.651733 / -0.650085.
- **DC offset (midline amplitude):** +0.000824 (negligible).
- **Rough frequency (SoX):** 5815 Hz (full-mix centroid, not isolated-guitar centroid).
- **Spectral behavior (from spectrogram):** broad low-end energy and dense upper-band content typical of a full mix. For patching, this means tight low-cut behavior and controlled presence are more important than boosting highs.

## 3. Proposed Chain
Order: DYNAMICS -> FILTER -> DRIVE -> AMP -> CABINET -> MODULATION -> SFX -> DELAY -> REVERB -> PEDAL -> SND-RTN -> IR

(Standard category order is preserved; FILTER/MODULATION/SFX/DELAY/PEDAL/SND-RTN/IR are intentionally unused in this first pass.)

| Slot | Category | Effect (from catalog) | Catalog cite |
|------|----------|-----------------------|--------------|
| 1 | DYNAMICS | NoiseGate | `reference/g6-fx-catalog.yaml` DYNAMICS p.3 |
| 2 | DRIVE | BG GRID | `reference/g6-fx-catalog.yaml` DRIVE p.8 |
| 3 | AMP | DZ DRV | `reference/g6-fx-catalog.yaml` AMP p.12 |
| 4 | CABINET | RCT4x12 | `reference/g6-fx-catalog.yaml` CABINET p.16 |
| 5 | REVERB | Room | `reference/g6-fx-catalog.yaml` REVERB p.25 |

## 4. Parameters
All values are within catalog-defined `raw` ranges from `reference/g6-fx-catalog.yaml`.

### Slot 1 — NoiseGate
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| DETCT | GTRIN | GTRIN, EFXIN | Input detection keeps gating tied to picking dynamics. |
| Depth | 68 | 0 - 100 | Drop A# needs firmer low-string cleanup than Drop C; this is intentionally tighter. |
| THRSH | 42 | 0 - 100 | Stops low-tuned idle rumble while still opening for normal picking. |
| Decay | 38 | 0 - 100 | Short-to-medium release to avoid gate chatter while preserving chug definition. |

### Slot 2 — BG GRID
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| Gain | 18 | 0 - 100 | Keep pedal gain low; use it as a tightener, not main distortion source. |
| Tone | 50 | 0 - 100 | Middle position is more balanced than bridge-only; a small tone restore keeps attack definition. |
| BAL | 100 | 0 - 100 | Full effect path for consistent preamp tightening. |
| VOL | 67 | 0 - 100 | Drives amp front-end enough to sharpen attack on low-string riffs. |

### Slot 3 — DZ DRV
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| GAIN | 58 | 0 - 100 | High-gain rhythm saturation with attack still intact. |
| BASS | 43 | 0 - 100 | Pulls back some low buildup now that neck pickup is blended in parallel. |
| MIDDLE | 53 | 0 - 100 | Keeps center note body while preserving the open character of middle position. |
| TREBLE | 46 | 0 - 100 | Restores edge lost in the bridge-only compensation pass. |
| PRESENCE | 40 | 0 - 100 | Slight high-air return for articulation without reintroducing fizz. |
| VOLUME | 70 | 0 - 100 | Output gain staging target for A/B level matching. |
| DEEP | 44 | 0 - 100 | Re-centers low-end weight for neck+bridge blend to avoid sub bloom. |
| MID CUT | 30 | 0 - 100 | Slightly less scoop keeps the parallel-pickup tone full and balanced. |

### Slot 4 — RCT4x12
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| MIC | ON | OFF, ON | Required for direct/monitor use; avoids raw amp buzzsaw output. |
| D57:D421 | 45 | 0 - 100 | Small shift back toward articulation while keeping body in the blend. |
| Hi | 44 | 0 - 100 | Adds controlled bite to match middle-position openness. |
| Lo | 44 | 0 - 100 | Tightens lows to counter neck-side low-mid contribution. |

### Slot 5 — Room
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| PreD | 12 | 1 - 100 | Keeps initial pick attack forward and dry. |
| Decay | 10 | 1 - 30 | Short room tail to add space without smearing rhythm articulation. |
| Mix | 14 | 0 - 100 | Subtle depth only; rhythm focus stays dry and punchy. |
| Tail | ON | OFF, ON | Natural note/reverb release for better phrase continuity. |

## 5. Chain Order Justification
The chain follows standard category order without deviation. FILTER is omitted in the first pass to keep gain staging simple and avoid over-correcting a source that appears to be full-mix audio, not isolated DI. If first A/B reveals specific harsh bands or boom, add `ParaEQ` (FILTER p.5) in slot 2 and re-balance BG GRID/DZ DRV accordingly.

## 6. Expected Sonic Impact
- **NoiseGate:** tightens idle low-string noise and cleans chug gaps at Drop A# tension.
- **BG GRID:** sharpens attack and reduces preamp flub before the amp stage.
- **DZ DRV:** main modern high-gain body with separate DEEP/MID CUT control for low-tuned shaping.
- **RCT4x12:** V30-style cabinet contour for focused mids and controlled low/high extremes.
- **Room:** adds minimal spatial depth so the tone does not feel sterile while staying rhythm-forward.

## 7. A/B Iteration Log
| # | Date | User feedback | Param deltas applied | Result |
|---|------|---------------|----------------------|--------|
| 1 | 2026-05-21 | Initial draft for Drop A# | n/a | Pending first user A/B |
| 2 | 2026-05-22 | Gibson toggle switch is in low position (bridge pickup) | BG GRID Tone 52->47; DZ DRV BASS 42->45; DZ DRV MIDDLE 52->55; DZ DRV TREBLE 48->44; DZ DRV PRESENCE 43->38; DZ DRV DEEP 44->46; RCT4x12 D57:D421 42->48; RCT4x12 Hi 47->42; RCT4x12 Lo 43->46 | Applied bridge-pickup compensation pass; awaiting user ear check |
| 3 | 2026-05-22 | i'm wrong, the toggle is in mid Middle = Neck + Bridge (parallel) Balanced, open, classic Les Paul "both pickups" sound. | BG GRID Tone 47->50; DZ DRV BASS 45->43; DZ DRV MIDDLE 55->53; DZ DRV TREBLE 44->46; DZ DRV PRESENCE 38->40; DZ DRV DEEP 46->44; DZ DRV MID CUT 33->30; RCT4x12 D57:D421 48->45; RCT4x12 Hi 42->44; RCT4x12 Lo 46->44 | Applied middle-position rebalance for neck+bridge parallel response; awaiting user ear check |

## 8. Finalization Checklist
- [x] Every effect exists verbatim in `reference/g6-fx-catalog.yaml`
- [x] Every parameter value is within catalog range
- [x] Chain length <= G6 hard limit (5 slots)
- [x] Category order follows standard flow (no deviation)
- [ ] User has A/B'd against the source sample and approved
- [ ] At least one post-feedback iteration logged with exact deltas
