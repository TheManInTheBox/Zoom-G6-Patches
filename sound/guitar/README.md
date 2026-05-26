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

## Studio One Guitar Chain

Use the G6 as the amp/cab source and keep Studio One processing small. The point is level control and cleanup, not a second amp sim.

### Studio One guitar track template

Build this once, save it as a track preset, and reuse it on every song.

1. Input: mono audio track from the G6 / Quantum HD 8 line input.
2. Clip gain: trim loud sections so pre-insert peaks land around -12 to -8 dBFS.
3. HPF: start at 75 Hz, move to 80 Hz only if the low end is still thick.
4. Subtractive EQ:
	- 250–300 Hz, about -2 dB, medium Q, if the tone is muddy.
	- 2.8–4 kHz, about -1 to -3 dB, only if the 498T gets sharp.
5. Compressor: light glue only, 1–2 dB gain reduction.
6. Optional saturation: very gentle, and level-match the output.
7. Track fader: final placement in the mix.
8. Guitar bus: 1 dB of glue compression max, HPF around 80 Hz, tiny vocal-pocket cuts only.

### Preset names

- Track preset: `FM Guitar G6 - Rhythm`
- Bus preset: `FM Guitar Bus - Glue`

### Chain rule

Do not add another amp sim in Studio One. The G6 is the tone source; Studio One is for cleanup, control, and automation.

### Rhythm track

1. Event/clip gain: trim so loud sections peak around -12 to -8 dBFS before inserts.
2. HPF EQ: 75 Hz start point, move to 80 Hz if the low end is still too thick.
3. Subtractive EQ:
	- 250–300 Hz, about -2 dB, medium Q, if the tone is muddy.
	- 2.8–4 kHz, about -1 to -3 dB, only if the 498T gets sharp.
4. Compressor: light glue only, 1–2 dB gain reduction, slow enough to keep pick attack alive.
5. Optional saturation: use only if the track feels too sterile, and level-match the output.
6. Track fader: bring the part into the mix here, not with extra gain on the inserts.

### Lead track

1. Same cleanup as rhythm.
2. Add a little more mid presence instead of more top-end.
3. Use more compression than rhythm only if you need sustain, but keep it subtle.
4. Add delay/reverb on sends, not as inserts.

### Guitar bus

1. Bus comp: 1 dB gain reduction max.
2. HPF: about 80 Hz.
3. Subtractive EQ: tiny cuts only, mainly to keep vocals clear.
4. No heavy saturation or limiting on the guitar bus unless the whole mix is already balanced.

### Red Light Dist reference settings

If you want to use Red Light Dist as a color box on guitars, start here:

- Type: Soft Tube
- Stages: I
- Drive: 1.2 to 2.0
- Distortion: 0.9 to 2.0
- Mix: 10% to 18%
- Input: just enough to tickle it, not slam it
- Output: level-match bypassed vs enabled

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
