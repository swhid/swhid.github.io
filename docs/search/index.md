---
title: Search
hide:
  - toc
---

<div id="pagefind-search"></div>

<script>
(function () {
  const BASE = (window.__BASE_URL__ || "").replace(/\/+$/, "");
  const ROOT = BASE === "." ? "" : BASE;
  const ensure = (href, tag, attr) => {
    return new Promise((res, rej) => {
      if (tag === "script" && window.PagefindUI) return res();
      const el = document.createElement(tag);
      el[attr] = href;
      if (tag === "script") el.defer = true;
      el.onload = res; el.onerror = rej;
      document.head.appendChild(el);
    });
  };

  const init = () => {
    /* global PagefindUI */
    const ui = new PagefindUI({
      element: "#pagefind-search",
      bundlePath: `${ROOT}/pagefind/`,
      baseUrl: `${ROOT}/`,
      showSubResults: true,
      showImages: false,
      showFilters: ["section","spec_version","tag"],
      translations: { placeholder: "Search SWHID.org" }
    });
    // Seed query from ?q=
    const params = new URLSearchParams(location.search);
    const q = params.get("q");
    if (q) {
      const input = document.querySelector("#pagefind-search input[type='text']");
      if (input) { input.value = q; input.dispatchEvent(new Event("input", { bubbles: true })); }
    }
  };

  Promise.all([
    ensure(`${ROOT}/pagefind/pagefind-ui.css`, "link", "href"),
    ensure(`${ROOT}/pagefind/pagefind-ui.js`, "script", "src")
  ]).then(init);
})();
</script>