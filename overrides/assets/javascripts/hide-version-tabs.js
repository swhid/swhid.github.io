// Hide any top tab whose label looks like a version (vX.Y[.Z]) or is "dev".
document.addEventListener("DOMContentLoaded", () => {
  const VERSION_RE = /^v\d+\.\d+(?:\.\d+)?$/i;
  document.querySelectorAll(".md-tabs__list .md-tabs__item").forEach((item) => {
    const a = item.querySelector("a");
    if (!a) return;
    const label = (a.textContent || "").trim();
    if (VERSION_RE.test(label) || label.toLowerCase() === "dev") {
      item.classList.add("swhid-hidden-tab");
    }
  });
});
