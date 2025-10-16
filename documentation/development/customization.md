# Customization Guide

## Overview

The SWHID.org website uses MkDocs with the Material theme and a monorepo architecture, providing extensive customization options. This guide covers how to customize the appearance, functionality, and behavior of the website.

For comprehensive styling customization, see the [Complete Site Styling Guide](site-styling-guide.md).

## Current Architecture

The website uses a **monorepo approach** that integrates content from multiple sources:
- **Main Site**: Core content (homepage, FAQ, news, etc.)
- **Specification**: Technical specification content with versioning
- **Governance**: Community governance documents
- **Search**: Pagefind-powered search functionality
- **Tags**: Dynamic tag system for content organization

## Theme Customization

### Material Theme Configuration

The Material theme is configured in `mkdocs.yml`:

```yaml
theme:
  name: material
  custom_dir: overrides
  features:
    - navigation.tabs
    - navigation.top
    - navigation.expand
    - content.code.copy
    - search.suggest
    - search.highlight
    - toc.integrate
  palette:
    - scheme: default
      primary: custom
      accent: custom
  icon:
    logo: material/fingerprint
  language: en
```

### Color System

The website uses a **consistent color palette** defined in the main CSS file:

#### Primary Color Palette

```css
/* SWHID Brand Colors */
:root {
  --swh-red: #e20026;
  --swh-orange: #ef4426;
  --swh-light-orange: #f79622; /* Light orange */
  --swh-yellow: #fabf1f;
  --swh-grey: #737373;
  --swh-primary: var(--swh-red); /* Primary color */
  --swh-secondary: var(--swh-orange); /* Secondary color */
  --swh-neutral: var(--swh-orange); /* Neutral color */
  --swh-accent: var(--swh-light-orange); /* Accent color */
  --swh-highlight: var(--swh-yellow); /* Highlight color */
}
```

### CSS Architecture

The website uses a **centralized CSS architecture** with all custom styles in a single file:

#### File Structure

```
overrides/assets/stylesheets/
└── extra.css                    # Main custom styles
```

#### Main Custom Styles (`extra.css`)

```css
/* Main custom styles - all styling is contained in this file */

/* All custom styles are defined in this single file */

/* Custom Header Styling */
.md-header {
  background: var(--swh-primary);
}

/* Custom Button Styling */
.md-button--primary {
  background-color: var(--swh-primary);
  border-color: var(--swh-primary);
}

.md-button--primary:hover {
  background-color: var(--swh-secondary);
  border-color: var(--swh-secondary);
}
```

#### Navigation Customization

```css
/* Hide version tabs from horizontal navigation */
.md-tabs__item.swhid-hidden-tab {
  display: none !important;
}

/* Custom navigation styling */
.md-nav__item--active > .md-nav__link {
  color: var(--swh-primary);
  font-weight: 600;
}
```

#### News and Content Components

The website includes custom styling for news entries and content components. All styles are defined in the main `extra.css` file and follow the SWHID color scheme.

### Custom JavaScript

Custom JavaScript is located in `overrides/assets/javascripts/` and includes functionality for hiding version tabs and other interactive features.

#### Pagefind Search Integration

The website uses **Pagefind** for client-side search functionality with header search and dedicated search pages. For detailed search customization options, see the [Search Customization Guide](search-customization.md).

## Typography and Fonts

The website uses the Material theme's default typography system with custom color overrides. All typography customization is handled through the main CSS file.

## Template Customization

Custom HTML templates are located in `overrides/` and include the main template and redirect template for handling page redirects.

## Plugin Configuration

The website uses several MkDocs plugins configured in `mkdocs.yml`:

- **search**: Built-in search functionality
- **git-revision-date-localized**: Git revision dates
- **redirects**: URL redirects
- **monorepo**: Multi-site integration

### Monorepo Architecture

The website uses the **MkDocs Monorepo Plugin** to integrate content from multiple sources including specification versions and governance documents.

## Color Customization

The website uses a **consistent color palette** defined in the main CSS file. All colors are defined as CSS variables and can be easily customized by modifying the `:root` selector in `extra.css`.

### Custom Plugins

Custom plugins can be added to extend functionality by creating Python files in a `plugins/` directory and registering them in `mkdocs.yml`.

## Branding Customization

### Logo and Icons

The website uses the Material theme's default logo and icon system. Custom logos and icons can be configured in `mkdocs.yml` and styled in the main CSS file.

## Advanced Customization

### Custom Components

Custom components can be created by adding CSS classes and HTML templates. All custom styling should be added to the main `extra.css` file.

### Responsive Design

The website uses responsive design principles with mobile-first approach. All responsive styles are defined in the main CSS file.

## Testing Customizations

### Local Testing

```bash
# Build and serve locally
make serve

# Test in different browsers and devices
```

## Best Practices

1. **Use CSS Variables**: Define colors and sizes as variables
2. **Mobile First**: Design for mobile first
3. **Semantic Classes**: Use semantic class names
4. **Document Changes**: Document all customizations
5. **Test Changes**: Test all changes before deploying



