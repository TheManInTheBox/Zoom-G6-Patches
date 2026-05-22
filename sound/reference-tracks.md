# Fat Man — Sonic Target Spec

The two tracks below are **ground truth**. Every guitar patch, drum kit, mix-bus chain, and master in this repo must be measured against these numbers. If a future mix doesn't land inside the tolerances, it isn't a Fat Man record.

## Reference Tracks

| Track | File | Length |
|---|---|---|
| Abyssal Riff | [samples/_reference/fat-man/abyssal-riff.wav](../samples/_reference/fat-man/abyssal-riff.wav) | 3:42 |
| Orbit Of You | [samples/_reference/fat-man/orbit-of-you.wav](../samples/_reference/fat-man/orbit-of-you.wav) | 3:55 |

Analysis artifacts: [analysis/abyssal-riff/](../analysis/abyssal-riff/), [analysis/orbit-of-you/](../analysis/orbit-of-you/)

## Loudness Target (master bus)

| Metric | Abyssal Riff | Orbit Of You | **Target band** | Tolerance |
|---|---|---|---|---|
| Integrated loudness (LUFS-I) | -12.2 | -12.3 | **-12.0 to -12.5 LUFS** | ±0.3 LU |
| Loudness range (LRA) | 3.5 LU | 5.2 LU | **3.5 to 5.5 LU** | tight; do not exceed 6 |
| True peak | -3.7 dBTP | -3.6 dBTP | **-3.5 to -4.0 dBTP** | hard ceiling -3.0 dBTP |
| Sample peak | -3.7 dBFS | -3.6 dBFS | matches TP within 0.1 dB | — |
| RMS amplitude (normalized) | 0.204 | 0.201 | **~0.20** | ±0.01 |
| Crest factor (peak/RMS) | ~10.1 dB | ~10.3 dB | **~10 dB** | ±1 dB |

### Headroom policy — locked

True peak sits **~3 dB under 0 dBFS** on both masters. Confirmed intentional (2026-05-20).

**Master limiter ceiling: -3.5 dBTP** (range -3.5 to -4.0). Why:
- Streaming codec safety — lossy encoders (AAC, Opus) can add up to +1 dB of inter-sample peaks post-encoding. A -3.5 dBTP master survives encoding without distortion.
- Loudness normalization headroom — Spotify/Apple/YouTube turn -12 LUFS masters down to -14 LUFS for playback. Headroom is "free" without losing perceived loudness.
- No audible downside at -12 LUFS-I.

Every Fat Man master ships at **-12.2 ±0.3 LUFS-I / -3.5 to -4.0 dBTP / LRA ≤ 5.5 LU**. Non-negotiable.

## Spectral Target

From [analysis/orbit-of-you/spectrogram.png](../analysis/orbit-of-you/spectrogram.png) and [analysis/abyssal-riff/spectrogram.png](../analysis/abyssal-riff/spectrogram.png):

| Band | Hz | Density | Notes |
|---|---|---|---|
| Sub | 20–60 | Present, controlled | No runaway sub, but solid extension. Not hi-passed aggressively. |
| Low | 60–200 | **Dense, dominant** | Drop-tuned guitar fundamentals + kick + bass live here. This is the wall. |
| Low-mid | 200–500 | Dense | Body of the guitar tone. Likely where the mud risk lives — keep cleared on individual tracks via HPFs. |
| Mid | 500–2k | **Sustained, prominent** | Guitar bite, snare body, vocal fundamentals. Mid-forward mix, NOT scooped. |
| Upper-mid | 2k–5k | Strong, sustained to ~5k | Presence, attack, vocal intelligibility. Aggressive but not harsh. |
| Presence | 5k–8k | Tapered | Air starts thinning. Cymbal sizzle and consonant clarity. |
| Air | 8k–16k | Soft rolloff | Open but not hyped. No 10k+ shelf boost obvious. |
| Top | 16k–20k | Content present, hard cut at ~20k | Mastering chain has a 20 kHz brickwall lowpass. |

**Rough spectral centroid (sox stat "Rough frequency"):**
- Abyssal: 5815 Hz — more aggressive, more upper-mid drive.
- Orbit: 4243 Hz — more bottom-weighted, smoother top.

→ The Fat Man **range** is centroid 4.2–5.8 kHz. Mixes drifting below 4k will sound dull; above 6k will sound thin/harsh.

## Compositional / Production Inferences

Drawn from waveform density, LRA, and spectrogram patterns. Not measured — flagged as inference.

- **Mix-bus glue compression** is heavy. LRA 3.5–5.2 on a full song means a glue comp pulling 2–4 dB on choruses minimum, plus a master limiter taking another 1–3 dB.
- **No "loud chorus, quiet verse" dynamic strategy.** Every section sits in the same loudness window. Energy contrast comes from arrangement (instrumentation drops, tonal shifts) not from level changes.
- **Guitars are stereo-wide and dense across full track duration** — likely double-tracked L/R rhythm with no major drops.
- **Vocals sit forward in the 1k–4k window** — no obvious de-essing artifacts in the spectrogram, but consonant energy is present and controlled.
- **No obvious side-chain ducking** (kick on bass, etc.) visible in the waveform envelope — if used, it's gentle.

## How This Spec Gets Used

| Downstream artifact | Constraint |
|---|---|
| Guitar patch (G6) | Pre-DAW DI tone must, when re-amped into mix, fit the 60–500 Hz dense / 500–5k present spectral target. Patch alone should NOT brick the chain to -12 LUFS — that's the mix bus's job. |
| BFD3 drum kit | Kick fundamental in the 60–80 Hz pocket; snare body 180–250 Hz; cymbal energy tapered above 8 kHz. |
| Vocal chain | 1k–4k presence shelf; controlled 5–8k de-essing; no air-band hype above 10 kHz. |
| Mix bus | Glue comp 2–4 dB GR + limiter targeting **-12.2 LUFS-I, -3.5 to -4.0 dBTP, LRA ≤ 5.5**. |
| Master | -12.2 ±0.3 LUFS-I / -3.5 to -4.0 dBTP / LRA ≤ 5.5 LU. Locked policy. |

## Update Log

- 2026-05-20 — Initial spec from FFmpeg + SoX analysis of `abyssal-riff.wav` and `orbit-of-you.wav`.
