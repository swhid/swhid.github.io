# SWHID Monorepo

This is the unified documentation site for SWHID (Software Heritage Identifier), built using MkDocs with the Material theme and a monorepo plugin.

## Features

- **Unified Documentation**: Single site combining specification, governance, and general documentation
- **Version Management**: Multiple specification versions with easy switching
- **Template System**: Consistent configuration across all versions using templates
- **Material Theme**: Modern, responsive design with integrated search functionality
- **Pagefind Search**: Fast, client-side search with faceted filtering
- **Version Selector**: Interactive dropdown to switch between specification versions
- **Responsive Design**: Mobile-optimized search and navigation experience

## Quick Start

### Prerequisites
- Python 3.8+
- Git
- Make (optional, for convenience commands)

### Setup
```bash
# Clone the repository
git clone https://github.com/swhid/swhid.github.io
cd swhid.github.io

# Install dependencies
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
pip install -r requirements.txt

# Bootstrap the site (sets up submodules and generates configs)
make bootstrap

# Create the site and the search index
make build

# Serve locally
make serve
```

The site will be available at http://127.0.0.1:8000

## Project Structure

```
swhid.github.io/
├── docs/                          # Main documentation content
├── sources/                       # Submodule content
│   ├── specification/             # Specification submodule
│   ├── specification-v1.0/        # Version 1.0 worktree
│   ├── specification-v1.1/        # Version 1.1 worktree
│   ├── specification-v1.2/        # Version 1.2 worktree
│   ├── specification-vN.M/        # Version N.M worktree (for future versions)
│   ├── specification-dev /        # Development worktree
│   └── governance/                # Governance submodule
├── templates/                     # Configuration templates
│   ├── mkdocs.yml.template       # Main config template
│   └── spec-overlay.yml.template # Specification overlay template
├── scripts/                       # Build and maintenance scripts
│   ├── bootstrap.sh              # Main bootstrap script
│   ├── bootstrap-versions.sh     # Version discovery and generation
│   ├── generate-config.py        # Template-based config generator
│   └── cleanup.sh                # Cleanup script
├── overrides/                     # Material theme customizations
│   ├── main.html                 # Main template override
│   └── partials/                 # Template partials
│       └── version-selector.html # Version selector component
├── .monorepo-overlays/            # Generated overlay configs
├── mkdocs.yml                     # Main MkDocs configuration (generated)
└── requirements.txt               # Python dependencies
```

## Template System

The monorepo uses a template-based configuration system to ensure consistency across all versions. See [Template System Documentation](docs/development/template-system.md) for details.

### Key Benefits
- **Consistency**: All versions use identical configuration
- **Maintainability**: Changes made once in templates affect all versions
- **Automation**: New versions automatically get correct configuration

## Available Commands

```bash
make bootstrap    # Initialize submodules and generate configurations
make serve        # Start development server
make build        # Build static site
make clean        # Remove build artifacts
make cleanup      # Comprehensive cleanup (removes all generated files and submodules)
```

### Cleanup Options

- **`make clean`** - Removes build artifacts only
- **`make cleanup`** - Complete reset that removes:
  - All generated configuration files
  - Git submodules and worktrees
  - Build artifacts and temporary files
  - Python virtual environments
  - All cached data and git remnants

## Version Management

### Adding New Versions
1. Create a new tag in the specification repository
2. Run `make bootstrap` to discover and set up the new version
3. The version will automatically appear in the version selector

### Version Selector
The version selector appears on all specification pages and allows users to:
- See all available versions
- Switch between versions seamlessly
- Maintain their current page context when switching

## Development

### Local Development
1. Make changes to documentation files
2. The development server will automatically reload
3. Test changes across different versions using the version selector

### Configuration Changes
1. Edit template files in `templates/`
2. Run `python3 scripts/generate-config.py` to regenerate configs
3. Restart the development server

### Adding New Features
1. Update templates as needed
2. Modify generation scripts if required
3. Test across all versions
4. Update documentation

## Deployment

The site is designed to be deployed to GitHub Pages or any static hosting service:

1. Run `make build` to generate the static site
2. Deploy the `site/` directory to your hosting service
3. Ensure all submodules are properly initialized

## Troubleshooting

### Common Issues

**Version selector not appearing:**
- Ensure overlay files use Material theme
- Check that `extra.swhid_spec_versions` is populated
- Verify template generation completed successfully

**Build failures:**
- Run `make cleanup` to remove generated files
- Run `make bootstrap` to regenerate everything
- Check that all submodules are initialized

**Navigation issues:**
- Ensure `nav.yml` is not manually edited
- Run `scripts/bootstrap-versions.sh` to regenerate navigation
- Check template syntax in `templates/`

### Getting Help

- Check the [Template System Documentation](docs/development/template-system.md)
- Review the [Architecture Documentation](docs/development/architecture.md)
- See the [Complete Site Styling Guide](docs/development/site-styling-guide.md) for comprehensive customization options
- Look at existing issues in the repository

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test across all versions
5. Submit a pull request

## License

This project is licensed under the same terms as the SWHID specification. See the individual submodules for their specific licenses.
