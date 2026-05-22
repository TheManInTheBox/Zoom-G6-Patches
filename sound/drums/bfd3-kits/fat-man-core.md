# Fat Man Core Kit (BFD3)

**Status: stub kit definition.** Populate specific kit-piece picks after auditioning against [../../../samples/_reference/fat-man/](../../../samples/_reference/fat-man/).

**Default source palette:** BFD Crush (shells) + BFD Metal Snares (snare top) + BFD3 stock cymbals.

## Kit Pieces

| Slot | Source candidate | Notes |
|---|---|---|
| Kick | BFD Crush kick (TBD which) | Target: 60–80 Hz fundamental, 2.5–4 kHz click |
| Snare top | BFD Metal Snares (TBD which) | Target: 180–250 Hz body, 3–5 kHz crack |
| Snare bottom | BFD3 stock or paired with snare top | Wires character — not paper |
| Hi-hat | BFD3 stock | Tight, controlled |
| Tom 1 (rack) | BFD Crush | Tuned to fill 100–200 Hz |
| Tom 2 (rack) | BFD Crush | " |
| Tom 3 (floor) | BFD Crush | Lower fundamental, not stepping on kick |
| Crashes | BFD3 stock | Energy tapered above 8 kHz |
| Ride | BFD3 stock | — |
| Overheads | BFD Crush mics | Stereo, no comb-filter |
| Room | BFD Crush room | Real-room feel, not plate |

## BFD3 Internal Mixer (defaults to dial in)

- **Kick:** light internal compression, gentle 200 Hz cut on the in-channel EQ, OH/Room bleed -6 to -10 dB.
- **Snare top:** internal comp 2–3 dB GR, OH/Room bleed full or slightly trimmed.
- **Toms:** gated to taste (BFD3 has per-channel gates), bleed managed via the mixer.
- **OH/Room:** stereo width 80–100%, level balance approx OH -3 dB to Room -6 dB relative to direct mics.

## Multi-Out Routing to DAW

Recommend **at least these discrete outs** to Fender Studio Pro:
1. Kick (mono)
2. Snare top (mono)
3. Snare bottom (mono)
4. Toms sub-mix (stereo) — or per-tom if heavy processing planned
5. Hi-hat (mono)
6. Cymbals/OH (stereo)
7. Room (stereo)

All feed the Drum bus in the DAW (see [../../mix-bus/chain.md](../../mix-bus/chain.md)).

## Validation

After kit is built, bounce a solo drum pattern at a Fat Man tempo. Run analysis tasks on the bounce. Compare spectral profile to the reference — specifically:
- Kick fundamental sits in 60–80 Hz with click in 2.5–4 kHz
- Snare body in 180–250 Hz, crack in 3–5 kHz
- Cymbal energy tapered above 8 kHz
- Bus comp/limiter applied later — raw bounce should be ~6–8 LU quieter than final

## Update Log

- 2026-05-20 — Stub created.
- 2026-05-20 — Source palette locked to BFD Crush + Metal Snares + stock cymbals.
