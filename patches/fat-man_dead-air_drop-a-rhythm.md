# Patch Recipe — Fat Man "Dead Air" Drop-A Rhythm

> **Source sample:** `samples/_reference/fat-man/Dead-Air.wav` (full-mix reference, not isolated DI)
> **Analysis artifacts:** `analysis/dead-air/`
> **Reference song / target:** Fat Man — "Dead Air"
> **Author / date:** GitHub Copilot / 2026-05-23
> **Status:** iterating

## 1. Target Tone Summary
Drop-A modern metal rhythm tone with tight palm-mute response, controlled sub/bass bloom, focused upper-mid bite, and restrained fizz. The goal is heavy and percussive, with enough note separation for low-tuned riff movement without turning into flat noise in a dense full mix.

Current iteration target is **Les Paul middle position (both pickups on)**, which typically has lower output than bridge-only and more low-mid body. This pass tightens low-mid buildup and slightly smooths top-end while keeping chug definition.

## 2. Analysis Snapshot
- Duration / format: 175.24 s, 48 kHz, stereo, 16-bit PCM.
- Loudness (EBU R128): Integrated **-14.2 LUFS**, LRA **3.4 LU**.
- Peaks: channel peaks around **-3.4 / -3.3 dBFS**.
- SoX stats: RMS amplitude **0.144941**, max amplitude **0.630127**, min amplitude **-0.677948**, max delta **0.731964**.
- Spectral center proxy: rough frequency **4223 Hz** (full-mix centroid).
- Spectrogram (`analysis/dead-air/spectrogram.png`): dense low-mid energy through most of the track, strong upper-mid occupancy, frequent vertical transient stripes, and repeated arrangement dropouts/breaks.
- Interpretation for patching: because this is a loud full mix with compact LRA, the guitar patch should prioritize transient definition and low-end control over extra gain.

## 3. Proposed Chain
Order: DYNAMICS → FILTER → DRIVE → AMP → CABINET → MODULATION → SFX → DELAY → REVERB → PEDAL → SND-RTN → IR

| Slot | Category | Effect (from catalog) | Catalog cite |
|------|----------|-----------------------|--------------|
| 1 | DYNAMICS | NoiseGate | `reference/E_G6_FX-list_2.txt` p.3 |
| 2 | FILTER | ParaEQ | `reference/E_G6_FX-list_2.txt` p.5 |
| 3 | DRIVE | BG GRID | `reference/E_G6_FX-list_2.txt` p.8 |
| 4 | AMP | KRAMPUS | `reference/E_G6_FX-list_2.txt` p.13 |
| 5 | CABINET | KP4x12 | `reference/E_G6_FX-list_2.txt` p.17 |
| 6 | REVERB | Room | `reference/E_G6_FX-list_2.txt` p.25 |

## 4. Parameters

### Slot 1 — NoiseGate
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| DETCT | GTRIN | GTRIN, EFXIN | Gate tracks raw guitar input for tighter muting behavior. |
| Depth | 62 | 0 – 100 | Strong clamp for Drop A low-string noise between chugs. |
| THRSH | 36 | 0 – 100 | Lower threshold to accommodate lower output in both-pickups mode without choking sustain. |
| Decay | 44 | 0 – 100 | Slightly slower release to keep note tails natural in middle position. |

### Slot 2 — ParaEQ
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| FREQ | 300 | 20 – 20k | Targets the extra low-mid cloud that both-pickups mode can introduce. |
| Q | 1.4 | 0.5 – 16 | Slightly tighter cut around the mud center. |
| Gain | -4 | -12 – 12 | Deeper cleanup for middle-position thickness. |
| VOL | 100 | 0 – 100 | Unity behavior for this stage; no intentional level loss. |

### Slot 3 — BG GRID
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| Gain | 24 | 0 – 100 | Slightly more push to recover attack with lower middle-position output. |
| Tone | 50 | 0 – 100 | Keeps articulation while reducing brittle edge. |
| BAL | 100 | 0 – 100 | Full overdrive path to shape amp input consistently. |
| VOL | 68 | 0 – 100 | Pushes amp input for attack and clamp. |

### Slot 4 — KRAMPUS
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| GAIN | 52 | 0 – 100 | Keeps aggression while avoiding low-string smear in Drop A. |
| BASS | 34 | 0 – 100 | Prevents low-end bloom with both-pickups mode. |
| MIDDLE | 54 | 0 – 100 | Pushes note definition so riff movement stays audible in full mix. |
| TREBLE | 47 | 0 – 100 | Retains bite without the brittle top edge. |
| PRESENCE | 38 | 0 – 100 | Tames super-high fizz from high-gain bright voicing. |
| VOLUME | 72 | 0 – 100 | Practical amp output level for downstream cab/reverb stages. |

### Slot 5 — KP4x12
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| MIC | ON | OFF, ON | Required for direct/monitor-friendly cabsim response. |
| D57:D421 | 40 | 0 – 100 | Balanced 57/421 blend: enough cut from 57, enough body from 421. |
| Hi | 42 | 0 – 100 | Controls upper fizz while keeping articulation. |
| Lo | 37 | 0 – 100 | Tightens low-end thump for Drop-A chugs. |

### Slot 6 — Room
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| PreD | 12 | 1 – 100 | Keeps dry attack forward before room bloom. |
| Decay | 9 | 1 – 30 | Short tail to avoid rhythmic smear. |
| Mix | 14 | 0 – 100 | Subtle depth only; rhythm tone stays upfront. |
| Tail | ON | OFF, ON | Natural tail behavior when phrases stop. |

## 5. Chain Order Justification
This follows the standard category order exactly. Gate first controls input noise, then pre-distortion EQ trims mud before gain multiplication, then drive boosts attack into the amp, cabinet shapes speaker response, and room reverb is last to add space without changing distortion behavior.

## 6. Expected Sonic Impact
- NoiseGate: cleaner starts/stops for low-tuned chugs.
- ParaEQ: reduced low-mid congestion in dense riff sections.
- BG GRID: tighter pick attack and better palm-mute definition.
- KRAMPUS: tighter modern low range with brighter upper bite for Drop-A rhythm clarity.
- KP4x12: matching KRAMPUS cabinet contour with controlled fizz and low-end focus.
- Room: slight depth so the tone is not completely dry/flat.

## 7. A/B Iteration Log
| # | Date | User feedback | Param deltas applied | Result |
|---|------|---------------|----------------------|--------|
| 1 | 2026-05-23 | Initial draft from Dead-Air.wav analysis for Drop A. | N/A (first draft) | Awaiting user A/B on hardware. |
| 2 | 2026-05-23 | using both pickups | NoiseGate THRSH 42->36; NoiseGate Decay 38->44; ParaEQ FREQ 250->300; ParaEQ Q 1.2->1.4; ParaEQ Gain -3->-4; BG GRID Gain 22->24; BG GRID Tone 53->50; POLLEX GAIN 56->54; POLLEX BASS 40->37; POLLEX MIDDLE 46->50; POLLEX TREBLE 52->49; POLLEX PRESENCE 44->40; RCT4x12 Hi 47->45; RCT4x12 Lo 43->40 | Pending user A/B on Les Paul middle position. |
| 3 | 2026-05-25 | re-evaluate patch using KRAMPUS for Drop A tuning | AMP POLLEX->KRAMPUS; CAB RCT4x12->KP4x12; KRAMPUS GAIN 54->52; KRAMPUS BASS 37->34; KRAMPUS MIDDLE 50->54; KRAMPUS TREBLE 49->47; KRAMPUS PRESENCE 40->38; KP4x12 D57:D421 42->40; KP4x12 Hi 45->42; KP4x12 Lo 40->37 | Ready for user A/B against Dead Air reference in full mix. |

## 8. Finalization Checklist
- [x] Every effect exists verbatim in `reference/E_G6_FX-list_2.txt`
- [x] Every parameter value is within catalog range
- [x] Chain length ≤ G6 hard limit
- [x] Category order follows §3 (or §5 justifies deviation)
- [ ] User has A/B'd against the source sample and approved