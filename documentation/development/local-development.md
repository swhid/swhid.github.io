# Local Development

## Prerequisites

Before you can work on the SWHID.org website locally, you need to install the following:

### Required Software

- **Python 3.11+** - Runtime environment
- **Git** - Version control
- **Make** - Build automation (optional but recommended)

### Python Dependencies

The project uses Python virtual environments to manage dependencies. All required packages are listed in `requirements.txt`.

## Setup

### 1. Clone the Repository

```bash
# Clone the main repository
git clone https://github.com/swhid/swhid-iso.git
cd swhid-iso

# Navigate to the website directory
cd swhid.github.io
```

### 2. Initialize Submodules

The website uses Git submodules and worktrees to include external content. You need to initialize them:

```bash
# Initialize and update submodules
make bootstrap
```

This command will:
- Initialize all Git submodules
- Create Git worktrees for versioned specification content
- Discover available versions (v1.0, v1.1, v1.2, dev)
- Generate overlay configurations from templates
- Install Python dependencies
- Install Node.js dependencies (concurrently, chokidar-cli, http-server, pagefind)
- Generate dynamic content (tags, news)
- Build the site for the first time

### 3. Install Dependencies

If you prefer to install dependencies manually:

```bash
# Create virtual environment
python -m venv .venv

# Activate virtual environment
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

## Development Workflow

### Building the Site

```bash
# Complete workflow (recommended)
make cleanup    # Clean all generated files
make bootstrap  # Initialize submodules and generate configs
make build      # Build the site
make serve      # Serve locally

# Individual commands
make build      # Build the site only
make serve      # Build and serve locally
make clean      # Clean build artifacts
make cleanup    # Deep clean (removes worktrees, submodules, etc.)
```

### Available Make Commands

- **`make bootstrap`**: Initialize submodules, worktrees, and generate configurations
- **`make build`**: Build the static site and Pagefind search index
- **`make serve`**: Build and serve locally with live reload (uses http-server for proper WASM support)
- **`make clean`**: Remove build artifacts
- **`make cleanup`**: Deep clean (removes worktrees, submodules, generated files)

### Search Functionality

The website includes two search implementations:

1. **Header Search**: Integrated search box in the horizontal navigation bar
   - Compact design that expands when typing
   - Responsive behavior (search icon on small screens)
   - Live search results with faceted filtering

2. **Dedicated Search Page**: Full-featured search at `/search/`
   - Complete search interface with filters
   - URL parameter support for direct search links
   - Advanced filtering by section, version, and tags

For detailed search customization options, see the [Search Customization Guide](search-customization.md).

### Making Changes

1. **Edit Content**: Modify files in the `docs/` directory
2. **Test Changes**: Run `make serve` to see changes locally
3. **Commit Changes**: Use `git add` and `git commit` to save changes
4. **Push Changes**: Use `git push` to deploy changes

### Content Types

#### Main Content (`docs/`)

- **Homepage**: `docs/index.md`
- **FAQ**: `docs/faq.md`
- **News**: `docs/news/`
- **Publications**: `docs/publications.md`
- **Core Team**: `docs/coreteam.md`

#### Specification Content

- **Current Version**: `sources/specification/`
- **Versioned Content**: `sources/specification-v*/`

#### Governance Content

- **Governance**: `sources/governance/`

### Customization

#### CSS Styling

- **Main Styles**: `overrides/assets/stylesheets/extra.css`
- **Theme Overrides**: `overrides/assets/stylesheets/`

#### JavaScript

- **Custom Scripts**: `overrides/assets/javascripts/`
- **Theme Scripts**: `overrides/assets/javascripts/`

#### Templates

- **HTML Templates**: `overrides/partials/`
- **Theme Overrides**: `overrides/`

## Testing

### Local Testing

```bash
# Build and serve locally
make serve

# Open browser to http://localhost:8000
```

### Link Checking

```bash
# Check all links
./scripts/check-links.sh

# Check specific file
./scripts/check-links.sh docs/publications.md
```

### Build Verification

```bash
# Clean build
make clean
make build

# Verify no errors
echo "Build completed successfully"
```

## Troubleshooting

### Common Issues

#### Submodule Issues

```bash
# Reset submodules
git submodule deinit -f .
git submodule update --init --recursive
```

#### Dependency Issues

```bash
# Reinstall dependencies
rm -rf .venv
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

#### Build Issues

```bash
# Clean and rebuild
make clean
make build
```

### Debug Mode

```bash
# Enable debug mode
export MKDOCS_DEBUG=1
make serve
```

### Logs

Check the console output for error messages. Common issues include:
- Missing dependencies
- Submodule issues
- Configuration errors
- File permission problems

## Development Tips

### Best Practices

1. **Test Locally**: Always test changes locally before committing
2. **Check Links**: Run link checking before committing
3. **Clean Builds**: Use `make clean` before important builds
4. **Commit Messages**: Write clear, descriptive commit messages
5. **Small Changes**: Make small, focused changes

### Performance

- **Incremental Builds**: MkDocs supports incremental builds
- **File Watching**: Use `make serve` for automatic rebuilds
- **Caching**: Browser caching for faster development

### Content Management

- **Markdown**: Use standard Markdown syntax
- **Images**: Place images in appropriate directories
- **Links**: Use relative links when possible
- **Metadata**: Include proper front matter

## IDE Setup

### Recommended IDEs

- **VS Code**: With Markdown extensions
- **PyCharm**: With Markdown support
- **Vim/Neovim**: With Markdown plugins
- **Emacs**: With Markdown mode

### Useful Extensions

- **Markdown All in One**: VS Code extension
- **MkDocs Material**: VS Code extension
- **GitLens**: Git integration
- **Python**: Python support

## Next Steps

Once you have the local development environment set up:

1. **Explore the Codebase**: Familiarize yourself with the structure
2. **Make Small Changes**: Try editing some content
3. **Test Changes**: Use `make serve` to see changes
4. **Check Links**: Use the link checking tools
5. **Commit Changes**: Practice the Git workflow

For more detailed information, see the other documentation files in the `docs/` directory.
