# Upstream-triggered site rebuilds

## Goal
Automatically rebuild and deploy the site whenever upstream content repos (specification, governance) change.

## Recommended approach: repository_dispatch + submodule update
This approach triggers the site build as soon as upstream pushes land, without polling.

### 1) Prepare credentials
- Create a bot token (fine-grained PAT or GitHub App) with minimal permissions to the `swhid.github.io` repo:
  - Permissions: contents:read, contents:write (for committing submodule bumps), metadata:read, actions:write (optional for dispatch).
- Store it as a secret in each upstream repo:
  - Secret name suggestion: `SWHID_SITE_TOKEN`.

### 2) Upstream repos → send repository_dispatch on push
Add a workflow to each upstream (`specification`, `governance`). Example `.github/workflows/notify-site.yml`:

```yaml
name: Notify swhid.github.io on updates
on:
  push:
    branches: [ main ]
jobs:
  dispatch:
    runs-on: ubuntu-latest
    steps:
      - name: Trigger site rebuild
        run: |
          curl -X POST \
            -H "Authorization: token ${{ secrets.SWHID_SITE_TOKEN }}" \
            -H "Accept: application/vnd.github+json" \
            https://api.github.com/repos/swhid/swhid.github.io/dispatches \
            -d '{"event_type":"upstream-updated","client_payload":{"source":"${{ github.repository }}","sha":"'${{ github.sha }}'"}}'
```

### 3) Site repo → listen, update submodules, build, deploy
Add a workflow in `swhid.github.io` (e.g. `.github/workflows/build-on-dispatch.yml`):

```yaml
name: Build on upstream update
on:
  repository_dispatch:
    types: [upstream-updated]

permissions:
  contents: write
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          submodules: recursive
          fetch-depth: 0

      - name: Update submodules to latest upstream
        run: |
          git submodule update --init --recursive --remote
          if ! git diff --quiet; then
            git config user.name "swhid-bot"
            git config user.email "bot@swhid.org"
            git commit -am "chore(submodules): bump to latest upstream"
            git push
          fi

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: pip install -r requirements.txt

      - name: Build
        run: mkdocs build

      - name: Deploy to GitHub Pages
        uses: actions/deploy-pages@v4
```

### 4) Test plan
- Manually dispatch from an upstream repo once (Actions → Run workflow) and verify site workflow runs, bumps submodules, builds, and deploys.
- Break-glass: temporarily echo-only the submodule commit/push step to validate diffs before enabling write.

## Options and variants

### A) Add scheduled polling fallback (optional)
Catches missed dispatches. Extend the site workflow triggers:

```yaml
on:
  schedule:
    - cron: '*/30 * * * *'  # every 30 minutes
  repository_dispatch:
    types: [upstream-updated]
```

In the job, keep the same `git submodule update --remote` + conditional commit to bump pointers.

### B) Open PR instead of direct push (review gate)
Use a PR flow to review submodule pointer bumps:

```yaml
- uses: peter-evans/create-pull-request@v6
  with:
    commit-message: chore(submodules): bump to latest upstream
    title: chore(submodules): bump to latest upstream
    body: Auto-bump submodules to latest commits
    branch: chore/bump-submodules
    labels: automated
```

### C) Security hardening
- Use a GitHub App instead of a PAT when possible; restrict to target repo.
- Scope token minimally; rotate regularly.
- Set workflow `permissions:` explicitly (as above) and avoid default write-all.
- Validate payload `client_payload.source` if you add conditional paths.

### D) Observability
- Add summary annotations and artifacts (e.g. `mkdocs config` output, list of changed files).
- Optional Slack/Webhook notification on success/failure.

## Rollback
- Revert the submodule bump commit in `swhid.github.io` to roll back the site content to the prior upstream snapshot.

## Next steps (actionable)
1. Create/choose bot credentials; store as `SWHID_SITE_TOKEN` in both upstream repos.
2. Add `notify-site.yml` to upstream repos (push on `main`).
3. Add `build-on-dispatch.yml` to `swhid.github.io` (listen, update submodules, build, deploy).
4. Dry-run test via manual dispatch; then merge and monitor first automatic run.
