---
applyTo: "patches/**/*.md"
---
# Patch Recipe Rules

You are editing a Zoom G6 patch recipe. Enforce the rules below without exception.

## Schema
- Every recipe MUST extend [patches/_TEMPLATE.md](../../patches/_TEMPLATE.md). All 8 sections present, in order.
- File name: `<artist>_<track>_<tone-tag>.md`, lowercase, snake/kebab only, no spaces.
- Header block MUST set `Status:` to one of `draft`, `iterating`, `finalized`.

## Source-of-Truth
- Every effect listed in §3 MUST appear verbatim in [reference/E_G6_FX-list_2.txt](../../reference/E_G6_FX-list_2.txt).
- Every parameter in §4 MUST be present in that catalog entry, with the value inside the catalog-stated range.
- "Catalog cite" column is REQUIRED — page number from the FX list, or the `[ CATEGORY ]` section header it falls under.
- If a value would fall outside the range, do NOT clamp silently — surface the conflict to the user.

## Chain Discipline
- Maximum 9 active effect slots. Reject longer chains.
- Default category order: DYNAMICS → FILTER → DRIVE → AMP → CABINET → MODULATION → SFX → DELAY → REVERB → PEDAL → SND-RTN → IR.
- Out-of-order chains require a non-empty §5 justification. No justification = reject.
- At most one AMP and one CABINET/IR unless the catalog says otherwise.

## A/B Log
- Every iteration MUST append a row to §7 with: date, verbatim user feedback, the exact param deltas applied, and the observed result.
- Never silently overwrite param values. Old → new must be visible in the delta column for that iteration.

## Finalization
- `Status: finalized` requires every box in §8 checked, and at least one A/B row where the user explicitly approved.
- If any check fails, refuse to set `finalized` and list the failures.
