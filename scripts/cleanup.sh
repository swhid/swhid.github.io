#!/usr/bin/env bash
set -euo pipefail

# Cleanup script for SWHID monorepo
# Removes all generated files and temporary directories

echo "==> Cleaning up generated files and temporary directories..."

# Remove Python virtual environment
if [ -d ".venv" ]; then
    echo "  Removing Python virtual environment (.venv/)"
    rm -rf .venv/
fi

if [ -d "venv" ]; then
    echo "  Removing Python virtual environment (venv/)"
    rm -rf venv/
fi

# Remove MkDocs build output
if [ -d "site" ]; then
    echo "  Removing MkDocs build output (site/)"
    rm -rf site/
fi

if [ -d "build" ]; then
    echo "  Removing build directory (build/)"
    rm -rf build/
fi

# Remove generated monorepo files
echo "  Removing generated monorepo files"
rm -f .monorepo-overlays/spec-*.mkdocs.yml
rm -rf docs/swhid-specification/
rm -f nav.yml

# Remove git worktrees for specification versions
echo "  Removing git worktrees for specification versions"
if [ -d "sources/specification" ]; then
    cd sources/specification
    for worktree in $(git worktree list --porcelain | grep "worktree" | cut -d' ' -f2 | grep "specification-v"); do
        if [ -d "$worktree" ]; then
            echo "    Removing worktree: $worktree"
            git worktree remove "$worktree" --force 2>/dev/null || true
        fi
    done
    cd ../..
fi

# Remove git submodule remnants
echo "  Removing git submodule remnants"
if [ -d ".git/modules" ]; then
    echo "    Removing .git/modules directory"
    rm -rf .git/modules/
fi

# Remove sources directory completely (includes submodules and worktrees)
if [ -d "sources" ]; then
    echo "  Removing sources directory (submodules and worktrees)"
    rm -rf sources/
fi

# Deinitialize all submodules to clean up git configuration
echo "  Deinitializing git submodules"
git submodule deinit --all -f 2>/dev/null || true

# Clean up any remaining git configuration
echo "  Cleaning up git configuration"
# Note: We keep .gitmodules as it defines our submodule structure

# Remove any stale git references
echo "  Removing stale git references"
git config --remove-section submodule.sources/specification 2>/dev/null || true
git config --remove-section submodule.sources/governance 2>/dev/null || true

# Remove Python cache files
echo "  Removing Python cache files (__pycache__/)"
find . -name "__pycache__" -type d -prune -exec rm -rf {} + 2>/dev/null || true
find . -name "*.pyc" -delete 2>/dev/null || true
find . -name "*.pyo" -delete 2>/dev/null || true

# Remove Pagefind search index
if [ -d "pagefind" ]; then
    echo "  Removing Pagefind search index (pagefind/)"
    rm -rf pagefind/
fi

# Remove temporary files
echo "  Removing temporary files"
find . -name "*.tmp" -delete 2>/dev/null || true
find . -name "*.temp" -delete 2>/dev/null || true
find . -name "*.log" -delete 2>/dev/null || true
find . -name "*.bak" -delete 2>/dev/null || true
find . -name "*.backup" -delete 2>/dev/null || true

# Remove IDE files
echo "  Removing IDE files"
find . -name ".vscode" -type d -prune -exec rm -rf {} + 2>/dev/null || true
find . -name ".idea" -type d -prune -exec rm -rf {} + 2>/dev/null || true
find . -name "*.swp" -delete 2>/dev/null || true
find . -name "*.swo" -delete 2>/dev/null || true
find . -name "*~" -delete 2>/dev/null || true

# Remove OS-generated files
echo "  Removing OS-generated files"
find . -name ".DS_Store" -delete 2>/dev/null || true
find . -name "Thumbs.db" -delete 2>/dev/null || true
find . -name "._*" -delete 2>/dev/null || true

# Remove test coverage files
echo "  Removing test coverage files"
find . -name ".coverage" -delete 2>/dev/null || true
find . -name ".coverage.*" -delete 2>/dev/null || true
find . -name "htmlcov" -type d -prune -exec rm -rf {} + 2>/dev/null || true
find . -name ".pytest_cache" -type d -prune -exec rm -rf {} + 2>/dev/null || true
find . -name ".tox" -type d -prune -exec rm -rf {} + 2>/dev/null || true

# Remove Node.js files (if any)
if [ -d "node_modules" ]; then
    echo "  Removing Node.js modules (node_modules/)"
    rm -rf node_modules/
fi

find . -name "npm-debug.log*" -delete 2>/dev/null || true
find . -name "yarn-debug.log*" -delete 2>/dev/null || true
find . -name "yarn-error.log*" -delete 2>/dev/null || true

echo "==> Cleanup completed successfully!"
echo "   All generated files, temporary files, and build artifacts have been removed."
