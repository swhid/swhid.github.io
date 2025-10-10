(function () {
  console.log("🔍 Pagefind Header Debug: Script starting...");
  
  // Avoid double-initialization
  if (window.__pf_header_loaded) {
    console.log("🔍 Pagefind Header Debug: Already loaded, skipping");
    return;
  }
  window.__pf_header_loaded = true;

  function ensureScript(src) {
    return new Promise((resolve, reject) => {
      if (window.PagefindUI) {
        console.log("🔍 Pagefind Header Debug: PagefindUI already available");
        return resolve();
      }
      console.log("🔍 Pagefind Header Debug: Loading PagefindUI from", src);
      const s = document.createElement('script');
      s.src = src;
      s.defer = true;
      s.onload = () => {
        console.log("🔍 Pagefind Header Debug: PagefindUI loaded successfully");
        resolve();
      };
      s.onerror = (e) => {
        console.error("🔍 Pagefind Header Debug: Failed to load PagefindUI", e);
        reject(e);
      };
      document.head.appendChild(s);
    });
  }

  function ready(fn) {
    if (document.readyState === "loading") {
      console.log("🔍 Pagefind Header Debug: Waiting for DOMContentLoaded");
      document.addEventListener("DOMContentLoaded", fn, { once: true });
    } else {
      console.log("🔍 Pagefind Header Debug: DOM already ready, running immediately");
      fn();
    }
  }

  ready(async function () {
    console.log("🔍 Pagefind Header Debug: DOM ready, starting initialization...");
    
    // Insert the container at the end of the header toolbar
    const headerInner =
      document.querySelector(".md-header__inner") || document.querySelector(".md-header");
    
    if (!headerInner) {
      console.error("🔍 Pagefind Header Debug: Could not find header container!");
      return;
    }
    
    console.log("🔍 Pagefind Header Debug: Found header container:", headerInner);

    // If Material search exists (in case someone turns it back on), remove it
    const matSearch = headerInner.querySelector(".md-search");
    if (matSearch) {
      console.log("🔍 Pagefind Header Debug: Removing existing Material search");
      matSearch.remove();
    }

    // Create Pagefind header host
    const host = document.createElement("div");
    host.id = "pf-header";
    host.innerHTML = `<div id="pf-header-ui" class="pf-header-ui"></div>`;
    headerInner.appendChild(host);
    
    console.log("🔍 Pagefind Header Debug: Created Pagefind container:", host);

    // Ensure Pagefind UI bundle is available on every page
    try {
      await ensureScript("/pagefind/pagefind-ui.js");
    } catch (e) {
      console.error("🔍 Pagefind Header Debug: Pagefind UI script not found at /pagefind/pagefind-ui.js", e);
      return;
    }

    // Initialize Pagefind UI directly in the header.
    // It will render its own input + live results dropdown.
    console.log("🔍 Pagefind Header Debug: Initializing PagefindUI...");
    try {
      /* global PagefindUI */
      new PagefindUI({
        element: "#pf-header-ui",
        bundlePath: "/pagefind/",
        baseUrl: "/",
        showSubResults: true,
        showImages: false,
        showFilters: ["section", "spec_version", "tag"],
        translations: { placeholder: "Search SWHID.org" },
      });
      console.log("🔍 Pagefind Header Debug: PagefindUI initialized successfully!");
    } catch (error) {
      console.error("🔍 Pagefind Header Debug: PagefindUI initialization failed:", error);
    }

    // Close dropdown when clicking outside header
    document.addEventListener("click", (ev) => {
      const ui = document.querySelector("#pf-header-ui");
      if (!ui) return;
      const drawer = ui.querySelector(".pagefind-ui__drawer");
      if (!drawer) return;
      if (!host.contains(ev.target)) {
        drawer.setAttribute("hidden", "");
      }
    });
    
    console.log("🔍 Pagefind Header Debug: Setup complete!");
  });
})();
