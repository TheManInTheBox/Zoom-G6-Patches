# Vocal Chain Design

**Mic: Shure SM7B** (cardioid dynamic, broadcast/studio standard).
**Preamp: Quantum HD 8 onboard** (enough clean gain for this mic in this room/setup).

## Honest constraint

The SM7B is a better fit for Fat Man vocals than the old PDM35, but it still has real constraints in a dense `-12 LUFS` mix:
- It is naturally controlled, not hyped. Do not expect condenser-style air above 10 kHz.
- It still has proximity effect. Sing roughly 4–6 inches off with a pop filter, not right on the grille.
- It rewards strong performance level. Quiet delivery into high gain still sounds smaller than loud, committed takes.
- It is smoother than the PDM35, so you should need less corrective EQ and less saturation.

## Target

Vocals on the Fat Man references sit forward in the **1k–4k window** with controlled consonant energy and no obvious de-essing artifacts. Not air-band hyped above 10 kHz.

| Behavior | Target |
|---|---|
| Fundamental presence | 200–500 Hz controlled; not chesty/boomy |
| Body / warmth | 500 Hz–1 kHz solid |
| Intelligibility | 1k–4k forward — this is where the lead voice lives |
| Sibilance | 5–8 kHz controlled; de-esser tucking not pumping |
| Air | Open above 10k but **not** shelf-boosted |
| Compression | Forward, sustained presence — implies 4–8 dB GR across a serial chain (1176-style fast + LA-2A-style slow) |

## Chain (SM7B-tuned)

```
SM7B (4-6" off-axis with pop filter)
  → Quantum HD 8 preamp (set peaks around -12 dBFS)
  → Mono DAW track
  → HPF @ 70-90 Hz
  → Subtractive EQ:
        - Notch ~200-350 Hz to taste (mud / chest buildup)
        - Notch ~700 Hz-1.2 kHz IF nasal
        - Notch ~3-5 kHz IF consonants get hard
  → Comp 1 (fast, 1176-style):
        ratio 4:1, attack fast, release medium
        3-6 dB GR on peaks
  → Comp 2 (slow, LA-2A-style):
        slow / opto-style leveling
        2-4 dB GR average
  → De-esser @ 5-7 kHz, gentle
  → Additive EQ:
        - Presence bell +1-3 dB @ 2-4 kHz if needed
        - Tiny air lift above 10 kHz only if the take still feels shut in
  → Saturation (optional, very gentle - density, not distortion)
  → Sends:
      → Plate or short room reverb (pre-delay 20-40ms, decay 1.2-1.8s)
      → Slap or 1/8 note delay (low feedback)
```

## Studio One Vocal Template

Build this once, save it as a track preset, and reuse it on every song.

### Vocal track

1. Input: mono audio track from Quantum HD 8 mic preamp.
2. Clip gain: trim loud phrases so pre-insert peaks land around -12 to -8 dBFS.
3. HPF: start at 80 Hz, move only if proximity rumble is still getting through.
4. Subtractive EQ:
   - 200–350 Hz, small cut if chest buildup is muddy.
   - 700 Hz–1.2 kHz, small cut only if the SM7B sounds boxy or nasal.
   - 3–5 kHz, small cut only if consonants get hard before the de-esser.
5. Comp 1: fast compressor, 3–6 dB gain reduction on peaks.
6. Comp 2: slow compressor, 2–4 dB gain reduction average.
7. De-esser: 5–7 kHz, just enough to tuck sibilance.
8. Additive EQ: +1 to +3 dB around 2–4 kHz only if the vocal still hides.
9. Optional saturation: very gentle, level-matched.
10. Track fader: bring the vocal into the mix here, not by cranking the preamp.

### Vocal bus

1. Bus comp: 1–2 dB gain reduction max.
2. Send verbs and delays from the track, not as inserts on the bus.
3. Keep the bus clean enough that automation still works when the chorus hits.

### Track preset name

- `FM Vocal SM7B - Lead`

### FX chain preset name

- `FM Vocal SM7B - Main Chain`

The **saturation** step is less critical here than it was for the PDM35. Use it only to add density or attitude after compression, not to fabricate missing top end.

## Open Questions

- **Vocal style on Fat Man records** — clean singing, screams, mix? Affects compression aggression.
- **Doubling / harmony tracks** — single performance with stereo widening, or genuinely tracked doubles?
- **Pop filter + shock mount in use?** The SM7B is forgiving, but plosives still punish close vocals.

## Next Action

Record a mono test phrase through the SM7B, run this chain, and A/B against the vocal energy heard in [../../samples/_reference/fat-man/](../../samples/_reference/fat-man/). If the vocal still hides in the mix, adjust `2-4 kHz` presence before adding more saturation or top end.
