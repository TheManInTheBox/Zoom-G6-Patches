# Bass Processing (Suno-rendered stems)

**Source: Suno AI–generated bass stems** (`.wav`), dropped into the DAW as an audio track. No physical bass, no DI, no amp sim.

## What this changes

Suno renders are already mixed, compressed, and limited internally. You don't have:
- A clean DI to re-amp
- Independent control of pick attack vs. fundamental
- The ability to retune or re-perform

You do have:
- A finished-sounding stem that needs to **sit in a Fat Man mix**
- DAW-side EQ, comp, saturation, and bus integration

Processing strategy = **integrate the stem**, not design a chain from scratch.

## Target (extracted from [../reference-tracks.md](../reference-tracks.md))

| Band | Target |
|---|---|
| 20–40 Hz | Sub extension. Felt, not heard. Don't over-cut. |
| 40–80 Hz | Fundamental. Locked with kick. |
| 80–250 Hz | Body. Tight, not woofy. |
| 250–700 Hz | Cut to taste — this is where bass and guitar fight. |
| 700 Hz–2 kHz | Grind / pick attack. Present in references. |
| > 2 kHz | Tapered. |

## Stem processing chain

```
Suno bass stem (audio track)
  → Trim gain so stem peaks land at -10 to -6 dBFS pre-processing
  → HPF @ 30 Hz (kill subsonic rumble, keep musical sub)
  → Subtractive EQ:
        - Cut whatever 250-500 Hz mud overlaps with guitar body
        - Verify by soloing bass + guitar buses together, sweep narrow bell to find the clash
  → Light comp (1-3 dB GR max):
        Suno stems are already compressed; over-compressing kills what's left of dynamics
        Slow attack, medium release
  → Saturation (optional):
        Adds upper-harmonic grind in the 700 Hz-2 kHz band if the stem is too clean
  → Additive EQ:
        Small shelf or bell @ 80 Hz (+1-2 dB) if fundamental is shy
        Small bell @ 1-2 kHz (+1-2 dB) for definition over the wall of guitars
  → Bass bus
```

## What NOT to do

- **Don't split into clean + grind tracks** — you can't because the stem is already a finished render. That technique requires a raw DI.
- **Don't aggressive-compress** — Suno output is already compressed; stacking ratios pumps and distorts.
- **Don't re-amp through a bass amp sim** — the stem already has cab/amp character baked in; running it through another amp sim is double-coloring.

## Side-chain ducking?

References don't show obvious pumping. If kick and bass fundamentals fight, **try a gentle 1–2 dB duck on bass keyed by kick** before reaching for EQ. Often cleaner than carving the bass.

## Open Questions

- Will Suno bass stems arrive **per-song** or do you want a library of generic stems? Affects workflow.
- Tuning consistency — can Suno reliably render bass in drop C to match the guitar? If not, key signature mismatches will surface as dissonance, not something processing can fix.

## Next Action

Get a single Suno bass stem for one of the reference songs (or generate a new one). Apply this chain. A/B against the reference bass. Adjust.
