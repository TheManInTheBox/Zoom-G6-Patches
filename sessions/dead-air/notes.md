# Dead Air - Studio One Song Template

## Template Name

FM - Dead Air - Drop A

## Song Setup

- Sample rate: 48 kHz
- Bit depth: 24-bit
- Pan law: -3 dB
- Song length: 3:30 initial timeline
- Tempo map: set from reference before tracking; start with fixed tempo and convert to map after drums lock
- Tuning context: Drop A guitars

## Folder and Track Layout

### Drums folder

- Kick In
- Snare Top
- Snare Bottom
- Toms
- Overheads L/R
- Room
- Drum Bus

### Bass folder

- Bass DI
- Bass Grind (parallel)
- Bass Bus

### Guitar folder

- GTR Rhythm L
- GTR Rhythm R
- GTR Lead
- Guitar Bus

### Vocals folder

- Vox Lead Melodic
- Vox Lead Harsh
- Vox Double L
- Vox Double R
- Vocal Bus

### FX and Print

- FX Plate
- FX Slap
- FX Throw
- Mix Bus
- Print Ref (muted, no output to mix bus)

## Routing Rules

- All audio tracks route to their instrument bus.
- Instrument buses route to Mix Bus.
- FX returns route to Mix Bus.
- Print Ref track output routes directly to Main Out (not Mix Bus).

## Insert Preset Map

- GTR Rhythm L/R: FM Guitar G6 - Rhythm
- GTR Lead: FM Guitar G6 - Lead
- Vox Lead Melodic: FM Vocal SM7B - Lead
- Vox Lead Harsh: FM Vocal SM7B - Lead (duplicate then bypass pitch correction stage)
- Guitar Bus: FM Guitar Bus - Glue
- Vocal Bus: FM Vocal Bus - Glue

## Send Defaults

- GTR Rhythm L/R -> FX Plate: -22 dB
- GTR Lead -> FX Plate: -18 dB
- GTR Lead -> FX Slap: -20 dB
- Vox Lead Melodic -> FX Plate: -16 dB
- Vox Lead Melodic -> FX Slap: -18 dB
- Vox Lead Harsh -> FX Plate: -20 dB
- Vox Lead Harsh -> FX Slap: -22 dB

## Gain Staging Targets

- Recorded clips before inserts: peak -12 to -8 dBFS
- Guitar bus glue compression: <= 1 dB GR
- Vocal bus glue compression: 1 to 2 dB GR
- Mix bus limiter ceiling: -3.5 dBTP while producing

## Dead Air Build Procedure

1. Create a new empty Studio One song with settings above.
2. Create folders, tracks, buses, and FX channels in the order listed.
3. Apply the preset map exactly.
4. Import the reference to Print Ref and level-match by ear at chorus impact sections.
5. Save as song template: FM - Dead Air - Drop A.
6. Save a working song copy under sessions/dead-air.

## First-Pass QC Checklist

- Palm mutes stay tight when bass and kick are unmuted.
- Harsh vocals stay readable without top-end fizz.
- Lead vocal stays forward around 1 kHz to 4 kHz without sounding nasal.
- Rhythm guitars sound slightly lean in solo but heavy in full mix.
- Mix bus has headroom and does not hit limiter hard during arrangement peaks.
