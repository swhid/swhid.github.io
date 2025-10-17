# Styling Quick Reference

## Quick Color Changes

### Primary Brand Colors
```css
:root {
  --swh-red: #e20026;
  --swh-orange: #ef4426;
  --swh-grey: #737373;
  --swh-primary: var(--swh-orange); /* Main brand color */
  --swh-secondary: var(--swh-light-orange); /* Hover/secondary color */
  --swh-neutral: var(--swh-grey); /* Neutral color */
}
```

### Change Header Color
```css
.md-header {
  background: var(--swh-primary);   /* Or any color */
}
```

### Change Link Colors
```css
.md-typeset a {
  color: var(--swh-primary);        /* Link color */
}

.md-typeset a:hover {
  color: var(--swh-secondary);     /* Hover color */
}
```

## Quick Layout Changes

### Content Width
```css
.md-content {
  max-width: 80rem;             /* Wider content */
  /* or */
  max-width: 60rem;             /* Narrower content */
}
```

### Component Spacing
```css
.swhid-banner {
  margin: 3rem 0;               /* More vertical spacing */
  padding: 3rem;                /* More internal padding */
}
```

### News Item Layout
```css
.news-grid {
  grid-template-columns: repeat(3, 1fr);  /* 3 columns */
  /* or */
  grid-template-columns: repeat(2, 1fr);  /* 2 columns */
  /* or */
  grid-template-columns: 1fr;             /* 1 column */
}
```

## Quick Typography Changes

### Font Sizes
```css
.md-content h1 {
  font-size: 3rem;              /* Larger h1 */
}

.md-content p {
  font-size: 1.125rem;          /* Larger body text */
}
```

### Font Family
```css
:root {
  --md-text-font: 'Your Font', sans-serif;
}
```

## Quick Component Styling

### News Items
```css
.news-item {
  background-color: #your-color;     /* Background */
  border-color: #your-color;         /* Border */
}

.news-item h3 {
  color: #your-color;                /* Heading color */
}
```

### Buttons
```css
.btn {
  background-color: #your-color;     /* Button background */
  color: white;                      /* Button text */
  border-radius: 8px;                /* Rounded corners */
  padding: 1rem 2rem;                /* Button size */
}
```

### Version Selector
```css
.version-selector-inline select {
  background: #your-bg-color;        /* Background */
  color: #your-text-color;           /* Text color */
  border-color: #your-border-color;  /* Border color */
}
```

## Quick Responsive Changes

### Mobile Breakpoints
```css
@media (max-width: 48em) {           /* Mobile */
  .md-content h1 {
    font-size: 2rem;                 /* Smaller on mobile */
  }
}

@media (min-width: 76.25rem) {       /* Desktop */
  .md-content {
    padding: 0 2rem;                 /* More padding on desktop */
  }
}
```

### Hide Elements on Mobile
```css
@media (max-width: 48em) {
  .your-element {
    display: none;                   /* Hide on mobile */
  }
}
```

## Quick Animation Changes

### Hover Effects
```css
.news-item {
  transition: all 0.3s ease;         /* Transition duration */
}

.news-item:hover {
  transform: translateY(-5px);       /* Hover lift effect */
  box-shadow: 0 10px 25px rgba(0,0,0,0.2);
}
```

### Button Animations
```css
.btn {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.btn:hover {
  transform: scale(1.05);            /* Scale on hover */
}
```

## Quick Dark Mode

### Dark Mode Colors
```css
@media (prefers-color-scheme: dark) {
  :root {
    --swh-primary: #ff4444;              /* Brighter for dark mode */
  }
  
  .swhid-banner {
    background-color: #2a1a1a;       /* Dark background */
  }
}
```

## File Locations

### Main Styles
- **`overrides/assets/stylesheets/extra.css`** - Main site styles
- **`docs/assets/stylesheets/pagefind-header.css`** - Search box styles

### Templates
- **`overrides/main.html`** - Main template
- **`overrides/partials/version-selector.html`** - Version selector

### Configuration
- **`templates/mkdocs.yml.template`** - MkDocs configuration
- **`mkdocs.yml`** - Generated configuration

## Common Tasks

### Add New Component
1. Add CSS to `overrides/assets/stylesheets/extra.css`
2. Use consistent naming: `.swhid-component-name`
3. Follow color scheme: use CSS variables
4. Add responsive breakpoints
5. Test across devices

### Change Color Scheme
1. Update CSS variables in `:root`
2. Update Material theme integration
3. Test contrast ratios
4. Update dark mode if needed

### Add Animation
1. Define transition properties
2. Add hover/focus states
3. Use consistent timing functions
4. Test performance

### Make Responsive
1. Start with mobile styles
2. Add tablet breakpoint (768px)
3. Add desktop breakpoint (1220px)
4. Test on real devices

## Testing Checklist

- [ ] Test in Chrome, Firefox, Safari, Edge
- [ ] Test on mobile (320px-768px)
- [ ] Test on tablet (768px-1024px)
- [ ] Test on desktop (1024px+)
- [ ] Check color contrast
- [ ] Test keyboard navigation
- [ ] Verify animations work
- [ ] Check dark mode support
- [ ] Test with slow connections
- [ ] Validate CSS syntax

For detailed information, see the [Complete Site Styling Guide](site-styling-guide.md).
