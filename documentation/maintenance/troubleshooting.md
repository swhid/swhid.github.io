# Troubleshooting Guide

## Overview

This guide provides solutions to common issues encountered when working with the SWHID.org website. It covers build problems, deployment issues, content problems, and navigation issues.

## Build Issues

### Build Fails

#### Symptoms
- `mkdocs build` command fails
- Error messages in terminal
- Site not generated

#### Common Causes

1. **Missing Dependencies**
   ```bash
   # Solution: Install dependencies
   pip install -r requirements.txt
   ```

2. **Configuration Errors**
   ```bash
   # Solution: Check configuration
   mkdocs config
   ```

3. **Submodule Issues**
   ```bash
   # Solution: Initialize submodules
   git submodule update --init --recursive
   ```

4. **File Permissions**
   ```bash
   # Solution: Check permissions
   ls -la
   chmod +x scripts/*.sh
   ```

#### Debug Steps

1. **Enable Debug Mode**
   ```bash
   export MKDOCS_DEBUG=1
   mkdocs build
   ```

2. **Check Logs**
   ```bash
   mkdocs build 2>&1 | tee build.log
   ```

3. **Validate Configuration**
   ```bash
   mkdocs config --quiet
   ```

4. **Check Dependencies**
   ```bash
   pip list
   pip check
   ```

### Build Warnings

#### Symptoms
- Build completes but shows warnings
- Yellow warning messages
- Non-critical issues

#### Common Warnings

1. **Missing Files**
   ```
   WARNING - Document not found: 'missing-file.md'
   ```
   **Solution**: Create missing file or remove reference

2. **Broken Links**
   ```
   WARNING - Link 'broken-link' in 'file.md' is not found
   ```
   **Solution**: Fix or remove broken links

3. **Configuration Warnings**
   ```
   WARNING - Config value 'invalid_option' not recognized
   ```
   **Solution**: Remove or fix invalid configuration

### Build Performance Issues

#### Symptoms
- Slow build times
- High memory usage
- Timeout errors

#### Solutions

1. **Optimize Configuration**
   ```yaml
   # mkdocs.yml
   plugins:
     - search:
         lang: en
   ```

2. **Use Incremental Builds**
   ```bash
   # Use file watching for development
   mkdocs serve
   ```

3. **Check Resource Usage**
   ```bash
   # Monitor memory usage
   top -p $(pgrep mkdocs)
   ```

## Deployment Issues

### Deployment Fails

#### Symptoms
- GitHub Actions workflow fails
- Site not updated
- Error messages in Actions logs

#### Common Causes

1. **Build Failures**
   - Check build step in Actions
   - Verify all dependencies are installed
   - Check for configuration errors

2. **Permission Issues**
   - Verify repository permissions
   - Check GitHub Pages settings
   - Ensure Actions has required permissions

3. **Submodule Issues**
   - Check submodule initialization
   - Verify submodule URLs
   - Ensure submodules are accessible

#### Debug Steps

1. **Check Actions Logs**
   - Go to Actions tab in GitHub
   - Click on failed workflow
   - Review error messages

2. **Test Locally**
   ```bash
   # Test build locally
   make build
   ```

3. **Check Configuration**
   ```bash
   # Validate configuration
   mkdocs config
   ```

### Site Not Updating

#### Symptoms
- Changes not reflected on live site
- Old content still showing
- Cache issues

#### Solutions

1. **Check Deployment Status**
   - Verify Actions workflow completed
   - Check GitHub Pages settings
   - Wait for CDN propagation

2. **Clear Cache**
   - Hard refresh browser (Ctrl+F5)
   - Clear browser cache
   - Check CDN cache

3. **Verify Changes**
   - Check if changes were committed
   - Verify push to main branch
   - Check file permissions

## Content Issues

### Content Not Appearing

#### Symptoms
- New content not visible
- Missing pages
- Navigation issues

#### Common Causes

1. **File Not Added to Navigation**
   ```yaml
   # Solution: Add to mkdocs.yml
   nav:
     - New Page: new-page.md
   ```

2. **File in Wrong Location**
   ```bash
   # Solution: Move to correct directory
   mv docs/wrong-location.md docs/correct-location.md
   ```

3. **File Not Committed**
   ```bash
   # Solution: Add and commit file
   git add docs/new-page.md
   git commit -m "Add new page"
   git push
   ```

### Content Formatting Issues

#### Symptoms
- Markdown not rendering correctly
- Images not displaying
- Links not working

#### Solutions

1. **Check Markdown Syntax**
   ```markdown
   # Correct header syntax
   ## Subheader
   
   [Link text](url)
   ![Alt text](image-url)
   ```

2. **Verify File Paths**
   ```bash
   # Check if files exist
   ls -la docs/images/
   ```

3. **Check Front Matter**
   ```yaml
   ---
   title: Page Title
   date: 2024-01-01
   ---
   ```

### Link Issues

#### Symptoms
- Broken links
- 404 errors
- Redirect issues

#### Solutions

1. **Check Link URLs**
   ```bash
   # Use link checker
   ./scripts/check-links.sh
   ```

2. **Fix Broken Links**
   ```markdown
   # Update broken links
   [Working Link](https://example.com)
   ```

3. **Check Redirects**
   ```yaml
   # Verify redirect configuration
   plugins:
     - redirects:
         redirect_maps:
           "old-url/": "new-url/"
   ```

## Navigation Issues

### Navigation Not Appearing

#### Symptoms
- Navigation menu missing
- Links not working
- Structure incorrect

#### Common Causes

1. **Configuration Errors**
   ```yaml
   # Check navigation configuration
   nav:
     - Home: index.md
     - About: about.md
   ```

2. **Missing Files**
   ```bash
   # Check if referenced files exist
   ls -la docs/
   ```

3. **Theme Issues**
   ```bash
   # Check theme configuration
   mkdocs config | grep theme
   ```

### Version Links Visible

#### Symptoms
- Individual version links showing in navigation
- Version selector not working
- CSS/JavaScript not applied

#### Solutions

1. **Check CSS**
   ```css
   /* Verify CSS is loaded */
   .md-tabs__item.swhid-hidden-tab {
     display: none !important;
   }
   ```

2. **Check JavaScript**
   ```bash
   # Verify JavaScript file exists
   ls -la overrides/assets/javascripts/
   ```

3. **Check Configuration**
   ```yaml
   # Verify JavaScript is registered
   extra_javascript:
     - assets/javascripts/hide-version-tabs.js
   ```

### Navigation Performance Issues

#### Symptoms
- Slow navigation loading
- JavaScript errors
- Unresponsive interface

#### Solutions

1. **Check JavaScript Errors**
   ```bash
   # Open browser console
   # Check for JavaScript errors
   ```

2. **Optimize JavaScript**
   ```javascript
   // Check for performance issues
   console.time('navigation');
   // ... navigation code ...
   console.timeEnd('navigation');
   ```

3. **Check File Sizes**
   ```bash
   # Check JavaScript file size
   ls -la overrides/assets/javascripts/
   ```

## Submodule Issues

### Submodule Not Updating

#### Symptoms
- Submodule content not updated
- Old content still showing
- Build errors

#### Solutions

1. **Update Submodule**
   ```bash
   git submodule update --remote
   ```

2. **Check Submodule Status**
   ```bash
   git submodule status
   ```

3. **Reset Submodule**
   ```bash
   git submodule deinit -f .
   git submodule update --init --recursive
   ```

### Submodule Build Errors

#### Symptoms
- Submodule content not building
- Missing files
- Configuration errors

#### Solutions

1. **Check Submodule Configuration**
   ```bash
   # Check submodule configuration
   cat .gitmodules
   ```

2. **Verify Submodule URLs**
   ```bash
   # Check if submodule URLs are accessible
   git submodule foreach git remote -v
   ```

3. **Check Submodule Content**
   ```bash
   # Check submodule content
   ls -la sources/specification/
   ```

## Performance Issues

### Slow Loading

#### Symptoms
- Pages load slowly
- High resource usage
- Timeout errors

#### Solutions

1. **Optimize Images**
   ```bash
   # Compress images
   find docs/images/ -name "*.jpg" -exec jpegoptim --max=80 {} \;
   ```

2. **Minify CSS/JavaScript**
   ```bash
   # Use minification tools
   npm install -g clean-css-cli
   cleancss -o style.min.css style.css
   ```

3. **Check File Sizes**
   ```bash
   # Check large files
   find site/ -type f -size +1M
   ```

### Memory Issues

#### Symptoms
- High memory usage
- Build failures
- System slowdown

#### Solutions

1. **Check Memory Usage**
   ```bash
   # Monitor memory usage
   top -p $(pgrep mkdocs)
   ```

2. **Optimize Build Process**
   ```bash
   # Use incremental builds
   mkdocs serve
   ```

3. **Check for Memory Leaks**
   ```bash
   # Use memory profiling tools
   python -m memory_profiler mkdocs build
   ```

## Security Issues

### Content Security Policy

#### Symptoms
- JavaScript not loading
- CSS not applying
- Security warnings

#### Solutions

1. **Check CSP Headers**
   ```html
   <!-- Add CSP meta tag -->
   <meta http-equiv="Content-Security-Policy" content="default-src 'self'">
   ```

2. **Update CSP Configuration**
   ```yaml
   # Add to mkdocs.yml
   extra:
     csp:
       default-src: "'self'"
       script-src: "'self' 'unsafe-inline'"
   ```

### Dependency Vulnerabilities

#### Symptoms
- Security warnings
- Vulnerability alerts
- Outdated packages

#### Solutions

1. **Update Dependencies**
   ```bash
   pip install --upgrade -r requirements.txt
   ```

2. **Check for Vulnerabilities**
   ```bash
   pip-audit
   ```

3. **Use Security Scanning**
   ```bash
   # Use GitHub security features
   # Check Dependabot alerts
   ```

## Getting Help

### Self-Help Resources

1. **Documentation**
   - Check this troubleshooting guide
   - Review other documentation files
   - Check MkDocs documentation

2. **Logs and Debugging**
   - Enable debug mode
   - Check error logs
   - Use browser developer tools

3. **Community Resources**
   - GitHub Issues
   - GitHub Discussions
   - MkDocs community

### Reporting Issues

1. **Create GitHub Issue**
   - Provide detailed description
   - Include error messages
   - Attach relevant files

2. **Include Debug Information**
   - System information
   - Version numbers
   - Error logs

3. **Test Cases**
   - Provide steps to reproduce
   - Include expected vs actual behavior
   - Provide minimal test case

### Emergency Procedures

1. **Critical Issues**
   - Rollback to previous version
   - Disable problematic features
   - Notify team members

2. **Site Down**
   - Check GitHub Pages status
   - Verify repository access
   - Check Actions workflow

3. **Data Loss**
   - Check Git history
   - Restore from backups
   - Contact GitHub support

## Prevention

### Best Practices

1. **Regular Maintenance**
   - Update dependencies regularly
   - Check links periodically
   - Monitor performance

2. **Testing**
   - Test changes locally
   - Use staging environment
   - Validate before deployment

3. **Documentation**
   - Keep documentation current
   - Document changes
   - Maintain troubleshooting guides

### Monitoring

1. **Automated Checks**
   - Set up link checking
   - Monitor build status
   - Check deployment health

2. **Regular Reviews**
   - Review error logs
   - Check performance metrics
   - Update documentation

3. **Team Communication**
   - Share knowledge
   - Document solutions
   - Train team members



