# SWHID Versioning Solution

## Overview
This document describes the solution for maintaining multiple versions of the SWHID specification with clean URLs and proper navigation isolation.

## Solution Architecture

### 1. **Clean URL Structure**
- `/swhid-specification/v1.0/` - Version 1.0 specification
- `/swhid-specification/v1.1/` - Version 1.1 specification  
- `/swhid-specification/v1.2/` - Version 1.2 specification (latest)
- `/swhid-specification/` - Redirects to latest version (v1.2)

### 2. **Overlay Configuration Files**
Instead of modifying submodules directly, we use overlay files in `.monorepo-overlays/`:

- `.monorepo-overlays/spec-v1.0.mkdocs.yml`
- `.monorepo-overlays/spec-v1.1.mkdocs.yml`
- `.monorepo-overlays/spec-v1.2.mkdocs.yml`

Each overlay file:
- Sets the correct `site_name` for clean URLs
- Points to the appropriate submodule's `docs_dir`
- Defines version-specific navigation (no cross-version links)
- Maintains the original theme and styling

### 3. **Maintenance Strategy**

#### **For Regular Updates:**
1. **Submodules update automatically** - No manual intervention needed
2. **Overlay files remain stable** - Only need updates for major structural changes
3. **Bootstrap script handles patching** - Automatically patches `site_name` if needed

#### **For New Versions:**
1. Add new submodule: `git submodule add <url> sources/specification-v1.X`
2. Create overlay file: `.monorepo-overlays/spec-v1.X.mkdocs.yml`
3. Update main `mkdocs.yml` navigation
4. Update redirect page to point to new latest version

#### **For Submodule Updates:**
- Submodules can be updated independently
- Overlay files isolate navigation changes
- No risk of breaking the main site

## Files Structure

```
swhid.github.io/
├── .monorepo-overlays/           # Overlay configuration files
│   ├── spec-v1.0.mkdocs.yml
│   ├── spec-v1.1.mkdocs.yml
│   └── spec-v1.2.mkdocs.yml
├── sources/                      # Git submodules
│   ├── specification/            # Latest version (v1.2)
│   ├── specification-v1.1/       # Version 1.1
│   └── specification-v1.0/       # Version 1.0
├── scripts/
│   ├── bootstrap.sh              # Main bootstrap script
│   └── patch-site-names.sh      # Patches site_name if needed
└── mkdocs.yml                    # Main configuration
```

## Benefits

1. **Clean URLs**: `/swhid-specification/v1.X/` format
2. **Isolated Navigation**: Each version shows only its own content
3. **Maintainable**: Overlay files are easy to update
4. **Submodule Safe**: Original submodules remain untouched
5. **Automated**: Bootstrap script handles patching
6. **Scalable**: Easy to add new versions

## Usage

### **Development:**
```bash
# Bootstrap the project
./scripts/bootstrap.sh

# Build the site
mkdocs build

# Serve locally
mkdocs serve
```

### **Adding New Version:**
1. Add submodule: `git submodule add <url> sources/specification-v1.X`
2. Create overlay file in `.monorepo-overlays/`
3. Update `mkdocs.yml` navigation
4. Update version selector page

### **Updating Existing Versions:**
```bash
# Update all submodules
git submodule update --remote

# Rebuild
mkdocs build
```

## Technical Details

### **Monorepo Plugin Configuration**
The `mkdocs-monorepo-plugin` automatically discovers and includes content from submodules. The overlay files provide:
- Correct `site_name` for URL generation
- Isolated navigation per version
- Consistent theming and styling

### **URL Generation**
The plugin uses the `site_name` from each overlay file to generate the output paths:
- `site_name: swhid-specification/v1.2` → `/swhid-specification/v1.2/`
- `site_name: swhid-specification/v1.1` → `/swhid-specification/v1.1/`
- `site_name: swhid-specification/v1.0` → `/swhid-specification/v1.0/`

### **Navigation Isolation**
Each overlay file defines its own `nav` section, ensuring that:
- Version 1.0 only shows its own chapters
- Version 1.1 only shows its own chapters  
- Version 1.2 only shows its own chapters
- No cross-version navigation links

This solution provides a robust, maintainable approach to versioning while keeping the submodules clean and updateable.
