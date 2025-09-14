#!/usr/bin/env bash
set -euo pipefail

# Dynamic Bootstrap Script for SWHID Unified Website
# This script automatically detects specification versions and builds them dynamically

# Read pins (or allow overrides via env)
read_ref () { ruby -ryaml -e "p YAML.load_file('sources.lock.yml').dig('$1','ref')" ; }
SPEC_REF="${SPEC_REF:-$(read_ref spec)}"
GOV_REF="${GOV_REF:-$(read_ref gov)}"
DSN_REF="${DSN_REF:-$(read_ref design)}"

# Get script directory for relative paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION_DETECTOR="$SCRIPT_DIR/version-detector.sh"

echo "=== SWHID Unified Website Bootstrap (Dynamic Version Detection) ==="

# Setup external repositories
mkdir -p .ext
[ -d .ext/spec ]   || git clone https://github.com/swhid/specification .ext/spec
[ -d .ext/gov ]    || git clone https://github.com/swhid/governance    .ext/gov
[ -d .ext/design ] || git clone https://github.com/swhid/swhid-design  .ext/design
(cd .ext/spec && git fetch --all && git checkout "$SPEC_REF" || git checkout main)
(cd .ext/gov  && git fetch --all && git checkout "$GOV_REF"  || git checkout main)
(cd .ext/design && git fetch --all && git checkout "$DSN_REF" || git checkout main)

# Setup Python environment
python3 -m venv .venv && . .venv/bin/activate
pip install -U pip mkdocs mkdocs-material

# Copy design assets to specification and governance
mkdir -p .ext/spec/docs/assets/design .ext/gov/docs/assets/design
cp assets/design/tokens.css      .ext/spec/docs/assets/design/
cp assets/design/swhid-brand.css .ext/spec/docs/assets/design/
cp assets/design/tokens.css      .ext/gov/docs/assets/design/
cp assets/design/swhid-brand.css .ext/gov/docs/assets/design/

# Detect specification versions dynamically
echo "=== Detecting Specification Versions ==="
if [ ! -f "$VERSION_DETECTOR" ]; then
    echo "Error: Version detector script not found at $VERSION_DETECTOR" >&2
    exit 1
fi

# Run version detection
"$VERSION_DETECTOR" .ext/spec specification

# Source the generated configuration
if [ ! -f "specification/versions.json" ]; then
    echo "Error: Version detection failed - versions.json not generated" >&2
    exit 1
fi

# Read detected versions
VERSIONS=($(grep -o '"version": "[^"]*"' specification/versions.json | sed 's/"version": "//g' | sed 's/"//g'))
LATEST_VERSION=$(grep -o '"title": "[^"]*latest[^"]*"' specification/versions.json | head -1 | sed 's/.*"\([^"]*\)".*/\1/' | sed 's/ (latest)//')

echo "Detected versions: ${VERSIONS[*]}"
echo "Latest version: $LATEST_VERSION"

# Build multiple specification versions with mike-style version management
echo "=== Building Specification Versions ==="
rm -rf specification .tmp_spec_*

# Create specification directory structure
mkdir -p specification

# The versions.json is already in the right place from version detection

# Create version selector assets
mkdir -p specification/css specification/js

# Create version-select.css
cat > specification/css/version-select.css << 'EOF'
#version-selector {
  display: block;
  margin: -10px auto 0.809em;
  padding: 2px;
  background: #f8f9fa;
  border: 1px solid #dee2e6;
  border-radius: 4px;
  font-size: 0.9em;
  color: #495057;
}

#version-selector:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
}
EOF

# Create version-select.js
cat > specification/js/version-select.js << 'EOF'
// Version selector with retry logic
function initVersionSelector() {
  console.log("Version selector script loaded");
  
  function expandPath(path) {
    // Get the base directory components.
    var expanded = window.location.pathname.split("/");
    expanded.pop();
    var isSubdir = false;

    path.split("/").forEach(function(bit, i) {
      if (bit === "" && i === 0) {
        isSubdir = false;
        expanded = [""];
      } else if (bit === "." || bit === "") {
        isSubdir = true;
      } else if (bit === "..") {
        if (expanded.length === 1) {
          // We must be trying to .. past the root!
          throw new Error("invalid path");
        } else {
          isSubdir = true;
          expanded.pop();
        }
      } else {
        isSubdir = false;
        expanded.push(bit);
      }
    });

    if (isSubdir)
      expanded.push("");
    return expanded.join("/");
  }

  // `base_url` comes from the base.html template for this theme.
  var ABS_BASE_URL = expandPath(base_url);
  var CURRENT_VERSION = ABS_BASE_URL.match(/\/([^\/]+)\/$/)[1];
  
  console.log("Current version:", CURRENT_VERSION);
  console.log("Base URL:", ABS_BASE_URL);

  function makeSelect(options) {
    var select = document.createElement("select");

    options.forEach(function(i) {
      var option = new Option(i.text, i.value, undefined,
                              i.selected);
      select.add(option);
    });

    return select;
  }

  function addVersionSelector() {
    var title = document.querySelector("div.wy-side-nav-search");
    var iconHome = document.querySelector(".icon-home");
    
    console.log("Title element:", title);
    console.log("Icon home element:", iconHome);
    
    if (title && iconHome) {
      // Check if version selector already exists
      if (document.getElementById("version-selector")) {
        console.log("Version selector already exists");
        return;
      }
      
      fetch(ABS_BASE_URL + "../versions.json").then((response) => {
        console.log("Fetching versions.json...");
        return response.json();
      }).then((versions) => {
        console.log("Versions loaded:", versions);
        
        var realVersion = versions.find(function(i) {
          return i.version === CURRENT_VERSION ||
                 i.aliases.includes(CURRENT_VERSION);
        }).version;

        var select = makeSelect(versions.filter(function(i) {
          return i.version === realVersion || !i.properties || !i.properties.hidden;
        }).map(function(i) {
          return {text: i.title, value: i.version,
                  selected: i.version === realVersion};
        }));
        select.id = "version-selector";
        select.addEventListener("change", function(event) {
          window.location.href = ABS_BASE_URL + "../" + this.value + "/";
        });

        title.insertBefore(select, iconHome.nextSibling);
        console.log("Version selector added successfully");
      }).catch(function(error) {
        console.log("Version selector not available:", error);
      });
    } else {
      console.log("Could not find required elements for version selector, retrying...");
      // Retry after a short delay
      setTimeout(addVersionSelector, 100);
    }
  }
  
  addVersionSelector();
}

// Try to initialize immediately
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initVersionSelector);
} else {
  initVersionSelector();
}

// Also try after a delay to catch any dynamic content
setTimeout(initVersionSelector, 500);
EOF

# Build each specification version dynamically
for version in "${VERSIONS[@]}"; do
  echo "Building specification $version..."
  (cd .ext/spec && git checkout "$version")
  # Apply unified theme after checkout
  mkdir -p .ext/spec/css
  cp assets/design/unified-theme.css .ext/spec/css/style.css
  cp assets/design/tokens.css .ext/spec/css/tokens.css
  (cd .ext/spec && mkdocs build -d ../../.tmp_spec_$version)
done

# Build governance
echo "Building governance..."
# Apply unified theme to governance
mkdir -p .ext/gov/css
cp assets/design/unified-theme.css .ext/gov/css/style.css
cp assets/design/tokens.css .ext/gov/css/tokens.css
(cd .ext/gov && mkdocs build -d ../../.tmp_gov)

# Move built versions to final locations
for version in "${VERSIONS[@]}"; do
  mv .tmp_spec_$version specification/$version
done

# Copy unified theme CSS to each version's output directory
for version in "${VERSIONS[@]}"; do
  echo "Adding unified theme to $version..."
  cp assets/design/unified-theme.css specification/$version/css/style.css
  cp assets/design/tokens.css specification/$version/css/tokens.css
done

# Copy unified theme CSS to governance output directory
echo "Adding unified theme to governance..."
mkdir -p governance/css
cp assets/design/unified-theme.css governance/css/style.css
cp assets/design/tokens.css governance/css/tokens.css

# Copy governance files
cp -r .tmp_gov/* governance/

# Add version selector to all HTML files in each version
for version in "${VERSIONS[@]}"; do
  echo "Adding version selector to $version HTML files..."
  
  # Update the HTML to include version selector assets
  find specification/$version -name "*.html" -exec sed -i 's|<link href="css/style.css" rel="stylesheet" />|<link href="css/style.css" rel="stylesheet" />\n        <link href="css/version-select.css" rel="stylesheet" />|g' {} \;
  find specification/$version -name "*.html" -exec sed -i 's|<link href="../css/style.css" rel="stylesheet" />|<link href="../css/style.css" rel="stylesheet" />\n        <link href="../css/version-select.css" rel="stylesheet" />|g' {} \;
  find specification/$version -name "*.html" -exec sed -i 's|<link href="./css/style.css" rel="stylesheet" />|<link href="./css/style.css" rel="stylesheet" />\n        <link href="./css/version-select.css" rel="stylesheet" />|g' {} \;
  find specification/$version -name "*.html" -exec sed -i 's|<script src="js/theme.js"></script>|<script src="js/theme.js"></script>\n      <script src="js/version-select.js" defer></script>|g' {} \;
  find specification/$version -name "*.html" -exec sed -i 's|<script src="../js/theme.js"></script>|<script src="../js/theme.js"></script>\n      <script src="../js/version-select.js" defer></script>|g' {} \;
  find specification/$version -name "*.html" -exec sed -i 's|<script src="./js/theme.js"></script>|<script src="./js/theme.js"></script>\n      <script src="./js/version-select.js" defer></script>|g' {} \;
done

# Create specification index.html with redirect to latest version
cat > specification/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>SWHID Specification</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="refresh" content="0; url=$LATEST_VERSION/">
    <script>
        window.location.href = "$LATEST_VERSION/";
    </script>
</head>
<body>
    <p>Redirecting to <a href="$LATEST_VERSION/">latest version</a>...</p>
</body>
</html>
EOF

# Build Jekyll (aggregated content will be preserved)
echo "Building Jekyll site..."
bundle exec jekyll build

# Generate Pagefind search index
if command -v npx >/dev/null 2>&1; then
  echo "Generating Pagefind search index..."
  npx pagefind --site _site
  echo "Pagefind index generated in _site/pagefind/"
else
  echo "Warning: npx not found, skipping Pagefind index generation"
  echo "Install Node.js to enable search functionality"
fi

echo "=== Bootstrap Complete ==="
echo "Specification versions built: ${VERSIONS[*]}"
echo "Latest version: $LATEST_VERSION"
echo "Version selector added to all specification pages"
echo "Unified theme applied to all versions"
echo "Build complete! Run: bundle exec jekyll serve --livereload"
