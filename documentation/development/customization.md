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

The website uses a **shared branding system** with consistent colors across all components:

#### Primary Color Palette

```css
/* Software Heritage Brand Colors */
:root {
  --swh-primary: #1e3a8a;        /* Software Heritage Blue */
  --swh-secondary: #059669;       /* Software Heritage Green */
  --swh-accent: #dc2626;          /* Software Heritage Red */
  --swh-neutral: #6b7280;         /* Gray */
  --swh-light-gray: #f3f4f6;      /* Light background */
  --swh-dark-gray: #1f2937;       /* Dark text */
  --swh-text-color: #333;         /* Primary text */
}
```

#### Legacy SWHID Colors (for backward compatibility)

```css
:root {
  --swhid-red: #d73c2c;
  --swhid-orange: #f39c12;
  --swhid-dark: #2c3e50;
  --swhid-light: #ecf0f1;
}
```

### CSS Architecture

The website uses a **modular CSS architecture** with shared branding:

#### File Structure

```
overrides/assets/stylesheets/
├── extra.css                    # Main site-wide styles (brand tokens, components)

assets/stylesheets/
├── pagefind-header.css          # Header search styling (Pagefind)
```

#### Main Custom Styles (`extra.css`)

```css
/* Brand tokens */
:root {
  --swh-red: #e20026;
  --swh-orange: #ef4426;
  --swh-light-orange: #f79622;
  --swh-yellow: #fabf1f;
  --swh-grey: #737373;
}

/* Core hooks into Material */
.md-typeset a { color: var(--swh-red); }
.md-header { background: var(--swh-red); }
.md-tabs { background: var(--swh-grey); }
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

#### Content Styling

```css
/* Custom content styling */
.md-content h1 {
  color: var(--swh-primary);
  border-bottom: 2px solid var(--swh-secondary);
  padding-bottom: 0.5rem;
}

.md-content h2 {
  color: var(--swh-dark-gray);
  margin-top: 2rem;
}

/* Code block styling */
.md-content pre {
  background-color: #f8f9fa;
  border: 1px solid #e9ecef;
  border-radius: 0.375rem;
}

/* Table styling */
.md-content table {
  border-collapse: collapse;
  width: 100%;
}

.md-content th,
.md-content td {
  border: 1px solid #dee2e6;
  padding: 0.75rem;
  text-align: left;
}

.md-content th {
  background-color: var(--swh-light-gray);
  font-weight: 600;
}
```

#### News and Content Components

```css
/* News Entry Styling */
.news-entry {
  background-color: #fff;
  border: 2px solid #e20026;
  border-radius: 12px;
  padding: 1.5rem;
  margin-bottom: 1.5rem;
  box-shadow: 0 4px 12px rgba(226, 0, 38, 0.1);
  transition: all 0.3s ease;
  position: relative;
  padding-bottom: 3rem;
}

.news-entry:hover {
  border-color: #ef4426;
  box-shadow: 0 6px 16px rgba(226, 0, 38, 0.15);
  transform: translateY(-2px);
}

.news-date {
  color: var(--swh-neutral);
  font-size: 0.9rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.news-title {
  color: #e20026;
  margin-bottom: 1rem;
  font-size: 1.4rem;
  font-weight: 700;
  line-height: 1.3;
}

.news-excerpt {
  color: #333;
  margin-bottom: 1rem;
  line-height: 1.6;
  font-size: 1rem;
}

a.news-read-more {
  background-color: #e20026;
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 6px 6px 0 0;
  text-decoration: none;
  font-weight: 600;
  font-size: 0.9rem;
  position: absolute;
  bottom: -1px;
  right: 0;
  transition: all 0.3s ease;
  box-shadow: 0 -2px 4px rgba(226, 0, 38, 0.2);
}
```

#### Search and Tags Styling

```css
/* Search Filter Styling */
.search-filters {
  background: var(--md-default-bg-color);
  border: 1px solid var(--md-default-fg-color--lightest);
  border-radius: 0.5rem;
  padding: 1rem;
  margin: 1rem 0;
}

.filter-section {
  margin-bottom: 1rem;
}

.filter-section h4 {
  margin: 0 0 0.5rem 0;
  font-size: 0.9rem;
  font-weight: 600;
  color: var(--md-default-fg-color--light);
}

.filter-checkboxes {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.filter-checkboxes label {
  display: flex;
  align-items: center;
  gap: 0.25rem;
  font-size: 0.85rem;
  cursor: pointer;
  padding: 0.25rem 0.5rem;
  border-radius: 0.25rem;
  transition: background-color 0.2s;
}

.clear-filters-btn {
  background: var(--md-accent-fg-color);
  color: var(--md-accent-bg-color);
  border: none;
  border-radius: 0.25rem;
  padding: 0.5rem 1rem;
  font-size: 0.85rem;
  cursor: pointer;
  transition: opacity 0.2s;
}
```

### Custom JavaScript

Custom JavaScript is located in `overrides/assets/javascripts/`:

#### Version Tab Hiding (`hide-version-tabs.js`)

```javascript
// Hide version tabs from horizontal navigation
document.addEventListener('DOMContentLoaded', function() {
  // Add class to version tabs to hide them
  const versionTabs = document.querySelectorAll('.md-tabs__item');
  versionTabs.forEach(tab => {
    const link = tab.querySelector('a');
    if (link && (link.textContent.includes('v1.0') || 
                 link.textContent.includes('v1.1') || 
                 link.textContent.includes('v1.2') || 
                 link.textContent.includes('dev'))) {
      tab.classList.add('swhid-hidden-tab');
    }
  });
});
```

#### Pagefind Search Integration

The website uses **Pagefind** for client-side search functionality with two main implementations:

1. **Header Search**: Integrated search box in the horizontal navigation bar
2. **Dedicated Search Page**: Full-featured search page at `/search/`

For detailed search customization options, see the [Search Customization Guide](search-customization.md).

**Header Search Implementation**:
```javascript
// Header search (in docs/assets/javascripts/pagefind-header.js)
new PagefindUI({
  element: "#pf-header-ui",
  bundlePath: "/pagefind/",
  baseUrl: "/",
  showSubResults: true,
  showImages: false,
  showFilters: ["section", "spec_version", "tag"],
  translations: { placeholder: "Search SWHID.org" }
});
```

**Search Page Implementation**:
```javascript
// Search page (in docs/search/index.md)
new PagefindUI({
  element: "#pagefind-search",
  bundlePath: "/pagefind/",
  baseUrl: "/",
  showSubResults: true,
  showImages: false,
  showFilters: ["section", "spec_version", "tag"],
  translations: { placeholder: "Search SWHID.org" }
});
```

#### Search Filter Functionality

```javascript
// Search filter implementation (in docs/search.md)
window.addEventListener('DOMContentLoaded', (event) => {
  const urlParams = new URLSearchParams(window.location.search);
  const query = urlParams.get('q') || '';
  const tagFilter = urlParams.get('tag') || '';
  
  // Initialize Pagefind
  const pagefindUI = new PagefindUI({ 
    element: "#search",
    // ... configuration
  });
  
  // Wait for Pagefind to be ready
  pagefindUI.on('ready', () => {
    // Apply filters from URL parameters
    if (tagFilter) {
      pagefindUI.filter({ tag: tagFilter.split(',') });
    }
    
    // Trigger search if query exists
    if (query) {
      const searchInput = document.querySelector('#search input[type="search"]');
      if (searchInput) {
        searchInput.value = query;
        searchInput.dispatchEvent(new Event('input', { bubbles: true }));
      }
    }
  });
});
```

## Typography and Fonts

### Font System

The website uses a **consistent typography system** with the following hierarchy:

#### Primary Font Stack

```css
:root {
  --swh-font-family: 'Inter', 'Helvetica Neue', Helvetica, Arial, sans-serif;
  --swh-font-size-base: 16px;
  --swh-line-height: 1.6;
}
```

#### Font Sizes and Weights

```css
/* Headings */
.md-content h1 {
  font-size: 2.5rem;        /* 40px */
  font-weight: 700;
  line-height: 1.2;
  margin-bottom: 1rem;
}

.md-content h2 {
  font-size: 2rem;          /* 32px */
  font-weight: 600;
  line-height: 1.3;
  margin-top: 2rem;
  margin-bottom: 1rem;
}

.md-content h3 {
  font-size: 1.5rem;        /* 24px */
  font-weight: 600;
  line-height: 1.4;
  margin-top: 1.5rem;
  margin-bottom: 0.75rem;
}

.md-content h4 {
  font-size: 1.25rem;       /* 20px */
  font-weight: 600;
  line-height: 1.4;
  margin-top: 1.25rem;
  margin-bottom: 0.5rem;
}

/* Body text */
.md-content p {
  font-size: 1rem;          /* 16px */
  font-weight: 400;
  line-height: 1.6;
  margin-bottom: 1rem;
}

/* Small text */
.md-content small {
  font-size: 0.875rem;      /* 14px */
  font-weight: 400;
  line-height: 1.5;
}

/* Code */
.md-content code {
  font-family: 'Fira Code', 'Monaco', 'Consolas', monospace;
  font-size: 0.875rem;
  font-weight: 400;
}
```

#### Responsive Typography

```css
/* Mobile adjustments */
@media (max-width: 768px) {
  .md-content h1 {
    font-size: 2rem;        /* 32px */
  }
  
  .md-content h2 {
    font-size: 1.75rem;     /* 28px */
  }
  
  .md-content h3 {
    font-size: 1.375rem;    /* 22px */
  }
  
  .md-content p {
    font-size: 0.9375rem;   /* 15px */
  }
}

/* Tablet adjustments */
@media (min-width: 769px) and (max-width: 1024px) {
  .md-content h1 {
    font-size: 2.25rem;     /* 36px */
  }
  
  .md-content h2 {
    font-size: 1.875rem;    /* 30px */
  }
}
```

### Customizing Fonts

#### Changing the Primary Font

To change the primary font family, update the CSS variable:

```css
:root {
  --swh-font-family: 'Your Font', 'Helvetica Neue', Helvetica, Arial, sans-serif;
}
```

#### Adding Google Fonts

1. **Add to HTML head** (in `overrides/main.html`):

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
```

2. **Update CSS variables**:

```css
:root {
  --swh-font-family: 'Inter', 'Helvetica Neue', Helvetica, Arial, sans-serif;
}
```

#### Font Loading Optimization

```css
/* Font display optimization */
@font-face {
  font-family: 'Inter';
  font-display: swap; /* Improves loading performance */
  src: url('path/to/inter.woff2') format('woff2');
}
```

## Template Customization

### HTML Templates

Custom HTML templates are located in `overrides/`:

#### Main Template (`overrides/main.html`)

```html
{# overrides/main.html #}
{% extends "base.html" %}

{% block extrahead %}
  {{ super() }}
  <script>window.__BASE_URL__ = "{{ base_url | default('') }}";</script>
  <link rel="stylesheet" href="{{ base_url }}/pagefind/pagefind-ui.css">
{% endblock %}

{% block header %}
  {{ super() }}
{% endblock %}

{% block content %}
  {% if page and page.url %}
    {% set segs = page.url.split('/') %}
    {% if segs and segs[0] == 'swhid-specification' %}
      {% include "partials/version-selector.html" %}
    {% endif %}
  {% endif %}
  {{ super() }}
{% endblock %}
```

#### Redirect Template (`overrides/redirect.html`)

```html
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="refresh" content="0; url={{ page.meta.redirect_url }}">
    <link rel="canonical" href="{{ page.meta.redirect_url }}">
    <script>
        window.location.replace("{{ page.meta.redirect_url }}");
    </script>
    <title>Redirecting...</title>
</head>
<body>
    <p>You should be redirected automatically to <a href="{{ page.meta.redirect_url }}">{{ page.meta.redirect_url }}</a>. If not, click the link.</p>
</body>
</html>
```

## Plugin Configuration

### MkDocs Plugins

Plugins are configured in `mkdocs.yml`:

```yaml
plugins:
  - search
  - git-revision-date-localized:
      enable_creation_date: true
  - redirects:
      redirect_maps: {}
  - monorepo
```

### Monorepo Architecture

The website uses the **MkDocs Monorepo Plugin** to integrate content from multiple sources:

#### Current Site Structure

```yaml
nav:
  - Home: index.md
  - Specification: '!include .monorepo-overlays/spec-v1.2.mkdocs.yml'
  - v1.0: '!include .monorepo-overlays/spec-v1.0.mkdocs.yml'
  - v1.1: '!include .monorepo-overlays/spec-v1.1.mkdocs.yml'
  - dev: '!include .monorepo-overlays/spec-dev.mkdocs.yml'
  - Governance: '!include sources/governance/mkdocs.yml'
  - FAQ: faq.md
  - News: 
    - All news: news/index.md
    - [Dynamic news entries...]
  - Tags: tags/index.md
  - Publications: publications.md
  - Core Team: coreteam.md
```

#### Version Management

The system automatically manages multiple specification versions:

- **Latest Version**: `v1.2` (marked as "Specification" in navigation)
- **Previous Versions**: `v1.0`, `v1.1` (shown as separate tabs)
- **Development Version**: `dev` (hidden from horizontal navigation but accessible via URL)

#### Overlay Generation

Version-specific overlays are automatically generated in `.monorepo-overlays/`:

```
.monorepo-overlays/
├── spec-v1.0.mkdocs.yml    # v1.0 specification overlay
├── spec-v1.1.mkdocs.yml    # v1.1 specification overlay
├── spec-v1.2.mkdocs.yml    # v1.2 specification overlay (latest)
└── spec-dev.mkdocs.yml     # Development version overlay
```

### Search Integration

#### Pagefind Configuration

The website uses **Pagefind** for client-side search:

```yaml
# Pagefind is installed locally and configured via JavaScript
extra_javascript:
  - assets/javascripts/hide-version-tabs.js
```

#### Search Features

- **Full-text search** across all content
- **Tag-based filtering** for content organization
- **Version-specific filtering** for specification content
- **Section-based filtering** (news, specification, governance, main)
- **URL parameter support** for direct search links

### Dynamic Content Generation

#### Tags System

The website includes a **dynamic tags system**:

```python
# scripts/generate-tags.py
# Automatically scans all markdown files for YAML frontmatter tags
# Generates docs/tags/index.md with organized tag listings
```

#### News Management

News entries are **dynamically discovered** and included in navigation:

```python
# scripts/generate-config.py
# Scans docs/news/ directory for markdown files
# Extracts titles from YAML frontmatter
# Generates navigation entries automatically
```

## Color Customization

### Complete Color System

The website uses a **comprehensive color system** with multiple levels of customization:

#### Primary Brand Colors

```css
/* Software Heritage Brand Colors */
:root {
  --swh-primary: #1e3a8a;        /* Software Heritage Blue */
  --swh-secondary: #059669;       /* Software Heritage Green */
  --swh-accent: #dc2626;          /* Software Heritage Red */
  --swh-neutral: #6b7280;         /* Gray */
  --swh-light-gray: #f3f4f6;      /* Light background */
  --swh-dark-gray: #1f2937;       /* Dark text */
  --swh-text-color: #333;         /* Primary text */
}
```

#### Material Theme Color Integration

```css
/* Material theme color overrides */
:root {
  --md-primary-fg-color: var(--swh-primary);
  --md-primary-fg-color--light: #3b82f6;  /* Lighter blue */
  --md-primary-fg-color--dark: #1e40af;   /* Darker blue */
  --md-accent-fg-color: var(--swh-secondary);
  --md-accent-fg-color--transparent: rgba(5, 150, 105, 0.1);
}
```

#### Component-Specific Colors

```css
/* Header and navigation */
.md-header {
  background: linear-gradient(135deg, var(--swh-primary), var(--swh-secondary));
}

.md-tabs {
  background: var(--swh-neutral);
}

/* Buttons and interactive elements */
.md-button--primary {
  background-color: var(--swh-primary);
  border-color: var(--swh-primary);
}

.md-button--primary:hover {
  background-color: var(--swh-secondary);
  border-color: var(--swh-secondary);
}

/* Links */
.md-typeset a {
  color: var(--swh-primary);
}

.md-typeset a:hover {
  color: var(--swh-secondary);
}

/* Active navigation items */
.md-nav__item--active > .md-nav__link {
  color: var(--swh-primary);
  font-weight: 600;
}
```

#### News and Content Colors

```css
/* News entries */
.news-entry {
  background-color: #fdf2f2;      /* Light red background */
  border: 2px solid #e20026;      /* Red border */
  color: #333;                    /* Dark text */
}

.news-title {
  color: #e20026;                 /* Red title */
}

.news-date {
  color: var(--swh-neutral);      /* Gray date */
}

/* Search and filter components */
.search-filters {
  background: var(--md-default-bg-color);
  border: 1px solid var(--md-default-fg-color--lightest);
}

.filter-section h4 {
  color: var(--md-default-fg-color--light);
}

.clear-filters-btn {
  background: var(--md-accent-fg-color);
  color: var(--md-accent-bg-color);
}
```

### Customizing Colors

#### Make Material palette follow brand tokens

To have Material UI elements adopt your brand tokens defined in `extra.css`, map them to Material theme variables in `:root`:

```css
/* Map brand tokens to Material palette */
:root {
  /* Primary */
  --md-primary-fg-color: var(--swh-red);
  --md-primary-fg-color--light: #f24d62;  /* adjust to taste */
  --md-primary-fg-color--dark: #b3001f;   /* adjust to taste */

  /* Accent */
  --md-accent-fg-color: var(--swh-orange);
  --md-accent-fg-color--transparent: rgba(239, 68, 38, 0.12); /* soft accent */
}
```

#### Changing the Primary Color

To change the primary brand color:

1. **Update the CSS variable**:

```css
:root {
  --swh-primary: #your-color;  /* Replace with your color */
}
```

2. **Update Material theme colors**:

```css
:root {
  --md-primary-fg-color: var(--swh-primary);
  --md-primary-fg-color--light: #lighter-version;
  --md-primary-fg-color--dark: #darker-version;
}
```

#### Creating a Custom Color Palette

```css
/* Custom color palette */
:root {
  /* Primary colors */
  --custom-primary: #6366f1;      /* Indigo */
  --custom-secondary: #8b5cf6;    /* Purple */
  --custom-accent: #f59e0b;       /* Amber */
  
  /* Neutral colors */
  --custom-gray-50: #f9fafb;
  --custom-gray-100: #f3f4f6;
  --custom-gray-500: #6b7280;
  --custom-gray-900: #111827;
  
  /* Semantic colors */
  --custom-success: #10b981;      /* Green */
  --custom-warning: #f59e0b;      /* Amber */
  --custom-error: #ef4444;        /* Red */
  --custom-info: #3b82f6;         /* Blue */
}
```

#### Dark Mode Support

```css
/* Dark mode color overrides */
@media (prefers-color-scheme: dark) {
  :root {
    --swh-text-color: #e5e7eb;
    --swh-light-gray: #374151;
    --swh-dark-gray: #f9fafb;
    
    /* Dark mode specific colors */
    --md-default-bg-color: #1a1a1a;
    --md-default-fg-color: #e5e7eb;
  }
}
```

### Custom Plugins

Custom plugins can be added to extend functionality:

```python
# plugins/custom_plugin.py
from mkdocs.plugins import BasePlugin

class CustomPlugin(BasePlugin):
    def on_page_content(self, content, page, config, files):
        # Custom content processing
        return content

    def on_page_markdown(self, markdown, page, config, files):
        # Custom markdown processing
        return markdown
```

## Branding Customization

### Logo and Icons

#### Logo Configuration

```yaml
# mkdocs.yml
theme:
  logo: assets/images/logo.svg
  favicon: assets/images/favicon.ico
```

#### Custom Icons

```css
/* Custom icon styling */
.md-icon {
  width: 24px;
  height: 24px;
}

.md-icon--custom {
  background-image: url("data:image/svg+xml;base64,...");
}
```

### Color Scheme

#### Primary Colors

```css
:root {
  --md-primary-fg-color: #d73c2c;        /* SWHID Red */
  --md-primary-fg-color--light: #e74c3c; /* Light Red */
  --md-primary-fg-color--dark: #c0392b;  /* Dark Red */
  --md-accent-fg-color: #f39c12;         /* SWHID Orange */
  --md-accent-fg-color--transparent: rgba(243, 156, 18, 0.1);
}
```

#### Secondary Colors

```css
:root {
  --md-default-fg-color: #2c3e50;        /* Dark Text */
  --md-default-fg-color--light: #7f8c8d; /* Light Text */
  --md-default-fg-color--lighter: #bdc3c7; /* Lighter Text */
  --md-default-fg-color--lightest: #ecf0f1; /* Lightest Text */
  --md-default-bg-color: #ffffff;        /* White Background */
  --md-default-bg-color--light: #f8f9fa; /* Light Background */
  --md-default-bg-color--lighter: #f1f2f6; /* Lighter Background */
  --md-default-bg-color--lightest: #ffffff; /* Lightest Background */
}
```

## Advanced Customization

### Custom Components

#### Custom Buttons

```css
.swhid-button {
  display: inline-block;
  padding: 0.75rem 1.5rem;
  background-color: var(--swhid-red);
  color: white;
  text-decoration: none;
  border-radius: 0.375rem;
  font-weight: 600;
  transition: all 0.2s ease;
}

.swhid-button:hover {
  background-color: var(--swhid-orange);
  color: white;
  text-decoration: none;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
```

#### Custom Cards

```css
.swhid-card {
  background: white;
  border: 1px solid #e9ecef;
  border-radius: 0.5rem;
  padding: 1.5rem;
  margin: 1rem 0;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  transition: box-shadow 0.2s ease;
}

.swhid-card:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}
```

### Responsive Design

#### Mobile Optimization

```css
@media (max-width: 768px) {
  .md-header__title {
    font-size: 1.25rem;
  }
  
  .md-content h1 {
    font-size: 1.75rem;
  }
  
  .md-content h2 {
    font-size: 1.5rem;
  }
}
```

#### Tablet Optimization

```css
@media (min-width: 769px) and (max-width: 1024px) {
  .md-content {
    max-width: 800px;
    margin: 0 auto;
  }
}
```

## Testing Customizations

### Local Testing

```bash
# Build and serve locally
make serve

# Test in different browsers
# Test on different devices
# Test with different screen sizes
```

### Browser Testing

- **Chrome**: Test in Chrome
- **Firefox**: Test in Firefox
- **Safari**: Test in Safari
- **Edge**: Test in Edge
- **Mobile**: Test on mobile devices

### Performance Testing

```bash
# Check CSS size
ls -la overrides/assets/stylesheets/

# Check JavaScript size
ls -la overrides/assets/javascripts/

# Check build time
time make build
```

## Best Practices

### CSS Best Practices

1. **Use CSS Variables**: Define colors and sizes as variables
2. **Mobile First**: Design for mobile first
3. **Semantic Classes**: Use semantic class names
4. **Consistent Spacing**: Use consistent spacing units
5. **Performance**: Minimize CSS size

### JavaScript Best Practices

1. **Minimal JavaScript**: Use minimal JavaScript
2. **Progressive Enhancement**: Enhance, don't replace
3. **Error Handling**: Include error handling
4. **Performance**: Optimize for performance
5. **Accessibility**: Ensure accessibility

### Maintenance

1. **Document Changes**: Document all customizations
2. **Version Control**: Use version control
3. **Testing**: Test all changes
4. **Backup**: Keep backups of customizations
5. **Updates**: Update customizations when needed



