---
mode: agent
description: Start a new Zoom G6 patch recipe from a .wav in samples/. Runs analysis tasks, then drafts the recipe.
---
# New Patch

Author a new Zoom G6 patch recipe.

## Inputs you must collect (ask one at a time if missing)
1. Path to the `.wav` under `samples/`.
2. Target tone description (artist + track + timestamp, or a verbal description).
3. Desired tone tag (one short kebab-case slug, e.g., `tight-metal-rhythm`).

## Steps
1. Confirm the `.wav` exists. If not, stop and ask.
2. Run the `Analyze: All` VS Code task with the supplied `.wav`. Wait for it to finish.
   - If FFmpeg or SoX is missing, output the exact install command for Windows (`winget install Gyan.FFmpeg`, `winget install ChrisBagwell.SoX`) and stop.
3. Read `analysis/<basename>/loudness.txt` and `analysis/<basename>/sox-stat.txt`. Note the spectrogram path for the user to view.
4. Create `patches/<artist>_<track>_<tone-tag>.md` by copying `patches/_TEMPLATE.md`.
5. Fill §1 (summary) and §2 (analysis snapshot) with concrete numbers from the artifacts.
6. Propose the chain in §3 and starting parameters in §4, following the `g6-patch-authoring` skill and the rules in [.github/instructions/patches.instructions.md](../instructions/patches.instructions.md).
7. Cite [reference/E_G6_FX-list_2.txt](../../reference/E_G6_FX-list_2.txt) for every effect (section header + page).
8. Hand to the user with a single question: "Dial this in and tell me what's wrong."
