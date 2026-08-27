.PHONY: install test lint paper figures clean help

help:
	@echo "Available commands:"
	@echo ""
	@echo "  make install   Install dependencies"
	@echo "  make test      Run the CPU test suite (no GPU, no network)"
	@echo "  make lint      Run ruff"
	@echo "  make paper     Build the paper PDF"
	@echo "  make figures   Regenerate the paper figures from results/"
	@echo "  make clean     Remove caches"
	@echo ""

install:
	uv sync

test:
	uv run pytest tests/ -q -m "not slow"

lint:
	uv run ruff check src/ scripts/ tests/

paper:
	cd context_fatigue_paper && tectonic context_fatigue.tex

figures:
	uv run python scripts/context_fatigue/make_paper_figures.py

clean:
	rm -rf __pycache__ */__pycache__ */*/__pycache__
	rm -rf *.egg-info .pytest_cache
