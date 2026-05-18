# Patch Recipe — <Tone Name>

> **Source sample:** `samples/<file>.wav`
> **Analysis artifacts:** `analysis/<basename>/`
> **Reference song / target:** <artist — track @ timestamp, or "original">
> **Author / date:** <you> / <YYYY-MM-DD>
> **Status:** draft | iterating | finalized

## 1. Target Tone Summary
One paragraph describing the sonic goal in plain words (e.g., "tight modern high-gain rhythm, scooped mids, fast attack, short room tail").

## 2. Analysis Snapshot
Bullet the objective facts pulled from `analysis/<basename>/`:
- Peak / RMS / LUFS (from `loudness.txt`)
- Spectral centroid, crest factor, DC offset (from `sox-stat.txt`)
- Notable spectral features (from `spectrogram.png`)
- Pick attack character, sustain length, perceived gain stage

## 3. Proposed Chain
Order: DYNAMICS → FILTER → DRIVE → AMP → CABINET → MODULATION → SFX → DELAY → REVERB → PEDAL → SND-RTN → IR
(Deviate only with explicit justification in §5.)

| Slot | Category | Effect (from catalog) | Catalog cite |
|------|----------|-----------------------|--------------|
| 1    |          |                       | `reference/E_G6_FX-list_2.txt` p.X |
| 2    |          |                       |              |
| 3    |          |                       |              |
| 4    |          |                       |              |
| 5    |          |                       |              |
| 6    |          |                       |              |

## 4. Parameters
For each slot, list every parameter with the value AND the catalog-defined range.

### Slot 1 — <Effect>
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
|       |       |                 |           |

(repeat per slot)

## 5. Chain Order Justification
Why this order. If it breaks the standard category flow, explain exactly why and what sonic outcome it serves.

## 6. Expected Sonic Impact
Per effect, one sentence on what it contributes to the target tone.

## 7. A/B Iteration Log
| # | Date | User feedback | Param deltas applied | Result |
|---|------|---------------|----------------------|--------|
| 1 |      |               |                      |        |

## 8. Finalization Checklist
- [ ] Every effect exists verbatim in `reference/E_G6_FX-list_2.txt`
- [ ] Every parameter value is within catalog range
- [ ] Chain length ≤ G6 hard limit
- [ ] Category order follows §3 (or §5 justifies deviation)
- [ ] User has A/B'd against the source sample and approved
