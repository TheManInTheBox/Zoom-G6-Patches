# Patch Recipe - Original "Drop-C Krampus Aggressive"

> **Source sample:** `samples/_reference/fat-man/orbit-of-you.wav` (optional reference only)
> **Analysis artifacts:** `analysis/orbit-of-you/` (optional)
> **Reference song / target:** original
> **Author / date:** GitHub Copilot / 2026-05-25
> **Status:** iterating

## 1. Target Tone Summary
Fresh, very aggressive Drop-C high-gain rhythm tone built around KRAMPUS. Priorities are violent palm-mute punch, fast stop/start gating, hard upper-mid cut, and controlled sub/low-mid bloom so the tone stays massive without turning to mud.

## 2. Analysis Snapshot
- This is a fresh design pass and does not depend on matching one specific record.
- Optional full-mix references in this repo suggest dense low-mid energy and strong 2-5 kHz occupancy.
- Patch design choice: tighten low end before gain, push attack in the drive stage, and keep a short room tail only.

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
| DETCT | GTRIN | GTRIN, EFXIN | Fastest, most consistent gating from raw input. |
| Depth | 72 | 0 - 100 | Hard clamp for high-gain idle noise. |
| THRSH | 44 | 0 - 100 | Aggressive threshold for tight chug stops. |
| Decay | 30 | 0 - 100 | Quick release for percussive rhythm work. |

### Slot 2 - ParaEQ
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| FREQ | 300 | 20 - 20k | Cuts low-mid mud before distortion multiplies it. |
| Q | 1.8 | 0.5 - 16 | Focused cut for tighter low-string articulation. |
| Gain | -6 | -12 - 12 | Strong cleanup for aggressive gain stacking. |
| VOL | 100 | 0 - 100 | Maintains level through EQ stage. |

### Slot 3 - BG GRID
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| Gain | 30 | 0 - 100 | Adds extra grind and forward attack. |
| Tone | 60 | 0 - 100 | Sharpens pick edge and cut. |
| BAL | 100 | 0 - 100 | Full overdrive path for maximum front-end shaping. |
| VOL | 75 | 0 - 100 | Hits amp front end hard for aggressive response. |

### Slot 4 - KRAMPUS
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| GAIN | 68 | 0 - 100 | Very high saturation for modern heavy rhythm. |
| BASS | 39 | 0 - 100 | Keeps weight while avoiding low-end bloom. |
| MIDDLE | 46 | 0 - 100 | Slight mid pull for heavier contour. |
| TREBLE | 58 | 0 - 100 | Aggressive bite and cut through dense mixes. |
| PRESENCE | 54 | 0 - 100 | Extra top-edge for attack and grind. |
| VOLUME | 78 | 0 - 100 | Strong output into cab stage. |

### Slot 5 - KP4x12
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| MIC | ON | OFF, ON | Full speaker/mic contour for direct output tone. |
| D57:D421 | 30 | 0 - 100 | SM57-leaning blend for sharper mids and bite. |
| Hi | 50 | 0 - 100 | Keeps aggression up without maxed fizz. |
| Lo | 42 | 0 - 100 | Holds low-end chunk under control. |

### Slot 6 - Room
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| PreD | 8 | 1 - 100 | Keeps dry attack leading the sound. |
| Decay | 7 | 1 - 30 | Very short ambiance to avoid smear. |
| Mix | 8 | 0 - 100 | Barely-there space; tone stays upfront and hostile. |
| Tail | ON | OFF, ON | Natural trail on hard stops and phrase endings. |

## 5. Chain Order Justification
Standard order is used with intent: gate first to enforce stop/start precision, EQ before gain to remove mud at the source, drive into KRAMPUS for attack and aggression, then KP4x12 to shape the final speaker contour. Reverb is minimal and last.

## 6. Expected Sonic Impact
- NoiseGate: brutally tight muting and clean pauses.
- ParaEQ: less low-mid blur under heavy saturation.
- BG GRID: sharper transient response and tighter chug attack.
- KRAMPUS: dominant aggressive voice with bright modern grind.
- KP4x12: focused speaker character with strong upper-mid cut.
- Room: just enough air to avoid sterile dryness.

## 7. A/B Iteration Log
| # | Date | User feedback | Param deltas applied | Result |
|---|------|---------------|----------------------|--------|
| 1 | 2026-05-25 | no constraints; i want fresh | New standalone patch created from scratch around KRAMPUS for very aggressive Drop C. | Ready for first hardware A/B. |

## 8. Finalization Checklist
- [x] Every effect exists verbatim in `reference/g6-fx-catalog.yaml`
- [x] Every parameter value is within catalog range
- [x] Chain length <= G6 hard limit
- [x] Category order follows section 3 (no deviation)
- [ ] User has A/B'd against a target and approved