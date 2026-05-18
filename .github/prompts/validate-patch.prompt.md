---
mode: agent
description: Validate a patch recipe against the FX catalog and the Zoom G6 hard constraints. Reports every violation, fixes nothing automatically.
---
# Validate Patch

Pre-finalization audit of a recipe. Report violations; do not silently fix them.

## Inputs
- Path to the recipe under `patches/`.

## Checks (run all, list every failure)

### A. Schema
- Filename matches `<artist>_<track>_<tone-tag>.md`, no spaces, lowercase.
- All 8 sections from [patches/_TEMPLATE.md](../../patches/_TEMPLATE.md) present in order.
- `Status:` is one of `draft`, `iterating`, `finalized`.

### B. Source-of-truth
- For each effect in §3:
  - Exact name appears verbatim in [reference/E_G6_FX-list_2.txt](../../reference/E_G6_FX-list_2.txt).
  - Catalog cite is present (section header + page).
- For each parameter in §4:
  - Parameter name exists for that effect in the catalog.
  - Value is within the catalog-printed range.

### C. Chain discipline
- Total active slots ≤ 9.
- Category order matches the default DYNAMICS → FILTER → DRIVE → AMP → CABINET → MODULATION → SFX → DELAY → REVERB → PEDAL → SND-RTN → IR, OR §5 contains a non-empty justification.
- At most one AMP, at most one CABINET, at most one IR (unless catalog explicitly allows).

### D. A/B log
- §7 has at least one row.
- Each row has date, feedback, deltas, result — no empty cells.
- For `Status: finalized`, at least one row must record explicit user approval.

### E. Finalization
- If `Status: finalized`, every checkbox in §8 must be ticked.

## Output
Produce a checklist with PASS / FAIL per check. For each FAIL, quote the offending line(s) from the recipe and state the rule that was violated. Do not modify the recipe.
