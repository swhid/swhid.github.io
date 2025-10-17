# Simple Makefile for SWHID unified site
SHELL := bash
PY := python3

# switch to clone mode by exporting BOOTSTRAP_MODE=clone
BOOTSTRAP_MODE ?= submodules

.PHONY: help bootstrap serve build clean cleanup lock

help:
	@echo "make bootstrap   - init/update sources"
	@echo "make serve       - mkdocs live-reload server"
	@echo "make build       - build static site"
	@echo "make clean       - remove build artifacts"
	@echo "make cleanup     - comprehensive cleanup of all generated files"

bootstrap:
	@chmod +x scripts/bootstrap.sh
	scripts/bootstrap.sh

serve:
	npx concurrently -n BUILD,HTTP \
	  "./scripts/watch-and-serve.sh" \
	  "npx http-server site -p 8000 -c-1"

build:
	mkdocs build
	npx pagefind --site site --output-path site/pagefind --force-language en \
	  --exclude-selectors '.md-header,.md-tabs,.md-footer,.swhid-banner'

clean:
	rm -rf site
	find . -name '__pycache__' -type d -prune -exec rm -rf {} +

cleanup:
	@chmod +x scripts/cleanup.sh
	scripts/cleanup.sh
