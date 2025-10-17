# Deployment Guide

## Overview

The SWHID.org website is automatically deployed using GitHub Actions whenever changes are pushed to the main branch. This guide explains the deployment process and how to manage it.

## Deployment Process

### Automatic Deployment

The website is automatically deployed when:

1. **Push to Main**: Changes are pushed to the `main` branch
2. **Pull Request Merge**: Pull requests are merged to `main`
3. **Manual Trigger**: GitHub Actions workflow is manually triggered

### Deployment Pipeline

The deployment process follows these steps:

1. **Trigger**: GitHub Actions workflow is triggered
2. **Checkout**: Repository code is checked out
3. **Setup**: Python environment is set up
4. **Dependencies**: Required dependencies are installed
5. **Submodules**: Git submodules are initialized and updated
6. **Build**: MkDocs site is built
7. **Deploy**: Built site is deployed to GitHub Pages

## GitHub Actions Configuration

### Workflow File

The deployment is configured in `.github/workflows/site.yml`:

```yaml
name: Build & Deploy site (preview / staging / production)

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          submodules: recursive
          fetch-depth: 0

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: 3.11

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt

      - name: Setup Pages
        uses: actions/configure-pages@v4

      - name: Build with MkDocs
        run: mkdocs build

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./site

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

### Key Configuration Points

- **Submodules**: `submodules: recursive` ensures all submodules are included
- **Python Version**: Uses Python 3.11 for consistency
- **Dependencies**: Installs from `requirements.txt`
- **Build Command**: Uses `mkdocs build` to build the site
- **Deployment**: Uses GitHub Pages deployment action

## Manual Deployment

### Local Deployment

For testing purposes, you can build the site locally:

```bash
# Build the site
make build

# Serve locally
make serve

# Clean build artifacts
make clean
```

### Staging Deployment

For staging deployments, you can use a different branch:

1. **Create Branch**: Create a staging branch
2. **Push Changes**: Push changes to staging branch
3. **Test**: Test the staging deployment
4. **Merge**: Merge to main when ready

## Deployment Monitoring

### GitHub Actions Dashboard

Monitor deployments in the GitHub Actions dashboard:

1. **Go to Actions**: Navigate to the Actions tab
2. **Select Workflow**: Select the "Build & Deploy site (preview / staging / production)" workflow
3. **View Runs**: View individual workflow runs
4. **Check Logs**: Check logs for any errors

### Deployment Status

Check deployment status:

- **Green Checkmark**: Deployment successful
- **Red X**: Deployment failed
- **Yellow Circle**: Deployment in progress
- **Gray Circle**: Deployment queued

### Common Issues

#### Build Failures

Common build failure causes:

1. **Missing Dependencies**: Required packages not installed
2. **Submodule Issues**: Submodules not properly initialized
3. **Configuration Errors**: MkDocs configuration errors
4. **File Permissions**: File permission issues
5. **Syntax Errors**: Markdown or YAML syntax errors

#### Deployment Failures

Common deployment failure causes:

1. **GitHub Pages Issues**: GitHub Pages service issues
2. **Artifact Issues**: Build artifact not properly created
3. **Permission Issues**: Insufficient permissions
4. **Network Issues**: Network connectivity problems

## Troubleshooting

### Build Issues

#### Missing Dependencies

```bash
# Check requirements.txt
cat requirements.txt

# Install dependencies locally
pip install -r requirements.txt

# Check for missing packages
pip check
```

#### Submodule Issues

```bash
# Initialize submodules
git submodule init
git submodule update --recursive

# Check submodule status
git submodule status
```

#### Configuration Errors

```bash
# Validate MkDocs configuration
mkdocs config

# Check for syntax errors
mkdocs build --strict
```

### Deployment Issues

#### GitHub Pages Issues

1. **Check Settings**: Verify GitHub Pages settings
2. **Check Permissions**: Verify repository permissions
3. **Check Actions**: Verify GitHub Actions is enabled
4. **Check Logs**: Check GitHub Actions logs

#### Artifact Issues

1. **Check Build**: Verify build completed successfully
2. **Check Artifact**: Verify artifact was created
3. **Check Size**: Check artifact size limits
4. **Check Format**: Verify artifact format

## Best Practices

### Pre-Deployment

1. **Test Locally**: Always test changes locally first
2. **Check Links**: Run link checking before deploying
3. **Review Changes**: Review all changes before pushing
4. **Small Changes**: Make small, focused changes
5. **Document Changes**: Document significant changes

### During Deployment

1. **Monitor Progress**: Monitor deployment progress
2. **Check Logs**: Check logs for any issues
3. **Verify Success**: Verify deployment completed successfully
4. **Test Site**: Test the deployed site
5. **Check Functionality**: Verify all functionality works

### Post-Deployment

1. **Verify Deployment**: Verify site is accessible
2. **Test Functionality**: Test all site functionality
3. **Check Performance**: Check site performance
4. **Monitor Errors**: Monitor for any errors
5. **Update Documentation**: Update documentation if needed

## Rollback Procedures

### Emergency Rollback

If a deployment causes issues:

1. **Identify Issue**: Identify the specific issue
2. **Revert Changes**: Revert the problematic changes
3. **Push Revert**: Push the revert commit
4. **Monitor Deployment**: Monitor the rollback deployment
5. **Verify Fix**: Verify the issue is resolved

### Gradual Rollback

For less critical issues:

1. **Identify Problem**: Identify the specific problem
2. **Create Fix**: Create a fix for the problem
3. **Test Fix**: Test the fix locally
4. **Deploy Fix**: Deploy the fix
5. **Monitor**: Monitor the fix

## Security Considerations

### Access Control

- **Repository Access**: Limit repository access to authorized users
- **Branch Protection**: Use branch protection rules
- **Code Review**: Require code review for changes
- **Security Scanning**: Use security scanning tools

### Content Security

- **Input Validation**: Validate all user inputs
- **XSS Protection**: Protect against XSS attacks
- **CSRF Protection**: Protect against CSRF attacks
- **Content Security Policy**: Use CSP headers

### Infrastructure Security

- **HTTPS Only**: Use HTTPS for all communications
- **Secure Headers**: Use security headers
- **Dependency Scanning**: Scan for vulnerable dependencies
- **Regular Updates**: Keep dependencies updated

## Performance Optimization

### Build Optimization

- **Incremental Builds**: Use incremental builds when possible
- **Caching**: Use build caching
- **Parallel Processing**: Use parallel processing
- **Resource Limits**: Set appropriate resource limits

### Deployment Optimization

- **CDN**: Use CDN for static assets
- **Compression**: Use compression for assets
- **Minification**: Minify CSS and JavaScript
- **Image Optimization**: Optimize images

## Monitoring and Alerting

### Monitoring

- **Uptime Monitoring**: Monitor site uptime
- **Performance Monitoring**: Monitor site performance
- **Error Monitoring**: Monitor for errors
- **Usage Analytics**: Monitor usage analytics

### Alerting

- **Deployment Alerts**: Alert on deployment failures
- **Error Alerts**: Alert on critical errors
- **Performance Alerts**: Alert on performance issues
- **Security Alerts**: Alert on security issues
