#!/usr/bin/env bash
set -euo pipefail

# Version Detection Script for SWHID Specification
# This script automatically detects available specification versions from git tags
# and generates the necessary configuration for the version selector.

# Configuration
SPEC_REPO_URL="https://github.com/swhid/specification"
VERSION_PATTERN="^v[0-9]+\.[0-9]+(-[a-zA-Z0-9]+)?$"
LATEST_ALIAS="latest"

# Function to get available versions from git tags
get_available_versions() {
    local spec_dir="${1:-.ext/spec}"
    
    if [ ! -d "$spec_dir" ]; then
        echo "Error: Specification directory $spec_dir not found" >&2
        return 1
    fi
    
    # Fetch latest tags and get version tags matching our pattern
    (cd "$spec_dir" && git fetch --tags --quiet)
    
    # Get all version tags, sort them properly (v1.0, v1.1, v1.2, etc.)
    (cd "$spec_dir" && git tag -l | grep -E "$VERSION_PATTERN" | sort -V)
}

# Function to determine the latest version
get_latest_version() {
    local versions=("$@")
    
    if [ ${#versions[@]} -eq 0 ]; then
        echo "Error: No versions found" >&2
        return 1
    fi
    
    # Filter out pre-release versions (those with hyphens) and get the latest official version
    local official_versions=()
    for version in "${versions[@]}"; do
        if [[ ! "$version" =~ - ]]; then
            official_versions+=("$version")
        fi
    done
    
    # If we have official versions, use the latest one
    if [ ${#official_versions[@]} -gt 0 ]; then
        echo "${official_versions[-1]}"
    else
        # Fallback to the latest version (including pre-releases) if no official versions
        echo "${versions[-1]}"
    fi
}

# Function to generate versions.json
generate_versions_json() {
    local versions=("$@")
    local latest_version
    local versions_json="["
    local first=true
    
    latest_version=$(get_latest_version "${versions[@]}")
    
    for version in "${versions[@]}"; do
        if [ "$first" = true ]; then
            first=false
        else
            versions_json+=","
        fi
        
        versions_json+="\n  {\n"
        versions_json+="    \"version\": \"$version\",\n"
        
        if [ "$version" = "$latest_version" ]; then
            versions_json+="    \"title\": \"$version (latest)\",\n"
            versions_json+="    \"aliases\": [\"$LATEST_ALIAS\"]\n"
        else
            versions_json+="    \"title\": \"$version\",\n"
            versions_json+="    \"aliases\": []\n"
        fi
        
        versions_json+="  }"
    done
    
    versions_json+="\n]"
    echo -e "$versions_json"
}

# Function to generate build commands for each version
generate_build_commands() {
    local versions=("$@")
    local build_commands=""
    
    for version in "${versions[@]}"; do
        build_commands+="# Build $version\n"
        build_commands+="echo \"Building specification $version...\"\n"
        build_commands+="(cd .ext/spec && git checkout $version)\n"
        build_commands+="# Apply unified theme after checkout\n"
        build_commands+="mkdir -p .ext/spec/css\n"
        build_commands+="cp assets/design/unified-theme.css .ext/spec/css/style.css\n"
        build_commands+="cp assets/design/tokens.css .ext/spec/css/tokens.css\n"
        build_commands+="(cd .ext/spec && mkdocs build -d ../../.tmp_spec_$version)\n\n"
    done
    
    echo "$build_commands"
}

# Function to generate directory move commands
generate_move_commands() {
    local versions=("$@")
    local move_commands=""
    
    for version in "${versions[@]}"; do
        move_commands+="mv .tmp_spec_$version specification/$version\n"
    done
    
    echo "$move_commands"
}

# Function to generate version loop commands
generate_version_loops() {
    local versions=("$@")
    local version_list=$(IFS=" " ; echo "${versions[*]}")
    
    echo "for version in $version_list; do"
}

# Function to generate redirect logic
generate_redirect_logic() {
    local latest_version="$1"
    
    cat << EOF
    <meta http-equiv="refresh" content="0; url=$latest_version/">
    <script>
        window.location.href = "$latest_version/";
    </script>
    <p>Redirecting to <a href="$latest_version/">latest version</a>...</p>
EOF
}

# Main function
main() {
    local spec_dir="${1:-.ext/spec}"
    local output_dir="${2:-specification}"
    
    echo "Detecting specification versions from $spec_dir..."
    
    # Get available versions
    local versions
    mapfile -t versions < <(get_available_versions "$spec_dir")
    
    if [ ${#versions[@]} -eq 0 ]; then
        echo "Error: No valid versions found matching pattern $VERSION_PATTERN" >&2
        return 1
    fi
    
    echo "Found ${#versions[@]} versions: ${versions[*]}"
    
    # Generate configurations
    local latest_version
    latest_version=$(get_latest_version "${versions[@]}")
    echo "Latest version: $latest_version"
    
    # Create output directory
    mkdir -p "$output_dir"
    
    # Generate versions.json
    echo "Generating versions.json..."
    generate_versions_json "${versions[@]}" > "$output_dir/versions.json"
    
    # Generate build script
    echo "Generating build commands..."
    generate_build_commands "${versions[@]}" > "$output_dir/build_commands.sh"
    
    # Generate move commands
    echo "Generating move commands..."
    generate_move_commands "${versions[@]}" > "$output_dir/move_commands.sh"
    
    # Generate version loops
    echo "Generating version loops..."
    generate_version_loops "${versions[@]}" > "$output_dir/version_loops.sh"
    
    # Generate redirect logic
    echo "Generating redirect logic..."
    generate_redirect_logic "$latest_version" > "$output_dir/redirect_logic.html"
    
    echo "Version detection complete!"
    echo "Generated files in $output_dir/:"
    echo "  - versions.json"
    echo "  - build_commands.sh"
    echo "  - move_commands.sh"
    echo "  - version_loops.sh"
    echo "  - redirect_logic.html"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
