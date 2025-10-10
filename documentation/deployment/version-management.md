# Version Management

## Overview

The SWHID specification supports multiple versions, each with its own documentation and content. This guide explains how to manage specification versions, including adding new versions, updating existing versions, and maintaining version-specific content.

## Version Structure

### Current Versioning Scheme

The SWHID specification uses semantic versioning (SemVer) with the format `vMAJOR.MINOR.PATCH`:

- **v1.0**: Initial release
- **v1.1**: Minor updates and improvements
- **v1.2**: Latest version with additional features
- **v2.0**: Future major version (planned)

### Version Directories

Each version has its own directory structure:

```
sources/
├── specification/           # Current/latest version
├── specification-v1.0/     # Version 1.0
├── specification-v1.1/     # Version 1.1
├── specification-v1.2/     # Version 1.2
└── specification-v2.0/     # Future version
```

## Adding New Versions

### 1. Create Version Directory

```bash
# Create new version directory
mkdir sources/specification-v2.0

# Copy content from previous version
cp -r sources/specification/* sources/specification-v2.0/

# Initialize as Git repository
cd sources/specification-v2.0
git init
git add .
git commit -m "Initial version 2.0"
```

### 2. Update Version Content

Edit the version-specific content:

- **Version Numbers**: Update all version references
- **Changelog**: Add new changelog entries
- **Documentation**: Update documentation for new features
- **Examples**: Update examples and code samples

### 3. Update Navigation

Add the new version to the main navigation in `mkdocs.yml`:

```yaml
nav:
  - Home: index.md
  - Specification: '!include .monorepo-overlays/spec-v2.0.mkdocs.yml'  # Updated to latest
  - v2.0: '!include .monorepo-overlays/spec-v2.0.mkdocs.yml'         # New version
  - v1.2: '!include .monorepo-overlays/spec-v1.2.mkdocs.yml'         # Previous version
  - v1.1: '!include .monorepo-overlays/spec-v1.1.mkdocs.yml'         # Older version
  - v1.0: '!include .monorepo-overlays/spec-v1.0.mkdocs.yml'         # Oldest version
  - Governance: '!include sources/governance/mkdocs.yml'
  - FAQ: faq.md
  - News: ...
```

### 4. Create Overlay Configuration

Create a new overlay configuration file `.monorepo-overlays/spec-v2.0.mkdocs.yml`:

```yaml
site_name: "SWHID Specification v2.0"
site_url: "/swhid-specification/v2.0/"
docs_dir: "sources/specification-v2.0"
nav:
  - "!include sources/specification-v2.0/mkdocs.yml"
theme:
  name: material
  custom_dir: overrides
  features:
    - navigation.tabs
    - navigation.sections
    - navigation.expand
    - navigation.top
    - search.highlight
    - search.share
    - search.suggest
    - content.code.copy
    - content.code.annotate
    - content.action.edit
    - content.action.view
  palette:
    - scheme: default
      primary: red
      accent: orange
      toggle:
        icon: material/brightness-7
        name: Switch to dark mode
    - scheme: slate
      primary: red
      accent: orange
      toggle:
        icon: material/brightness-4
        name: Switch to light mode
```

### 5. Update Version Selector

Update the version selector to include the new version:

```json
// versions.json
{
  "versions": [
    {
      "version": "v2.0",
      "url": "/swhid-specification/v2.0/",
      "latest": true
    },
    {
      "version": "v1.2",
      "url": "/swhid-specification/v1.2/",
      "latest": false
    },
    {
      "version": "v1.1",
      "url": "/swhid-specification/v1.1/",
      "latest": false
    },
    {
      "version": "v1.0",
      "url": "/swhid-specification/v1.0/",
      "latest": false
    }
  ]
}
```

## Updating Existing Versions

### Minor Updates

For minor updates to existing versions:

1. **Edit Content**: Make changes to the version-specific content
2. **Update Changelog**: Add changelog entries
3. **Test Changes**: Test changes locally
4. **Commit Changes**: Commit and push changes
5. **Deploy**: Changes are automatically deployed

### Major Updates

For major updates that affect multiple versions:

1. **Plan Changes**: Plan changes across versions
2. **Update Content**: Update content for each affected version
3. **Update Navigation**: Update navigation if needed
4. **Test Changes**: Test all affected versions
5. **Deploy**: Deploy all changes

## Version Lifecycle

### Version States

Each version goes through different states:

1. **Development**: Version is being developed
2. **Beta**: Version is in beta testing
3. **Release Candidate**: Version is ready for release
4. **Stable**: Version is stable and recommended
5. **Maintenance**: Version is in maintenance mode
6. **Deprecated**: Version is deprecated
7. **End of Life**: Version is no longer supported

### Version Support

- **Current Version**: Full support and active development
- **Previous Version**: Maintenance support only
- **Older Versions**: Limited support
- **Deprecated Versions**: No support

## Content Management

### Version-Specific Content

Each version maintains its own content:

- **Specification**: Technical specification content
- **Changelog**: Version-specific changelog
- **Examples**: Version-specific examples
- **Documentation**: Version-specific documentation

### Shared Content

Some content is shared across versions:

- **Governance**: Community governance documents
- **FAQ**: Frequently asked questions
- **News**: News and announcements
- **Publications**: Academic papers and publications

## URL Structure

### Version URLs

Each version has its own URL structure:

- **Latest**: `/swhid-specification/` (redirects to latest)
- **v2.0**: `/swhid-specification/v2.0/`
- **v1.2**: `/swhid-specification/v1.2/`
- **v1.1**: `/swhid-specification/v1.1/`
- **v1.0**: `/swhid-specification/v1.0/`

### Redirects

The latest version redirects to the current stable version:

```yaml
# mkdocs.yml
plugins:
  - redirects:
      redirect_maps:
        "swhid-specification/latest/": "swhid-specification/v2.0/"
        "swhid-specification/": "swhid-specification/v2.0/"
```

## Navigation Management

### Horizontal Navigation

The horizontal navigation shows:

- **Specification**: Link to latest version
- **Individual Versions**: Hidden by default (using CSS/JS)
- **Other Sections**: Governance, FAQ, News, etc.

### Version Selector

The version selector appears on specification pages:

- **Dropdown**: Shows all available versions
- **Current Version**: Highlights current version
- **Version Links**: Links to specific versions

### Left Navigation

The left navigation shows:

- **Version-Specific Content**: Content for current version
- **Cross-Version Links**: Links to other versions
- **External Links**: Links to external resources

## Testing Versions

### Local Testing

Test each version locally:

```bash
# Test specific version
cd sources/specification-v2.0
mkdocs serve

# Test all versions
make test-versions
```

### Integration Testing

Test version integration:

```bash
# Build all versions
make build

# Test navigation
make test-navigation

# Test links
make test-links
```

## Maintenance

### Regular Maintenance

Regular maintenance tasks:

1. **Update Dependencies**: Keep dependencies updated
2. **Check Links**: Verify all links work
3. **Update Content**: Keep content current
4. **Test Functionality**: Test all functionality
5. **Monitor Performance**: Monitor site performance

### Version-Specific Maintenance

Version-specific maintenance:

1. **Content Updates**: Update version-specific content
2. **Bug Fixes**: Fix version-specific bugs
3. **Security Updates**: Apply security updates
4. **Performance Optimization**: Optimize performance
5. **Documentation Updates**: Update documentation

## Best Practices

### Version Management

1. **Semantic Versioning**: Use semantic versioning
2. **Clear Naming**: Use clear, descriptive version names
3. **Documentation**: Document all changes
4. **Testing**: Test all changes thoroughly
5. **Communication**: Communicate changes to users

### Content Management

1. **Consistency**: Maintain consistency across versions
2. **Accuracy**: Ensure content accuracy
3. **Completeness**: Ensure content completeness
4. **Clarity**: Write clear, understandable content
5. **Accessibility**: Ensure content accessibility

### Technical Management

1. **Code Quality**: Maintain high code quality
2. **Performance**: Optimize for performance
3. **Security**: Ensure security best practices
4. **Compatibility**: Ensure backward compatibility
5. **Scalability**: Design for scalability

## Troubleshooting

### Common Issues

#### Version Not Appearing

1. **Check Directory**: Verify version directory exists
2. **Check Navigation**: Verify navigation configuration
3. **Check Build**: Verify build completed successfully
4. **Check Deploy**: Verify deployment completed

#### Navigation Issues

1. **Check Configuration**: Verify navigation configuration
2. **Check Overlays**: Verify overlay files exist
3. **Check Submodules**: Verify submodules are updated
4. **Check Build**: Verify build completed successfully

#### Link Issues

1. **Check URLs**: Verify URL structure
2. **Check Redirects**: Verify redirect configuration
3. **Check Content**: Verify content links
4. **Check Build**: Verify build completed successfully

### Getting Help

- **Documentation**: Check this documentation
- **Issues**: Create GitHub issue
- **Discussions**: Use GitHub discussions
- **Team**: Contact team members



