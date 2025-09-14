#!/usr/bin/env bash
set -euo pipefail

# Read pins (or allow overrides via env)
read_ref () { ruby -ryaml -e "p YAML.load_file('sources.lock.yml').dig('$1','ref')" ; }
SPEC_REF="${SPEC_REF:-$(read_ref spec)}"
GOV_REF="${GOV_REF:-$(read_ref gov)}"
DSN_REF="${DSN_REF:-$(read_ref design)}"

mkdir -p .ext
[ -d .ext/spec ]   || git clone https://github.com/swhid/specification .ext/spec
[ -d .ext/gov ]    || git clone https://github.com/swhid/governance    .ext/gov
[ -d .ext/design ] || git clone https://github.com/swhid/swhid-design  .ext/design
(cd .ext/spec && git fetch --all && git checkout "$SPEC_REF" || git checkout main)
(cd .ext/gov  && git fetch --all && git checkout "$GOV_REF"  || git checkout main)
(cd .ext/design && git fetch --all && git checkout "$DSN_REF" || git checkout main)

python3 -m venv .venv && . .venv/bin/activate
pip install -U pip mkdocs mkdocs-material

# Design assets are now centralized at site root and accessed via absolute paths
# No need to copy assets to individual subsites

# Build multiple specification versions with mike-style version management
echo "Building specification versions with mike-style version selector..."
rm -rf specification .tmp_spec_*

# Create specification directory structure first
mkdir -p specification

# Create versions.json for mike-style version management
cat > specification/versions.json << 'EOF'
[
  {
    "version": "v1.0",
    "title": "v1.0",
    "aliases": []
  },
  {
    "version": "v1.1", 
    "title": "v1.1",
    "aliases": []
  },
  {
    "version": "v1.2",
    "title": "v1.2 (latest)",
    "aliases": ["latest"]
  }
]
EOF

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

# Build v1.0
echo "Building specification v1.0..."
(cd .ext/spec && git checkout v1.0)
# Apply unified theme after checkout
mkdir -p .ext/spec/css
cp assets/design/unified-theme.css .ext/spec/css/style.css
# tokens.css is now accessed via absolute path from unified-theme.css
(cd .ext/spec && mkdocs build -d ../../.tmp_spec_v1.0)

# Build v1.1  
echo "Building specification v1.1..."
(cd .ext/spec && git checkout v1.1)
# Apply unified theme after checkout
mkdir -p .ext/spec/css
cp assets/design/unified-theme.css .ext/spec/css/style.css
# tokens.css is now accessed via absolute path from unified-theme.css
(cd .ext/spec && mkdocs build -d ../../.tmp_spec_v1.1)

# Build v1.2 (latest)
echo "Building specification v1.2..."
(cd .ext/spec && git checkout v1.2)
# Apply unified theme after checkout
mkdir -p .ext/spec/css
cp assets/design/unified-theme.css .ext/spec/css/style.css
# tokens.css is now accessed via absolute path from unified-theme.css
(cd .ext/spec && mkdocs build -d ../../.tmp_spec_v1.2)

# Build governance
echo "Building governance..."
# Apply unified theme to governance
mkdir -p .ext/gov/css
cp assets/design/unified-theme.css .ext/gov/css/style.css
# tokens.css is now accessed via absolute path from unified-theme.css
(cd .ext/gov && mkdocs build -d ../../.tmp_gov)

# Create specification directory structure
mkdir -p specification
mv .tmp_spec_v1.0 specification/v1.0
mv .tmp_spec_v1.1 specification/v1.1  
mv .tmp_spec_v1.2 specification/v1.2

# Copy unified theme CSS to each version's output directory
for version in v1.0 v1.1 v1.2; do
  echo "Adding unified theme to $version..."
  cp assets/design/unified-theme.css specification/$version/css/style.css
  # tokens.css is now accessed via absolute path from unified-theme.css
done

# Copy unified theme CSS to governance output directory
echo "Adding unified theme to governance..."
mkdir -p governance/css
cp assets/design/unified-theme.css governance/css/style.css
# tokens.css is now accessed via absolute path from unified-theme.css

# Copy version selector assets to each version
for version in v1.0 v1.1 v1.2; do
  echo "Adding version selector to $version..."
  cp specification/css/version-select.css specification/$version/css/
  cp specification/js/version-select.js specification/$version/js/
  
  # Update the HTML to include version selector assets
  find specification/$version -name "*.html" -exec sed -i 's|<link href="css/style.css" rel="stylesheet" />|<link href="css/style.css" rel="stylesheet" />\n        <link href="css/version-select.css" rel="stylesheet" />|g' {} \;
  find specification/$version -name "*.html" -exec sed -i 's|<link href="../css/style.css" rel="stylesheet" />|<link href="../css/style.css" rel="stylesheet" />\n        <link href="../css/version-select.css" rel="stylesheet" />|g' {} \;
  find specification/$version -name "*.html" -exec sed -i 's|<link href="./css/style.css" rel="stylesheet" />|<link href="./css/style.css" rel="stylesheet" />\n        <link href="./css/version-select.css" rel="stylesheet" />|g' {} \;
  find specification/$version -name "*.html" -exec sed -i 's|<script src="js/theme.js"></script>|<script src="js/theme.js"></script>\n      <script src="js/version-select.js" defer></script>|g' {} \;
  find specification/$version -name "*.html" -exec sed -i 's|<script src="../js/theme.js"></script>|<script src="../js/theme.js"></script>\n      <script src="../js/version-select.js" defer></script>|g' {} \;
  find specification/$version -name "*.html" -exec sed -i 's|<script src="./js/theme.js"></script>|<script src="./js/theme.js"></script>\n      <script src="./js/version-select.js" defer></script>|g' {} \;
done

# Create redirect page to latest version
cat > specification/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>SWHID Specification</title>
    <meta charset="utf-8">
    <meta http-equiv="refresh" content="0; url=v1.2/">
    <script>
        // Fallback redirect
        window.location.href = "v1.2/";
    </script>
</head>
<body>
    <p>Redirecting to <a href="v1.2/">latest version</a>...</p>
</body>
</html>
EOF

# Move governance
rm -rf governance
mv .tmp_gov governance

echo "MkDocs outputs ready under ./specification and ./governance"

# Build Jekyll (aggregated content will be preserved)
bundle install
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

echo "Build complete! Run: bundle exec jekyll serve --livereload"
