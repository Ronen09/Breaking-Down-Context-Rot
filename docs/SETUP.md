# Setup

## Prerequisites

- Python 3.12+
- A CUDA GPU with 80 GB for the full sweeps. The 7B and 9B models fit in less, but the
  long-context runs fill a 32k window and the attention-capture paths hold a full
  final-position row, so headroom matters.
- A HuggingFace token. Gemma and Llama are gated and need accepted licenses.

CPU is enough for the test suite, the analysis scripts, and the figures.

## Install

```bash
uv sync
cp .env.example .env    # then fill in HF_TOKEN
```

## Models

| Model | Used for |
|---|---|
| `allenai/OLMo-2-1124-7B-Instruct` | the main arm for every mechanism |
| `allenai/OLMo-2-1124-7B-SFT`, `-DPO`, base | the post-training chain |
| `Qwen/Qwen2.5-7B-Instruct` | cross-family replication, and the competition divergence |
| `google/gemma-2-9b-it`, `google/gemma-2-9b` | SAE arms |
| `meta-llama/Llama-3.1-8B-Instruct` | entropy forward check |

Datasets download from HuggingFace at run time: `aai530-group6/ddxplus`,
`allenai/WildChat-1M` (streamed), `cais/mmlu`, `deepmind/narrativeqa`, `gsm8k`. The DDXPlus
condition and evidence tables are vendored in `data/context_fatigue/`.

## Running experiments

Drivers are plain argparse CLIs in `scripts/context_fatigue/`. Run them from the repo root
so that `_cf_common` and the sibling driver imports resolve.

```bash
uv run python scripts/context_fatigue/run_distance_sweep.py --help
```

`scripts/context_fatigue/WRITEUP.md` documents what each driver does and the exact
invocations behind the committed results.

## Analysis and figures

The `analyze_*.py` scripts are pure re-analysis and need no GPU. They read from `results/`
and are the path from artifacts to the numbers in the paper.

```bash
make figures    # regenerates the paper figures
make test       # CPU test suite
make paper      # builds the PDF
```

## Artifacts

`docs/ARTIFACTS.md` explains what is tracked in git, which raw dumps live on the compute
box instead, and which directories are still missing and being recovered.
