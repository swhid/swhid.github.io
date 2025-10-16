# Complete Site Styling Guide

## Overview

The SWHID.org website uses a comprehensive styling system built on top of MkDocs Material theme. This guide covers all aspects of site customization, from colors and typography to layout and responsive design.

## Current Styling Architecture

### File Structure

```
overrides/assets/stylesheets/
├── extra.css                    # Main site-wide styles
docs/assets/stylesheets/
├── pagefind-header.css          # Search box styling
overrides/
├── main.html                    # Template overrides
└── partials/
    └── version-selector.html    # Version selector component
```

### CSS Loading Order

1. **Material Theme CSS** (base theme)
2. **`extra.css`** (main custom styles)
3. **`pagefind-header.css`** (search functionality)

## Color System

### Primary Brand Colors

The site uses a consistent Software Heritage color palette:

```css
:root {
  --swh-red: #e20026;
  --swh-orange: #ef4426;
  --swh-light-orange: #f79622;
  --swh-yellow: #fabf1f;
  --swh-grey: #737373;
  --swh-primary: var(--swh-red); /* Primary - headers, links, buttons */
  --swh-secondary: var(--swh-orange); /* Secondary - hover states */
  --swh-accent: var(--swh-light-orange); /* Light - accents */
  --swh-highlight: var(--swh-yellow); /* Highlights */
  --swh-neutral: var(--swh-grey); /* Neutral - secondary text */
}
```

### Material Theme Integration

```css
/* Material theme color overrides */
.md-typeset a { 
  color: var(--swh-primary);
}

.md-header { 
  background: var(--swh-primary);
}

.md-tabs { 
  background: var(--swh-neutral);
}
```

### Color Usage Guidelines

- **Primary Primary (`--swh-primary`)**: Headers, main links, buttons, active states
- **Secondary (`--swh-secondary`)**: Hover states, secondary actions
- **Neutral (`--swh-neutral`)**: Secondary text, borders, inactive elements
- **Light (`--swh-accent`)**: Accent elements, highlights
- **Highlight (`--swh-highlight`)**: Special highlights, warnings

## Typography

### Font System

The site inherits Material theme's typography system with custom overrides:

```css
/* Headings */
.md-content h1 {
  color: var(--swh-primary);
  font-size: 2.5rem;
  font-weight: 700;
  line-height: 1.2;
  margin-bottom: 1rem;
}

.md-content h2 {
  color: var(--swh-neutral);
  font-size: 2rem;
  font-weight: 600;
  line-height: 1.3;
  margin-top: 2rem;
  margin-bottom: 1rem;
}

/* Body text */
.md-content p {
  font-size: 1rem;
  line-height: 1.6;
  margin-bottom: 1rem;
}

/* Links */
.md-typeset a {
  color: var(--swh-primary);
  text-decoration: none;
}

.md-typeset a:hover {
  color: var(--swh-secondary);
  text-decoration: underline;
}
```

### Responsive Typography

```css
/* Mobile adjustments */
@media (max-width: 768px) {
  .md-content h1 {
    font-size: 2rem;
  }
  
  .md-content h2 {
    font-size: 1.75rem;
  }
  
  .md-content p {
    font-size: 0.9375rem;
  }
}
```

## Header and Navigation

### Header Styling

```css
/* Main header */
.md-header {
  background: var(--swh-primary);
  box-shadow: 0 0 0.2rem 0 rgba(0,0,0,.1), 0 0.2rem 0.4rem 0 rgba(0,0,0,.1);
}

/* Header title */
.md-header__title {
  color: white;
  font-weight: 600;
}

/* Header navigation */
.md-header__nav {
  color: white;
}
```

### Tab Navigation

```css
/* Tab bar */
.md-tabs {
  background: var(--swh-neutral);
  border-bottom: 0.05rem solid rgba(0,0,0,.07);
}

/* Tab items */
.md-tabs__item {
  margin: 0 0.5rem;
  white-space: nowrap;
  flex-shrink: 0;
}

/* Tab links */
.md-tabs__link {
  color: rgba(255,255,255,0.7);
  font-weight: 500;
}

.md-tabs__link:hover,
.md-tabs__link--active {
  color: white;
}
```

### Responsive Navigation

```css
/* Keep tabs visible until they would wrap */
.md-tabs {
  display: block !important;
}

.md-tabs__list {
  display: flex !important;
  flex-wrap: nowrap;
  justify-content: center;
  padding: 0 1rem;
  overflow: hidden;
}

/* Medium screens - reduce spacing */
@media screen and (max-width: 76.1875em) {
  .md-tabs__list {
    padding: 0 0.75rem;
  }
  .md-tabs__item {
    margin: 0 0.4rem;
  }
}

/* Hide tabs on small screens */
@media screen and (max-width: 48em) {
  .md-tabs {
    display: none !important;
  }
}
```

## Content Areas

### Main Content

```css
/* Content container */
.md-content {
  max-width: 64rem;
  margin: 0 auto;
  padding: 0 1rem;
}

/* Content headings */
.md-content h1 {
  color: var(--swh-primary);
  border-bottom: 2px solid var(--swh-secondary);
  padding-bottom: 0.5rem;
}

.md-content h2 {
  color: var(--swh-neutral);
  margin-top: 2rem;
}

/* Code blocks */
.md-content pre {
  background-color: #f8f9fa;
  border: 1px solid #e9ecef;
  border-radius: 0.375rem;
  padding: 1rem;
}

/* Tables */
.md-content table {
  border-collapse: collapse;
  width: 100%;
  margin: 1rem 0;
}

.md-content th,
.md-content td {
  border: 1px solid #dee2e6;
  padding: 0.75rem;
  text-align: left;
}

.md-content th {
  background-color: #f8f9fa;
  font-weight: 600;
  color: var(--swh-primary);
}
```

### Sidebar Navigation

```css
/* Sidebar navigation */
.md-nav__item--active > .md-nav__link {
  color: var(--swh-primary);
  font-weight: 600;
}

.md-nav__link:hover {
  color: var(--swh-secondary);
}

/* Nested navigation */
.md-nav--secondary .md-nav__item--active > .md-nav__link {
  color: var(--swh-secondary);
}
```

## Special Components

### SWHID Banner

```css
/* Main banner styling */
.swhid-banner {
  background-color: #fff;           /* White background */
  border: 2px solid var(--swh-primary);        /* Primary border */
  border-radius: 12px;              /* Rounded corners */
  padding: 2rem;
  margin: 2rem 0;
  box-shadow: 0 4px 12px rgba(226, 0, 38, 0.1);
  text-align: center;
}

.swhid-banner h2 {
  color: var(--swh-primary);                   /* Primary heading */
  margin-bottom: 1rem;
  font-size: 1.8rem;
  font-weight: 700;
}

.swhid-banner p {
  color: #333;
  margin-bottom: 1rem;
  font-size: 1.1rem;
}

.swhid-banner .btn {
  background-color: var(--swh-primary);        /* Primary button */
  color: white;
  border: none;
  padding: 0.75rem 1.5rem;
  margin: 0.5rem;
  border-radius: 6px;
  text-decoration: none;
  font-weight: 600;
  display: inline-block;
  transition: background-color 0.3s ease;
}

.swhid-banner .btn:hover {
  background-color: var(--swh-secondary);        /* Secondary on hover */
  color: white;
  text-decoration: none;
}
```

### News Components

#### News Grid

```css
/* News item grid */
.news-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
  margin: 2rem 0;
}

.news-item {
  background-color: #fff;           /* White background */
  border: 2px solid var(--swh-primary);        /* Primary border */
  border-radius: 12px;              /* Rounded corners */
  padding: 1.5rem;
  box-shadow: 0 4px 12px rgba(226, 0, 38, 0.1);
  transition: all 0.3s ease;
  text-align: center;
}

.news-item:hover {
  border-color: var(--swh-secondary);            /* Secondary border on hover */
  box-shadow: 0 6px 16px rgba(226, 0, 38, 0.15);
  transform: translateY(-2px);      /* Lift effect */
}

.news-item h3 {
  color: var(--swh-primary);                   /* Primary heading */
  margin-bottom: 1rem;
  font-size: 1.3rem;
  font-weight: 700;
}

.news-item .btn {
  background-color: var(--swh-primary);        /* Primary button */
  color: white;
  border: 2px solid var(--swh-primary);
  padding: 0.75rem 1.5rem;
  border-radius: 6px;
  text-decoration: none;
  font-weight: 600;
  display: inline-block;
  transition: all 0.3s ease;
  width: 100%;
  text-align: center;
}

.news-item .btn:hover {
  background-color: var(--swh-secondary);        /* Secondary on hover */
  border-color: var(--swh-secondary);
  color: white;
  text-decoration: none;
  transform: translateY(-1px);
}
```

#### News Entries

```css
/* Individual news entries */
.news-entry {
  background-color: #fff;           /* White background */
  border: 2px solid var(--swh-primary);        /* Primary border */
  border-radius: 12px;              /* Rounded corners */
  padding: 1.5rem;
  margin-bottom: 1.5rem;
  box-shadow: 0 4px 12px rgba(226, 0, 38, 0.1);
  transition: all 0.3s ease;
  position: relative;
  padding-bottom: 3rem;             /* Space for read more button */
}

.news-entry:hover {
  border-color: var(--swh-secondary);            /* Secondary border on hover */
  box-shadow: 0 6px 16px rgba(226, 0, 38, 0.15);
  transform: translateY(-2px);      /* Lift effect */
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
  color: var(--swh-primary);                   /* Primary heading */
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
  background-color: var(--swh-primary);        /* Primary button */
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 6px 6px 0 0;      /* Rounded top corners only */
  text-decoration: none;
  font-weight: 600;
  font-size: 0.9rem;
  position: absolute;
  bottom: -1px;                     /* Overlap the bottom border */
  right: 0;
  transition: all 0.3s ease;
  box-shadow: 0 -2px 4px rgba(226, 0, 38, 0.2);
}

a.news-read-more:hover {
  background-color: var(--swh-secondary);        /* Secondary on hover */
  color: white;
  text-decoration: none;
  transform: translateY(-2px);
  box-shadow: 0 -4px 8px rgba(226, 0, 38, 0.3);
}
```

### Version Selector

```css
/* Version selector container */
.spec-version-switcher {
  margin: 0 auto;
  padding: 0.35rem 1rem;
  max-width: 64rem;                 /* Aligns with content width */
}

/* Inline version selector */
.version-selector-inline {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.version-selector-inline select {
  background: var(--md-primary-bg-color);
  color: var(--md-primary-fg-color);
  border: 1px solid var(--md-primary-fg-color--light);
  border-radius: 4px;
  padding: 0.25rem 0.5rem;
  font-size: 0.875rem;
  min-width: 120px;
  cursor: pointer;
}

.version-selector-inline select:focus {
  outline: none;
  border-color: var(--md-accent-fg-color);
  box-shadow: 0 0 0 2px var(--md-accent-fg-color--transparent);
}

/* Mobile responsiveness */
@media (max-width: 720px) {
  .version-selector-inline {
    width: 100%;
  }
  .version-selector-inline select {
    width: 100%;
    max-width: none;
  }
}
```

### Navigation Components

#### Specification Navigation

```css
/* Specification navigation bar */
.swhid-spec-nav {
  background: #f8f9fa;
  border-bottom: 1px solid rgba(0,0,0,.06);
  padding: 1rem 0;
}

.swhid-spec-nav__inner {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}

.swhid-spec-nav h3 {
  margin: 0 0 0.5rem 0;
  font-size: 1rem;
  font-weight: 600;
  color: var(--swh-primary);
}

.swhid-spec-links {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.swhid-spec-links a {
  padding: 0.25rem 0.75rem;
  background: #fff;
  border: 1px solid #dee2e6;
  border-radius: 0.25rem;
  color: var(--swh-neutral);
  text-decoration: none;
  font-size: 0.875rem;
  transition: all 0.2s ease;
}

.swhid-spec-links a:hover {
  background: var(--swh-primary);
  color: #fff;
  border-color: var(--swh-primary);
}

.swhid-spec-links a.active {
  background: var(--swh-primary);
  color: #fff;
  border-color: var(--swh-primary);
}
```

#### Governance Navigation

```css
/* Governance navigation (same styling as spec nav) */
.swhid-gov-nav {
  background: #f8f9fa;
  border-bottom: 1px solid rgba(0,0,0,.06);
  padding: 1rem 0;
}

.swhid-gov-nav__inner {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}

.swhid-gov-nav h3 {
  margin: 0 0 0.5rem 0;
  font-size: 1rem;
  font-weight: 600;
  color: var(--swh-primary);
}

.swhid-gov-links {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.swhid-gov-links a {
  padding: 0.25rem 0.75rem;
  background: #fff;
  border: 1px solid #dee2e6;
  border-radius: 0.25rem;
  color: var(--swh-neutral);
  text-decoration: none;
  font-size: 0.875rem;
  transition: all 0.2s ease;
}

.swhid-gov-links a:hover {
  background: var(--swh-primary);
  color: #fff;
  border-color: var(--swh-primary);
}

.swhid-gov-links a.active {
  background: var(--swh-primary);
  color: #fff;
  border-color: var(--swh-primary);
}
```

## Responsive Design

### Breakpoints

The site uses Material theme's responsive breakpoints:

```css
/* Mobile first approach */
@media (max-width: 48em) {          /* 768px */
  /* Mobile styles */
}

@media (min-width: 48em) and (max-width: 76.1875em) {  /* 768px - 1219px */
  /* Tablet styles */
}

@media (min-width: 76.25rem) {      /* 1220px+ */
  /* Desktop styles */
}
```

### Mobile Optimizations

```css
/* Mobile header */
@media (max-width: 48em) {
  .md-header__title {
    font-size: 1.25rem;
  }
  
  .md-tabs {
    display: none !important;
  }
}

/* Mobile content */
@media (max-width: 768px) {
  .md-content {
    padding: 0 0.5rem;
  }
  
  .news-grid {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
  
  .news-item {
    padding: 1rem;
  }
}

/* Mobile navigation */
@media (max-width: 48em) {
  .version-selector-inline {
    width: 100%;
  }
  
  .swhid-spec-links,
  .swhid-gov-links {
    flex-direction: column;
  }
}
```

## Customization Guide

### Changing Colors

#### Primary Color Scheme

```css
/* Update the main color variables */
:root {
  --swh-primary: #your-primary-color;      /* Main brand color */
  --swh-secondary: #your-secondary-color; /* Hover/secondary color */
  --swh-neutral: #your-neutral-color;     /* Neutral color */
}

/* Update Material theme integration */
.md-typeset a { 
  color: var(--swh-primary);
}

.md-header { 
  background: var(--swh-primary);
}

.md-tabs { 
  background: var(--swh-neutral);
}
```

#### Component-Specific Colors

```css
/* Customize specific components */
.swhid-banner {
  background-color: #your-banner-bg;
  border-color: #your-banner-border;
}

.news-item {
  background-color: #your-news-bg;
  border-color: #your-news-border;
}

.news-item h3 {
  color: #your-news-heading-color;
}
```

### Changing Typography

#### Font Family

```css
/* Update font family */
:root {
  --md-text-font: 'Your Font', 'Helvetica Neue', Helvetica, Arial, sans-serif;
  --md-code-font: 'Your Code Font', 'Monaco', 'Consolas', monospace;
}
```

#### Font Sizes

```css
/* Adjust heading sizes */
.md-content h1 {
  font-size: 3rem;                   /* Larger h1 */
}

.md-content h2 {
  font-size: 2.25rem;                /* Larger h2 */
}

/* Adjust body text */
.md-content p {
  font-size: 1.125rem;               /* Larger body text */
  line-height: 1.7;                  /* More line spacing */
}
```

### Layout Customization

#### Content Width

```css
/* Adjust content width */
.md-content {
  max-width: 80rem;                  /* Wider content */
  margin: 0 auto;
  padding: 0 2rem;                   /* More padding */
}
```

#### Component Spacing

```css
/* Adjust component spacing */
.swhid-banner {
  margin: 3rem 0;                    /* More vertical spacing */
  padding: 3rem;                     /* More internal padding */
}

.news-item {
  margin-bottom: 2rem;               /* More spacing between news items */
}
```

### Animation and Transitions

#### Hover Effects

```css
/* Customize hover effects */
.news-item {
  transition: all 0.5s ease;         /* Slower transition */
}

.news-item:hover {
  transform: translateY(-5px);       /* More dramatic lift */
  box-shadow: 0 10px 25px rgba(226, 0, 38, 0.2);
}

/* Button hover effects */
.btn {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.btn:hover {
  transform: scale(1.05);            /* Scale effect */
}
```

#### Loading Animations

```css
/* Add loading animations */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

.news-item {
  animation: fadeIn 0.6s ease-out;
}

/* Staggered animation */
.news-item:nth-child(1) { animation-delay: 0.1s; }
.news-item:nth-child(2) { animation-delay: 0.2s; }
.news-item:nth-child(3) { animation-delay: 0.3s; }
.news-item:nth-child(4) { animation-delay: 0.4s; }
```

## Dark Mode Support

### Dark Mode Colors

```css
/* Dark mode color overrides */
@media (prefers-color-scheme: dark) {
  :root {
    --swh-primary: #ff4444;              /* Brighter red for dark mode */
    --swh-secondary: #ff6b35;           /* Brighter orange for dark mode */
    --swh-grey: #a0a0a0;             /* Lighter grey for dark mode */
  }
  
  .swhid-banner {
    background-color: #2a1a1a;       /* Dark red background */
    border-color: #ff4444;           /* Bright red border */
  }
  
  .news-item {
    background-color: #2a1a1a;       /* Dark red background */
    border-color: #ff4444;           /* Bright red border */
  }
  
  .md-content {
    color: #e0e0e0;                  /* Light text */
  }
}
```

## Performance Optimization

### CSS Optimization

```css
/* Use efficient selectors */
.md-content h1 {                     /* Good: specific */
  color: var(--swh-primary);
}

/* Avoid overly specific selectors */
div.container .content .main h1 {    /* Bad: too specific */
  color: var(--swh-primary);
}

/* Use CSS custom properties for repeated values */
:root {
  --border-radius: 0.5rem;
  --box-shadow: 0 4px 12px rgba(226, 0, 38, 0.1);
  --transition: all 0.3s ease;
}

.news-item {
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  transition: var(--transition);
}
```

### Critical CSS

```css
/* Above-the-fold critical styles */
.md-header {
  background: var(--swh-primary);
  position: sticky;
  top: 0;
  z-index: 100;
}

.md-content h1 {
  color: var(--swh-primary);
  font-size: 2.5rem;
  font-weight: 700;
}
```

## Testing and Debugging

### Browser Testing

```bash
# Test in different browsers
# - Chrome (latest)
# - Firefox (latest)
# - Safari (latest)
# - Edge (latest)
```

### Responsive Testing

```bash
# Test different screen sizes
# - Mobile: 320px - 768px
# - Tablet: 768px - 1024px
# - Desktop: 1024px+
```

### Performance Testing

```bash
# Check CSS size
ls -la overrides/assets/stylesheets/

# Test loading performance
# - First Contentful Paint
# - Largest Contentful Paint
# - Cumulative Layout Shift
```

## Best Practices

### CSS Organization

1. **Use CSS Custom Properties**: Define colors and values as variables
2. **Mobile First**: Design for mobile first, then enhance for desktop
3. **Semantic Class Names**: Use descriptive, semantic class names
4. **Consistent Spacing**: Use consistent spacing units (rem, em)
5. **Performance**: Minimize CSS size and complexity

### Maintenance

1. **Document Changes**: Document all customizations
2. **Version Control**: Use version control for all changes
3. **Testing**: Test across different browsers and devices
4. **Updates**: Update customizations when theme updates
5. **Performance**: Monitor site performance regularly

### Accessibility

1. **Color Contrast**: Ensure sufficient color contrast
2. **Focus States**: Provide clear focus indicators
3. **Keyboard Navigation**: Ensure keyboard accessibility
4. **Screen Readers**: Test with screen readers
5. **Semantic HTML**: Use semantic HTML elements

## Troubleshooting

### Common Issues

#### Styles Not Applying

- Check CSS specificity
- Verify CSS files are loaded
- Check for syntax errors
- Clear browser cache

#### Responsive Issues

- Test on different screen sizes
- Check media query breakpoints
- Verify viewport meta tag
- Test touch interactions

#### Performance Issues

- Minimize CSS size
- Use efficient selectors
- Optimize images
- Enable compression

### Debug Tools

1. **Browser DevTools**: Inspect elements and styles
2. **CSS Validator**: Check for syntax errors
3. **Performance Tools**: Monitor loading performance
4. **Accessibility Tools**: Test accessibility compliance

For more specific customization options, see the [Search Customization Guide](search-customization.md) for search-related styling.
