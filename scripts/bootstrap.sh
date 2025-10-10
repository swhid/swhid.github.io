#!/usr/bin/env bash
set -euo pipefail

# modes: submodules (default) or clone (legacy)
MODE="${BOOTSTRAP_MODE:-submodules}"

echo "==> Bootstrap mode: ${MODE}"

case "${MODE}" in
  submodules)
    echo "==> Initializing submodules..."
    
    # Add main submodules if they don't exist
    if ! git submodule status sources/specification >/dev/null 2>&1; then
      echo "  Adding specification submodule..."
      git submodule add https://github.com/swhid/specification.git sources/specification
    fi
    
    if ! git submodule status sources/governance >/dev/null 2>&1; then
      echo "  Adding governance submodule..."
      git submodule add https://github.com/swhid/governance.git sources/governance
    fi
    
    # Initialize and update all submodules
    git submodule sync --recursive
    git submodule update --init --recursive
    git config submodule.recurse true
    
    # Create version-specific directories by checking out tagged commits
    echo "==> Setting up specification version directories..."
    
    # Only proceed if specification submodule exists
    if [ -d "sources/specification" ]; then
      # Get available tags from the specification repository
      cd sources/specification
      git fetch --tags --quiet
      
      # Create version directories by checking out each tag
      for tag in $(git tag -l | grep -E '^v[0-9]+\.[0-9]+$' | sort -V); do
        version_dir="../specification-${tag}"
        if [ ! -d "$version_dir" ]; then
          echo "  Creating directory for version ${tag}..."
          # Check if worktree is already registered but missing
          if git worktree list --porcelain | grep -q "worktree.*$version_dir"; then
            echo "    Removing stale worktree registration for ${tag}..."
            git worktree remove "$version_dir" --force 2>/dev/null || true
          fi
          git worktree add "$version_dir" "$tag"
        fi
      done
      
      cd ../..
    else
      echo "  Warning: specification submodule not found, skipping version directories"
    fi
    ;;
  clone)
    mkdir -p sources
    [ -d sources/specification ] || git clone https://github.com/swhid/specification sources/specification
    [ -d sources/governance    ] || git clone https://github.com/swhid/governance    sources/governance
    ;;
  *)
    echo "Unknown BOOTSTRAP_MODE='${MODE}'" >&2
    exit 1
    ;;
esac

# Optional pin overrides (useful in CI or local testing):
SPEC_REF="${SPEC_REF:-}"
GOV_REF="${GOV_REF:-}"
if [ -n "${SPEC_REF}" ]; then
  (cd sources/specification && git fetch --all && git checkout "${SPEC_REF}")
fi
if [ -n "${GOV_REF}" ]; then
  (cd sources/governance && git fetch --all && git checkout "${GOV_REF}")
fi

# vendored shared assets (design kit could be a submodule as well if needed)
mkdir -p overrides/assets/stylesheets
# Extra CSS already placed in overrides/assets/stylesheets/extra.css

# Install Node.js dependencies for development tools
echo "==> Installing Node.js dependencies..."
if [ -f "package.json" ]; then
    npm install
else
    echo "Warning: package.json not found - Node.js dependencies not installed"
fi

# Ensure essential files exist for deployment
echo "==> Checking essential files..."
if [ ! -f "CNAME" ]; then
    echo "Warning: CNAME file not found - custom domain may not work"
fi
if [ ! -f "robots.txt" ]; then
    echo "Warning: robots.txt file not found - SEO may be affected"
fi

# Discover versions and generate overlays
echo "==> Discovering versions and generating overlays..."
if [ -f "scripts/bootstrap-versions.sh" ]; then
    ./scripts/bootstrap-versions.sh
else
    echo "Warning: bootstrap-versions.sh not found - versions may not be discovered"
fi

echo "==> Bootstrap done."
