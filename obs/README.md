# OBS Studio Configuration

Scene collections, profiles, and audio routing for Fat Man streams + recordings.

## Audio Routing (confirmed)

```
Fender Studio Pro master out
  → Quantum HD 8 loopback channel (configured in PreSonus UC Surface)
  → OBS audio source (select Quantum HD loopback input)

HyperX QuadCast (USB)
  → OBS audio source (separate channel for stream commentary)
```

Two audio sources in OBS: the loopback for the music/DAW, the QuadCast for talking over the stream. Keep the QuadCast OUT of the DAW chain entirely.

## Streaming targets (confirmed: Twitch + YouTube simultaneously)

OBS sends **one** RTMP stream. Fanning out to two platforms requires one of:

| Option | How | Pros | Cons |
|---|---|---|---|
| **Restream.io** (recommended) | OBS → Restream RTMP → Twitch + YouTube | Free tier covers 2 destinations; reliable; cloud handles fan-out (no extra CPU) | Adds cloud hop latency (~2–3s); free tier has Restream branding overlay on some plans — verify current ToS |
| **Aitum Multistream** (OBS plugin) | Multiple RTMP outputs from OBS itself | No cloud dependency; no branding; full local control | Doubles encoder CPU/GPU load; if one platform stutters, can affect both |
| **OBS Multiple RTMP Outputs** plugin | Same as Aitum but older plugin | Free, established | Same CPU cost; less polished UI |
| **Twitch Enhanced Broadcasting / YouTube Live native multistream** | Platform-side | Platform-supported | YouTube doesn't currently support multistream-in for RTMP; not a fit |

**Default: Restream.io free tier.** Re-evaluate if you hit the free-tier limits or want zero-latency local control.

## Encoder recommendations

For a music streaming + recording setup:

| Target | Encoder | Bitrate | Resolution | FPS | Notes |
|---|---|---|---|---|---|
| Twitch | NVENC (or x264 medium) | 6000 kbps | 1080p | 60 | Twitch caps at 6000 kbps for non-partners |
| YouTube | NVENC | 9000–12000 kbps | 1080p | 60 | YouTube allows higher; pick based on upload bandwidth |
| Local recording | NVENC, CQP 18–20 | — (quality-based) | 1080p or higher | 60 | Higher quality than the stream; use for archives |

If using **Restream**, set OBS to one bitrate (Restream re-encodes for each destination if needed on paid tiers; on free tier it passes through).

## Files (when populated)

- `scene-collections/` — exported `.json` scene collections (OBS → Scene Collection → Export).
- `profiles/` — exported profiles (encoder settings, output paths, hotkeys).

## Open Questions

- **Restream account exists?** If not, that's the first step.
- **Stream key management** — stream keys must NOT be committed to git. Store in OBS profiles only.
- **Video sources** — webcam? Multiple cameras? Screen capture? Affects scene design.

## Next Action

Confirm Restream.io account access; export current OBS scene collection + profile (if any exist) to `scene-collections/` and `profiles/`; then build a base Fat Man scene.
