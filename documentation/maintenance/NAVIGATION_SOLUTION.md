# Navigation Solution: Hiding Version Links from Horizontal Bar

## Problem

The SWHID monorepo requires all specification versions to be present in the navigation configuration for the build system to include them in the final site. However, we want to hide the individual version links (v1.0, v1.1, v1.2) from the horizontal navigation bar while keeping only a single "Specification" link that points to the latest version.

## Solution Overview

This solution uses a clean, text-based JavaScript filter that hides version tabs at runtime while preserving all functionality. The approach is future-proof and automatically handles any number of versions without requiring manual updates.

## Implementation

### 1. CSS Helper Classes (`overrides/assets/stylesheets/extra.css`)

Simple CSS classes to hide elements programmatically:

```css
/* =============================================================================
   VERSION TAB HIDING - Hide individual version tabs from horizontal navigation
   ============================================================================= */

/* Hide any tab we mark programmatically */
.md-tabs__item.swhid-hidden-tab {
  display: none !important;
}

/* Hide version links from mobile sidebar navigation */
.md-nav__item.swhid-hidden-nav {
  display: none !important;
}
```

### 2. JavaScript Filter (`overrides/assets/javascripts/hide-version-tabs.js`)

A lightweight JavaScript filter that targets tabs by their visible text content:

```javascript
(function () {
  'use strict';

  // Match v1.0, v1.2.3, etc. Adjust if you want only major.minor.
  const VERSION_LABEL_RE = /^v\d+\.\d+(?:\.\d+)?$/i;

  function hideVersionTabs() {
    // Top horizontal tabs (first-level nav)
    document.querySelectorAll('.md-tabs__list .md-tabs__item').forEach((item) => {
      const a = item.querySelector('a');
      if (!a) return;
      const label = (a.textContent || '').trim();
      if (VERSION_LABEL_RE.test(label)) {
        item.classList.add('swhid-hidden-tab');
      }
    });
  }

  // Hide from mobile sidebar navigation
  function hideVersionPrimaryNav() {
    document
      .querySelectorAll('.md-nav--primary .md-nav__item')
      .forEach((li) => {
        const a = li.querySelector('a');
        if (!a) return;
        const label = (a.textContent || '').trim();
        if (VERSION_LABEL_RE.test(label) || label.toLowerCase() === 'dev') {
          li.classList.add('swhid-hidden-nav');
        }
      });
  }

  function run() {
    hideVersionTabs();
    hideVersionPrimaryNav(); // Hide from mobile sidebar navigation
  }

  // Material for MkDocs is a SPA; run on load and on page changes.
  document.addEventListener('DOMContentLoaded', run);
  document.addEventListener('navigation', run);
})();
```

### 3. JavaScript Registration (`mkdocs.yml`)

Register the JavaScript file in the MkDocs configuration:

```yaml
extra_javascript:
- assets/javascripts/hide-version-tabs.js
```

## How It Works

1. **Build Time**: All version links remain in the navigation configuration, ensuring the monorepo build system includes all versions
2. **Runtime**: JavaScript scans both horizontal navigation tabs and mobile sidebar navigation for version labels (v1.0, v1.1, v1.2, dev, etc.)
3. **Filtering**: Navigation items with version labels are marked with the appropriate CSS class:
   - Horizontal tabs: `swhid-hidden-tab` class
   - Mobile sidebar: `swhid-hidden-nav` class
4. **Hiding**: CSS hides elements with these classes
5. **Result**: Only the main "Specification" link is visible in both horizontal navigation and mobile sidebar

## Key Benefits

- **Future-Proof**: Automatically handles any new version labels (v2.0, v3.1, etc.) without code changes
- **Non-Destructive**: All content remains accessible, only the UI is curated
- **Monorepo Compatible**: Build system gets all versions it needs
- **Clean UI**: Only "Specification" tab visible in both horizontal navigation and mobile sidebar
- **Version Selector**: Dropdown remains fully functional on specification pages
- **Text-Based**: Reliable filtering based on visible labels, not URLs
- **Lightweight**: Minimal JavaScript with no external dependencies

## Configuration

The solution automatically uses the version numbers defined in `mkdocs.yml`:

```yaml
nav:
- Home: index.md
- Specification: '!include .monorepo-overlays/spec-v1.2.mkdocs.yml'  # Main link
- v1.0: '!include .monorepo-overlays/spec-v1.0.mkdocs.yml'         # Hidden
- v1.1: '!include .monorepo-overlays/spec-v1.1.mkdocs.yml'         # Hidden
- v1.2: '!include .monorepo-overlays/spec-v1.2.mkdocs.yml'         # Hidden
- Governance: '!include sources/governance/mkdocs.yml'
- FAQ: faq.md
- News: ...
```

## Adding New Versions

When adding new specification versions:

1. Add the version to the navigation configuration in `mkdocs.yml`
2. The JavaScript will automatically hide the new version tab
3. No code changes required

Example for adding v2.0:

```yaml
nav:
- Home: index.md
- Specification: '!include .monorepo-overlays/spec-v2.0.mkdocs.yml'  # Updated to latest
- v2.0: '!include .monorepo-overlays/spec-v2.0.mkdocs.yml'         # New version (hidden)
- v1.2: '!include .monorepo-overlays/spec-v1.2.mkdocs.yml'         # Hidden
- v1.1: '!include .monorepo-overlays/spec-v1.1.mkdocs.yml'         # Hidden
- v1.0: '!include .monorepo-overlays/spec-v1.0.mkdocs.yml'         # Hidden
```

## Browser Support

- **Modern Browsers**: Uses modern JavaScript features (ES6+)
- **Material for MkDocs**: Compatible with Material theme's SPA navigation
- **Mobile**: Works on all screen sizes
- **Accessibility**: Maintains proper navigation structure

## Troubleshooting

### Version Tabs Still Visible

1. Check that the JavaScript file is being loaded
2. Verify the CSS classes are being applied
3. Check browser console for JavaScript errors
4. Ensure the regex pattern matches your version labels
5. Test both desktop and mobile views to ensure version links are hidden in both navigation areas

### JavaScript Not Working

1. Check that the JavaScript file is in the correct location (`overrides/assets/javascripts/`)
2. Verify the file is registered in `mkdocs.yml`
3. Check for JavaScript errors in the browser console
4. Ensure the DOM is ready before the script runs

### CSS Not Working

1. Check that the CSS file is being loaded
2. Verify the CSS classes are being applied to the elements
3. Check for CSS syntax errors
4. Ensure the `!important` declarations are not being overridden

## Files Modified

- `overrides/assets/stylesheets/extra.css` - CSS helper classes (added to existing file)
- `overrides/assets/javascripts/hide-version-tabs.js` - JavaScript filter
- `mkdocs.yml` - JavaScript registration

## Testing

To test the solution:

1. Build the site: `make build`
2. Open the site in a browser
3. Check that only the "Specification" link is visible in the horizontal navigation
4. Test mobile view (resize browser or use mobile device) and verify version links are hidden in the mobile sidebar
5. Verify that all version pages are still accessible via direct URLs
6. Test the version selector dropdown on specification pages
7. Test on different browsers and screen sizes

## Maintenance

The solution requires minimal maintenance:

- **Adding Versions**: Just update the navigation configuration
- **CSS Updates**: Only needed if the HTML structure changes significantly
- **JavaScript Updates**: Only needed for major functionality changes
- **Version Labels**: Update the regex pattern if version label format changes

## Conclusion

This solution provides a robust, maintainable way to hide version links while preserving the monorepo build requirements. The text-based filtering approach is reliable, future-proof, and automatically scales to any number of versions without breaking existing functionality.