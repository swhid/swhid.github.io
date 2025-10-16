// Hide any top tab whose label looks like a version (vX.Y[.Z]) or is "dev".
document.addEventListener("DOMContentLoaded", () => {
  const VERSION_RE = /^v\d+\.\d+(?:\.\d+)?$/i;
  
  // Hide from horizontal navigation tabs
  document.querySelectorAll(".md-tabs__list .md-tabs__item").forEach((item) => {
    const a = item.querySelector("a");
    if (!a) return;
    const label = (a.textContent || "").trim();
    if (label == "Specification") {
      // specification nav menu entry should always be visible
      a.style.setProperty("display", "block", "important");
    } else if (VERSION_RE.test(label) || label.toLowerCase() === "dev") {
      item.classList.add("swhid-hidden-tab");
    }
  });
  
  // Hide from mobile sidebar navigation
  document.querySelectorAll(".md-nav--primary .md-nav__item").forEach((item) => {
    const a = item.querySelector("a");
    const span = item.querySelector("span.md-ellipsis");
    for (let elt of [a, span]) {
      if (!elt) continue;
      const label = (elt.textContent || "").trim();
      if (VERSION_RE.test(label) || label.toLowerCase() === "dev") {
        item.classList.add("swhid-hidden-nav");
        return;
      }
    }
  });
});
