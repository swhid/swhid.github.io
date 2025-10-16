(function () {
  // Avoid double-initialization
  if (window.__pf_header_loaded) return;
  window.__pf_header_loaded = true;

  function ensureScript(src) {
    return new Promise((resolve, reject) => {
      if (window.PagefindUI) return resolve();
      const s = document.createElement('script');
      s.src = src;
      s.defer = true;
      s.onload = resolve;
      s.onerror = reject;
      document.head.appendChild(s);
    });
  }

  function ready(fn) {
    if (document.readyState === "loading") {
      document.addEventListener("DOMContentLoaded", fn, { once: true });
    } else {
      fn();
    }
  }

  ready(async function () {
    // Insert the container in the center of the header toolbar
    const headerInner =
      document.querySelector(".md-header__inner") || document.querySelector(".md-header");
    if (!headerInner) return;

    // If Material search exists (in case someone turns it back on), remove it
    const matSearch = headerInner.querySelector(".md-search");
    if (matSearch) matSearch.remove();

    // Create Pagefind header host
    const host = document.createElement("div");
    host.id = "pf-header";
    host.innerHTML = `<div id="pf-header-ui" class="pf-header-ui"></div>`;
    
    // Insert in the center - after the title but before the GitHub link
    const title = headerInner.querySelector(".md-header__title");
    const source = headerInner.querySelector(".md-header__source");
    
    if (title && source) {
      // Insert between title and source
      title.parentNode.insertBefore(host, source);
    } else {
      // Fallback: append to end
      headerInner.appendChild(host);
    }

    // Ensure Pagefind UI bundle is available on every page
    let BASE = (window.__BASE_URL__ || "").replace(/\/+$/, "");
    BASE = BASE === "." ? "" : BASE + "/";
    try {
      await ensureScript(`${BASE}pagefind/pagefind-ui.js`);
    } catch (e) {
      console.warn("Pagefind UI script not found");
      return;
    }

    // Initialize Pagefind UI directly in the header.
    // It will render its own input + live results dropdown.
    /* global PagefindUI */
    const pagefind = new PagefindUI({
      element: "#pf-header-ui",
      showSubResults: true,
      showImages: false,
      showFilters: ["section", "spec_version", "tag"],
      translations: { placeholder: "Search SWHID.org" },
    });

    // --- helpers ---
    function getDrawer(host) {
      return host.querySelector(".pagefind-ui__drawer");
    }
    function isDrawerOpen(drawer) {
      if (!drawer) return false;
      return !drawer.classList.contains("pagefind-ui__hidden");
    }
    function applyExpanded(host) {
      const open = isDrawerOpen(getDrawer(host));
      host.classList.toggle("expanded", open);
    }

    // --- attribute observer for a given drawer ---
    function bindDrawerAttributeObserver(host, drawer) {
      const attrObserver = new MutationObserver(() => applyExpanded(host));
      attrObserver.observe(drawer, {
        attributes: true,
        attributeFilter: ["hidden", "style", "class"],
      });
      // Sync once
      applyExpanded(host);
      return attrObserver;
    }

    // --- reattach whenever Pagefind re-renders the drawer ---
    let drawerAttrObserver = null;
    const reattachObserver = new MutationObserver(() => {
      const drawer = getDrawer(host);
      if (!drawer) {
        applyExpanded(host);
        return;
      }
      // If we already observe THIS drawer, skip
      if (drawerAttrObserver && drawerAttrObserver._drawer === drawer) return;
      // Disconnect old
      if (drawerAttrObserver) drawerAttrObserver.disconnect();
      // Bind new
      drawerAttrObserver = bindDrawerAttributeObserver(host, drawer);
      drawerAttrObserver._drawer = drawer;
      applyExpanded(host);
    });

    // Start listening for child/subtree changes inside the host UI
    reattachObserver.observe(host, { childList: true, subtree: true });
    // Also run once at init (in case the drawer already exists)
    applyExpanded(host);

    // Close dropdown on outside click and resync width
    document.addEventListener("pointerdown", (ev) => {
      const ui = document.querySelector("#pf-header-ui");
      if (!ui) return;
      const drawer = ui.querySelector(".pagefind-ui__drawer");
      if (!drawer) return;

      if (host.contains(ev.target) || drawer.contains(ev.target)) return;
      applyExpanded(host);
    });

    // Press "/" to focus search, like GitHub
    document.addEventListener("keydown", (e) => {
      if (e.key === "/" && !/input|textarea|select/i.test(document.activeElement.tagName)) {
        e.preventDefault();
        const input = document.querySelector("#pf-header-ui input[type='text']");
        if (input) input.focus();
      }
    });
  });
})();
