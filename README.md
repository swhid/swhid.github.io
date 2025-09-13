# SWHID.org Website Documentation

This is the repository for the [SWHID website](https://swhid.github.io/).

[![Deploy Jekyll site to Pages](https://github.com/swhid/swhid.github.io/actions/workflows/pages.yml/badge.svg)](https://github.com/swhid/swhid.github.io/actions/workflows/pages.yml)
[![pages-build-deployment](https://github.com/swhid/swhid.github.io/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/swhid/swhid.github.io/deployments/github-pages)
[![SWHID site](https://img.shields.io/website?url=https%3A%2F%2Fswhid.github.io%2F&label=SWHID%20site&up_message=online&down_message=offline&color=brightgreen)](https://swhid.github.io/)
[![Gem Version](https://img.shields.io/gem/v/just-the-docs.svg)](https://rubygems.org/gems/just-the-docs)

This documentation describes how the SWHID.org website is built using the Just the Docs Jekyll theme, how to customize it, and how to manage content and deployment.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Local Development](#local-development)
- [Customization Guide](#customization-guide)
- [Content Management](#content-management)
- [Deployment](#deployment)
- [Troubleshooting](#troubleshooting)

## Overview

The SWHID.org website is built using:
- **Jekyll 4.4.1** - Static site generator
- **Just the Docs 0.10.1** - Jekyll theme for documentation
- **GitHub Pages** - Hosting platform
- **GitHub Actions** - Automated deployment

The site features:
- Responsive design with unified SWH branding
- **Pagefind search functionality** - unified search across Jekyll and MkDocs content
- News and publications management
- Custom footer with SWH links
- SEO optimization
- Custom domain (www.swhid.org)
- **Unified UX system** with shared design tokens
- **Content aggregation** from external repositories via bootstrap script
- **Consistent branding** across all SWHID sites

## Architecture

### Directory Structure

```
swhid.github.io/
├── _config.yml                 # Main Jekyll configuration
├── _data/
│   └── navigation.yml          # Navigation structure
├── _includes/
│   ├── components/
│   │   ├── footer.html         # Custom footer component
│   │   └── header.html         # Unified header component
│   └── nav_footer_custom.html  # Empty sidebar footer override
├── _layouts/
│   └── post.html              # Custom layout for news posts
├── _posts/                    # News posts (Jekyll collections)
├── _sass/
│   └── custom/
│       └── custom.scss        # Custom SCSS overrides
├── assets/
│   └── design/                # Shared design system
│       ├── tokens.css         # CSS design tokens
│       └── swhid-brand.css    # SWH branding styles
├── .github/
│   └── workflows/
│       └── pages.yml          # GitHub Actions deployment
├── CNAME                      # Custom domain configuration
├── sources.lock.yml           # Deterministic build configuration
└── *.md                       # Content pages
```

### Key Files

- **`_config.yml`**: Main configuration, navigation, SEO settings
- **`_sass/custom/custom.scss`**: All custom styling and SWH branding
- **`_includes/components/footer.html`**: Custom footer with SWH links
- **`_includes/components/header.html`**: Unified header component
- **`_layouts/post.html`**: Custom layout for individual news posts
- **`assets/design/tokens.css`**: CSS design tokens for consistent styling
- **`assets/design/swhid-brand.css`**: SWH branding styles
- **`sources.lock.yml`**: Deterministic build configuration
- **`.github/workflows/pages.yml`**: Automated deployment workflow

## Unified UX System

The SWHID website now implements a unified user experience system that provides consistent branding and design across all SWHID-related sites.

### Design System

The unified UX is built on a shared design system located in `assets/design/`:

- **`tokens.css`**: CSS custom properties (variables) for colors, typography, and spacing
- **`swhid-brand.css`**: SWH-specific branding styles and components

### Content Aggregation

The site aggregates content from external repositories using a bootstrap script:

- **Specification**: Content from `swhid/specification` repository
- **Governance**: Content from `swhid/governance` repository
- **Build-time integration**: External content is fetched and integrated during build via `scripts/bootstrap.sh`
- **Consistent styling**: Aggregated content uses the same design system
- **MkDocs integration**: External repos are built with MkDocs and integrated into Jekyll

### Configuration

Content aggregation is configured in `sources.lock.yml`:

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

The bootstrap script (`scripts/bootstrap.sh`) handles:
- Cloning external repositories
- Installing MkDocs and dependencies
- Copying design system assets
- Building MkDocs sites
- Integrating content into Jekyll

### Benefits

- **Consistent branding**: All SWHID sites share the same visual identity
- **Maintainable design**: Changes to design tokens propagate across all sites
- **Unified navigation**: Seamless navigation between different SWHID resources
- **Single deployment**: One site serves all SWHID content with consistent UX

## Local Development

### Prerequisites

- Ruby 3.1+
- Bundler gem
- Git

### Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/swhid/swhid.github.io.git
   cd swhid.github.io
   ```

2. **Install dependencies:**
   ```bash
   bundle install
   ```

3. **Build and serve locally:**
   ```bash
   bundle exec jekyll serve --port 4001
   ```

4. **Access the site:**
   Open http://127.0.0.1:4001 in your browser

### Important: Clean Build

**Always clean before building to avoid conflicts:**

```bash
bundle exec jekyll clean
bundle exec jekyll build
bundle exec jekyll serve --port 4001
```

This prevents issues with stale files in `_site/` that can cause:
- Conflicting HTML files
- Missing assets
- Incorrect navigation
- Styling issues

### Development Workflow

1. Make changes to content or styling
2. **Always run `bundle exec jekyll clean` first**
3. Test with `bundle exec jekyll serve`
4. Verify changes in browser
5. Commit and push changes

## Customization Guide

### 1. Colors and Branding

SWH branding colors are defined in the design system for consistency across all sites:

**Primary location**: `assets/design/tokens.css` (design system)
**Override location**: `_sass/custom/custom.scss` (site-specific)

```scss
:root {
  --swh-red: #e20026;           // Primary SWH red
  --swh-orange: #ef4426;        // SWH orange
  --swh-light-orange: #f79622;  // Light orange
  --swh-yellow: #fabf1f;        // SWH yellow
  --swh-grey: #737373;          // SWH grey
}
```

**To change colors globally (affects all SWHID sites):**
1. Edit `assets/design/tokens.css`
2. Run `bundle exec jekyll clean && bundle exec jekyll serve`
3. Test the changes

**To override colors for this site only:**
1. Edit the CSS variables in `_sass/custom/custom.scss`
2. Run `bundle exec jekyll clean && bundle exec jekyll serve`
3. Test the changes

### 2. Typography and Fonts

Fonts are controlled by the Just the Docs theme. To customize:

1. **Override font families in `_sass/custom/custom.scss`:**
   ```scss
   body {
     font-family: 'Your Custom Font', sans-serif;
   }
   ```

2. **Add custom fonts via `_includes/head_custom.html`:**
   ```html
   <link href="https://fonts.googleapis.com/css2?family=YourFont:wght@400;600;700&display=swap" rel="stylesheet">
   ```

### 3. Layout Modifications

#### Header
- **Site title**: Edit `title` in `_config.yml`
- **Navigation**: Modify `navigation` section in `_config.yml`
- **External links**: Update `nav_external_links` in `_config.yml`

#### Footer
- **Content**: Edit `_includes/components/footer.html`
- **Styling**: Modify `.site-footer` styles in `_sass/custom/custom.scss`

#### Sidebar
- **Navigation**: Update `_data/navigation.yml`
- **Footer**: Edit `_includes/nav_footer_custom.html` (currently empty)

### 4. Page Layouts

#### Standard Pages
Use Markdown files in the root directory with front matter:
```yaml
---
layout: default
title: "Page Title"
nav_exclude: false  # Set to true to hide from sidebar
---
```

#### News Posts
Use the custom `post` layout:
```yaml
---
layout: post
title: "News Title"
date: 2025-01-15
---
```

### 5. Search Implementation

The site uses Pagefind for unified search across Jekyll and MkDocs content:

#### Pagefind Configuration
Search is configured in `_includes/head_custom.html`:

```html
<!-- Unified search via Pagefind -->
<link rel="stylesheet" href="/pagefind/pagefind-ui.css">
<script src="/pagefind/pagefind.js"></script>
<script src="/pagefind/pagefind-ui.js"></script>
<script>
document.addEventListener('DOMContentLoaded', async () => {
  const mount = document.querySelector('.search-form');
  if (!mount) return;

  await new PagefindUI({
    element: mount,
    showSubResults: true,
    bundlePath: "/pagefind/",
    baseUrl: "/"
  });
});
</script>
```

#### Search Styling
Search input and results are styled in `_sass/custom/custom.scss`:
- Search input appears in the top navigation bar
- Results appear as a fixed overlay below the top bar
- Consistent with SWH branding colors

#### Search Index Generation
The search index is generated during build:
1. Jekyll builds the site to `_site/`
2. `npx pagefind --site _site` generates the search index
3. Pagefind files are served from `/pagefind/` (root level)

### 6. Styling Components

#### Buttons
```scss
.btn {
  background-color: var(--swh-red);
  color: white;
  // ... other styles
}

.btn-outline {
  background-color: transparent;
  color: var(--swh-red);
  border-color: var(--swh-red);
}
```

#### News Entries
```scss
.news-entry {
  border: 1px solid var(--swh-grey);
  // ... hover effects and styling
}
```

#### SWH Banner
```scss
.swhid-banner {
  background-color: var(--swh-red);
  color: white;
  // ... styling for the ISO standard banner
}
```

## Content Management

### Adding News Posts

1. **Create a new file in `_posts/`:**
   ```bash
   touch _posts/YYYY-MM-DD-post-title.md
   ```

2. **Add front matter and content:**
   ```yaml
   ---
   layout: post
   title: "Your News Title"
   date: 2025-01-15
   ---
   
   Your news content here...
   ```

3. **The post will automatically appear on the news page**

### Adding Publications

1. **Edit `publications.md`:**
   ```markdown
   # Publications
   
   ## 2025
   - **Title**: Your Publication Title
     **Authors**: Author Names
     **Journal**: Journal Name
     **Link**: [DOI Link](https://doi.org/...)
   ```

### Managing Pages

#### Core Team
- Edit `coreteam.md`
- Add team member information

#### FAQ
- Edit `faq.md`
- Add questions and answers

#### Governance
- Edit `governance.md`
- Update governance information

### Content Aggregation Management

The site aggregates content from external repositories using the bootstrap script:

#### Configuration
Edit `sources.lock.yml` to configure aggregation:

```yaml
spec:
  repo: swhid/specification
  ref: main  # Branch or tag
gov:
  repo: swhid/governance
  ref: main
design:
  repo: swhid/swhid-design
  ref: main
```

#### Adding New Sources
1. Add a new source to `sources.lock.yml`
2. Update `scripts/bootstrap.sh` to handle the new source
3. Ensure the repository is accessible
4. Test with `./scripts/bootstrap.sh && bundle exec jekyll serve`

#### Rebuilding Aggregated Content
Run `./scripts/bootstrap.sh` to rebuild all external content:
- Clones/updates external repositories
- Installs MkDocs dependencies
- Copies design system assets
- Builds MkDocs sites
- Integrates content into Jekyll

#### Troubleshooting Aggregation
- Check repository access and branch names in `sources.lock.yml`
- Verify MkDocs is installed: `pip install mkdocs mkdocs-material`
- Run `./scripts/bootstrap.sh` to rebuild external content
- Run `bundle exec jekyll clean` after configuration changes

### Navigation Updates

1. **Main navigation**: Edit `navigation` in `_config.yml`
2. **Sidebar navigation**: Edit `_data/navigation.yml`
3. **External links**: Update `nav_external_links` in `_config.yml`

### SEO Configuration

Edit `_config.yml` for:
- Site description
- Keywords
- Social media links
- Open Graph settings
- Twitter card settings

## Deployment

### Automatic Deployment

The site uses GitHub Actions for automatic deployment:

1. **Push to master branch:**
   ```bash
   git add .
   git commit -m "Your commit message"
   git push origin master
   ```

2. **GitHub Actions will automatically:**
   - Build the site
   - Run HTML validation
   - Deploy to GitHub Pages
   - Make it available at www.swhid.org

### Manual Deployment

If you need to deploy manually:

1. **Build the site:**
   ```bash
   bundle exec jekyll clean
   bundle exec jekyll build
   ```

2. **Deploy to GitHub Pages:**
   - Go to repository Settings → Pages
   - Select "Deploy from a branch"
   - Choose `master` branch
   - Select `/ (root)` folder

### Deployment Workflow

The `.github/workflows/pages.yml` workflow:

1. **Triggers on:**
   - Push to `master` branch
   - Manual workflow dispatch

2. **Build process:**
   - Checks out code
   - Sets up Ruby 3.1
   - Installs dependencies
   - Builds with Jekyll
   - Validates HTML
   - Uploads artifacts

3. **Deploy process:**
   - Deploys to GitHub Pages
   - Updates www.swhid.org

### Custom Domain

The site uses a custom domain configured via:
- **`CNAME` file**: Contains `www.swhid.org`
- **DNS settings**: Point to GitHub Pages
- **GitHub Pages settings**: Custom domain enabled

## Troubleshooting

### Common Issues

#### 1. Styling Not Applied
**Problem**: Changes to SCSS not visible
**Solution**: 
```bash
bundle exec jekyll clean
bundle exec jekyll serve
```

#### 2. Navigation Issues
**Problem**: Pages not appearing in navigation
**Solution**: Check `_data/navigation.yml` and page front matter

#### 3. Build Failures
**Problem**: Jekyll build errors
**Solution**: 
- Check for syntax errors in Markdown
- Verify front matter format
- Run `bundle exec jekyll clean`

#### 4. External Links Not Opening in New Tab
**Problem**: Links open in same window
**Solution**: 
- Use `nav_external_links` in `_config.yml`
- Set `opens_in_new_tab: true`

#### 5. Search Not Working
**Problem**: Pagefind search returns no results
**Solution**: 
- Ensure `search_enabled: false` in `_config.yml` (JTD search disabled for Pagefind)
- Check that Pagefind files exist in `_site/pagefind/`
- Run `npx pagefind --site _site` to regenerate search index
- Run `bundle exec jekyll clean` and rebuild

#### 6. Design System Not Loading
**Problem**: SWH colors and branding not applied
**Solution**:
- Check that `assets/design/tokens.css` and `assets/design/swhid-brand.css` exist
- Verify CSS import paths in `_sass/custom/custom.scss`
- Run `bundle exec jekyll clean && bundle exec jekyll serve`

#### 7. Content Aggregation Issues
**Problem**: External content not appearing
**Solution**:
- Check `sources.lock.yml` configuration
- Verify repository access and branch names
- Run `./scripts/bootstrap.sh` to rebuild external content
- Ensure MkDocs is installed: `pip install mkdocs mkdocs-material`
- Run `bundle exec jekyll clean` and rebuild

### Debug Commands

```bash
# Clean and rebuild
bundle exec jekyll clean && bundle exec jekyll build

# Serve with verbose output
bundle exec jekyll serve --verbose

# Check for errors
bundle exec jekyll build --trace

# Validate HTML
htmlproofer _site --disable-external
```

### File Conflicts

If you see conflicts like:
```
Conflict: The following destination is shared by multiple files.
          /path/to/file.html
           - file1.md
           - file2.html
```

**Solution**: Delete conflicting HTML files and use Markdown only.

### Port Already in Use

If you get "Address already in use":
```bash
# Kill existing Jekyll processes
pkill -f jekyll

# Or use a different port
bundle exec jekyll serve --port 4002
```

## Best Practices

### Development
1. **Always clean before building**
2. **Test locally before pushing**
3. **Use meaningful commit messages**
4. **Keep SCSS organized and commented**

### Content
1. **Use consistent front matter**
2. **Test all links before publishing**
3. **Optimize images for web**
4. **Use semantic HTML structure**

### Deployment
1. **Test on staging before production**
2. **Monitor GitHub Actions logs**
3. **Keep dependencies updated**
4. **Backup important content**

## Support

For issues with:
- **Jekyll**: [Jekyll Documentation](https://jekyllrb.com/docs/)
- **Just the Docs**: [Theme Documentation](https://just-the-docs.github.io/just-the-docs/)
- **GitHub Pages**: [GitHub Pages Documentation](https://docs.github.com/en/pages)
- **SWHID Website**: Create an issue in the repository

---

*Last updated: January 2025*
