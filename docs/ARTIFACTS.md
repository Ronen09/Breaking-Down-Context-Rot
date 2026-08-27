# Artifacts: what is tracked, what is not, and where the rest lives

## What is in git

Everything under `results/` except raw binary state dumps. That means `summary.json`,
`turns.csv`, `attention_stats.csv`, and the UPPERCASE run notes. These are the provenance
chain. `context_fatigue_paper/numbers.md` maps every number in the paper to a file here,
and `context_fatigue_paper/AUDIT_2026-08-26.md` records which of those reproduce.

Keep it that way. Do not add a blanket `results/` or `data/` rule to `.gitignore`. The
original shared repo had one, and 995 files were force-added past it, so the ignore file
said the opposite of what the repo did.

## What was removed at the split

546 `.npz` files, 422 MB, against 3.9 MB for everything else under `results/context_fatigue`.
They were stripped from git history on 2026-08-27 rather than carried into this repo.

| Directory | Files | What they hold |
|---|---|---|
| `e3c_hot_close/` | 365 | per-row hot-set attention state |
| `e1_rows/` | 160 | per-row distance-sweep state, `s{seed}_d{depth}_p{pos}_{arm}.npz` |
| `e7_*`, `qwen_e7_*` | 19 | `delivery_states.npz`, the activation-patch donor states |
| `e3c_hot_close_preflight/` | 2 | preflight |

The single largest was `e7_bisect_pos_template_olmo/delivery_states.npz` at 81.5 MB.

These live on the A100 box. They are inputs to re-analysis, not to any paper number that
is not already summarized in a committed CSV or JSON. Nothing in the current test suite
reads them.

To re-attach, copy the directories back under `results/context_fatigue/`. The `.gitignore`
will keep them untracked, which is intended.

## What is missing and being recovered

Separate problem from the above. These directories were never committed anywhere, in this
repo or the original, though `numbers.md` and `paper_figures.py` cite them. The 2026-08-26
audit found this. Nine tests fail on a fresh clone because of it.

- The OLMo E6 erosion program: `e6_code/`, `e6_gsm8k/`, `e6_mmlu/`, `e6_*_spans/`,
  `e6_mmlu_recovery/`, `e6_exemplar_close/`, `e6_format_probes/`, `e6_mode_steering*`,
  `e6_probe_dir_erase_*`, and `E6_FORMAT_EROSION.md`.
- Original OLMo competition and head artifacts: `e3_competition/`, `e3_attention/`,
  `e3c_competitor_close/`, `e1_heads_all/`, `e3_heads_all/`.
- The adherence run, which exists as a prose note with no `summary.json` or `turns.csv`.
- `random_context_topbin/turns_pooled.csv`, behind the n=699/1001 nulls.

The tiered recovery list is in `tasks/todo.md`. Once these land, commit the small files
here and the nine failing tests should pass.
