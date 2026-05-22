# Vocal Chain Design

**Mic: Phenyx Pro PDM35** (cardioid dynamic, broadcast-style, budget tier).
**Preamp: Quantum HD 8 onboard** (~45–60 dB gain needed for this mic).

## Honest constraint

The PDM35 is a workable but budget-tier dynamic. In a -12 LUFS dense mix, expect:
- Limited HF detail above ~10 kHz — don't fight it with a huge air shelf, it'll just hiss the preamp noise floor.
- Strong proximity effect when close — sing 4–6 inches off, not 1 inch.
- Preamp noise audible if gain is high and signal is quiet — perform loud.
- This mic is the most likely upgrade candidate when budget allows (SM7B, RE20, sE V7X).

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

## Chain (PDM35-tuned)

```
PDM35 (4-6" off-axis)
  → Quantum HD 8 preamp (~50 dB gain typical)
  → DAW track
  → HPF @ 100 Hz (PDM35 proximity bass cleanup)
  → Subtractive EQ:
        - Notch ~250-400 Hz to taste (mud)
        - Notch ~3-4 kHz IF harshness on consonants (PDM35 can spike here)
  → Comp 1 (fast, 1176-style):
        ratio 4:1, attack fast, release medium
        3-6 dB GR on peaks
  → Comp 2 (slow, LA-2A-style):
        ratio 3:1, slow attack
        2-4 dB GR average
  → Additive EQ:
        - Presence shelf or bell +2-3 dB @ 2-4 kHz
        - DO NOT boost above 10 kHz on this mic
  → De-esser @ 5-7 kHz, gentle (PDM35's HF isn't aggressive enough to over-ess)
  → Saturation (optional, gentle - adds harmonic content the PDM35 lacks)
  → Sends:
      → Plate or short room reverb (pre-delay 20-40ms, decay 1.2-1.8s)
      → Slap or 1/8 note delay (low feedback)
```

The **saturation** step is more important here than on a higher-end mic — it adds harmonic content (warmth, presence) that the PDM35 doesn't capture natively. Tape, console, or tube saturation, low drive.

## Open Questions

- **Vocal style on Fat Man records** — clean singing, screams, mix? Affects compression aggression.
- **Doubling / harmony tracks** — single performance with stereo widening, or genuinely tracked doubles?
- **Pop filter + shock mount in use?** PDM35 plosive handling is mediocre without a pop filter.

## Next Action

Record a test vocal phrase, run the chain, A/B against the vocal energy heard in [../../samples/_reference/fat-man/](../../samples/_reference/fat-man/). Identify where the PDM35 falls short, decide whether to compensate via processing or queue the mic upgrade.
