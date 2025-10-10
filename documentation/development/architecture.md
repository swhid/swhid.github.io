# Website Architecture

## Overview

The SWHID.org website is built using a **monorepo approach** that integrates content from multiple sources into a unified, modern website. The architecture is designed to be maintainable, scalable, and user-friendly.

## Technology Stack

- **MkDocs 1.6.0** - Static site generator
- **Material theme** - Modern MkDocs theme with advanced features
- **MkDocs Monorepo Plugin** - Multi-site integration
- **Pagefind** - Client-side search functionality
- **GitHub Pages** - Hosting platform
- **GitHub Actions** - Automated deployment
- **Python 3.11+** - Runtime environment
- **Git Submodules** - Content integration from external repositories
- **Git Worktrees** - Version management for specification content

## Repository Structure

### Main Website (`swhid.github.io/`)

The main website serves as a monorepo that integrates content from multiple sources:

```
swhid.github.io/
├── docs/                     # Main site content
│   ├── index.md             # Homepage
│   ├── faq.md               # Frequently Asked Questions
│   ├── news/                # News and announcements
│   │   ├── index.md         # News listing page
│   │   └── *.md             # Individual news articles
│   ├── tags/                # Dynamic tags system
│   │   └── index.md         # Auto-generated tags page
│   ├── publications.md      # Publications and papers
│   ├── coreteam.md          # Core team information
│   ├── search.md            # Search page
│   └── search-results.md    # Search results page
├── sources/                 # Git submodules for external content
│   ├── specification/       # Current specification (dev version)
│   ├── governance/          # Governance documents
│   ├── specification-v1.0/  # v1.0 specification (git worktree)
│   ├── specification-v1.1/  # v1.1 specification (git worktree)
│   └── specification-v1.2/  # v1.2 specification (git worktree)
├── .monorepo-overlays/      # Generated overlay configurations
│   ├── spec-v1.0.mkdocs.yml
│   ├── spec-v1.1.mkdocs.yml
│   ├── spec-v1.2.mkdocs.yml
│   └── spec-dev.mkdocs.yml
├── overrides/               # Material theme customizations
│   ├── main.html            # Main template override
│   ├── redirect.html        # Redirect template
│   └── assets/              # Custom CSS and JavaScript
│       ├── stylesheets/
│       │   └── extra.css    # Main custom styles
│       └── javascripts/
│           └── hide-version-tabs.js
├── shared-branding/         # Shared branding system
│   ├── swh-variables.css    # Color variables and design tokens
│   └── swh-components.css   # Reusable UI components
├── scripts/                 # Build and deployment scripts
│   ├── bootstrap.sh         # Main bootstrap script
│   ├── bootstrap-versions.sh # Version management
│   ├── generate-config.py   # Configuration generation
│   ├── generate-tags.py     # Tags page generation
│   └── cleanup.sh           # Cleanup script
├── templates/               # Configuration templates
│   ├── mkdocs.yml.template
│   ├── spec-overlay.yml.template
│   └── spec-overlay-v1.0.yml.template
├── mkdocs.yml              # Main configuration file
├── nav.yml                 # Generated navigation
├── Makefile                # Build commands
└── package.json            # Pagefind dependencies
```

## Build System

### Monorepo Integration

The website uses the **MkDocs Monorepo Plugin** to merge navigation from multiple subsites:

1. **Main Site**: Core content (homepage, FAQ, news, etc.)
2. **Specification**: Technical specification content with versioning
3. **Governance**: Community governance documents
4. **Versioned Content**: Multiple specification versions (v1.0, v1.1, v1.2, dev)

### Build Process

The build system follows a **template-based approach**:

1. **Bootstrap Phase**:
   - Initialize Git submodules
   - Create Git worktrees for versioned content
   - Discover available versions
   - Generate overlay configurations

2. **Configuration Generation**:
   - Generate `mkdocs.yml` from templates
   - Create version-specific overlays
   - Generate navigation structure
   - Create dynamic content (tags, news)

3. **Build Phase**:
   - MkDocs processes all configurations
   - Pagefind indexes content for search
   - Static files are generated

### Key Features

- **Git Submodules**: External repositories are included as submodules
- **Git Worktrees**: Version-specific content managed via worktrees
- **Template System**: Configuration generated from templates
- **Navigation Merging**: Automatic integration of navigation from subsites
- **Version Management**: Multiple specification versions with clean URLs
- **Search Integration**: Pagefind search functionality with filtering
- **Dynamic Content**: Auto-generated tags and news pages
- **Responsive Design**: Mobile-first approach with Material theme

## Content Management

### Content Sources

1. **Main Content** (`docs/`): Site-specific content like homepage, FAQ, news
2. **Specification** (`sources/specification/`): Technical specification content
3. **Governance** (`sources/governance/`): Community governance documents
4. **Versioned Content** (`sources/specification-v*/`): Version-specific content

### Navigation Structure

The navigation is automatically generated from:
- Main site navigation (`mkdocs.yml`)
- Specification navigation (from submodule)
- Governance navigation (from submodule)
- Version-specific navigation (from versioned submodules)

## Customization

### Theme Customization

The site uses Material theme with extensive customizations:

- **Custom CSS**: SWHID branding and styling
- **Custom JavaScript**: Enhanced functionality
- **Custom Templates**: Modified HTML templates
- **Custom Assets**: Logos, icons, and other assets

### Branding

- **Color Scheme**: SWHID red and orange palette
- **Typography**: Custom font choices
- **Layout**: Responsive grid system
- **Components**: Custom UI components

## Performance

### Optimization Features

- **Static Generation**: Pre-built HTML for fast loading
- **Asset Optimization**: Minified CSS and JavaScript
- **Image Optimization**: Compressed images
- **CDN Integration**: GitHub Pages CDN for global delivery

### Search

- **Pagefind Integration**: Client-side search functionality
- **Index Generation**: Automatic search index creation
- **Multi-language Support**: Search across all content

## Security

### Security Features

- **HTTPS Only**: All traffic encrypted
- **Content Security Policy**: XSS protection
- **Subresource Integrity**: Asset integrity verification
- **GitHub Security**: Platform-level security features

## Monitoring

### Analytics

- **GitHub Pages Analytics**: Built-in analytics
- **Custom Tracking**: Optional custom analytics
- **Performance Monitoring**: Site performance tracking

### Health Checks

- **Link Validation**: Automated link checking
- **Build Verification**: Continuous integration testing
- **Deployment Monitoring**: Automated deployment verification

## Future Considerations

### Scalability

- **Content Growth**: Architecture supports content expansion
- **Version Management**: Easy addition of new specification versions
- **Performance**: Optimized for growing content base

### Maintenance

- **Automated Updates**: Submodule updates
- **Dependency Management**: Automated dependency updates
- **Content Validation**: Automated content checking
