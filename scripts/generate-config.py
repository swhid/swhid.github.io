#!/usr/bin/env python3
"""
Generate MkDocs configuration files from templates
"""
import os
import sys
import json
import re
from pathlib import Path

def load_versions():
    """Load versions from versions.json"""
    versions_file = Path("build/meta/versions.json")
    if versions_file.exists():
        with open(versions_file, 'r') as f:
            data = json.load(f)
            versions = data.get('versions', [])
            latest = data.get('latest', '')
            if not latest and versions:
                # If no latest specified, use the highest version
                latest = max(versions, key=lambda v: [int(x) for x in v[1:].split('.')])
            return versions, latest
    return [], ''

def discover_news_files():
    """Discover news files from docs/news/ directory and extract titles"""
    news_dir = Path("docs/news")
    news_files = []
    
    if not news_dir.exists():
        return news_files
    
    # Find all markdown files in news directory (excluding index.md)
    for news_file in news_dir.glob("*.md"):
        if news_file.name == "index.md":
            continue
            
        # Extract title from markdown file
        title = extract_title_from_markdown(news_file)
        if title:
            news_files.append({
                'title': title,
                'path': f"news/{news_file.name}",
                'date': extract_date_from_filename(news_file.name)
            })
    
    # Sort by date (newest first)
    news_files.sort(key=lambda x: x['date'], reverse=True)
    return news_files

def extract_title_from_markdown(file_path):
    """Extract title from markdown file (YAML frontmatter or first # heading)"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Check for YAML frontmatter
        if content.startswith('---\n'):
            lines = content.split('\n')
            in_frontmatter = False
            for line in lines:
                if line.strip() == '---':
                    if in_frontmatter:
                        break  # End of frontmatter
                    in_frontmatter = True
                    continue
                if in_frontmatter and line.startswith('title:'):
                    return line.split(':', 1)[1].strip()
        
        # Fallback to markdown headers
        for line in content.split('\n'):
            line = line.strip()
            if line.startswith('# '):
                return line[2:].strip()
            elif line.startswith('## '):
                return line[3:].strip()
    except Exception as e:
        print(f"Warning: Could not read {file_path}: {e}")
    return None

def extract_date_from_filename(filename):
    """Extract date from filename like '2025-04-23-title.md'"""
    match = re.match(r'^(\d{4}-\d{2}-\d{2})-', filename)
    if match:
        return match.group(1)
    return "0000-00-00"  # Fallback for files without date

def generate_spec_overlay(version, template_path, output_path):
    """Generate specification overlay from template"""
    # Check if version-specific template exists (e.g., spec-overlay-v1.0.yml.template)
    version_specific_template = template_path.parent / f'spec-overlay-{version}.yml.template'
    
    if version_specific_template.exists():
        template_path = version_specific_template
        print(f"Using version-specific template: {template_path}")
    else:
        print(f"Using default template: {template_path}")
    
    with open(template_path, 'r') as f:
        template = f.read()
    
    # Replace template variables
    content = template.replace('{{VERSION}}', version)
    
    # Special handling for dev version - use main submodule directory
    if version == 'dev':
        # Update docs_dir to point to main submodule for dev version
        content = re.sub(
            r'docs_dir: \.\./sources/specification-dev/Chapters',
            'docs_dir: ../sources/specification/Chapters',
            content
        )
        print(f"  Using main submodule directory for dev version")
    
    # Write output file
    with open(output_path, 'w') as f:
        f.write(content)
    
    print(f"Generated {output_path}")

def generate_main_mkdocs(versions, latest, template_path, output_path):
    """Generate main mkdocs.yml from template"""
    with open(template_path, 'r') as f:
        template = f.read()
    
    # Generate navigation entries for all versions
    nav_entries = []
    nav_entries.append("  - Home: index.md")
    nav_entries.append(f"  - Specification: '!include .monorepo-overlays/spec-{latest}.mkdocs.yml'")
    
    for version in versions:
        if version != latest:
            nav_entries.append(f"  - {version}: '!include .monorepo-overlays/spec-{version}.mkdocs.yml'")
    
    # Add governance and other static pages
    nav_entries.extend([
        "  - Governance: '!include sources/governance/mkdocs.yml'",
        "  - FAQ: faq.md",
        "  - News:"
    ])
    
    # Add news index
    nav_entries.append("    - All news: news/index.md")
    
    # Dynamically discover news files
    news_files = discover_news_files()
    for news_file in news_files:
        nav_entries.append(f"    - {news_file['title']}: {news_file['path']}")
    
    # Add remaining static pages
    nav_entries.extend([
        "  - Publications: publications.md",
        "  - Core Team: coreteam.md"
    ])
    
    # Replace navigation section in template
    nav_content = '\n'.join(nav_entries)
    content = template.replace('{{NAVIGATION}}', nav_content)
    
    # Update version list in extra section
    versions_yaml = '\n'.join([f"    - {v}" for v in versions])
    content = content.replace('{{VERSIONS}}', versions_yaml)
    
    # Write output file
    with open(output_path, 'w') as f:
        f.write(content)
    
    print(f"Generated {output_path}")

def main():
    """Main function"""
    root = Path(__file__).parent.parent
    os.chdir(root)
    
    # Load versions
    versions, latest = load_versions()
    print(f"Loaded versions: {versions}, latest: {latest}")
    
    # Sort versions in descending order for version selector (latest first)
    # Handle dev version specially - put it at the end
    def version_sort_key(v):
        if v == "dev":
            return [0, 0]  # Put dev at the end
        return [int(x) for x in v[1:].split('.')]
    
    sorted_versions = sorted(versions, key=version_sort_key, reverse=True)
    print(f"Sorted versions (descending): {sorted_versions}")
    
    # Generate specification overlays
    template_dir = Path("templates")
    overlays_dir = Path(".monorepo-overlays")
    overlays_dir.mkdir(exist_ok=True)
    
    for version in versions:
        template_path = template_dir / "spec-overlay.yml.template"
        output_path = overlays_dir / f"spec-{version}.mkdocs.yml"
        generate_spec_overlay(version, template_path, output_path)
    
    # Generate main mkdocs.yml
    template_path = template_dir / "mkdocs.yml.template"
    output_path = Path("mkdocs.yml")
    generate_main_mkdocs(sorted_versions, latest, template_path, output_path)
    
    print("Configuration generation completed!")

if __name__ == "__main__":
    main()
