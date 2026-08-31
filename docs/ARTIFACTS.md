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

## What was missing, and what still is

Separate problem from the above. The 2026-08-26 audit found directories that had never been
committed anywhere, in this repo or the original, though `numbers.md` and `paper_figures.py`
cite them. All of them were re-run or copied on the A100 box on 2026-08-27 and are now
tracked: the OLMo E6 erosion program (`e6_{code,gsm8k,mmlu}/` with `spans.csv` inside each,
`e6_mmlu_recovery/`, `e6_exemplar_close/`, `e6_format_probes/`, `e6_mode_steering*`,
`e6_probe_dir_erase_*`, `E6_FORMAT_EROSION.md`), the original OLMo competition and head
artifacts (`e3_competition/`, `e3_attention/`, `e3c_competitor_close/`, `e1_heads_all/`,
`e3_heads_all/`, `head_structure.json`), the E5 raw dirs, the adherence run
(`instruction_adherence/`), `random_context_topbin/turns_pooled.csv`, and
`capture_validation.log`. The re-runs are not byte-identical to the lost originals. The cells
that moved are listed in `E6_FORMAT_EROSION.md` ("Divergences") and `E3_RECOVERY_RERUN.md`,
and `numbers.md` marks each with its pre-recovery value.

Still missing, found 2026-08-31 when the suite was re-run against the recovered tree:

- `e1_distance_sweep/` (the OLMo distance ladder, Table 3 and Fig. 2a, and the §4.2 joint
  fit and parsed-only ladder), `e1_with_attention/` (the E1b evidence-share addendum, the
  share column of Table 3), and `e1f_share_knee/` (the E1f dose-response, Fig. 2b).
  Zero commits in any history. Their numbers currently trace only to `E1_DISTANCE_SWEEP.md`
  and `E1_MECHANISM.md`. Three tests in `test_paper_figures.py` fail on a fresh clone until
  they are re-run (`run_distance_sweep.py`) or copied from the A100 box.
