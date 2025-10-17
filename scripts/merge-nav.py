#!/usr/bin/env python3
"""
Merge nav.yml into mkdocs.yml
"""
import re
import sys
from pathlib import Path

def merge_nav():
    root = Path(__file__).parent.parent
    mkdocs_file = root / "mkdocs.yml"
    nav_file = root / "nav.yml"
    
    # Read mkdocs.yml content
    with open(mkdocs_file, 'r') as f:
        mkdocs_content = f.read()
    
    # Read nav.yml content
    with open(nav_file, 'r') as f:
        nav_content = f.read()
    
    # Find the nav section in mkdocs.yml and replace it
    # Look for "nav:" followed by content until the next top-level key (not indented)
    # This pattern matches nav: and everything until the next unindented line that starts with a letter
    nav_pattern = r'^nav:\s*\n(?:^  .*\n|^# .*\n|^$)*'
    
    # Find the start of nav section
    nav_match = re.search(nav_pattern, mkdocs_content, re.MULTILINE)
    
    if nav_match:
        # Replace the existing nav section
        new_content = re.sub(nav_pattern, 'nav:\n' + nav_content + '\n', mkdocs_content, flags=re.MULTILINE)
    else:
        # If no nav section found, add it after the plugins section
        plugins_pattern = r'^plugins:\s*\n(?:^  .*\n)*'
        plugins_match = re.search(plugins_pattern, mkdocs_content, re.MULTILINE)
        
        if plugins_match:
            # Insert nav after plugins
            insert_pos = plugins_match.end()
            new_content = mkdocs_content[:insert_pos] + '\nnav:\n' + nav_content + '\n' + mkdocs_content[insert_pos:]
        else:
            # Fallback: add at the end
            new_content = mkdocs_content + '\nnav:\n' + nav_content + '\n'
    
    # Write back to mkdocs.yml
    with open(mkdocs_file, 'w') as f:
        f.write(new_content)
    
    print(f"✅ Merged {nav_file} into {mkdocs_file}")

if __name__ == "__main__":
    merge_nav()
