# Patch Recipe - Fat Man "Orbit of You" Drop-C Krampus Aggressive

> **Source sample:** `samples/_reference/fat-man/orbit-of-you.wav` (full-mix reference, not isolated DI)
> **Analysis artifacts:** `analysis/orbit-of-you/`
> **Reference song / target:** Fat Man - "Orbit of You" (aggressive Drop-C variant)
> **Author / date:** GitHub Copilot / 2026-05-25
> **Status:** iterating

## 1. Target Tone Summary
Very aggressive Drop-C rhythm tone centered on KRAMPUS: hard pick attack, fast gate recovery, tight low-end control, pushed upper-mid bite, and enough saturation to keep single-note runs mean without turning palm-mutes into low-end blur.

## 2. Analysis Snapshot
- Duration / format: 235 s, 48 kHz stereo, 16-bit PCM.
- Loudness (EBU R128): Integrated -12.3 LUFS, LRA 5.2 LU, true peak -3.6 dBTP.
- SoX stats: RMS amplitude 0.2014, rough frequency 4243 Hz, crest factor about 10 dB.
- Spectral notes: dense low-mid body in the full mix and strong 2-5 kHz presence; patch needs tight low-end and controlled fizz so guitars stay violent but intelligible.

## 3. Proposed Chain
Order: DYNAMICS -> FILTER -> DRIVE -> AMP -> CABINET -> MODULATION -> SFX -> DELAY -> REVERB -> PEDAL -> SND-RTN -> IR

| Slot | Category | Effect (from catalog) | Catalog cite |
|------|----------|-----------------------|--------------|
| 1 | DYNAMICS | NoiseGate | `reference/g6-fx-catalog.yaml` DYNAMICS p.3 |
| 2 | FILTER | ParaEQ | `reference/g6-fx-catalog.yaml` FILTER p.5 |
| 3 | DRIVE | BG GRID | `reference/g6-fx-catalog.yaml` DRIVE p.8 |
| 4 | AMP | KRAMPUS | `reference/g6-fx-catalog.yaml` AMP p.13 |
| 5 | CABINET | KP4x12 | `reference/g6-fx-catalog.yaml` CABINET p.17 |
| 6 | REVERB | Room | `reference/g6-fx-catalog.yaml` REVERB p.25 |

## 4. Parameters

### Slot 1 - NoiseGate
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| DETCT | GTRIN | GTRIN, EFXIN | Tracks input directly for faster and cleaner gate behavior. |
| Depth | 68 | 0 - 100 | Aggressive clamp to kill idle low-string noise in Drop C. |
| THRSH | 42 | 0 - 100 | Opens on real pick attack, stays shut on buzz and ring bleed. |
| Decay | 34 | 0 - 100 | Fast release to keep chugs sharp and percussive. |

### Slot 2 - ParaEQ
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| FREQ | 280 | 20 - 20k | Targets mud zone before gain multiplication. |
| Q | 1.6 | 0.5 - 16 | Focused enough to clean low-mid cloud without hollowing tone. |
| Gain | -5 | -12 - 12 | Pulls congestion out so high gain stays clear at high volume. |
| VOL | 100 | 0 - 100 | Maintains stage level while reshaping frequency balance. |

### Slot 3 - BG GRID
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| Gain | 28 | 0 - 100 | Adds front-end aggression without fuzzy pedal-overload. |
| Tone | 58 | 0 - 100 | Pushes attack articulation and upper-mid edge. |
| BAL | 100 | 0 - 100 | Full overdrive feed for consistent preamp tightening. |
| VOL | 72 | 0 - 100 | Slams amp input for violent transient response. |

### Slot 4 - KRAMPUS
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| GAIN | 64 | 0 - 100 | High saturation for modern aggressive rhythm voice. |
| BASS | 40 | 0 - 100 | Keeps low-end authority without flub in Drop C. |
| MIDDLE | 48 | 0 - 100 | Slightly pulled mids for heavier grind while retaining note identity. |
| TREBLE | 56 | 0 - 100 | Adds bite and cut through dense drums/cymbals. |
| PRESENCE | 52 | 0 - 100 | Extra attack edge; tuned for aggression, not smoothness. |
| VOLUME | 76 | 0 - 100 | Strong output drive into cabinet/reverb stages. |

### Slot 5 - KP4x12
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| MIC | ON | OFF, ON | Required for direct monitoring and full cab-sim behavior. |
| D57:D421 | 34 | 0 - 100 | More SM57 bite for sharper pick definition and grind. |
| Hi | 48 | 0 - 100 | Retains aggression while avoiding top-end tearing. |
| Lo | 43 | 0 - 100 | Keeps chunk and punch with controlled boom. |

### Slot 6 - Room
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| PreD | 10 | 1 - 100 | Keeps dry hit in front, reverb behind it. |
| Decay | 8 | 1 - 30 | Very short tail so rhythm stays dry and brutal. |
| Mix | 10 | 0 - 100 | Minimal space, no wash. |
| Tail | ON | OFF, ON | Natural ring-out when stopping phrases. |

## 5. Chain Order Justification
Standard order is followed exactly so each stage has one clear job: gate first for noise control, EQ before gain for low-mid cleanup, drive into amp for aggression, cabinet for speaker contour, and only a short room at the end so tone stays forward.

## 6. Expected Sonic Impact
- NoiseGate: hard stop-start behavior for tight chugs.
- ParaEQ: less low-mid smear under high gain.
- BG GRID: sharper pick transient and tighter amp response.
- KRAMPUS: core aggressive high-gain character with bright, cutting attack.
- KP4x12: focused cabinet grind with controlled boom/fizz balance.
- Room: slight depth without softening the riff edge.

## 7. A/B Iteration Log
| # | Date | User feedback | Param deltas applied | Result |
|---|------|---------------|----------------------|--------|
| 1 | 2026-05-25 | i want a very aggressive Drop C model using Krampus AMP | New aggressive variant created: NoiseGate Depth 68 THRSH 42 Decay 34; ParaEQ 280 Hz Q 1.6 Gain -5; BG GRID Gain 28 Tone 58 VOL 72; KRAMPUS GAIN 64 BASS 40 MIDDLE 48 TREBLE 56 PRESENCE 52 VOLUME 76; KP4x12 D57:D421 34 Hi 48 Lo 43 | Ready for hardware A/B at gig volume. |

## 8. Finalization Checklist
- [x] Every effect exists verbatim in `reference/g6-fx-catalog.yaml`
- [x] Every parameter value is within catalog range
- [x] Chain length <= G6 hard limit
- [x] Category order follows section 3 (no deviation)
- [ ] User has A/B'd against the source sample and approved