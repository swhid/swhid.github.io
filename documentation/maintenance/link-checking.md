# Link Checking

## Overview

Link checking is an essential maintenance task to ensure all links on the SWHID.org website are working correctly. This guide explains how to use the link checking tools and maintain link integrity.

## Link Checking Tools

### 1. Bash Script (`scripts/check-links.sh`)

A comprehensive bash script that checks all types of links:

```bash
#!/bin/bash
# Check all links in the SWHID.org website

# Usage: ./scripts/check-links.sh [file]
# If no file is specified, checks all markdown files

# Configuration
SITE_DIR="site"
DOCS_DIR="docs"
BROKEN_LINKS=()

# Functions
check_external_links() {
    echo "Checking external links..."
    # Implementation details...
}

check_internal_links() {
    echo "Checking internal links..."
    # Implementation details...
}

check_markdown_links() {
    echo "Checking markdown links..."
    # Implementation details...
}

# Main execution
main() {
    echo "SWHID.org Link Checker"
    echo "====================="
    
    if [ $# -eq 0 ]; then
        check_all_links
    else
        check_specific_file "$1"
    fi
    
    report_results
}

main "$@"
```

### 2. Python Script (`scripts/check-links.py`)

A more robust Python script with better error handling:

```python
#!/usr/bin/env python3
"""
SWHID.org Link Checker

A comprehensive link checking tool for the SWHID.org website.
Checks external links, internal links, and markdown links.
"""

import os
import re
import sys
import time
import urllib.parse
from pathlib import Path
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

class LinkChecker:
    def __init__(self, site_dir="site", docs_dir="docs"):
        self.site_dir = Path(site_dir)
        self.docs_dir = Path(docs_dir)
        self.broken_links = []
        self.session = self._create_session()
    
    def _create_session(self):
        """Create a requests session with retry strategy."""
        session = requests.Session()
        retry_strategy = Retry(
            total=3,
            backoff_factor=1,
            status_forcelist=[429, 500, 502, 503, 504],
        )
        adapter = HTTPAdapter(max_retries=retry_strategy)
        session.mount("http://", adapter)
        session.mount("https://", adapter)
        return session
    
    def check_external_links(self):
        """Check all external links."""
        print("Checking external links...")
        # Implementation details...
    
    def check_internal_links(self):
        """Check all internal links."""
        print("Checking internal links...")
        # Implementation details...
    
    def check_markdown_links(self):
        """Check all markdown links."""
        print("Checking markdown links...")
        # Implementation details...
    
    def run(self):
        """Run all link checks."""
        print("SWHID.org Link Checker")
        print("=====================")
        
        self.check_external_links()
        self.check_internal_links()
        self.check_markdown_links()
        
        self.report_results()

if __name__ == "__main__":
    checker = LinkChecker()
    checker.run()
```

## Usage

### Basic Usage

```bash
# Check all links
./scripts/check-links.sh

# Check specific file
./scripts/check-links.sh docs/publications.md

# Check with Python script
python3 scripts/check-links.py
```

### Advanced Usage

```bash
# Check external links only
./scripts/check-links.sh --external-only

# Check internal links only
./scripts/check-links.sh --internal-only

# Check markdown links only
./scripts/check-links.sh --markdown-only

# Verbose output
./scripts/check-links.sh --verbose

# Save results to file
./scripts/check-links.sh --output results.txt
```

## Link Types

### External Links

External links point to resources outside the website:

- **HTTP/HTTPS URLs**: Web pages and resources
- **Email Addresses**: mailto: links
- **Phone Numbers**: tel: links
- **Other Protocols**: ftp:, file:, etc.

#### Checking External Links

```bash
# Check external links
./scripts/check-links.sh --external-only

# Check specific external link
curl -I "https://www.iso.org/standard/89985.html"
```

#### Common External Link Issues

1. **404 Not Found**: Target page doesn't exist
2. **301/302 Redirects**: Page moved permanently/temporarily
3. **403 Forbidden**: Access denied
4. **500 Server Error**: Server error
5. **Timeout**: Request timed out
6. **SSL Issues**: Certificate problems

### Internal Links

Internal links point to resources within the website:

- **Absolute Paths**: `/swhid-specification/`
- **Relative Paths**: `../faq.md`
- **Anchor Links**: `#section-name`
- **File Links**: `file.pdf`

#### Checking Internal Links

```bash
# Check internal links
./scripts/check-links.sh --internal-only

# Check specific internal link
ls -la site/swhid-specification/
```

#### Common Internal Link Issues

1. **Missing Files**: Target file doesn't exist
2. **Wrong Path**: Incorrect file path
3. **Missing Anchors**: Target anchor doesn't exist
4. **Case Sensitivity**: Incorrect case in filename
5. **Trailing Slashes**: Missing or extra slashes

### Markdown Links

Markdown links are defined in Markdown files:

- **Inline Links**: `[text](url)`
- **Reference Links**: `[text][ref]`
- **Automatic Links**: `<url>`
- **Image Links**: `![alt](url)`

#### Checking Markdown Links

```bash
# Check markdown links
./scripts/check-links.sh --markdown-only

# Check specific markdown file
./scripts/check-links.sh docs/publications.md
```

#### Common Markdown Link Issues

1. **Syntax Errors**: Incorrect Markdown syntax
2. **Missing References**: Undefined reference links
3. **Broken URLs**: Invalid or broken URLs
4. **Missing Images**: Image files not found
5. **Encoding Issues**: Character encoding problems

## Link Maintenance

### Regular Maintenance

Perform link checking regularly:

1. **Daily**: Check for critical link failures
2. **Weekly**: Check all external links
3. **Monthly**: Comprehensive link audit
4. **Before Releases**: Check all links before major releases

### Automated Checking

Set up automated link checking:

```yaml
# .github/workflows/link-check.yml
name: Link Check

on:
  schedule:
    - cron: '0 2 * * 1'  # Weekly on Monday at 2 AM
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  link-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Check Links
        run: ./scripts/check-links.sh
```

### Link Monitoring

Monitor link health:

1. **Uptime Monitoring**: Monitor critical external links
2. **Performance Monitoring**: Monitor link response times
3. **Error Tracking**: Track link errors and failures
4. **Analytics**: Use analytics to identify popular links

## Fixing Broken Links

### External Link Fixes

#### 1. Update URLs

```bash
# Find broken external links
./scripts/check-links.sh --external-only | grep "404"

# Update URLs in files
sed -i 's|old-url|new-url|g' docs/publications.md
```

#### 2. Remove Broken Links

```bash
# Remove broken external links
sed -i '/\[.*\](broken-url)/d' docs/publications.md
```

#### 3. Replace with Alternatives

```bash
# Replace with alternative URLs
sed -i 's|broken-url|alternative-url|g' docs/publications.md
```

### Internal Link Fixes

#### 1. Fix File Paths

```bash
# Fix incorrect file paths
sed -i 's|old-path|new-path|g' docs/index.md
```

#### 2. Create Missing Files

```bash
# Create missing files
touch docs/missing-file.md
```

#### 3. Update Anchors

```bash
# Update anchor references
sed -i 's|#old-anchor|#new-anchor|g' docs/index.md
```

### Markdown Link Fixes

#### 1. Fix Syntax Errors

```bash
# Fix Markdown syntax
sed -i 's|\[text\]\(url|\[text\](url)|g' docs/index.md
```

#### 2. Define Missing References

```bash
# Add missing reference definitions
echo "[ref]: url" >> docs/index.md
```

#### 3. Fix Image Links

```bash
# Fix image paths
sed -i 's|!\[alt\](old-path)|![alt](new-path)|g' docs/index.md
```

## Best Practices

### Link Creation

1. **Use Descriptive Text**: Use descriptive link text
2. **Check Before Adding**: Verify links work before adding
3. **Use Relative Paths**: Use relative paths when possible
4. **Avoid Deep Links**: Avoid linking to deep page sections
5. **Test Regularly**: Test links regularly

### Link Maintenance

1. **Monitor Changes**: Monitor for URL changes
2. **Update Regularly**: Update links regularly
3. **Document Changes**: Document link changes
4. **Backup Links**: Keep backups of important links
5. **Use Redirects**: Use redirects for moved content

### Link Quality

1. **Relevant Content**: Ensure links point to relevant content
2. **Current Information**: Keep links current and up-to-date
3. **Accessible Content**: Ensure linked content is accessible
4. **Fast Loading**: Prefer fast-loading pages
5. **Mobile Friendly**: Ensure linked pages are mobile-friendly

## Troubleshooting

### Common Issues

#### Script Not Working

```bash
# Check script permissions
chmod +x scripts/check-links.sh

# Check script syntax
bash -n scripts/check-links.sh
```

#### False Positives

```bash
# Check for false positives
./scripts/check-links.sh --verbose

# Verify specific links manually
curl -I "https://example.com"
```

#### Performance Issues

```bash
# Check script performance
time ./scripts/check-links.sh

# Use parallel processing
./scripts/check-links.sh --parallel
```

### Getting Help

- **Documentation**: Check this documentation
- **Script Help**: Run scripts with --help
- **Issues**: Create GitHub issue
- **Discussions**: Use GitHub discussions
- **Team**: Contact team members

## Advanced Features

### Custom Link Patterns

```bash
# Check custom link patterns
./scripts/check-links.sh --pattern "https://example.com/*"
```

### Link Validation

```bash
# Validate link syntax
./scripts/check-links.sh --validate-syntax
```

### Link Statistics

```bash
# Generate link statistics
./scripts/check-links.sh --stats
```

### Link Reports

```bash
# Generate detailed reports
./scripts/check-links.sh --report --output report.html
```



