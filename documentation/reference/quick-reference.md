# Quick Reference

## Essential Commands

### Local Development

```bash
# Initialize submodules and build
make bootstrap

# Build the site
make build

# Serve locally
make serve

# Clean build artifacts
make clean
```

### Git Operations

```bash
# Check status
git status

# Add changes
git add <file>

# Commit changes
git commit -m "Your commit message"

# Push changes
git push origin main

# Pull latest changes
git pull origin main
```

### Submodule Operations

```bash
# Initialize submodules
git submodule init

# Update submodules
git submodule update --recursive

# Update specific submodule
git submodule update --remote sources/specification

# Check submodule status
git submodule status
```

## File Structure

### Main Directories

```
swhid-iso/
├── swhid.github.io/          # Main website
├── governance/               # Governance submodule
├── specification/            # Specification submodule
├── overrides/               # Theme customizations
├── docs/                    # Consolidated documentation
└── README.md                # Main README
```

### Website Structure

```
swhid.github.io/
├── docs/                     # Main site content
├── sources/                 # Git submodules
├── overrides/               # Theme customizations
├── scripts/                 # Build scripts
├── mkdocs.yml              # Main configuration
└── Makefile                # Build commands
```

## Configuration Files

### MkDocs Configuration (`mkdocs.yml`)

```yaml
site_name: SWHID.org
site_url: https://swhid.org
repo_url: https://github.com/swhid/swhid.github.io
edit_uri: edit/main/swhid.github.io/

theme:
  name: material
  custom_dir: overrides
  features:
    - navigation.tabs
    - navigation.sections
    - navigation.expand
    - navigation.top
    - search.highlight
    - search.share
    - search.suggest
    - content.code.copy
    - content.code.annotate
    - content.action.edit
    - content.action.view
  palette:
    - scheme: default
      primary: red
      accent: orange
      toggle:
        icon: material/brightness-7
        name: Switch to dark mode
    - scheme: slate
      primary: red
      accent: orange
      toggle:
        icon: material/brightness-4
        name: Switch to light mode

nav:
  - Home: index.md
  - Specification: '!include .monorepo-overlays/spec-v1.2.mkdocs.yml'
  - v1.0: '!include .monorepo-overlays/spec-v1.0.mkdocs.yml'
  - v1.1: '!include .monorepo-overlays/spec-v1.1.mkdocs.yml'
  - v1.2: '!include .monorepo-overlays/spec-v1.2.mkdocs.yml'
  - Governance: '!include sources/governance/mkdocs.yml'
  - FAQ: faq.md
  - News: news/index.md
  - Publications: publications.md
  - Core Team: coreteam.md

plugins:
  - search:
      lang: en
  - material/blog:
      blog_dir: news
      blog_toc: false
  - material/tags:
      tags_file: docs/tags/index.md
  - rss:
      enabled: true
      rss_file: feed_rss_created.xml
      rss_file_updated: feed_rss_updated.xml
  - git-revision-date-localized:
      enable_creation_date: true
      enable_modification_date: true
      locale: en
  - redirects:
      redirect_maps:
        "swhid-specification/latest/": "swhid-specification/v1.2/"
        "swhid-specification/": "swhid-specification/v1.2/"
  - monorepo:
      docs_dir: docs
      sites:
        - site_name: "SWHID Specification"
          site_url: "/swhid-specification/"
          nav:
            - "!include sources/specification/mkdocs.yml"
        - site_name: "SWHID Governance"
          site_url: "/swhid-governance/"
          nav:
            - "!include sources/governance/mkdocs.yml"

extra_css:
  - assets/stylesheets/extra.css

extra_javascript:
  - assets/javascripts/hide-version-tabs.js
```

### Makefile

```makefile
.PHONY: bootstrap build serve clean test

bootstrap:
	git submodule update --init --recursive
	pip install -r requirements.txt
	mkdocs build

build:
	mkdocs build

serve:
	mkdocs serve

clean:
	rm -rf site/

test:
	mkdocs build
```

## Common Tasks

### Adding New Content

1. **Create File**: Create new Markdown file in `docs/`
2. **Add to Navigation**: Add to `mkdocs.yml` navigation
3. **Test Locally**: Run `make serve` to test
4. **Commit Changes**: Add and commit changes
5. **Push Changes**: Push to trigger deployment

### Updating Submodules

1. **Update Submodule**: `git submodule update --remote <submodule>`
2. **Test Changes**: Run `make serve` to test
3. **Commit Updates**: Commit submodule updates
4. **Push Changes**: Push to trigger deployment

### Checking Links

1. **Check All Links**: Use external link checking tools
2. **Check Specific File**: Review files manually for broken links
3. **Fix Broken Links**: Edit files to fix broken links
4. **Re-check**: Verify links work after fixes

### Customizing Theme

1. **Edit CSS**: Modify `overrides/assets/stylesheets/extra.css`
2. **Edit JavaScript**: Modify `overrides/assets/javascripts/`
3. **Edit Templates**: Modify `overrides/partials/`
4. **Test Changes**: Run `make serve` to test

## Troubleshooting

### Common Issues

#### Build Fails

```bash
# Check for errors
make build 2>&1 | tee build.log

# Check dependencies
pip install -r requirements.txt

# Check submodules
git submodule status
```

#### Links Broken

```bash
# Check all links using external tools
# Use browser developer tools or online link checkers

# Fix broken links
# Edit files to fix broken links
```

#### Navigation Issues

```bash
# Check navigation configuration
mkdocs config

# Check for syntax errors
mkdocs build --strict

# Test navigation locally
make serve
```

#### Submodule Issues

```bash
# Reset submodules
git submodule deinit -f .
git submodule update --init --recursive

# Check submodule status
git submodule status
```

### Debug Mode

```bash
# Enable debug mode
export MKDOCS_DEBUG=1
make serve

# Check logs
tail -f build.log
```

## Environment Variables

### Development

```bash
# Enable debug mode
export MKDOCS_DEBUG=1

# Set custom site URL
export MKDOCS_SITE_URL=http://localhost:8000

# Set custom port
export MKDOCS_PORT=8000
```

### Production

```bash
# Set production site URL
export MKDOCS_SITE_URL=https://swhid.org

# Set production configuration
export MKDOCS_CONFIG_FILE=mkdocs.yml
```

## Useful Scripts

### Link Checking

```bash
# Check all links using external tools
# Use browser developer tools or online link checkers

# Check specific files manually
# Review files for broken links
```

### Build Scripts

```bash
# Bootstrap everything
make bootstrap

# Build site
make build

# Serve locally
make serve

# Clean build artifacts
make clean
```

### Git Scripts

```bash
# Update all submodules
git submodule update --remote --recursive

# Check submodule status
git submodule status

# Initialize submodules
git submodule init
```

## Performance Tips

### Build Performance

- **Incremental Builds**: MkDocs supports incremental builds
- **File Watching**: Use `make serve` for automatic rebuilds
- **Caching**: Browser caching for faster development

### Development Performance

- **Local Server**: Use local server for faster development
- **File Watching**: Use file watching for automatic rebuilds
- **Parallel Processing**: Use parallel processing when possible

### Deployment Performance

- **CDN**: Use CDN for static assets
- **Compression**: Use compression for assets
- **Minification**: Minify CSS and JavaScript
- **Image Optimization**: Optimize images

## Security Considerations

### Content Security

- **Input Validation**: Validate all user inputs
- **XSS Protection**: Protect against XSS attacks
- **CSRF Protection**: Protect against CSRF attacks
- **Content Security Policy**: Use CSP headers

### Infrastructure Security

- **HTTPS Only**: Use HTTPS for all communications
- **Secure Headers**: Use security headers
- **Dependency Scanning**: Scan for vulnerable dependencies
- **Regular Updates**: Keep dependencies updated

## Monitoring and Analytics

### Site Monitoring

- **Uptime Monitoring**: Monitor site uptime
- **Performance Monitoring**: Monitor site performance
- **Error Monitoring**: Monitor for errors
- **Usage Analytics**: Monitor usage analytics

### Development Monitoring

- **Build Monitoring**: Monitor build success/failure
- **Deployment Monitoring**: Monitor deployment success
- **Link Monitoring**: Monitor link health
- **Content Monitoring**: Monitor content changes
