# Signal Flow

End-to-end signal path from instrument to recorded track. Update when any link in the chain changes.

## Guitar (electric)

```
Gibson LP Studio Modern (498T bridge / 490R neck, drop C, 12-60)
  → 1/4" instrument cable
  → Zoom G6 (input)
  → G6 patch chain (see ../patches/)
  → G6 1/4" analog output (MONO)
  → Quantum HD 8 line input
  → Fender Studio Pro (mono input track)
```

**Confirmed:**
- Path: G6 analog out → Quantum HD 8 line in. **Not** USB-direct.
- Capture: **mono.** Build G6 patches with mono compatibility in mind — avoid stereo-only effects (some modulations, ping-pong delays, stereo widening reverbs) since the right channel is being discarded. Set the G6 output to mono-sum where possible.
- Cab strategy: G6 internal cabsim only. No 3rd-party IRs loaded via the IR slot.

**Still TODO:**
- Sample rate / buffer size — confirm consistency across G6 and Quantum HD.

## Drums (BFD3)

```
BFD3 (VST or standalone)
  → multi-out routing (kick / snare / toms / OH / room / FX submix)
  → Fender Studio Pro instrument tracks (one per BFD3 output)
  → drum bus (group)
```

**TODO confirm:** BFD3 output routing template — how many discrete outs are you using?

## Vocals

```
Phenyx Pro PDM35 (cardioid dynamic)
  → XLR cable
  → Quantum HD 8 mic input (preamp ~45–60 dB gain)
  → Fender Studio Pro vocal track
  → vocal chain (see ../sound/vocals/chain.md)
```

No outboard preamp — Quantum HD 8 onboard preamp does all the work. PDM35 is a quiet dynamic; expect to push the preamp into the upper half of its range.

## Bass

```
Suno AI rendered stem (.wav)
  → import into Fender Studio Pro as audio track
  → bass processing chain (see ../sound/bass/chain.md)
```

No signal flow per se — the stem is already "recorded" by the time it lands in the DAW. Constraint: stem is pre-compressed/pre-mixed internally by Suno; less malleable than a raw DI.

## Reference monitoring

**TODO** — list monitors, headphones, room treatment. Affects mix-decision reliability.

## Streaming / Recording (OBS)

```
Fender Studio Pro master out
  → Quantum HD 8 loopback channel (configured in UC Surface)
  → OBS audio source (Quantum HD loopback input)
Camera → OBS video source
OBS:
  → local recording (NVENC/x264, see ../obs/)
  → Restream.io (recommended) → Twitch + YouTube simultaneously
```

**Routing:** Quantum HD 8 has a hardware/driver loopback channel — DAW output is routed to that channel, OBS picks it up as an input. No VoiceMeeter, no ASIO Link needed.

**Dual-target streaming:** OBS sends one RTMP feed to Restream, Restream fans out to Twitch + YouTube. Alternative: Aitum Multistream plugin for local-only fan-out. See [../obs/README.md](../obs/README.md).

## Update Log

- 2026-05-20 — Initial signal flow draft.
- 2026-05-20 — Confirmed: G6 mono analog → Quantum HD, G6 internal cabsim, PDM35 → Quantum HD preamp, Suno bass stems, Quantum HD loopback → OBS → Restream → Twitch+YouTube. Sample rate/buffer still TODO.
