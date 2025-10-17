# Template System Documentation

## Overview

The SWHID monorepo uses a template-based configuration system to generate MkDocs configuration files. This approach ensures consistency across all versions and makes maintenance much easier.

## Template Files

### `templates/mkdocs.yml.template`
This is the main template for the root `mkdocs.yml` file. It contains:
- Site metadata and configuration
- Theme settings with Material theme
- Plugin configurations
- Navigation structure with placeholders
- Version list with placeholders

**Template Variables:**
- `{{NAVIGATION}}` - Replaced with dynamically generated navigation
- `{{VERSIONS}}` - Replaced with YAML list of available versions

### `templates/spec-overlay.yml.template`
This template generates the overlay files for each specification version. It contains:
- Version-specific site name
- Material theme configuration with custom overrides
- Plugin configurations
- Basic navigation structure for specification chapters
- Version selector configuration

**Template Variables:**
- `{{VERSION}}` - Replaced with the specific version (e.g., "v1.2")

## Generation Process

### 1. Version Discovery
The system first discovers available versions by:
1. Looking for `sources/specification-v*` directories
2. Extracting version numbers from directory names
3. Sorting versions in descending order
4. Determining the latest version

### 2. Configuration Generation
The `scripts/generate-config.py` script:
1. Discovers available versions from the filesystem
2. Generates specification overlay files for each version
3. Generates the main `mkdocs.yml` with dynamic navigation
4. Ensures all files use consistent configuration

### 3. Template Processing
For each template:
1. Load the template file
2. Replace template variables with actual values
3. Write the processed content to the target file
4. Ensure proper YAML formatting

## Usage

### Automatic Generation
Configuration files are automatically generated when running:
```bash
make bootstrap
# or
scripts/bootstrap.sh
```

### Manual Generation
To regenerate configuration files manually:
```bash
python3 scripts/generate-config.py
```

### Force Regeneration
To force regeneration of overlay files:
```bash
OVERWRITE_OVERLAYS=1 scripts/bootstrap-versions.sh
```

## Benefits

### 1. Consistency
- All versions use identical theme and plugin configurations
- Navigation structure is consistent across versions
- Version selector works uniformly

### 2. Maintainability
- Changes to theme or plugins only need to be made in templates
- New versions automatically get correct configuration
- No risk of configuration drift between versions

### 3. Flexibility
- Easy to add new template variables
- Simple to modify configuration for all versions
- Template system can be extended for other subsites

## File Structure

```
templates/
├── mkdocs.yml.template          # Main configuration template
└── spec-overlay.yml.template    # Specification overlay template

scripts/
├── generate-config.py           # Configuration generator
├── bootstrap-versions.sh        # Version discovery and generation
└── bootstrap.sh                 # Main bootstrap script

.monorepo-overlays/
├── spec-v1.0.mkdocs.yml         # Generated overlay for v1.0
├── spec-v1.1.mkdocs.yml         # Generated overlay for v1.1
└── spec-v1.2.mkdocs.yml         # Generated overlay for v1.2

mkdocs.yml                       # Generated main configuration
```

## Adding New Versions

When a new specification version is added:

1. The version directory is created (e.g., `sources/specification-v1.3/`)
2. `bootstrap-versions.sh` discovers the new version
3. `generate-config.py` creates a new overlay file
4. The main `mkdocs.yml` is updated with the new version
5. No manual configuration changes are needed

## Customization

### Adding Template Variables
1. Add the variable to the template file: `{{NEW_VARIABLE}}`
2. Update `generate-config.py` to replace the variable
3. Regenerate configuration files

### Modifying Theme Settings
1. Edit the appropriate template file
2. Run `python3 scripts/generate-config.py`
3. All versions will be updated automatically

### Adding New Subsites
1. Create a new template file
2. Add generation logic to `generate-config.py`
3. Update `bootstrap-versions.sh` if needed

## Troubleshooting

### Configuration Not Updating
- Ensure templates are in the correct location
- Check that `generate-config.py` has execute permissions
- Verify that version discovery is working correctly

### Template Variables Not Replaced
- Check template syntax (double curly braces)
- Verify variable names match between template and generator
- Ensure template files are readable

### Version Selector Not Working
- Confirm that overlay files use Material theme
- Check that `extra.swhid_spec_versions` is populated
- Verify that `overrides/partials/version-selector.html` exists

## Future Enhancements

Potential improvements to the template system:

1. **Template Inheritance** - Allow templates to extend base templates
2. **Conditional Configuration** - Support conditional sections based on version
3. **Validation** - Add YAML validation for generated files
4. **Hot Reloading** - Automatically regenerate on template changes
5. **Multiple Subsites** - Support templates for governance and other subsites
