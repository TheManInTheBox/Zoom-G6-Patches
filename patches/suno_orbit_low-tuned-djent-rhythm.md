# Patch Recipe — Orbit Low-Tuned Djent Rhythm

> **Source sample:** `samples/orbit.wav`
> **Analysis artifacts:** `analysis/orbit/`
> **Reference song / target:** Suno-generated track "Orbit" (id `b9f741cb-487f-4e11-9065-24b7f6575adf`, created 2026-05-16) — the perceived rhythm-guitar layer, which the Suno stem separator mislabeled as bass.
> **Author / date:** GitHub Copilot (Patch Engineer mode) / 2026-05-18
> **Status:** draft

> ## ⚠️ Source-quality disclaimer (read before A/B-ing)
> 1. `samples/orbit.wav` is **not** a dry guitar DI. It is a fully-processed, wet, AI-rendered stem (`comment: made with suno`). Cab, mics, master-bus compression and limiting are baked in.
> 2. The stem is labeled (Bass) but is actually a **6-string electric guitar tuned to drop C** (C-G-C-F-A-D, low string ≈ 65 Hz), mis-classified by Suno's source separation.
> 3. No clean DI exists, so this patch **cannot be objectively A/B'd** against the source. You can only:
>    - Record a dry DI of your own guitar through the G6 with this patch loaded, and
>    - Subjectively judge against `samples/orbit.wav` as a *target reference*.
> 4. Every chain choice below is a **best-guess inference** from the spectrogram + loudness + sox stats. Treat the values as starting points, not gospel. Iterate via `iterate-patch` and log in §7.

## 1. Target Tone Summary
Tight modern high-gain rhythm tone aimed at a **drop-C** tuned 6-string electric (low C2 ≈ 65 Hz). Modern metal / metalcore / Gojira-Lamb-of-God-Trivium territory rather than 7/8-string djent. Fast palm-mute attack, controlled (but not gutted) low end, scooped low-mids, V30-flavored upper-mid presence around 2–4 kHz, short ambient tail for spatial depth without smearing chug articulation. Modeled after a Mesa Recto-style stack with a TS-style mid-pusher in front and a noise gate to keep palm mutes clean.

## 2. Analysis Snapshot
Numbers pulled from `analysis/orbit/loudness.txt` and `analysis/orbit/sox-stat.txt`; spectral observations from `analysis/orbit/spectrogram.png`.

- **Duration / format:** 235 s (3:55), 48 kHz stereo, 16-bit PCM.
- **Loudness (EBU R128):** Integrated stabilizes around **−21 LUFS** after the intro silence; short-term hovers −20 to −24 LUFS during the loud section.
- **Loudness range (LRA):** Collapses from ~23 LU (intro transients) down to **~7 LU** in the dense section → bus is heavily compressed/limited.
- **True peak:** Clamped at **−9.5 dBFS** for long sustained runs → limiter on the master bus.
- **SoX stats:** RMS amplitude **0.1043** (~−19.6 dBFS), max **+0.520 / −0.535** (~−5.4 dBFS). Crest factor ≈ **14 dB** — squashed, consistent with a wet mix-bus render, not a raw DI.
- **DC offset:** Midline −0.0073 (~0.7 % DC) — small but non-zero, harmless for tone purposes.
- **Rough frequency (SoX):** **~3.4 kHz** — strong upper-mid energy centered where a SM57-on-V30 presence peak sits.
- **Spectrogram:** Broadband fundamentals extending down to ~65 Hz (consistent with drop-C low C2 — confirmed against user-supplied tuning), structured energy through 5–8 kHz, broadband content tapering past ~12 kHz, dense stereo image (separation bleed from other instruments visible — not a pure mono guitar).

## 3. Proposed Chain
Order: DYNAMICS → FILTER → DRIVE → AMP → CABINET → MODULATION → SFX → DELAY → REVERB → PEDAL → SND-RTN → IR
(Standard category order, no deviation. 5 slots used out of the G6's ~9 slot budget — leaves DSP headroom and avoids unnecessary tone-smearing blocks.)

| Slot | Category  | Effect (from catalog) | Catalog cite |
|------|-----------|-----------------------|--------------|
| 1    | DYNAMICS  | NoiseGate             | `reference/g6-fx-catalog.yaml` DYNAMICS p.3 |
| 2    | DRIVE     | BG GRID               | `reference/g6-fx-catalog.yaml` DRIVE p.8 |
| 3    | AMP       | POLLEX                | `reference/g6-fx-catalog.yaml` AMP p.14 |
| 4    | CABINET   | RCT4x12               | `reference/g6-fx-catalog.yaml` CABINET p.16 |
| 5    | REVERB    | Room                  | `reference/g6-fx-catalog.yaml` REVERB p.25 |

## 4. Parameters
All values are inside the catalog `raw:` range for the named effect. Ranges quoted verbatim from `reference/g6-fx-catalog.yaml`.

### Slot 1 — NoiseGate (DYNAMICS p.3)
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| DETCT | GTRIN | GTRIN, EFXIN    | Trigger from raw guitar input so the gate doesn't chase post-amp noise. |
| Depth | 70    | 0 – 100         | Hard cut between palm mutes; high-gain amps need an aggressive gate. Slightly less than drop-A territory since drop-C strings are tighter (less subsonic rumble). |
| THRSH | 35    | 0 – 100         | Opens cleanly for picked notes, stays shut on string buzz. Start mid-low and bump up if it chokes sustain. |
| Decay | 30    | 0 – 100         | Fast release to keep chug articulation tight. |

### Slot 2 — BG GRID (DRIVE p.8) — Mesa Grid Slammer
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| Gain  | 25    | 0 – 100         | Low — used as a tightener, not a primary distortion. Pushes mids and clamps low-end flub before the amp. |
| Tone  | 60    | 0 – 100         | Slight upper-mid lift to help pick attack cut through. |
| BAL   | 100   | 0 – 100         | Fully wet (effect-only) so the boost actually shapes the signal hitting the amp. |
| VOL   | 70    | 0 – 100         | Hot enough to drive POLLEX input without over-saturating. |

### Slot 3 — POLLEX (AMP p.14) — Djent / drop-tuning amp
| Param    | Value | Range (catalog) | Rationale |
|----------|-------|-----------------|-----------|
| GAIN     | 70    | 0 – 100         | High but not maxed — POLLEX gets fizzy past ~80 with low tunings. |
| BASS     | 50    | 0 – 100         | Drop C has tighter low end than drop A/B; modest BASS gives weight without flub. Pull to 40 if chug feels muddy. |
| MIDDLE   | 35    | 0 – 100         | Scooped to hit the V-shape characteristic of modern metal rhythm. |
| TREBLE   | 65    | 0 – 100         | Brings string definition for palm-mute clarity. |
| PRESENCE | 60    | 0 – 100         | Adds the "bite" that the SM57-on-V30 sim will further emphasize. |
| VOLUME   | 70    | 0 – 100         | Master level; adjust to taste against bypass. |

### Slot 4 — RCT4x12 (CABINET p.16) — Mesa Recto 4×12 with Celestion V30s
| Param    | Value | Range (catalog) | Rationale |
|----------|-------|-----------------|-----------|
| MIC      | ON    | OFF, ON         | Required for direct monitoring / DAW / headphones. Set OFF only if running into a real guitar power amp + cab. |
| D57:D421 | 35    | 0 – 100         | Weighted toward SM57 (low values = more 57, high values = more MD421 per catalog) for tight upper-mid bite. **Verify direction by ear** — swap to 65 if the tone is too dark. |
| Hi       | 55    | 0 – 100         | Slight lift to keep articulation; pull back if fizz becomes harsh. |
| Lo       | 45    | 0 – 100         | Slight tame of the 4×12 low end. Drop C doesn't need the deeper cut a drop-A/B patch would. |

### Slot 5 — Room (REVERB p.25)
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| PreD  | 15    | 1 – 100 (ms)    | Short pre-delay keeps attack transient dry and forward. |
| Decay | 8     | 1 – 30          | Small room tail; long enough to add depth, short enough not to smear 16th-note chugs. |
| Mix   | 20    | 0 – 100         | Low blend — sit the rhythm in a space, don't drown it. |
| Tail  | ON    | OFF, ON         | Lets the tail ring naturally past note-off / patch-end. |

### Amp alternatives (swap candidates for §7 iteration)
Drop C sits at the **light end** of POLLEX's stated "extreme drop-tuning" target range. POLLEX still works, but two amps in the catalog are arguably more idiomatic for drop C:

- **DZ DRV** (AMP p.12) — Diezel VH4 model. Classic drop-C tone (Gojira, Lamb of God). Has explicit DEEP / MID CUT controls that pair well with drop tunings.
- **Recti ORG** (AMP p.12) — Mesa Rectifier model with MDRN mode. The amp that *defined* the modern drop-C rhythm sound.

If POLLEX feels too compressed or fizzy in A/B, swap to one of these and re-balance EQ. Do **not** stack amps — one AMP slot only per G6 rules.

## 5. Chain Order Justification
Standard G6 category flow followed exactly: DYNAMICS → DRIVE → AMP → CABINET → REVERB. No deviation. Skipped FILTER (no surgical EQ needed — amp tone stack + cab Hi/Lo do the V-shaping), MODULATION (rhythm tone, no width FX wanted), SFX, DELAY (would muddy palm-mute density), PEDAL, SND-RTN, IR (cab sim already in slot 4). Five slots leaves ~4 slots of headroom for the user to add a tube screamer-style boost, EQ scoop, or delay during iteration without busting the DSP budget.

## 6. Expected Sonic Impact
- **NoiseGate** — silences string buzz / hum between palm-muted chugs; mandatory at this gain.
- **BG GRID** — tightens low end and pushes mids into the amp so the preamp clips on a leaner signal (classic metal pedal-into-amp trick).
- **POLLEX** — supplies the saturated, drop-tuning-friendly high-gain character with the scooped midrange.
- **RCT4x12** — V30 4×12 sim provides the upper-mid presence peak that gives modern rhythm tones their "cut".
- **Room** — places the dry, tight signal into a believable small space so it doesn't sound sterile next to ambient mix elements.

## 7. A/B Iteration Log
| # | Date | User feedback | Param deltas applied | Result |
|---|------|---------------|----------------------|--------|
| 1 |      |               |                      |        |

## 8. Finalization Checklist
- [ ] Every effect exists verbatim in `reference/g6-fx-catalog.yaml`
- [ ] Every parameter value is within catalog range
- [ ] Chain length ≤ G6 hard limit (5 of ~9 used)
- [ ] Category order follows §3 (or §5 justifies deviation)
- [ ] User has recorded a dry DI through the G6 with this patch
- [ ] User has A/B'd the recorded DI subjectively against `samples/orbit.wav` and approved
- [ ] Disclaimer in header is still accurate (source still wet, no DI obtained)
