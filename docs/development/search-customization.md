# Search Customization Guide

## Overview

The SWHID.org website uses **Pagefind** for client-side search functionality, providing fast, faceted search across all content. This guide covers how to customize the search appearance, behavior, and functionality.

## Current Search Implementation

### Architecture

The search system consists of several components:

- **Pagefind Engine**: Client-side search index and engine
- **Header Search**: Integrated search box in the horizontal navigation bar
- **Dedicated Search Page**: Full-featured search page at `/search/`
- **Filter System**: Faceted search with section, version, and tag filters
- **Responsive Design**: Mobile-optimized search experience

### File Structure

```
assets/
├── stylesheets/
│   └── pagefind-header.css      # Header search styling
└── javascripts/
    └── pagefind-header.js       # Header search functionality

docs/search/
└── index.md                     # Dedicated search page

overrides/
└── main.html                    # Pagefind filter injection
```

## Header Search Customization

### CSS Customization (`assets/stylesheets/pagefind-header.css`)

The header search box is fully customizable through CSS. Here's a comprehensive guide to all available customization options:

#### Container and Layout

```css
/* Main search container in header */
#pf-header {
  margin-left: auto;                    /* Push to right side of header */
  display: flex;
  align-items: center;
  width: 12rem;                        /* Initial width (compact) */
  min-width: 3rem;                     /* Minimum width for search icon */
  max-width: calc(100% - 8rem);        /* Leave space for GitHub link */
  position: relative;
  z-index: 30;                         /* Above header background */
  transition: width 0.3s ease;         /* Smooth expansion animation */
}

/* Expanded state when typing */
#pf-header:focus-within,
#pf-header .pagefind-ui__form:focus-within {
  width: calc(100% - 6rem);            /* Use almost all available space */
  max-width: calc(100% - 6rem);
}
```

#### Search Input Styling

```css
/* Search input field */
#pf-header .pagefind-ui__search-input {
  width: 100%;
  height: 2.25rem;                     /* Height of input field */
  border-radius: 0.375rem;             /* Rounded corners */
  border: 1px solid var(--md-default-fg-color--lightest);
  background: var(--md-default-bg-color);
  color: var(--md-default-fg-color);
  padding: 0 0.75rem;                  /* Horizontal padding */
  font: inherit;                       /* Inherit font from theme */
}

/* Input focus state */
#pf-header .pagefind-ui__search-input:focus {
  outline: none;
  border-color: var(--md-accent-fg-color);
  box-shadow: 0 0 0 2px var(--md-accent-fg-color--transparent);
}
```

#### Search Results Dropdown

```css
/* Results dropdown panel */
#pf-header .pagefind-ui__drawer {
  position: absolute;
  top: calc(100% + 0.375rem);          /* Position below input */
  left: 0;
  width: 40rem;                        /* Fixed wide width for readability */
  max-width: 50rem;                    /* Allow some expansion */
  max-height: 75vh;                    /* Limit height to viewport */
  overflow: auto;                      /* Scrollable if needed */
  box-shadow: var(--md-shadow-z2);     /* Material design shadow */
  background: var(--md-default-bg-color);
  border: 1px solid var(--md-default-fg-color--lightest);
  border-radius: 0.5rem;
  z-index: 1000;                       /* Above other content */
}
```

#### Search Result Items

```css
/* Individual search result */
#pf-header .pagefind-ui__result {
  padding: 0.75rem 1rem;               /* Internal padding */
  border-bottom: 1px solid var(--md-default-fg-color--lightest);
  cursor: pointer;
  transition: background-color 0.2s ease;
}

#pf-header .pagefind-ui__result:hover {
  background-color: var(--md-default-bg-color--light);
}

#pf-header .pagefind-ui__result:last-child {
  border-bottom: none;
}

/* Result title */
#pf-header .pagefind-ui__result-title {
  font-weight: 600;
  margin-bottom: 0.25rem;
  color: var(--md-default-fg-color);
  font-size: 0.95rem;
}

/* Result excerpt */
#pf-header .pagefind-ui__result-excerpt {
  font-size: 0.875rem;
  color: var(--md-default-fg-color--light);
  line-height: 1.4;
}

/* Highlighted search terms */
#pf-header .pagefind-ui__result-excerpt mark {
  background-color: var(--md-accent-fg-color--transparent);
  color: var(--md-accent-fg-color);
  padding: 0.125rem 0.25rem;
  border-radius: 0.25rem;
}
```

#### Header Layout Protection

```css
/* Ensure header content doesn't get squeezed */
.md-header__inner {
  display: flex;
  align-items: center;
  width: 100%;
  gap: 0.5rem;                         /* Minimal gap between elements */
}

/* Protect the title - never let it get squeezed */
.md-header__title {
  flex-shrink: 0;                      /* Never shrink the title */
  min-width: 8rem;                     /* Ensure minimum space for "SWHID.org" */
  margin-right: 1rem;                  /* Space after title */
}

/* Protect the GitHub link - never let it get squeezed */
.md-header__source {
  flex-shrink: 0;                      /* Never shrink the GitHub link */
  margin-right: 0.5rem;                /* Minimal space before search box */
  min-width: 4rem;                     /* Ensure space for GitHub icon and text */
}
```

#### Responsive Design

```css
/* Medium screens - still allow full expansion */
@media (max-width: 76.1875em) {
  #pf-header { 
    width: 10rem;                      /* Smaller initial width */
    min-width: 3rem;
    max-width: calc(100% - 8rem);
  }
  
  #pf-header:focus-within {
    width: calc(100% - 6rem);          /* Still use most space */
    max-width: calc(100% - 6rem);
  }
  
  /* Make the drawer full width on medium screens */
  #pf-header .pagefind-ui__drawer {
    width: 100vw;
    max-width: 100vw;
    left: 0;
    right: 0;
  }
}

/* Small screens - show search icon only */
@media (max-width: 48em) {
  #pf-header {
    width: 3rem;                       /* Just search icon */
    min-width: 3rem;
    max-width: 3rem;
  }
  
  /* Hide the search input, show only icon */
  #pf-header .pagefind-ui__search-input {
    display: none;
  }
  
  /* Show search icon that redirects to search page */
  #pf-header::before {
    content: "🔍";                     /* Search icon */
    font-size: 1.2rem;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 3rem;
    height: 2.25rem;
    background: var(--md-default-bg-color);
    border: 1px solid var(--md-default-fg-color--lightest);
    border-radius: 0.375rem;
  }
  
  #pf-header:focus-within {
    width: 3rem;                       /* Stay as icon on small screens */
    max-width: 3rem;
  }
  
  /* On small screens, make the drawer full width */
  #pf-header .pagefind-ui__drawer {
    width: 100vw;
    max-width: 100vw;
    left: 0;
    right: 0;
    top: calc(100% + 0.5rem);
  }
}
```

### JavaScript Customization (`assets/javascripts/pagefind-header.js`)

The header search functionality is implemented in JavaScript. Key customization points:

#### PagefindUI Configuration

```javascript
new PagefindUI({
  element: "#pf-header-ui",             // Target element
  bundlePath: (window.__BASE_URL__||"").replace(/\/+$/,'') ? `${(window.__BASE_URL__||"").replace(/\/+$/,'')}/pagefind/` : "/pagefind/",
  baseUrl: (window.__BASE_URL__||"").replace(/\/+$/,'') || "/",
  showSubResults: true,                 // Show sub-results
  showImages: false,                    // Hide images in results
  showFilters: ["section", "spec_version", "tag"], // Available filters
  translations: { 
    placeholder: "Search SWHID.org"     // Placeholder text
  },
});
```

#### Customization Options

- **`element`**: CSS selector for the search container
- **`bundlePath`**: Path to Pagefind assets (must match build output)
- **`baseUrl`**: Base URL for rewriting result links
- **`showSubResults`**: Whether to show sub-results in dropdown
- **`showImages`**: Whether to show images in search results
- **`showFilters`**: Array of filter names to display
- **`translations`**: Object with custom text strings

## Search Page Customization

### Search Page (`docs/search/index.md`)

The dedicated search page provides full-featured search with filters:

```html
<div id="pagefind-search"></div>

<link rel="stylesheet" href="${((window.__BASE_URL__||"").replace(/\/+$/,'')||'')}/pagefind/pagefind-ui.css">
<script src="${((window.__BASE_URL__||"").replace(/\/+$/,'')||'')}/pagefind/pagefind-ui.js" defer></script>
<script defer>
  window.addEventListener('DOMContentLoaded', () => {
    try {
      // Get query parameter from URL
      const urlParams = new URLSearchParams(window.location.search);
      const query = urlParams.get('q');

      new PagefindUI({
        element: "#pagefind-search",
        bundlePath: (window.__BASE_URL__||"").replace(/\/+$/,'') ? `${(window.__BASE_URL__||"").replace(/\/+$/,'')}/pagefind/` : "/pagefind/",
        baseUrl: (window.__BASE_URL__||"").replace(/\/+$/,'') || "/",
        showSubResults: true,
        showImages: false,
        showFilters: ["section", "spec_version", "tag"],
        translations: { placeholder: "Search SWHID.org" },
        // Pre-populate search if query parameter exists
        ...(query && { searchTerm: query })
      });
    } catch (error) {
      console.error('PagefindUI initialization failed:', error);
      document.getElementById('pagefind-search').innerHTML = 
        '<p>Search temporarily unavailable. Please try again later.</p>';
    }
  });
</script>
```

## Filter System

### Filter Injection (`overrides/main.html`)

Filters are automatically injected into each page based on content:

```jinja2
{% block extrahead %}
  {{ super() }}
  <link rel="stylesheet" href="/pagefind/pagefind-ui.css">

  {# Section + spec version #}
  {% set _url = page and page.url or '' %}
  {% if _url.startswith('swhid-specification/') %}
    <meta data-pagefind-filter="section:specification">
    {# spec_version from URL: swhid-specification/vX.Y/... or /dev/... #}
    {% set segs = _url.split('/') %}
    {% if segs|length > 1 %}<meta data-pagefind-filter="spec_version:{{ segs[1] }}">{% endif %}
  {% elif _url.startswith('swhid-governance/') %}
    <meta data-pagefind-filter="section:governance">
  {% else %}
    <meta data-pagefind-filter="section:main">
  {% endif %}

  {# Front-matter tags -> filter "tag" (multiple allowed) #}
  {% if page and page.meta and page.meta.tags %}
    {% for t in page.meta.tags %}
      <meta data-pagefind-filter="tag:{{ t }}">
    {% endfor %}
  {% endif %}
{% endblock %}
```

### Available Filters

- **`section`**: Content section (specification, governance, main)
- **`spec_version`**: Specification version (v1.0, v1.1, v1.2, dev)
- **`tag`**: Content tags from front matter

## Color Customization

### Theme Integration

The search uses Material theme CSS variables for consistent styling:

```css
/* Use Material theme colors */
#pf-header .pagefind-ui__search-input {
  border-color: var(--md-default-fg-color--lightest);
  background: var(--md-default-bg-color);
  color: var(--md-default-fg-color);
}

#pf-header .pagefind-ui__drawer {
  background: var(--md-default-bg-color);
  border-color: var(--md-default-fg-color--lightest);
  box-shadow: var(--md-shadow-z2);
}

#pf-header .pagefind-ui__result-excerpt mark {
  background-color: var(--md-accent-fg-color--transparent);
  color: var(--md-accent-fg-color);
}
```

### Custom Color Scheme

To customize colors, override the CSS variables:

```css
/* Custom search colors */
:root {
  --search-primary: #1e3a8a;           /* Primary search color */
  --search-secondary: #059669;         /* Secondary search color */
  --search-accent: #dc2626;            /* Accent color */
  --search-bg: #ffffff;                /* Background color */
  --search-border: #e5e7eb;            /* Border color */
  --search-text: #1f2937;              /* Text color */
  --search-text-light: #6b7280;        /* Light text color */
}

/* Apply custom colors */
#pf-header .pagefind-ui__search-input {
  border-color: var(--search-border);
  background: var(--search-bg);
  color: var(--search-text);
}

#pf-header .pagefind-ui__search-input:focus {
  border-color: var(--search-primary);
  box-shadow: 0 0 0 2px rgba(30, 58, 138, 0.1);
}
```

## Size and Positioning Customization

### Width and Height

```css
/* Search container sizing */
#pf-header {
  width: 12rem;                        /* Initial width */
  min-width: 3rem;                     /* Minimum width */
  max-width: calc(100% - 8rem);        /* Maximum width */
}

/* Expanded width when typing */
#pf-header:focus-within {
  width: calc(100% - 6rem);            /* Expanded width */
  max-width: calc(100% - 6rem);
}

/* Input field height */
#pf-header .pagefind-ui__search-input {
  height: 2.25rem;                     /* Input height */
}

/* Results dropdown width */
#pf-header .pagefind-ui__drawer {
  width: 40rem;                        /* Dropdown width */
  max-width: 50rem;                    /* Maximum dropdown width */
}
```

### Positioning

```css
/* Header layout */
.md-header__inner {
  display: flex;
  align-items: center;
  gap: 0.5rem;                         /* Gap between elements */
}

/* Title protection */
.md-header__title {
  flex-shrink: 0;                      /* Never shrink */
  min-width: 8rem;                     /* Minimum title width */
  margin-right: 1rem;                  /* Space after title */
}

/* GitHub link protection */
.md-header__source {
  flex-shrink: 0;                      /* Never shrink */
  min-width: 4rem;                     /* Minimum GitHub width */
  margin-right: 0.5rem;                /* Space before search */
}

/* Search container positioning */
#pf-header {
  margin-left: auto;                   /* Push to right */
  position: relative;                  /* For dropdown positioning */
  z-index: 30;                         /* Above header background */
}
```

## Font Customization

### Font Family

```css
/* Search input font */
#pf-header .pagefind-ui__search-input {
  font-family: var(--md-text-font, inherit);
  font-size: 1rem;
  font-weight: 400;
}

/* Result title font */
#pf-header .pagefind-ui__result-title {
  font-family: var(--md-text-font, inherit);
  font-size: 0.95rem;
  font-weight: 600;
}

/* Result excerpt font */
#pf-header .pagefind-ui__result-excerpt {
  font-family: var(--md-text-font, inherit);
  font-size: 0.875rem;
  font-weight: 400;
  line-height: 1.4;
}
```

### Font Sizes

```css
/* Responsive font sizes */
@media (max-width: 48em) {
  #pf-header .pagefind-ui__search-input {
    font-size: 0.9rem;                 /* Smaller on mobile */
  }
  
  #pf-header .pagefind-ui__result-title {
    font-size: 0.9rem;
  }
  
  #pf-header .pagefind-ui__result-excerpt {
    font-size: 0.8rem;
  }
}
```

## Animation and Transitions

### Smooth Transitions

```css
/* Container expansion */
#pf-header {
  transition: width 0.3s ease;         /* Smooth width change */
}

/* Result hover effects */
#pf-header .pagefind-ui__result {
  transition: background-color 0.2s ease;
}

/* Input focus effects */
#pf-header .pagefind-ui__search-input {
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
}
```

### Custom Animations

```css
/* Fade in animation for results */
#pf-header .pagefind-ui__drawer {
  animation: fadeIn 0.2s ease-in-out;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(-10px); }
  to { opacity: 1; transform: translateY(0); }
}

/* Slide in animation for search box */
#pf-header {
  animation: slideIn 0.3s ease-out;
}

@keyframes slideIn {
  from { transform: translateX(20px); opacity: 0; }
  to { transform: translateX(0); opacity: 1; }
}
```

## Advanced Customization

### Custom Search Behavior

```javascript
// Custom search initialization
document.addEventListener('DOMContentLoaded', function() {
  const searchContainer = document.querySelector('#pf-header-ui');
  if (!searchContainer) return;

  // Initialize PagefindUI with custom options
  const pagefindUI = new PagefindUI({
    element: "#pf-header-ui",
    bundlePath: "/pagefind/",
    baseUrl: "/",
    showSubResults: true,
    showImages: false,
    showFilters: ["section", "spec_version", "tag"],
    translations: { 
      placeholder: "Search SWHID.org",
      clear_search: "Clear",
      load_more: "Load more results",
      search_error: "Search failed",
      no_results: "No results found",
      zero_results: "No results found for your search"
    }
  });

  // Custom event handlers
  pagefindUI.on('ready', () => {
    console.log('Pagefind search is ready');
  });

  pagefindUI.on('search', (query) => {
    console.log('Search query:', query);
  });

  pagefindUI.on('result', (result) => {
    console.log('Search result:', result);
  });
});
```

### Custom Styling for Different States

```css
/* Loading state */
#pf-header .pagefind-ui__loading {
  opacity: 0.6;
  pointer-events: none;
}

/* Error state */
#pf-header .pagefind-ui__error {
  color: var(--md-accent-fg-color);
  font-style: italic;
}

/* No results state */
#pf-header .pagefind-ui__no-results {
  color: var(--md-default-fg-color--light);
  font-style: italic;
  text-align: center;
  padding: 1rem;
}

/* Empty state */
#pf-header .pagefind-ui__empty {
  color: var(--md-default-fg-color--light);
  text-align: center;
  padding: 1rem;
}
```

## Testing and Debugging

### Local Testing

```bash
# Build and serve locally
make serve

# Test search functionality
# - Type in header search box
# - Check dropdown results
# - Test responsive behavior
# - Verify filter functionality
```

### Debug Mode

```javascript
// Enable debug logging
window.addEventListener('DOMContentLoaded', function() {
  const pagefindUI = new PagefindUI({
    // ... configuration
    debug: true  // Enable debug mode
  });
});
```

### Performance Testing

```bash
# Check Pagefind index size
ls -la site/pagefind/

# Check search performance
# - Measure search response time
# - Check memory usage
# - Verify index loading speed
```

## Best Practices

### CSS Best Practices

1. **Use CSS Variables**: Define colors and sizes as variables
2. **Mobile First**: Design for mobile first, then enhance for desktop
3. **Consistent Spacing**: Use consistent spacing units (rem, em)
4. **Performance**: Minimize CSS size and complexity
5. **Accessibility**: Ensure proper contrast and focus states

### JavaScript Best Practices

1. **Error Handling**: Always include try-catch blocks
2. **Performance**: Use efficient event listeners
3. **Accessibility**: Ensure keyboard navigation works
4. **Progressive Enhancement**: Work without JavaScript
5. **Clean Code**: Use clear, maintainable code

### Maintenance

1. **Document Changes**: Document all customizations
2. **Version Control**: Use version control for all changes
3. **Testing**: Test across different browsers and devices
4. **Updates**: Update when Pagefind or theme updates
5. **Performance**: Monitor search performance regularly

## Troubleshooting

### Common Issues

#### Search Box Not Appearing

- Check that `assets/stylesheets/pagefind-header.css` is loaded
- Verify `assets/javascripts/pagefind-header.js` is loaded
- Ensure Pagefind assets are built (`make build`)

#### Search Not Working

- Check browser console for JavaScript errors
- Verify Pagefind index is built (`ls -la site/pagefind/`)
- Check that `bundlePath` is correct

#### Styling Issues

- Check CSS specificity
- Verify Material theme variables are available
- Test in different browsers

#### Responsive Issues

- Test on different screen sizes
- Check media query breakpoints
- Verify mobile behavior

### Debug Steps

1. **Check Console**: Look for JavaScript errors
2. **Inspect Elements**: Check CSS is applied correctly
3. **Test Build**: Ensure `make build` completes successfully
4. **Check Assets**: Verify all assets are loaded
5. **Test Search**: Try searching for known content

For more help, see the main [Customization Guide](customization.md) or [Local Development](local-development.md) documentation.
