# Navigation Management

## Overview

The SWHID.org website uses a sophisticated navigation system that integrates content from multiple sources while providing a clean, user-friendly interface. This guide explains how to manage the navigation system, including adding new sections, managing version links, and customizing the navigation experience.

## Navigation Architecture

### Navigation Levels

The website has multiple navigation levels:

1. **Top Horizontal Navigation**: Main site sections
2. **Left Sidebar Navigation**: Page-specific navigation
3. **Breadcrumb Navigation**: Current page location
4. **Footer Navigation**: Additional links and information

### Navigation Sources

Navigation content comes from multiple sources:

- **Main Site**: Core website navigation
- **Specification**: Technical specification navigation
- **Governance**: Community governance navigation
- **Versioned Content**: Version-specific navigation

## Main Navigation Configuration

### Top Horizontal Navigation

The top horizontal navigation is configured in `mkdocs.yml`:

```yaml
nav:
  - Home: index.md
  - Specification: '!include .monorepo-overlays/spec-v1.2.mkdocs.yml'  # Main link
  - v1.0: '!include .monorepo-overlays/spec-v1.0.mkdocs.yml'         # Hidden
  - v1.1: '!include .monorepo-overlays/spec-v1.1.mkdocs.yml'         # Hidden
  - v1.2: '!include .monorepo-overlays/spec-v1.2.mkdocs.yml'         # Hidden
  - Governance: '!include sources/governance/mkdocs.yml'
  - FAQ: faq.md
  - News: news/index.md
  - Publications: publications.md
  - Core Team: coreteam.md
```

### Navigation Structure

Each navigation item can have:

- **Simple Link**: Direct link to a page
- **Section**: Group of related pages
- **External Link**: Link to external resource
- **Submodule**: Content from Git submodule

## Adding Navigation Items

### Adding Main Sections

1. **Create Content**: Create the content page
2. **Add to Navigation**: Add to `mkdocs.yml`
3. **Test Navigation**: Test the navigation
4. **Deploy**: Deploy the changes

Example:

```yaml
nav:
  - Home: index.md
  - New Section: new-section.md  # Add new section
  - Specification: '!include .monorepo-overlays/spec-v1.2.mkdocs.yml'
  # ... other sections
```

### Adding Subsections

1. **Create Content**: Create the content pages
2. **Organize Structure**: Organize in logical structure
3. **Add to Navigation**: Add to `mkdocs.yml`
4. **Test Navigation**: Test the navigation

Example:

```yaml
nav:
  - Home: index.md
  - Documentation:
    - Overview: docs/overview.md
    - Getting Started: docs/getting-started.md
    - API Reference: docs/api.md
  - Specification: '!include .monorepo-overlays/spec-v1.2.mkdocs.yml'
  # ... other sections
```

### Adding External Links

1. **Determine URL**: Determine the external URL
2. **Add to Navigation**: Add to `mkdocs.yml`
3. **Test Link**: Test the external link
4. **Deploy**: Deploy the changes

Example:

```yaml
nav:
  - Home: index.md
  - External Resource: https://example.com  # External link
  - Specification: '!include .monorepo-overlays/spec-v1.2.mkdocs.yml'
  # ... other sections
```

## Version Management

### Hiding Version Links

The website hides individual version links from the horizontal navigation while keeping them in the configuration for the build system:

#### CSS Solution

```css
/* Hide version tabs from horizontal navigation */
.md-tabs__item.swhid-hidden-tab {
  display: none !important;
}
```

#### JavaScript Solution

```javascript
// Hide version tabs based on label pattern
(function () {
  'use strict';
  
  const VERSION_LABEL_RE = /^v\d+\.\d+(?:\.\d+)?$/i;
  
  function hideVersionTabs() {
    document.querySelectorAll('.md-tabs__list .md-tabs__item').forEach((item) => {
      const a = item.querySelector('a');
      if (!a) return;
      const label = (a.textContent || '').trim();
      if (VERSION_LABEL_RE.test(label)) {
        item.classList.add('swhid-hidden-tab');
      }
    });
  }
  
  document.addEventListener('DOMContentLoaded', hideVersionTabs);
  document.addEventListener('navigation', hideVersionTabs);
})();
```

### Version Selector

The version selector appears on specification pages:

```html
<!-- Version selector dropdown -->
<select id="version-selector" onchange="window.location.href=this.value">
  <option value="/swhid-specification/v1.2/" selected>v1.2 (latest)</option>
  <option value="/swhid-specification/v1.1/">v1.1</option>
  <option value="/swhid-specification/v1.0/">v1.0</option>
</select>
```

## Submodule Navigation

### Specification Navigation

The specification navigation is managed through submodules:

```yaml
# sources/specification/mkdocs.yml
nav:
  - Introduction: Chapters/0.Introduction.md
  - Scope: Chapters/1.Scope.md
  - Terms and Definitions: Chapters/3.Terms_and_definitions.md
  - Syntax: Chapters/4.Syntax.md
  - Core Identifiers: Chapters/5.Core_identifiers.md
  - Qualified Identifiers: Chapters/6.Qualified_identifiers.md
  - Conformance: Chapters/A.Conformance.md
```

### Governance Navigation

The governance navigation is also managed through submodules:

```yaml
# sources/governance/mkdocs.yml
nav:
  - Introduction: Chapters/index.md
  - Scope: Chapters/2.Scope.md
  - License: Chapters/4.License.md
  - Governance: Chapters/5.Governance.md
  - Contributing: Chapters/6.Contributing.md
  - Code of Conduct: Chapters/7.Code_of_Conduct.md
```

## Navigation Customization

### Custom CSS

Customize navigation appearance:

```css
/* Custom navigation styling */
.md-nav__item--active > .md-nav__link {
  color: var(--swhid-red);
  font-weight: 600;
}

.md-nav__link:hover {
  color: var(--swhid-orange);
}

.md-nav__item--nested > .md-nav__link {
  padding-left: 1.5rem;
}

/* Custom tab styling */
.md-tabs__item--active {
  border-bottom: 2px solid var(--swhid-orange);
}

.md-tabs__link:hover {
  color: var(--swhid-orange);
}
```

### Custom JavaScript

Add custom navigation functionality:

```javascript
// Custom navigation functionality
(function () {
  'use strict';
  
  function initNavigation() {
    // Add smooth scrolling
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
      anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
          target.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
          });
        }
      });
    });
    
    // Add active state management
    updateActiveStates();
  }
  
  function updateActiveStates() {
    const currentPath = window.location.pathname;
    document.querySelectorAll('.md-nav__link').forEach(link => {
      if (link.getAttribute('href') === currentPath) {
        link.classList.add('md-nav__link--active');
      }
    });
  }
  
  document.addEventListener('DOMContentLoaded', initNavigation);
})();
```

## Navigation Testing

### Local Testing

Test navigation changes locally:

```bash
# Build and serve locally
make serve

# Test navigation
# - Check all links work
# - Verify navigation structure
# - Test responsive design
# - Check accessibility
```

### Navigation Validation

Validate navigation structure:

```bash
# Check navigation configuration
mkdocs config

# Validate navigation links using external tools
# Use browser developer tools or online link checkers

# Test navigation functionality
make test-navigation
```

## Best Practices

### Navigation Design

1. **Logical Structure**: Organize navigation logically
2. **Consistent Naming**: Use consistent naming conventions
3. **Clear Hierarchy**: Maintain clear navigation hierarchy
4. **User-Friendly**: Design for user experience
5. **Accessible**: Ensure navigation accessibility

### Content Organization

1. **Group Related Content**: Group related pages together
2. **Use Descriptive Labels**: Use clear, descriptive labels
3. **Limit Depth**: Avoid deep navigation hierarchies
4. **Provide Context**: Provide context for navigation items
5. **Maintain Consistency**: Maintain consistency across sections

### Technical Implementation

1. **Use Relative Links**: Use relative links when possible
2. **Validate Links**: Validate all navigation links
3. **Test Responsively**: Test on different screen sizes
4. **Optimize Performance**: Optimize navigation performance
5. **Handle Errors**: Handle navigation errors gracefully

## Troubleshooting

### Common Issues

#### Navigation Not Appearing

1. **Check Configuration**: Verify `mkdocs.yml` configuration
2. **Check Content**: Verify content files exist
3. **Check Build**: Verify build completed successfully
4. **Check Deploy**: Verify deployment completed

#### Links Not Working

1. **Check URLs**: Verify URL structure
2. **Check Content**: Verify target content exists
3. **Check Redirects**: Verify redirect configuration
4. **Check Build**: Verify build completed successfully

#### Version Links Visible

1. **Check CSS**: Verify CSS rules are applied
2. **Check JavaScript**: Verify JavaScript is working
3. **Check Classes**: Verify CSS classes are applied
4. **Check Build**: Verify build completed successfully

### Debugging

#### Enable Debug Mode

```bash
# Enable MkDocs debug mode
export MKDOCS_DEBUG=1
make serve
```

#### Check Navigation Structure

```bash
# Check navigation structure
mkdocs config --quiet | jq '.nav'
```

#### Validate Links

```bash
# Validate navigation links using external tools
# Use browser developer tools or online link checkers
```

## Advanced Features

### Dynamic Navigation

Create dynamic navigation based on content:

```javascript
// Dynamic navigation generation
function generateNavigation() {
  const content = document.querySelector('.md-content');
  const headings = content.querySelectorAll('h1, h2, h3, h4, h5, h6');
  
  const nav = document.createElement('nav');
  nav.className = 'md-nav md-nav--secondary';
  
  headings.forEach(heading => {
    const link = document.createElement('a');
    link.href = '#' + heading.id;
    link.textContent = heading.textContent;
    link.className = 'md-nav__link';
    nav.appendChild(link);
  });
  
  return nav;
}
```

### Navigation Analytics

Track navigation usage:

```javascript
// Navigation analytics
function trackNavigation() {
  document.querySelectorAll('.md-nav__link').forEach(link => {
    link.addEventListener('click', function() {
      // Track navigation clicks
      if (typeof gtag !== 'undefined') {
        gtag('event', 'navigation_click', {
          'link_text': this.textContent,
          'link_url': this.href
        });
      }
    });
  });
}
```

### Navigation Search

Add search functionality to navigation:

```javascript
// Navigation search
function addNavigationSearch() {
  const searchInput = document.createElement('input');
  searchInput.type = 'text';
  searchInput.placeholder = 'Search navigation...';
  searchInput.className = 'md-nav__search';
  
  searchInput.addEventListener('input', function() {
    const query = this.value.toLowerCase();
    document.querySelectorAll('.md-nav__link').forEach(link => {
      const text = link.textContent.toLowerCase();
      const parent = link.closest('.md-nav__item');
      if (text.includes(query)) {
        parent.style.display = 'block';
      } else {
        parent.style.display = 'none';
      }
    });
  });
  
  document.querySelector('.md-nav').prepend(searchInput);
}
```



