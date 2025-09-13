#!/usr/bin/env bash
set -euo pipefail

# Read pins (or allow overrides via env)
read_ref () { ruby -ryaml -e "p YAML.load_file('sources.lock.yml').dig('$1','ref')" ; }
SPEC_REF="${SPEC_REF:-$(read_ref spec)}"
GOV_REF="${GOV_REF:-$(read_ref gov)}"
DSN_REF="${DSN_REF:-$(read_ref design)}"

mkdir -p .ext
[ -d .ext/spec ]   || git clone https://github.com/swhid/specification .ext/spec
[ -d .ext/gov ]    || git clone https://github.com/swhid/governance    .ext/gov
[ -d .ext/design ] || git clone https://github.com/swhid/swhid-design  .ext/design
(cd .ext/spec && git fetch --all && git checkout "$SPEC_REF" || git checkout main)
(cd .ext/gov  && git fetch --all && git checkout "$GOV_REF"  || git checkout main)
(cd .ext/design && git fetch --all && git checkout "$DSN_REF" || git checkout main)

python3 -m venv .venv && . .venv/bin/activate
pip install -U pip mkdocs mkdocs-material

mkdir -p .ext/spec/docs/assets/design .ext/gov/docs/assets/design
cp assets/design/tokens.css      .ext/spec/docs/assets/design/
cp assets/design/swhid-brand.css .ext/spec/docs/assets/design/
cp assets/design/tokens.css      .ext/gov/docs/assets/design/
cp assets/design/swhid-brand.css .ext/gov/docs/assets/design/

(cd .ext/spec && mkdocs build -d ../../.tmp_spec)
(cd .ext/gov && mkdocs build -d ../../.tmp_gov)
rm -rf specification governance
mv .tmp_spec specification
mv .tmp_gov  governance

echo "MkDocs outputs ready under ./specification and ./governance"
echo "Now run: bundle install && bundle exec jekyll serve --livereload"
