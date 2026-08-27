# Breaking Down Context Rot in LLMs

Long-context degradation is usually reported as one curve. This work splits it into
separate mechanisms and asks which of them actually cost anything.

Accumulation on its own is the null arm. Filling a window with unrelated turns does not
by itself hurt accuracy. The mechanisms that do cost something are displacement (evidence
losing attention mass to the rest of the context), competition (a near-duplicate
distractor competing with the evidence), and precedent (the model settling into a
demonstrated answer format and staying there).

Competition is architecture-indexed. It shows a penalty on OLMo-2-7B and closing the
competitor span recovers 59% of it. The same panel on Qwen2.5-7B shows no penalty, and
the attention signature inverts. Positive claims about competition rest on OLMo.

Paper sources and the built PDF are in `context_fatigue_paper/`.

## Layout

- `scripts/context_fatigue/` — experiment drivers, all plain argparse CLIs. Run them from
  the repo root. `_cf_common.py` is the shared helper and several drivers sibling-import
  each other, so the root has to be on `PYTHONPATH`.
- `src/probes/context_fatigue/` — the library. Attention clamping and capture, context
  assembly, instruction checks, dilution and head analysis, figure generation.
- `tests/probes/context_fatigue/` — one test module per library module.
- `results/context_fatigue/` — the provenance store. Every number in the paper traces
  here through `context_fatigue_paper/numbers.md`.
- `context_fatigue_paper/` — LaTeX sources, `numbers.md`, and `AUDIT_2026-08-26.md`.

## Setup

```bash
uv sync
```

## Tests

```bash
make test    # CPU only, no network
```

Nine tests currently fail on a fresh clone. They read artifact directories that were never
committed and are being recovered. See `docs/ARTIFACTS.md` and the recovery list in
`tasks/todo.md`.

## Paper

```bash
make paper      # builds context_fatigue_paper/context_fatigue.pdf
make figures    # regenerates the figures from results/
```

## Provenance

`context_fatigue_paper/AUDIT_2026-08-26.md` is the honest record of what holds up. It lists
every claim that was recomputed from committed artifacts, the corrections that came out of
that pass, and the gaps that are still open. Read it before trusting a number.

## History

This repo was split out of a shared multi-paper repository on 2026-08-27. Commit history
for the Paper B paths is preserved. The `.npz` raw state dumps were removed from that
history because they ran to 422 MB against 3.9 MB for everything else.
