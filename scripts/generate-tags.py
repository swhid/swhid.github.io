#!/usr/bin/env python3
"""
Generate tags page by scanning all markdown files for YAML frontmatter tags
"""
import os
import re
from pathlib import Path
from collections import defaultdict

def extract_tags_from_file(file_path):
    """Extract tags from YAML frontmatter in a markdown file"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Check for YAML frontmatter
        if not content.startswith('---\n'):
            return []
        
        lines = content.split('\n')
        in_frontmatter = False
        tags = []
        
        for i, line in enumerate(lines):
            if line.strip() == '---':
                if in_frontmatter:
                    break  # End of frontmatter
                in_frontmatter = True
                continue
            
            if in_frontmatter and line.startswith('tags:'):
                # Handle both single line and multi-line tags
                tag_line = line.split(':', 1)[1].strip()
                if tag_line:
                    # Single line format: tags: tag1, tag2, tag3
                    if tag_line.startswith('['):
                        tag_line = tag_line.strip('[]')
                    tags = [tag.strip().strip('"\'') for tag in tag_line.split(',')]
                else:
                    # Multi-line format: tags: followed by list items
                    j = i + 1
                    while j < len(lines) and lines[j].strip().startswith('- '):
                        tag_item = lines[j].strip()[2:].strip().strip('"\'')
                        if tag_item:
                            tags.append(tag_item)
                        j += 1
                break
        
        return [tag for tag in tags if tag]  # Remove empty tags
    except Exception as e:
        print(f"Warning: Could not read {file_path}: {e}")
        return []

def get_page_title(file_path):
    """Extract page title from markdown file"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Check for YAML frontmatter title
        if content.startswith('---\n'):
            lines = content.split('\n')
            in_frontmatter = False
            for line in lines:
                if line.strip() == '---':
                    if in_frontmatter:
                        break
                    in_frontmatter = True
                    continue
                if in_frontmatter and line.startswith('title:'):
                    return line.split(':', 1)[1].strip().strip('"\'')
        
        # Fallback to first markdown header
        for line in content.split('\n'):
            line = line.strip()
            if line.startswith('# '):
                return line[2:].strip()
            elif line.startswith('## '):
                return line[3:].strip()
    except Exception as e:
        print(f"Warning: Could not read title from {file_path}: {e}")
    
    # Fallback to filename
    return Path(file_path).stem.replace('_', ' ').replace('-', ' ').title()

def generate_tags_page():
    """Generate the tags page with all tagged content"""
    root = Path(__file__).parent.parent
    docs_dir = root / "docs"
    
    # Dictionary to store tag -> list of pages
    tag_pages = defaultdict(list)
    
    # Scan all markdown files in docs directory
    for md_file in docs_dir.rglob("*.md"):
        if md_file.name == "index.md" and "swhid-specification" in str(md_file):
            # Skip the generated specification index page
            continue
            
        tags = extract_tags_from_file(md_file)
        if tags:
            # Get relative path for URL
            rel_path = md_file.relative_to(docs_dir)
            url_path = str(rel_path).replace('.md', '/')
            if url_path.endswith('/index/'):
                url_path = url_path[:-6] + '/'
            
            title = get_page_title(md_file)
            
            for tag in tags:
                tag_pages[tag].append({
                    'title': title,
                    'url': f'../{url_path}',
                    'file': str(rel_path)
                })
    
    # Sort tags alphabetically
    sorted_tags = sorted(tag_pages.keys())
    
    # Generate the tags page content
    tags_content = """# Tags

This page lists all the tags used across the SWHID documentation and news articles, with links to the pages that contain each tag.

"""
    
    if not sorted_tags:
        tags_content += "No tagged content found.\n"
    else:
        for tag in sorted_tags:
            pages = tag_pages[tag]
            # Sort pages by title
            pages.sort(key=lambda x: x['title'])
            
            tags_content += f"## {tag}\n\n"
            tags_content += f"*{len(pages)} page{'s' if len(pages) != 1 else ''}*\n\n"
            
            for page in pages:
                tags_content += f"- [{page['title']}]({page['url']})\n"
            
            tags_content += "\n"
    
    # Write the tags page
    tags_file = docs_dir / "tags" / "index.md"
    tags_file.parent.mkdir(exist_ok=True)
    
    with open(tags_file, 'w', encoding='utf-8') as f:
        f.write(tags_content)
    
    print(f"Generated tags page: {tags_file}")
    print(f"Found {len(sorted_tags)} unique tags across {sum(len(pages) for pages in tag_pages.values())} pages")
    
    # Print summary
    for tag in sorted_tags:
        print(f"  {tag}: {len(tag_pages[tag])} pages")

if __name__ == "__main__":
    generate_tags_page()
