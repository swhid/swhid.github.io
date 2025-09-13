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
- **Content aggregation**: `scripts/bootstrap.sh`
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
1. Edit `sources.lock.yml`
2. Update repository references:
   ```yaml
   spec:
     repo: swhid/specification
     ref: main
   gov:
     repo: swhid/governance
     ref: main
   design:
     repo: swhid/swhid-design
     ref: main
   ```
3. Run `./scripts/bootstrap.sh` to rebuild external content
4. Clean, build, test

### Rebuild External Content
1. Run `./scripts/bootstrap.sh`
2. This will:
   - Clone/update external repositories
   - Install MkDocs dependencies
   - Copy design system assets
   - Build MkDocs sites
   - Integrate content into Jekyll

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
1. Check `search_enabled: false` in `_config.yml` (JTD search disabled for Pagefind)
2. Ensure Pagefind files exist in `_site/pagefind/`
3. Run `npx pagefind --site _site` to regenerate search index
4. Run `bundle exec jekyll clean` and rebuild

### Design System Not Loading
1. Check `assets/design/tokens.css` and `assets/design/swhid-brand.css` exist
2. Verify CSS import paths in `_sass/custom/custom.scss`
3. Run `bundle exec jekyll clean`
4. Rebuild and test

### Content Aggregation Issues
1. Check `sources.lock.yml` configuration
2. Verify repository access and branch names
3. Run `./scripts/bootstrap.sh` to rebuild external content
4. Ensure MkDocs is installed: `pip install mkdocs mkdocs-material`
5. Run `bundle exec jekyll clean` and rebuild

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

### Configuration (`sources.lock.yml`)
```yaml
spec:
  repo: swhid/specification
  ref: main
gov:
  repo: swhid/governance
  ref: main
design:
  repo: swhid/swhid-design
  ref: main
```

### Adding New Sources
1. Add to `sources.lock.yml`
2. Update `scripts/bootstrap.sh` to handle new source
3. Ensure repository is accessible
4. Test with `./scripts/bootstrap.sh`

### Rebuilding External Content
Run `./scripts/bootstrap.sh` to rebuild all external content

## Search Implementation

### Pagefind Search
The site uses Pagefind for unified search across Jekyll and MkDocs content:

#### Search Configuration
- **Search input**: Located in top navigation bar (`_includes/components/header.html`)
- **Search styling**: Defined in `_sass/custom/custom.scss`
- **Search initialization**: `_includes/head_custom.html`

#### Search Index Generation
1. Jekyll builds site to `_site/`
2. Run `npx pagefind --site _site` to generate search index
3. Pagefind files served from `/pagefind/` (root level)

#### Search Troubleshooting
- Ensure `search_enabled: false` in `_config.yml` (JTD search disabled)
- Check Pagefind files exist in `_site/pagefind/`
- Regenerate index: `npx pagefind --site _site`
- Clean and rebuild: `bundle exec jekyll clean && bundle exec jekyll build`

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
