# Paper B repo split — done 2026-08-27

This repo was extracted from the shared multi-paper repo `justinshenk/temporal-awareness`,
branch `context-fatigue-datasets`, at commit `7c2b359`.

## How it was done

Two `git-filter-repo` passes over a fresh clone. The first kept the Paper B paths and the
shared infrastructure, the second stripped `*.npz` from all of history. Result: 626 MB of
`.git` down to about 10 MB, 198 commits preserved, 320 files tracked.

The keep-list, for reference if this ever has to be redone:

`context_fatigue_paper/`, `scripts/context_fatigue/`, `src/probes/context_fatigue/`,
`tests/probes/context_fatigue/`, `results/context_fatigue/`, `data/context_fatigue/`,
`results/{f90871_steering,random_context,olmo_gradient,olmo_gradient_n35}/`,
`results/olmo_attention_{instruct,sft,dpo}/`, `data/adversarial/narrativeqa/`,
`src/common/`, `src/probes/{__init__,ddxplus}.py`,
`src/probes/safety/{__init__,steering_hook}.py`,
`src/probes/lora_icl/{__init__,ddxplus_cases}.py`, the tests scaffolding
(`conftest.py`, the `__init__.py` chain, `tests/common/test_bootstrap_stats.py`), the
Paper B `tasks/*.md`, and the repo infra files.

One correction was needed mid-split. The first pass missed
`results/olmo_attention_instruct/` and `results/olmo_attention_dpo/`, which
`null_statistics.py` and `paper_figures.py` read through the `olmo_attention_{model}`
pattern. Three tests failed that pass in the original repo. The extraction was redone with
the corrected list rather than patching the files in, so those artifacts keep their history.

## Changes made on top of the extraction

- `src/common/null_intervals.py` removed. It was Paper A only.
- `pyproject.toml` renamed and cut from 33 dependencies to 11, derived from actual imports
  rather than guessed. Dropped dash, fastapi, uvicorn, plotly, pacmap, umap-learn, nnsight,
  pyvene, transformer_lens, peft, tensorboard, and the `latents` git dependency. The ruff
  and pytest config carried over unchanged except for new per-file ignores.
- `.gitignore` rewritten to be honest. The old one blanket-ignored `results/`, `data/`, and
  `tasks/` while 995 files were force-added past it. Now only the raw binary dumps are
  ignored, and no tracked file is covered by an ignore rule.
- `Makefile`: `paper-a` dropped, `lint` and `figures` added.
- CI: dropped the lint path to a directory that does not exist and the mypy job that
  installed no mypy. Removed eight `--ignore` entries for Paper A test files.
- `CLAUDE.md` Key Entry Points rewritten for one project.
- `README.md` rewritten. The old Paper B summary described an earlier framing.
- `docs/`: `ARTIFACTS.md` written, `SETUP.md` rewritten (the old one referenced
  `scripts/experiments/`, Stanford Sherlock, and make targets that do not exist),
  `RELATED_WORK.md` and `CONTRIBUTING.md` dropped as stale.
- `.env.example` cut to `HF_TOKEN`, dropping unused API keys and the old GCP project IDs.
- ruff per-file ignores added for the driver scripts. E701, E401, and F541 are pre-existing
  and deliberate in research scripts. F821 on `run_sycophancy_final.py` is a ruff 0.14 false
  positive, verified against the compiled code objects, which list `model` and `tokenizer`
  as closure freevars.

## Verification

- `ruff check src/ scripts/ tests/` passes.
- `pytest -m "not slow"`: 312 pass, 9 fail. The same 9 fail in the original repo. They read
  artifact directories that were never committed anywhere. See `docs/ARTIFACTS.md`.
- The paper builds: 23 pages, no LaTeX errors, no overfull boxes.
- Every package import resolves, including the two carried-over leaf dependencies.

## Still to do

1. Push to GitHub under Ronen's account. `gh` is not installed on this machine, so the
   empty repo has to be created in the browser first, then `git remote add origin` and push.
2. Land the recovered artifacts from the A100 box. See the tiered list in `todo.md`. The
   nine failing tests should pass once the E6 and competition directories are committed.
3. In the old repo, inline `pearson` in `scripts/safety/analyze_route_sweep.py` and vendor
   `SelectiveAttentionCapture` in `scripts/safety/run_attention_base_vs_lora.py`. Those are
   the only two Paper A imports that reach into `src/probes/context_fatigue/`. Then the
   Paper B trees can be deleted there. Not urgent.
