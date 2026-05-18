---
mode: agent
description: Iterate on an existing patch recipe using the user's A/B feedback. Proposes precise param deltas and logs them.
---
# Iterate Patch

Refine an existing recipe based on the user's listening feedback.

## Inputs you must collect (ask if missing)
1. Path to the recipe file under `patches/`.
2. The user's A/B feedback in their own words (e.g., "low-mids are muddy", "attack feels slow", "too much reverb tail").

## Steps
1. Read the recipe. Re-state the current chain and the slot/param values that are candidates to change.
2. For each piece of feedback, propose a focused delta:
   - Name the slot, the parameter, the current value, and the new value.
   - Cite [reference/E_G6_FX-list_2.txt](../../reference/E_G6_FX-list_2.txt) for the parameter's range. New value MUST be in range.
   - Explain in one sentence why the delta should address the feedback.
3. Prefer the smallest number of changes that could plausibly fix the complaint. Do not touch slots unrelated to the feedback.
4. If the feedback implies an effect the chain lacks (e.g., "needs a slapback"), propose adding a slot only if total slots stay ≤ 9 and category order is preserved (or you can justify a deviation in §5).
5. Apply the changes to the recipe file:
   - Update §4 parameter values.
   - Append a row to §7 (A/B Iteration Log) with date, verbatim feedback, deltas, and "expected" result.
6. Hand back to user with: "Re-dial and A/B again. What's still off?"
