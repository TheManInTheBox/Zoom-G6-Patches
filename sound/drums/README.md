# Drum Tone Design (BFD3)

Goal: a single Fat Man core kit + processing chain that delivers the kick/snare/cymbal profile heard on the reference tracks.

## Target (extracted from [../reference-tracks.md](../reference-tracks.md))

| Element | Target |
|---|---|
| Kick fundamental | 60–80 Hz pocket. Defined click in the 2.5–4 kHz region for cut through guitars. |
| Snare body | 180–250 Hz. Crack in the 3–5 kHz region. Not paper-thin, not boxy. |
| Toms | Tuned to fill 100–200 Hz when guitars drop out; not stepping on kick during full-band. |
| Cymbals | Energy tapered above 8 kHz. No hyped 10k+ shelf. |
| Room/OH | Stereo width without comb-filtering. Should feel like a real room, not a plate. |
| Bus dynamics | Drum bus glues hard — expect 3–6 dB GR on a parallel comp + 1–2 dB on a serial bus comp. |

## Installed BFD3 Expansions (confirmed)

| Expansion | Character | Use for Fat Man? |
|---|---|---|
| **BFD Crush** | Heavy, compressed, aggressive metal/rock kits | **Primary kit source.** Best match for the dense -12 LUFS reference target. |
| **BFD Metal Snares** | Metal-tuned snare library | **Primary snare source.** Pair with a Crush shell pack. |
| **BFD Dark Farm** | Dark, vintage farmstead kit — looser, warmer | **Alt kit** for songs needing more room / less aggression. |
| **BFD 8 Bit Kit** | Lo-fi / chiptune | **FX use only.** Bridges, transitions, electronic interludes. |
| **BFD Swan Percussion** | Orchestral percussion | **FX use.** Cinematic builds, intros, outros. |

Default Fat Man core build: **BFD Crush** shells + **BFD Metal Snares** snare top + BFD3 stock cymbals (cymbal expansions not installed). Details in [bfd3-kits/fat-man-core.md](bfd3-kits/fat-man-core.md).

## Workflow

1. **Pick a base kit** in BFD3 that has the right *raw character* before processing. Bright + crisp kits will fight the dense mid-forward mix; warm/punchy kits will sit better.
2. **Build the BFD3 internal mixer state** — kit-piece levels, compressor/EQ presets per channel, room/OH balance.
3. **Route to multi-outs** in the DAW for further processing (see [../mix-bus/chain.md](../mix-bus/chain.md) for the drum bus position).
4. **Document in [bfd3-kits/fat-man-core.md](bfd3-kits/fat-man-core.md)** — every kit-piece choice + every plugin setting.

## Kits

| Kit name | Use case | File |
|---|---|---|
| Fat Man Core | Default rhythm sections | [bfd3-kits/fat-man-core.md](bfd3-kits/fat-man-core.md) — **stub** |

## Open Questions

- Which specific kits within **BFD Crush** sound closest to the references? Audition needed.
- Stock BFD3 cymbals — are they adequate for the target, or is a cymbal expansion an upgrade target?
- Tempo / groove libraries in use, or hand-programmed only?

## Next Action

Load each BFD Crush kit in turn, play a typical Fat Man tempo + pattern, A/B against [../../samples/_reference/fat-man/](../../samples/_reference/fat-man/). Pick the closest match and document in [bfd3-kits/fat-man-core.md](bfd3-kits/fat-man-core.md). Then iterate snare top from BFD Metal Snares.
