# Guitar Tone Design

The Fat Man guitar sound, in two roles:
- **Rhythm** — dense, mid-forward, drop-C palm-mute wall.
- **Lead** — same DNA as rhythm, more sustain + cut, lower noise floor.

## Hardware constraints (locked)

| Item | Setting | Implication for patch design |
|---|---|---|
| Pickups | **Gibson 498T** (bridge) / **490R** (neck) | 498T is hot + bright. Patches likely need to **tame** 2.5–4 kHz, not boost it. Bridge will be the workhorse for rhythm/lead. |
| Tuning | **Drop C** | Low note fundamental ~65 Hz. Patch low-end shaping must keep this defined, not flubby. |
| Strings | D'Addario EXL148 (12–60) | Slight slack on low C — string definition relies on the patch noise gate + compressor more than usual. |
| Output | **G6 1/4" mono analog** → Quantum HD line in | **Patches must be mono-compatible.** No stereo-only effects (ping-pong delay, stereo widener reverbs). |
| Cab | **G6 internal cabsim only** | No 3rd-party IR slot use. Cab choice from [../../reference/g6-fx-catalog.yaml](../../reference/g6-fx-catalog.yaml) CABINET section is the entire cab decision. |

## Target (extracted from [../reference-tracks.md](../reference-tracks.md))

When a guitar track is soloed in the mix, it should:

| Band | Behavior |
|---|---|
| 20–60 Hz | Hi-pass at ~70 Hz on the track — guitar doesn't own this band; kick and bass do. |
| 60–200 Hz | Solid fundamental energy, but not dominant. Tight, not flubby. |
| 200–500 Hz | Body. The "chug" lives here. Watch for mud at 250–300 Hz. |
| 500 Hz–2 kHz | **Forward.** Not scooped. Modern hi-gain mid scoops kill the band's mid presence. |
| 2–5 kHz | Aggressive bite. Stops short of harsh. |
| 5–8 kHz | Tapered. Air starts thinning. |
| > 8 kHz | Soft rolloff. No fizz, no 10k shelf boost. |

## G6 Patches

| Role | Patch file | Status |
|---|---|---|
| Rhythm (drop C) | [../../patches/suno_orbit_low-tuned-djent-rhythm.md](../../patches/suno_orbit_low-tuned-djent-rhythm.md) | **Pending re-evaluation against real Orbit Of You reference** — was built from a Suno render. |
| Lead (drop C) | TBD | Not started. |
| Clean / arpeggio | TBD | Not started. |

## Open Questions

- **Double-tracking strategy** — hard L/R two passes? Or single + DAW-side widener? The reference sounds genuinely double-tracked. (Mono G6 output supports either approach — record two passes mono and pan.)
- **Lead patch sustain source** — long delay tail? Compressor + boost? Or amp gain itself?

## Next Action

Re-evaluate the rhythm patch against [../../samples/_reference/fat-man/orbit-of-you.wav](../../samples/_reference/fat-man/orbit-of-you.wav). Adjust until the soloed guitar in the reference and a re-amped DI through the patch land in the same spectral neighborhood.
