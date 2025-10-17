# API Reference

## Overview

This document provides a comprehensive reference for the SWHID.org website's technical components, including MkDocs configuration, custom scripts, and development tools.

## MkDocs Configuration

### Site Configuration

```yaml
# mkdocs.yml
site_name: SWHID.org
site_url: https://swhid.org
repo_url: https://github.com/swhid/swhid.github.io
edit_uri: edit/main/swhid.github.io/
```

### Theme Configuration

```yaml
theme:
  name: material
  custom_dir: overrides
  features:
    - navigation.tabs
    - navigation.top
    - navigation.expand
    - content.code.copy
    - toc.integrate
  palette:
    - scheme: default
      primary: custom
      accent: custom
  icon:
    logo: material/fingerprint
  language: en
```

### Plugin Configuration

```yaml
plugins:
  - git-revision-date-localized:
      enable_creation_date: true
  - redirects:
      redirect_maps: {}
  - monorepo
```

## Custom Scripts

### Link Checking

The website does not include built-in link checking scripts. External tools should be used for link validation.

### Build Scripts

#### Makefile

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

## Custom CSS

### Main Stylesheet (`overrides/assets/stylesheets/extra.css`)

```css
/* Brand tokens */
:root {
  --swh-red: #e20026;
  --swh-orange: #ef4426;
  --swh-light-orange: #f79622;
  --swh-yellow: #fabf1f;
  --swh-grey: #737373;
  --swh-primary: var(--swh-orange);
  --swh-secondary: var(--swh-light-orange);
  --swh-neutral: var(--swh-grey);
}

/* Core hooks into Material */
.md-typeset a { color: var(--swh-primary); }
.md-header { background: var(--swh-primary); }
.md-tabs { background: var(--swh-neutral); }

/* Example component styles */
.swhid-banner h2 { color: var(--swh-primary); }
.news-entry { background-color: #fff; border: 2px solid var(--swh-primary); }
```

## Custom JavaScript

### Version Tab Hiding (`overrides/assets/javascripts/hide-version-tabs.js`)

```javascript
// Hide any top tab whose label looks like a version (vX.Y[.Z]) or is "dev".
document.addEventListener("DOMContentLoaded", () => {
  const VERSION_RE = /^v\d+\.\d+(?:\.\d+)?$/i;
  
  // Hide from horizontal navigation tabs
  document.querySelectorAll(".md-tabs__list .md-tabs__item").forEach((item) => {
    const a = item.querySelector("a");
    if (!a) return;
    const label = (a.textContent || "").trim();
    if (VERSION_RE.test(label) || label.toLowerCase() === "dev") {
      item.classList.add("swhid-hidden-tab");
    }
  });
  
  // Hide from mobile sidebar navigation
  document.querySelectorAll(".md-nav--primary .md-nav__item").forEach((item) => {
    const a = item.querySelector("a");
    if (!a) return;
    const label = (a.textContent || "").trim();
    if (VERSION_RE.test(label) || label.toLowerCase() === "dev") {
      item.classList.add("swhid-hidden-nav");
    }
  });
});
```

## GitHub Actions

### Deployment Workflow (`.github/workflows/site.yml`)

```yaml
name: Build & Deploy site (preview / staging / production)

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          submodules: recursive
          fetch-depth: 0

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: 3.11

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt

      - name: Setup Pages
        uses: actions/configure-pages@v4

      - name: Build with MkDocs
        run: mkdocs build

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./site

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

## File Structure

### Directory Structure

```
swhid.github.io/
├── docs/                      # Main site content
├── overrides/                 # Theme customizations
│   ├── assets/
│   │   ├── stylesheets/       # Custom CSS (extra.css)
│   │   └── javascripts/       # Custom JS
│   └── partials/              # Custom HTML templates
├── assets/
│   ├── stylesheets/           # Search styles (pagefind-header.css)
│   └── javascripts/           # Search JS (pagefind-header.js)
├── mkdocs.yml                 # Main configuration
└── Makefile                   # Build commands
```

### Key Files

- **`mkdocs.yml`**: Main MkDocs configuration
- **`Makefile`**: Build commands and automation
- **`requirements.txt`**: Python dependencies
- **`overrides/`**: Theme customizations
- **`scripts/`**: Build and maintenance scripts
- **`sources/`**: Git submodules for external content

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

## Dependencies

### Python Dependencies (`requirements.txt`)

```
mkdocs==1.6.0
mkdocs-material==9.5.39
mkdocs-monorepo-plugin==1.1.2
mkdocs-redirects==1.2.1
mkdocs-git-revision-date-localized-plugin==1.2.5
mkdocs-rss-plugin==1.7.0
Jinja2==3.1.4
Pygments==2.18.0
Markdown==3.6
```

### Node.js Dependencies (`package.json`)

```json
{
  "name": "swhid-org",
  "version": "1.0.0",
  "description": "SWHID.org website",
  "scripts": {
    "build": "mkdocs build",
    "serve": "mkdocs serve",
    "clean": "rm -rf site/"
  },
  "devDependencies": {
    "pagefind": "^1.0.0"
  }
}
```

## Configuration Options

### MkDocs Options

- **`site_name`**: Site name displayed in navigation
- **`site_url`**: Base URL for the site
- **`repo_url`**: Repository URL for edit links
- **`edit_uri`**: URI pattern for edit links
- **`theme`**: Theme configuration
- **`nav`**: Navigation structure
- **`plugins`**: Plugin configuration
- **`extra_css`**: Additional CSS files
- **`extra_javascript`**: Additional JavaScript files

### Material Theme Options

- **`name`**: Theme name (material)
- **`custom_dir`**: Custom theme directory
- **`features`**: Enabled theme features
- **`palette`**: Color palette configuration
- **`font`**: Font configuration
- **`logo`**: Logo configuration
- **`favicon`**: Favicon configuration

### Plugin Options

- **`search`**: Search functionality
- **`material/blog`**: Blog functionality (built into Material theme)
- **`tags`**: Tag functionality (built into Material theme)
- **`rss`**: RSS feed generation
- **`git-revision-date-localized`**: Git revision dates
- **`redirects`**: URL redirects
- **`monorepo`**: Monorepo integration

## Troubleshooting

### Common Issues

#### Build Failures

- **Missing Dependencies**: Install required packages
- **Configuration Errors**: Check `mkdocs.yml` syntax
- **Submodule Issues**: Initialize and update submodules
- **File Permissions**: Check file permissions

#### Link Issues

- **Broken External Links**: Check external URLs
- **Broken Internal Links**: Check file paths
- **Markdown Syntax**: Check Markdown syntax
- **Redirect Issues**: Check redirect configuration

#### Navigation Issues

- **Missing Navigation**: Check navigation configuration
- **Version Links**: Check version hiding configuration
- **Submodule Navigation**: Check submodule configuration
- **Theme Issues**: Check theme configuration

### Debug Commands

```bash
# Enable debug mode
export MKDOCS_DEBUG=1

# Check configuration
mkdocs config

# Validate configuration
mkdocs build --strict

# Check for errors
mkdocs build 2>&1 | tee build.log
```

## Performance Optimization

### Build Optimization

- **Incremental Builds**: Use incremental builds
- **Parallel Processing**: Use parallel processing
- **Caching**: Use build caching
- **Resource Limits**: Set appropriate limits

### Runtime Optimization

- **CDN**: Use CDN for static assets
- **Compression**: Use compression
- **Minification**: Minify CSS and JavaScript
- **Image Optimization**: Optimize images

## Security Considerations

### Content Security

- **Input Validation**: Validate all inputs
- **XSS Protection**: Protect against XSS
- **CSRF Protection**: Protect against CSRF
- **Content Security Policy**: Use CSP headers

### Infrastructure Security

- **HTTPS Only**: Use HTTPS
- **Secure Headers**: Use security headers
- **Dependency Scanning**: Scan dependencies
- **Regular Updates**: Keep dependencies updated
