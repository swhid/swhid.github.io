#!/usr/bin/env python3
"""
Generate implementations page from YAML data file
"""
import yaml
from pathlib import Path

def format_types_qualifiers(types, qualifiers, all_types, all_qualifiers):
    """Format types and qualifiers with visual indicators"""
    type_labels = {
        'cnt': 'cnt',
        'dir': 'dir',
        'rev': 'rev',
        'rel': 'rel',
        'snp': 'snp'
    }
    
    qualifier_labels = {
        'origin': 'origin',
        'visit': 'visit',
        'anchor': 'anchor',
        'path': 'path',
        'lines': 'lines',
        'bytes': 'bytes'
    }
    
    # Format types
    type_list = []
    for t in all_types:
        if t in types:
            type_list.append(f"`{type_labels[t]}`")
        else:
            type_list.append("—")
    
    # Format qualifiers
    qualifier_list = []
    for q in all_qualifiers:
        if q in qualifiers:
            qualifier_list.append(f"`{qualifier_labels[q]}`")
        else:
            qualifier_list.append("—")
    
    return type_list, qualifier_list

def generate_implementations_page():
    """Generate the implementations page from YAML data"""
    root = Path(__file__).parent.parent
    data_file = root / "data" / "implementations.yaml"
    output_file = root / "docs" / "implementations.md"
    
    # Read YAML data
    try:
        with open(data_file, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f)
    except Exception as e:
        print(f"Error reading {data_file}: {e}")
        return
    
    # Define all types and qualifiers for consistent ordering
    all_types = ['cnt', 'dir', 'rev', 'rel', 'snp']
    all_qualifiers = ['origin', 'visit', 'anchor', 'path', 'lines', 'bytes']
    
    # Start building the page content
    content = """# Implementations

This page provides information about SWHID implementations, the reference implementation, and the test suite for validating implementations.

## Reference Implementation

"""
    
    # Add reference implementation section
    ref_impl = data.get('reference_implementation', {})
    if ref_impl:
        license = ref_impl.get('license', 'Not specified')
        license_url = ref_impl.get('license_url', '')
        if license_url and license != '---':
            license_display = f"[{license}]({license_url})"
        else:
            license_display = license
        
        content += f"""The **{ref_impl.get('name', 'swhid-rs')}** reference implementation is maintained by the SWHID Working Group.

- **Repository**: [{ref_impl.get('repository', '')}]({ref_impl.get('repository', '')})
- **Language**: {ref_impl.get('language', 'Rust')}
- **Description**: {ref_impl.get('description', '')}
- **License**: {license_display}
"""
        if ref_impl.get('note'):
            content += f"- **Note**: {ref_impl.get('note')}\n"
        
        content += "\n**Supported Types**: "
        content += ", ".join([f"`{t}`" for t in ref_impl.get('types', [])])
        content += "\n\n**Supported Qualifiers**: "
        content += ", ".join([f"`{q}`" for q in ref_impl.get('qualifiers', [])])
        content += "\n\n"
    
    # Add test suite section
    test_suite = data.get('test_suite', {})
    if test_suite:
        content += """## Test Suite

"""
        content += f"""{test_suite.get('description', '')}

- **Repository**: [{test_suite.get('repository', '')}]({test_suite.get('repository', '')})

The test suite can be used to validate that implementations correctly handle SWHID parsing, generation, and validation according to the specification.

"""
    
    # Add known implementations section
    implementations = data.get('implementations', [])
    if implementations:
        content += """## Known Implementations

The following table lists known implementations of the SWHID standard, along with their supported types and qualifiers.

"""
        # Create table header
        content += "| Implementation | Language | Maintainer | License | Types | Qualifiers | Description |\n"
        content += "|----------------|----------|-------------|---------|-------|------------|-------------|\n"
        
        # Add table rows
        for impl in implementations:
            name = impl.get('name', '')
            repo = impl.get('repository', '')
            language = impl.get('language', '')
            maintainer = impl.get('maintainer', '')
            license = impl.get('license', 'Not specified')
            license_url = impl.get('license_url', '')
            description = impl.get('description', '')
            types = impl.get('types', [])
            qualifiers = impl.get('qualifiers', [])
            
            # Format license as link if URL provided, otherwise use as-is
            if license_url and license != '---':
                license_display = f"[{license}]({license_url})"
            else:
                license_display = license
            
            # Format types and qualifiers
            type_list, qualifier_list = format_types_qualifiers(
                types, qualifiers, all_types, all_qualifiers
            )
            
            # Create name link
            name_link = f"[{name}]({repo})" if repo else name
            
            # Format types column (compact)
            types_str = " ".join(type_list)
            
            # Format qualifiers column (compact)
            qualifiers_str = " ".join(qualifier_list)
            
            # Escape pipe characters in description and license
            description_escaped = description.replace('|', '\\|')
            license_escaped = license_display.replace('|', '\\|')
            
            content += f"| {name_link} | {language} | {maintainer} | {license_escaped} | {types_str} | {qualifiers_str} | {description_escaped} |\n"
        
        content += "\n### Type and Qualifier Legend\n\n"
        content += "**Types**:\n"
        content += "- `cnt` - Contents (files)\n"
        content += "- `dir` - Directories\n"
        content += "- `rev` - Revisions (commits)\n"
        content += "- `rel` - Releases\n"
        content += "- `snp` - Snapshots\n\n"
        
        content += "**Qualifiers**:\n"
        content += "- `origin` - Software origin (context qualifier)\n"
        content += "- `visit` - Visit identifier (context qualifier)\n"
        content += "- `anchor` - Anchor identifier (context qualifier)\n"
        content += "- `path` - File path (context qualifier)\n"
        content += "- `lines` - Line range (fragment qualifier)\n"
        content += "- `bytes` - Byte range (fragment qualifier)\n\n"
    
    # Add template PR section
    content += """## Adding a New Implementation

If you have created an implementation of the SWHID standard and would like it to be listed here, please open a pull request with the following information:

### Template for Adding a New Implementation

```yaml
- name: "Your Implementation Name"
  repository: "https://github.com/your-org/your-repo"
  language: "Programming Language"
  maintainer: "Your Name or Organization"
  description: "Brief description of your implementation"
  license: "License name (e.g., MIT, GPL v3, Apache 2.0)"
  license_url: "https://github.com/your-org/your-repo/blob/main/LICENSE"  # Optional: URL to license file
  types:
    - cnt    # Check all that apply
    - dir
    - rev
    - rel
    - snp
  qualifiers:
    - origin   # Check all that apply
    - visit
    - anchor
    - path
    - lines
    - bytes
```

### Required Information

- **Repository URL**: Link to the implementation's source code repository
- **Programming Language**: The primary language used
- **Maintainer**: Name or organization maintaining the implementation
- **Description**: Brief description of what the implementation provides
- **License**: License under which the implementation is released (e.g., MIT, GPL v3, Apache 2.0). Use `---` if no license is specified.
- **Supported Types**: List of SWHID object types supported (`cnt`, `dir`, `rev`, `rel`, `snp`)
- **Supported Qualifiers**: List of qualifiers supported (`origin`, `visit`, `anchor`, `path`, `lines`, `bytes`)

### Optional Information

- **License URL**: URL to the license file in the repository (e.g., `https://github.com/org/repo/blob/main/LICENSE`). If provided, the license name will be displayed as a clickable link.
- **Documentation**: Link to documentation or usage examples
- **Test Suite Compatibility**: Whether the implementation passes the SWHID test suite

To add your implementation, edit `data/implementations.yaml` and submit a pull request. The page will be automatically regenerated when your changes are merged.

"""
    
    # Write the generated page
    output_file.parent.mkdir(parents=True, exist_ok=True)
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"Generated implementations page: {output_file}")
    print(f"Listed {len(implementations)} implementations")

if __name__ == "__main__":
    generate_implementations_page()

