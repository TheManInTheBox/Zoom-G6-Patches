# Patch Recipe — Fat Man "Orbit of You" Drop-C Rhythm

> **Source sample:** `samples/_reference/fat-man/orbit-of-you.wav` (full-mix reference, not an isolated DI)
> **Analysis artifacts:** `analysis/orbit-of-you/`
> **Reference song / target:** Fat Man — "Orbit of You" (locked reference track for this project)
> **Author / date:** GitHub Copilot (Patch Engineer mode) / 2026-05-20
> **Status:** draft (replaces `patches/suno_orbit_low-tuned-djent-rhythm.md`, which was built from a Suno render and assumed stereo cabsim)

> ## ⚠️ Constraints applied to this rewrite (read first)
> 1. **MONO output.** Signal path is LP → cable → G6 → **1/4" MONO** analog → Quantum HD 8 line in → mono Studio Pro track. Stereo-only effects (ping-pong delay, stereo wideners, dual-cabsim panning tricks) are forbidden — they collapse to mono and waste DSP. Any reverb/delay used is summed to mono downstream; verify it still sounds intentional after summing.
> 2. **G6 internal cabsim only.** No 3rd-party IRs. CABINET slot does the speaker simulation.
> 3. **Gibson LP Studio Modern, 498T bridge.** Hot ceramic humbucker, naturally bright with a presence peak in the 2.5–4 kHz region. **Tame, do not boost.** Patches that hit harder on TREBLE/PRESENCE will turn into ice picks.
> 4. **Drop C tuning, EXL148 12-60.** Low C2 ≈ 65 Hz fundamental. Tight strings → less subsonic flub than drop A/B, so noise gate and low-cut can be less aggressive than a Suno-djent template.
> 5. **Reference is a full mix.** `orbit-of-you.wav` includes drums, bass, vocals, FX. The 4243 Hz "rough frequency" centroid is the total mix, not the guitar. Tune the patch so the guitar **sits in** that mix, not so it duplicates it solo.
> 6. **No clean isolated DI of the target guitar exists.** A/B is subjective: record your own DI through the patch, drop it into a Studio Pro session against `orbit-of-you.wav`, judge by ear.

## 1. Target Tone Summary
Tight modern high-gain rhythm tone for **drop-C** 6-string (low C2 ≈ 65 Hz). Mid-modern-metal / metalcore territory — Gojira, Lamb of God, Trivium — not 7/8-string mechanical djent. Fast palm-mute attack, controlled (not gutted) low end, dialled-in low-mid scoop via the amp's dedicated MID CUT control (Diezel character), V30-flavored upper-mid presence around 2–4 kHz, **deliberately restrained** above 5 kHz to leave room for cymbals and vocal sibilance in the mix. Short ambient tail for depth without smearing chug articulation. Built around a **Diezel Herbert Channel 2** style amp into a Mesa Recto V30 4×12, with a Grid-Slammer-style boost in front and an aggressive gate to keep low-tuned palm mutes clean.

**Articulation goal (added 2026-05-20):** emphasize the *push/pull* feel of slid power-chord motion (drop-tuned single-finger root-fifth shapes sliding between positions, e.g. around the 5th fret). The patch supports this by (a) loosening the noise gate so slide tails breathe instead of choking mid-glide, (b) slightly extending the Room bloom so the slide trails into space, and (c) adding a short, low-mix SlapBackD delay that puts a perceptual trail behind the slide motion without echoing. The patch **cannot create** this feel — it lives in right-hand pick dynamics and left-hand slide timing. The patch only avoids fighting it.

## 2. Analysis Snapshot
Numbers from `analysis/orbit-of-you/loudness.txt` and `analysis/orbit-of-you/sox-stat.txt`; spectral observations from `analysis/orbit-of-you/spectrogram.png`. **All values describe the full mix, not the isolated guitar.**

- **Duration / format:** 235 s (3:55), 48 kHz stereo, 16-bit PCM.
- **Loudness (EBU R128):** Integrated **−12.3 LUFS** — production-level loudness, consistent with the locked project target (−12.2 ±0.3 LUFS-I).
- **Loudness range:** **LRA 5.2 LU** — moderately compressed mix bus, within the project ceiling of ≤5.5 LU.
- **True peak:** **−3.6 dBTP** — sits inside the locked −3.5 to −4.0 dBTP headroom policy.
- **SoX stats:** RMS amplitude **0.2014** (~−13.9 dBFS), max **+0.661 / −0.658** (~−3.6 dBFS), crest factor ≈ **10 dB** — typical for a finished modern-metal master.
- **DC offset:** Midline +0.00139 (~0.14 %) — negligible.
- **Rough frequency (SoX):** **~4243 Hz** — full-mix centroid sits in the upper-mid presence band, where V30-style cabs and cymbal stick attack live. Guitar contribution is a slice of this, not the whole thing.
- **Spectrogram:** Broadband fundamentals down to ~65 Hz, dense sustained energy through 200 Hz–500 Hz (guitar + bass low-mids), structured upper-mid presence 2–5 kHz, controlled roll-off above ~10 kHz with cymbal air visible to ~14 kHz.

## 3. Proposed Chain
Order: DYNAMICS → FILTER → DRIVE → AMP → CABINET → MODULATION → SFX → DELAY → REVERB → PEDAL → SND-RTN → IR
(Standard category order, no deviation. 5 slots of ~9 used. Leaves DSP headroom for iteration — add ParaEQ if 498T fizz around 3 kHz needs surgical taming, or swap REVERB for a Hall/Plate if Room is too short.)

| Slot | Category  | Effect (from catalog) | Catalog cite |
|------|-----------|-----------------------|--------------|
| 1    | DYNAMICS  | NoiseGate             | `reference/g6-fx-catalog.yaml` DYNAMICS p.3 |
| 2    | DRIVE     | BG GRID               | `reference/g6-fx-catalog.yaml` DRIVE p.8 |
| 3    | AMP       | DZ DRV                | `reference/g6-fx-catalog.yaml` AMP p.12 |
| 4    | CABINET   | RCT4x12               | `reference/g6-fx-catalog.yaml` CABINET p.16 |
| 5    | REVERB    | Room                  | `reference/g6-fx-catalog.yaml` REVERB p.25 |
| 6    | DELAY     | SlapBackD             | `reference/g6-fx-catalog.yaml` DELAY p.23 |

Skipped FILTER (no surgical EQ yet — first listen with the amp tone stack + cab Hi/Lo; reserve a ParaEQ slot for iteration if 498T harshness shows up). Skipped MODULATION/SFX (rhythm tone in mono — stereo width is impossible, mod FX would gimmick the tone). Skipped PEDAL/SND-RTN/IR. **DELAY now in use** (slot 6) for slide-motion emphasis — see articulation goal in §1. 6 of ~9 slots used.

## 4. Parameters
All values are inside the catalog `raw:` range for the named effect. Ranges quoted verbatim from `reference/g6-fx-catalog.yaml`.

### Slot 1 — NoiseGate (DYNAMICS p.3)
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| DETCT | GTRIN | GTRIN, EFXIN    | Trigger from raw guitar input so the gate doesn't chase post-amp hiss. |
| Depth | 55    | 0 – 100         | **Reduced from 65** to support slide articulation. Slides have no re-attack — they live entirely in sustain. A deep gate clamps the tail mid-glide and kills the push/pull feel. 55 still silences string buzz between chugs without choking slides. Push to 65 if hum leaks through; never above 70 with slide-heavy parts. |
| THRSH | 35    | 0 – 100         | Opens cleanly for picked notes, stays shut on string buzz. Raise to 40-45 if it chokes sustained chords; lower to 30 if chug noise leaks through. |
| Decay | 50    | 0 – 100         | **Increased from 30.** Longer release lets slide tails ring out as the gate closes gradually instead of clicking shut. Trade-off: slightly looser transition between chugs — if it sounds smeared, pull back to 40. |

### Slot 2 — BG GRID (DRIVE p.8) — Mesa Grid Slammer
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| Gain  | 20    | 0 – 100         | Low — used purely as a tightener and mid-pusher in front of the amp, **not** a primary distortion. 498T already has plenty of output; high pedal gain stacks fizz. Bump to 30 only if the chug feels loose. |
| Tone  | 55    | 0 – 100         | Slight upper-mid lift for pick definition. Held below 60 because the 498T already has pick attack — overdoing TS-style tone here is what creates the "ice pick" complaint. |
| BAL   | 100   | 0 – 100         | Fully wet (effect-only). The boost has to actually shape the signal hitting the amp; partial blend defeats the point. |
| VOL   | 65    | 0 – 100         | Hot enough to drive DZ DRV into saturation without smashing the input. Adjust ±5 against bypass A/B. |

### Slot 3 — DZ DRV (AMP p.12) — Diezel Herbert Channel 2
| Param    | Value | Range (catalog) | Rationale |
|----------|-------|-----------------|-----------|
| GAIN     | 55    | 0 – 100         | DZ DRV saturates harder per knob than a Mesa-style amp; 55 is already firmly in modern-metal rhythm territory with the BG GRID boost in front. Push to 65 only if the chug lacks teeth — past ~70 it loses pick articulation. |
| BASS     | 45    | 0 – 100         | Held back deliberately because the **DEEP** knob handles drop-C low-end weight separately. Stacking BASS + DEEP both high turns the chug into mush. |
| MIDDLE   | 55    | 0 – 100         | **Not scooped.** Diezel mid voicing is what makes the amp cut in a dense mix. Use **MID CUT** (below) for the V-scoop — don't double-dip by also pulling MIDDLE down. |
| TREBLE   | 50    | 0 – 100         | Neutral. The 498T supplies upper-mid bite; the V30 cab brings 2–4 kHz presence. TREBLE here is just a fine-trim — bump to 55 only if the soloed tone is too dark in context. |
| PRESENCE | 45    | 0 – 100         | Slightly under neutral. 498T + V30 cab already cover the presence band; PRESENCE above 50 starts pushing into ice-pick range and competes with cymbals in the mix. |
| VOLUME   | 70    | 0 – 100         | Master level; calibrate to bypass A/B so engaging the patch doesn't jump levels. |
| DEEP     | 40    | 0 – 100         | Drop-C low-end emphasis without flubbing BASS. Moderate setting gives the C2 fundamental weight while keeping the chug articulate. Push to 50 if the mix feels thin against the Suno bass; pull to 30 if low-end stacks muddy with the drum kick. |
| MID CUT  | 35    | 0 – 100         | Moderate V-scoop. **The reason we chose DZ DRV over POLLEX** — having scoop on a dedicated knob means you can tune the V-shape against the mix without disturbing the Diezel mid character. Pull deeper (50–60) for a more 90s-Pantera scoop; back off (20) if the guitar disappears behind bass + drums. |

### Slot 4 — RCT4x12 (CABINET p.16) — Mesa Recto 4×12 with Celestion V30s
| Param    | Value | Range (catalog) | Rationale |
|----------|-------|-----------------|-----------|
| MIC      | ON    | OFF, ON         | Required — the G6 is the only cabsim in the chain; signal goes direct to the Quantum HD line in, then into Studio Pro. MIC=OFF would send an un-mic'd amp signal into the DAW (no speaker filtering) and sound like a buzzsaw. |
| D57:D421 | 40    | 0 – 100         | Slight weighting toward SM57 (per catalog: low values = more SM57, high values = more MD421). SM57 gives tight upper-mid bite; MD421 is darker and thicker. **Verify direction by ear** — if it sounds dark/woolly, swap to 60. |
| Hi       | 50    | 0 – 100         | **Reduced from 55** in the old patch. Neutral on the cab Hi keeps fizz away. The 498T + RCT4x12 V30 combination is already a presence-heavy pairing. |
| Lo       | 45    | 0 – 100         | Slight tame of the 4×12 low end. Drop C doesn't need the deeper cut a drop-A/B patch would. Raise to 50 if the chug feels thin in the mix. |

### Slot 5 — Room (REVERB p.25)
| Param | Value | Range (catalog) | Rationale |
|-------|-------|-----------------|-----------|
| PreD  | 15    | 1 – 100 (ms)    | Short pre-delay keeps attack transient dry and forward. |
| Decay | 12    | 1 – 30          | **Increased from 8** to let slide tails bloom into the room as they move. Still well below the smear threshold for 16th-note chugs. If chug articulation softens too much, pull back to 10. |
| Mix   | 18    | 0 – 100         | **Increased from 15** to support slide bloom. Still compensated for stereo-to-mono summing (raw stereo Mix equivalent would be ~21). |
| Tail  | ON    | OFF, ON         | Lets the tail ring naturally past note-off. |

### Slot 6 — SlapBackD (DELAY p.23) — Short single-tap delay for slide-motion emphasis
| Param | Value | Range (catalog)   | Rationale |
|-------|-------|-------------------|-----------|
| Time  | 110   | 1 – 300 (ms)      | Short enough to **feel like a doubling/trail**, not an audible echo. Tuned to fall between common subdivision values so it doesn't lock to the grid and clash with off-beat slides. Adjust 80–140 ms to taste; >150 ms starts to register as a distinct echo and muddies palm-mute density. |
| F.B   | 10    | 0 – 100           | Near-zero feedback = essentially **one repeat**. The goal is a trail behind the slide, not a cascading echo. Push to 20 only if a single repeat is too subtle in the mix; never above 25 with this rhythm density. |
| Mix   | 15    | 0 – 100           | Low blend — the delay should be felt, not heard. If you can clearly pick out the repeat as a discrete event, Mix is too high. |
| SubDv | ♩     | ♩, ♪, P-P         | Quarter-note sync subdivision. **Do not use P-P** — it's ping-pong stereo, useless on the G6 mono output. Time is set in ms so SubDv may be ignored depending on the unit's Sync state; verify against PDF page 23 if the delay behaves unexpectedly. |

> **Verify against PDF before locking:** if the Room reverb's `notes:` or `typed.kind: special` flag in the catalog mentions stereo-only behavior or mono-sum cancellation, swap to a true mono-friendly REVERB (e.g., a Spring or Plate that mono-sums cleanly). For the first listen the mono-summing of Room is fine; flag any phasiness in iteration §7.

### Amp alternatives (swap candidates for §7 iteration)
**DZ DRV is the chosen amp.** Diezel Herbert Channel 2 with dedicated DEEP and MID CUT controls — ideal for sculpting drop-C low-end weight and V-scoop independently of the main tone stack. If DZ DRV doesn't land, two alternatives worth A/B'ing:

- **POLLEX** (AMP p.14) — most djent-flavored model in the catalog, with the scooped-mid character baked in. Try if DZ DRV feels too "open" / not tight enough.
- **Recti ORG** (AMP p.13) — Mesa Rectifier model. Defines the modern drop-C rhythm sound. Less compressed than POLLEX, more pick-attack texture.

One AMP slot only per G6 rules — pick one, don't stack.

## 5. Chain Order Justification
Standard G6 category flow followed exactly: DYNAMICS → DRIVE → AMP → CABINET → REVERB → DELAY. **Note:** standard category order places DELAY *before* REVERB. This patch deliberately reverses that for one reason: the SlapBackD is set up with a tiny mix and tuned to follow slide motion specifically, not to repeat audibly. Putting it **after** the Room reverb means the slap is fed by the already-wet (room-blurred) signal, producing a softer, less distinct repeat that supports the slide's tail without competing with the room ambience. If the slap sounds too washed-out, swap the order (DELAY then REVERB) and re-A/B. 6 of ~9 slots used, leaving ~3 slots of DSP headroom for the user to add a ParaEQ (FILTER, p.5) for surgical 498T-fizz taming or a second drive during iteration.

## 6. Expected Sonic Impact
- **NoiseGate** — silences string buzz / hum between palm-muted chugs; mandatory at this gain level for a 498T into a high-gain amp.
- **BG GRID** — tightens low end and pushes mids into the amp so the preamp clips on a leaner signal (classic metal pedal-into-amp trick). Held low because the pickup is already hot.
- **DZ DRV** — supplies the Diezel Herbert Channel 2 saturation: tight, articulate, with the **MID CUT** knob providing the V-scoop and **DEEP** providing the drop-C low-end weight independently. TREBLE/PRESENCE deliberately restrained for 498T compatibility.
- **RCT4x12** — V30 4×12 sim provides the upper-mid presence the modern metal rhythm tone needs to cut in a mix. Mic blend weighted toward SM57.
- **Room** — places the dry, mono signal into a believable small space so it doesn't sound sterile next to ambient drum room mics in `orbit-of-you.wav`. Slightly extended decay supports slide bloom.
- **SlapBackD** — single short repeat (~110 ms, low mix) puts a perceptual trail behind slide motion to emphasize the push/pull feel. Below audibility threshold as a discrete echo — felt, not heard.

## 7. A/B Iteration Log
A/B method: record dry DI through patch into a Studio Pro mono track at 48 kHz / 24-bit, drop the track into a fresh session alongside `samples/_reference/fat-man/orbit-of-you.wav`, level-match by ear, judge.

| # | Date | User feedback | Param deltas applied | Result |
|---|------|---------------|----------------------|--------|
| 1 |      |               |                      |        |

## 8. Finalization Checklist
- [ ] Every effect exists verbatim in `reference/g6-fx-catalog.yaml`
- [ ] Every parameter value is within catalog range
- [ ] Chain length ≤ G6 hard limit (5 of ~9 used)
- [ ] Category order follows §3 (or §5 justifies deviation)
- [ ] Mono-summing of REVERB verified — no phasiness or unintended level jump
- [ ] User has recorded a dry DI through the G6 with this patch
- [ ] User has A/B'd the recorded DI subjectively against `samples/_reference/fat-man/orbit-of-you.wav` and approved
- [ ] No stereo-only effects in the chain (mono signal path enforced)
- [ ] TREBLE / PRESENCE / cab Hi sanity-check: pickup is 498T — no harshness above 5 kHz
- [ ] Old patch `patches/suno_orbit_low-tuned-djent-rhythm.md` has been superseded or deleted
