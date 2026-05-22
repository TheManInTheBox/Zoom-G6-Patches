# Mix Bus + Master Chain

The chain that takes a balanced mix from "tracks summed" to "Fat Man master." Targets are locked from [../reference-tracks.md](../reference-tracks.md).

## Locked Master Targets

| Metric | Target | Tolerance |
|---|---|---|
| Integrated loudness | -12.2 LUFS-I | ±0.3 LU |
| LRA | ≤ 5.5 LU | tight |
| True peak ceiling | -3.5 to -4.0 dBTP | hard ceiling -3.5 |
| Sample peak | matches TP within 0.1 dB | — |

## Group Buses (feed the mix bus)

| Bus | Default chain |
|---|---|
| Drums | Bus comp 1–2 dB GR + parallel comp 3–6 dB GR (blend ~30%) + tone EQ |
| Guitars | Bus comp 1 dB GR (glue only) + HPF ~80 Hz + subtractive EQ to clear vocal pocket |
| Bass | Bus comp 2–3 dB GR + tone EQ |
| Vocals | Bus comp 1–2 dB GR + send to plate / slap delay |
| FX / sends | Reverb returns + delay returns, level-only on the bus |

All groups → mix bus.

## Mix Bus Chain

```
Mix bus input (sum of all group buses)
  → 1. Subtractive EQ (only if needed — gentle 1-2 dB cuts at problem freqs)
  → 2. Glue compressor (SSL-style):
        ratio 2:1 or 4:1
        attack 30ms, release auto or 0.3s
        threshold set for 2-4 dB GR on choruses
  → 3. Saturation (optional, gentle — tape or console emulation, low drive)
  → 4. Additive EQ (broad, musical — treble shelf if needed, low shelf for weight)
  → 5. Limiter:
        ceiling -3.5 dBTP (matches reference policy)
        threshold set for 1-3 dB GR average, 4-5 dB GR on peaks
        oversampling ON
  → Master out
```

## Master Chain

If the mix bus chain is dialed correctly, the master is just:
```
  → Final true-peak limiter (safety, ceiling -3.5 dBTP)
  → LUFS meter to confirm -12.2 ±0.3 LUFS-I
  → Export
```

If the mix isn't hitting the target loudness, **fix it on the mix bus**, not by hammering a master limiter harder. Do not exceed 5 dB GR on the master limiter.

## Plugin choices

**TBD** — confirm Fender Studio Pro stock plugins vs. 3rd-party preferences (FabFilter, Waves, Universal Audio, etc.). This doc stays plugin-agnostic until that's decided.

## Validation checklist (before calling a master done)

- [ ] LUFS-I reads -12.2 ±0.3
- [ ] True peak ≤ -3.5 dBTP
- [ ] LRA ≤ 5.5 LU
- [ ] Sample peak within 0.1 dB of true peak
- [ ] A/B against [../../samples/_reference/fat-man/](../../samples/_reference/fat-man/) at matched loudness — does it sit in the same neighborhood?
- [ ] Spectral centroid (sox stat "Rough frequency") in 4.2–5.8 kHz range

## Update Log

- 2026-05-20 — Stub created. Plugin choices pending.
