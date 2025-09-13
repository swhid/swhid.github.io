# SWHID.org Quick Reference Guide

## Essential Commands

### Local Development
```bash
# Clean and rebuild (ALWAYS do this first)
bundle exec jekyll clean

# Build the site
bundle exec jekyll build

# Serve locally
bundle exec jekyll serve --port 4001

# Clean, build, and serve in one command
bundle exec jekyll clean && bundle exec jekyll build && bundle exec jekyll serve --port 4001
```

### Deployment
```bash
# Add all changes
git add .

# Commit with message
git commit -m "Your commit message"

# Push to trigger deployment
git push origin master
```

## File Locations

### Content Files
- **Homepage**: `index.md`
- **News**: `news/index.md` (list) + `_posts/*.md` (individual posts)
- **Publications**: `publications.md`
- **FAQ**: `faq.md`
- **Core Team**: `coreteam.md`
- **Governance**: `governance.md`
- **Specification**: `specification.md`

### Configuration Files
- **Main config**: `_config.yml`
- **Navigation**: `_data/navigation.yml`
- **Custom styles**: `_sass/custom/custom.scss`
- **Custom footer**: `_includes/components/footer.html`
- **Custom header**: `_includes/components/header.html`
- **Design system**: `assets/design/tokens.css`, `assets/design/swhid-brand.css`
- **Content aggregation**: `_plugins/aggregator.rb`
- **Build config**: `sources.lock.yml`
- **Deployment**: `.github/workflows/pages.yml`

## Common Tasks

### Add News Post
1. Create file: `_posts/YYYY-MM-DD-title.md`
2. Add front matter:
   ```yaml
   ---
   layout: post
   title: "Your Title"
   date: 2025-01-15
   ---
   ```
3. Add content
4. Clean, build, test, commit, push

### Change Colors

#### Global (affects all SWHID sites)
1. Edit `assets/design/tokens.css`
2. Modify CSS variables:
   ```scss
   :root {
     --swh-red: #e20026;
     --swh-orange: #ef4426;
     // ... other colors
   }
   ```
3. Clean, build, test

#### Site-specific override
1. Edit `_sass/custom/custom.scss`
2. Override CSS variables
3. Clean, build, test

### Update Navigation
1. Edit `_config.yml` for main nav
2. Edit `_data/navigation.yml` for sidebar
3. Clean, build, test

### Add New Page
1. Create `pagename.md` in root
2. Add front matter:
   ```yaml
   ---
   layout: default
   title: "Page Title"
   ---
   ```
3. Add to navigation in `_config.yml`
4. Clean, build, test

### Configure Content Aggregation
1. Edit `_config.yml`
2. Update aggregation section:
   ```yaml
   aggregation:
     enabled: true
     sources:
       - name: specification
         repo: swhid/specification
         ref: integration/unified-ux
         target_dir: specification
   ```
3. Clean, build, test

### Disable Content Aggregation
1. Edit `_config.yml`
2. Set `enabled: false` in aggregation section
3. Clean, build, test

### Fix Styling Issues
1. **Always run**: `bundle exec jekyll clean`
2. Check `_sass/custom/custom.scss` for errors
3. Verify file paths and syntax
4. Test with `bundle exec jekyll serve`

### Fix Navigation Issues
1. Check `_data/navigation.yml` format
2. Verify page front matter
3. Ensure no conflicting HTML files
4. Clean and rebuild

## Troubleshooting

### Site Not Updating
```bash
bundle exec jekyll clean
bundle exec jekyll build
bundle exec jekyll serve
```

### Port Already in Use
```bash
pkill -f jekyll
# OR
bundle exec jekyll serve --port 4002
```

### Build Errors
```bash
bundle exec jekyll build --trace
```

### Search Not Working
1. Check `search_enabled: true` in `_config.yml`
2. Run `bundle exec jekyll clean`
3. Rebuild and test

### Design System Not Loading
1. Check `assets/design/tokens.css` and `assets/design/swhid-brand.css` exist
2. Verify CSS import paths in `_sass/custom/custom.scss`
3. Run `bundle exec jekyll clean`
4. Rebuild and test

### Content Aggregation Issues
1. Check aggregation config in `_config.yml`
2. Verify repository access and branch names
3. Ensure `enabled: true` in aggregation settings
4. Run `bundle exec jekyll clean`
5. Rebuild and test

## Design System Files

### Design Tokens (`assets/design/tokens.css`)
- CSS custom properties for colors, typography, spacing
- Shared across all SWHID sites
- Primary source for design consistency

### SWH Branding (`assets/design/swhid-brand.css`)
- SWH-specific branding styles
- Components and utilities
- Consistent with design tokens

### Site-Specific Overrides (`_sass/custom/custom.scss`)
- Site-specific styling
- Can override design system variables
- Imports design system files

## Color Reference

| Variable | Color | Hex | Usage |
|----------|-------|-----|-------|
| `--swh-red` | SWH Red | #e20026 | Primary color, links, buttons |
| `--swh-orange` | SWH Orange | #ef4426 | Hover states, accents |
| `--swh-light-orange` | Light Orange | #f79622 | Secondary accents |
| `--swh-yellow` | SWH Yellow | #fabf1f | Highlights |
| `--swh-grey` | SWH Grey | #737373 | Text, borders |

## CSS Classes

### Buttons
- `.btn` - Primary button (red background)
- `.btn-outline` - Outline button (red border)
- `.swhid-banner .btn` - White button for red banners

### News
- `.news-entry` - News item container
- `.news-title` - News item title
- `.news-date` - News item date
- `.news-excerpt` - News item excerpt
- `.news-read-more` - Read more button

### Layout
- `.swhid-banner` - Red banner for ISO standard
- `.site-footer` - Custom footer
- `.post` - Individual news post layout

## Front Matter Examples

### Standard Page
```yaml
---
layout: default
title: "Page Title"
nav_exclude: false
---
```

### News Post
```yaml
---
layout: post
title: "News Title"
date: 2025-01-15
---
```

### Hidden Page
```yaml
---
layout: default
title: "Hidden Page"
nav_exclude: true
---
```

## Content Aggregation

### Configuration (`_config.yml`)
```yaml
aggregation:
  enabled: true
  sources:
    - name: specification
      repo: swhid/specification
      ref: integration/unified-ux
      target_dir: specification
    - name: governance
      repo: swhid/governance
      ref: integration/unified-ux
      target_dir: governance
```

### Adding New Sources
1. Add to `sources` array in `_config.yml`
2. Ensure repository is accessible
3. Test with clean build

### Disabling Aggregation
Set `enabled: false` in aggregation config

## GitHub Actions

The site automatically deploys when you push to `master`:
1. Builds with Jekyll
2. Validates HTML
3. Deploys to GitHub Pages
4. Updates www.swhid.org

Check deployment status in: Repository → Actions tab

## Emergency Rollback

If something goes wrong:
1. Check recent commits: `git log --oneline -10`
2. Rollback to previous commit: `git reset --hard HEAD~1`
3. Force push: `git push origin master --force`
4. Wait for deployment to complete

---

*Keep this guide handy for quick reference!*
