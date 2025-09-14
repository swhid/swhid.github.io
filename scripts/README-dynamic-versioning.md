# Dynamic Version Detection for SWHID Specification

This directory contains scripts for automatically detecting and building specification versions without manual intervention.

## Overview

The dynamic version detection system automatically:
- Detects available specification versions from git tags
- Generates version selector configuration
- Builds all detected versions with unified theming
- Maintains version selector functionality across all pages

## Files

### Core Scripts

- **`version-detector.sh`** - Main version detection script
- **`bootstrap-dynamic.sh`** - Dynamic bootstrap script that replaces the hardcoded version
- **`bootstrap.sh`** - Original hardcoded bootstrap script (kept for reference)

### Generated Files

When the version detector runs, it creates:
- `versions.json` - Version selector configuration
- `build_commands.sh` - Dynamic build commands
- `move_commands.sh` - Directory move commands
- `version_loops.sh` - Version iteration loops
- `redirect_logic.html` - Redirect logic for latest version

## How It Works

### 1. Version Detection

The `version-detector.sh` script:
- Fetches all git tags from the upstream specification repository
- Filters tags matching the pattern `^v[0-9]+\.[0-9]+$`
- Sorts versions properly (v1.0, v1.1, v1.2, etc.)
- Identifies the latest version automatically
- Generates configuration files for the build process

### 2. Dynamic Building

The `bootstrap-dynamic.sh` script:
- Runs version detection first
- Builds each detected version dynamically
- Applies unified theming to all versions
- Adds version selector to all HTML pages
- Creates proper redirect logic

### 3. Version Selector

The version selector:
- Loads available versions from `versions.json`
- Provides dropdown navigation between versions
- Handles path resolution for different directory depths
- Includes retry logic for dynamic content loading

## Usage

### Local Development

```bash
# Run dynamic bootstrap
./scripts/bootstrap-dynamic.sh

# Start Jekyll server
bundle exec jekyll serve --port 4000 --host 0.0.0.0
```

### CI/CD

The system includes a GitHub Actions workflow (`pages-dynamic.yml`) that:
- Automatically detects versions on each build
- Builds all available versions
- Deploys to GitHub Pages

## Configuration

### Version Pattern

The version detection uses the pattern `^v[0-9]+\.[0-9]+$` by default. To modify:

```bash
# In version-detector.sh
VERSION_PATTERN="^v[0-9]+\.[0-9]+$"
```

### Latest Version Alias

The latest version gets the "latest" alias by default:

```bash
# In version-detector.sh
LATEST_ALIAS="latest"
```

## Adding New Versions

### Automatic Detection

When a new version is tagged in the upstream repository:
1. The version detector automatically finds it
2. The build process includes it automatically
3. The version selector shows it automatically
4. No manual intervention required

### Manual Override

To force detection of a specific version:

```bash
# Checkout the version in the spec repository
cd .ext/spec
git checkout v1.3
git tag v1.3  # if not already tagged

# Run version detection
cd ../..
./scripts/version-detector.sh .ext/spec specification
```

## Benefits

### Maintainability
- No more hardcoded version lists
- Automatic detection of new versions
- Single source of truth for version information

### Reliability
- Consistent version handling across all environments
- Automatic fallback to available versions
- Error handling for missing versions

### Scalability
- Supports unlimited number of versions
- Efficient build process
- Minimal maintenance overhead

## Migration from Hardcoded Versions

### Before (Hardcoded)
```bash
# Manual updates required for each new version
VERSIONS=("v1.0" "v1.1" "v1.2")
# ... hardcoded build commands
# ... hardcoded version loops
# ... hardcoded redirect logic
```

### After (Dynamic)
```bash
# Automatic detection
VERSIONS=($(get_available_versions))
# ... dynamic build commands
# ... dynamic version loops
# ... dynamic redirect logic
```

## Troubleshooting

### No Versions Found
- Check if the specification repository is accessible
- Verify git tags exist and match the pattern
- Ensure the repository is properly cloned

### Version Selector Not Appearing
- Check if `versions.json` was generated
- Verify CSS and JS files are in the correct location
- Check browser console for JavaScript errors

### Build Failures
- Ensure all required dependencies are installed
- Check if the specification repository has the required structure
- Verify MkDocs configuration is correct

## Current Status

The dynamic version detection system is now fully implemented and includes:

### ✅ Completed Features
- **Automatic version detection** from git tags
- **Dynamic building** of all detected versions
- **Version selectors** on all specification pages
- **Unified theming** across all versions
- **GitHub Actions integration** for CI/CD
- **Pagefind search index** generation
- **HTML validation** with html-proofer
- **Asset centralization** with absolute paths
- **Version selector positioning** and functionality fixes

### 🔄 Current Capabilities
- **Version Pattern**: `^v[0-9]+\.[0-9]+(-[a-zA-Z0-9]+)?$` (supports pre-release versions)
- **Latest Version Detection**: Filters out pre-release versions for official latest
- **Version Sorting**: Proper semantic version sorting
- **Error Handling**: Graceful fallbacks for missing versions
- **Retry Logic**: DOM loading retry for version selectors

### 🚀 Future Enhancements
- Support for custom version ordering logic
- Integration with upstream release automation
- Version deprecation warnings
- Analytics for version usage
- Enhanced pre-release version handling
