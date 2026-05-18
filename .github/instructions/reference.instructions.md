---
applyTo: "reference/**"
---
# Reference Catalog Rules

The files in `reference/` are the **single source of truth** for Zoom G6 effects and parameters.

## Files (in priority order)
1. **`reference/g6-fx-catalog.yaml`** — the structured, machine-readable catalog. **Use this for all programmatic lookups** (effect names, parameter names, ranges, enum values, signal-flow order).
2. **`reference/E_G6_FX-list_2.pdf`** — the original Zoom-published PDF. Authoritative for any visual element the YAML/TXT cannot represent (the two glyph tables, musical-note glyphs, layout context).
3. **`reference/E_G6_FX-list_2.txt`** — the raw OCR text dump that backs the YAML. Use it to verify the YAML against source wording, or to chase down anything missing from the YAML.

If the YAML and the TXT/PDF ever disagree, the **PDF wins**. Fix the YAML; do not silently work around it.

## Do
- Read `g6-fx-catalog.yaml` before proposing any effect or parameter value.
- When citing an effect in a recipe, include: effect name, category, source page (from the `page:` field), and exact parameter range string (the `raw:` field).
- Treat the `typed:` block as the canonical interpretation. When `kind: special` is present, read the `note:` and confirm against the PDF before assigning a value.
- When the YAML contains effect-level `notes:` flagging an OCR/source ambiguity, surface that note to the user before committing to a value.

## Do Not
- Do NOT invent effects, parameters, ranges, or enum values. If it isn't in the YAML, it doesn't exist on the G6.
- Do NOT paraphrase ranges in recipes (e.g., "around 50"). Use the catalog's exact notation from `raw:`.
- Do NOT silently edit files in `reference/` to "fix" a perceived inconsistency — call it out and confirm with the user (and the PDF) first.
- Do NOT extend a parameter's range past the catalog values, even by one. Out-of-range = invalid patch.

## YAML Schema Quick Reference
```yaml
categories:
  <CATEGORY>:
    effects:
      - name: <EffectName>
        page: <int>           # PDF page number
        description: <verbatim from catalog>
        params:
          - name: <ParamName>
            description: <verbatim>
            raw: "<exact source range string>"
            typed:
              kind: int | float | enum | special
              # int/float: min, max, optional unit
              # enum: values: [...]
              # special: note: "<explanation of the irregular range>"
        notes: [<optional effect-level caveats>]
```

## When the Catalog Is Ambiguous
- The TXT is OCR — line wraps can split a parameter from its range, and musical-note glyphs (♩ ♪) plus a couple of small tables were dropped. The YAML flags every such case with `kind: special` + a `note:`, or an effect-level `notes:` entry.
- For anything flagged, cross-check the PDF before assigning a value. Never guess.
- If the PDF reveals the YAML is wrong, update the YAML in the same change that uses the corrected value, and tell the user what was fixed.
