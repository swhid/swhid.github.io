#!/usr/bin/env bash
set -euo pipefail

npx chokidar 'docs/**/*' 'overrides/**/*' 'mkdocs.yml' 'templates/**/*' 'scripts/**/*' -c 'mkdocs build && npx pagefind --site site --output-path site/pagefind --force-language en --exclude-selectors ".md-header,.md-tabs,.md-footer,.swhid-banner"'
