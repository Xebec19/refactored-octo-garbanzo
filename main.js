// main.js - adds interactivity and improves user experience
document.addEventListener("DOMContentLoaded", function () {
  // Set current year for copyright text
  const yearEl = document.getElementById("current-year");
  if (yearEl) {
    yearEl.textContent = new Date().getFullYear();
  }

  // Add page load time for performance monitoring
  window.addEventListener("load", function () {
    const loadTime = performance.now();
    console.log("Page load time:", Math.round(loadTime), "ms");
  });

  // Track outbound links for analytics
  document
    .querySelectorAll('a[href^="http"], a[href^="https://api.whatsapp.com"]')
    .forEach((link) => {
      link.addEventListener("click", function (e) {
        const url = this.getAttribute("href");
        if (window.clarity) {
          window.clarity("set", "outbound_click", url);
        }
      });
    });
});

(function (c, l, a, r, i, t, y) {
  c[a] =
    c[a] ||
    function () {
      (c[a].q = c[a].q || []).push(arguments);
    };
  t = l.createElement(r);
  t.async = 1;
  t.src = "https://www.clarity.ms/tag/" + i;
  y = l.getElementsByTagName(r)[0];
  y.parentNode.insertBefore(t, y);
})(window, document, "clarity", "script", "rzarhfrlox");

(function (w, d, s, l, i) {
  w[l] = w[l] || [];
  w[l].push({ "gtm.start": new Date().getTime(), event: "gtm.js" });
  var f = d.getElementsByTagName(s)[0],
    j = d.createElement(s),
    dl = l != "dataLayer" ? "&l=" + l : "";
  j.async = true;
  j.src = "https://www.googletagmanager.com/gtm.js?id=" + i + dl;
  f.parentNode.insertBefore(j, f);
})(window, document, "script", "dataLayer", "GTM-W3R3Z7DZ");
