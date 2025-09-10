// Generate a random nonce
function generateNonce() {
  const array = new Uint8Array(16);
  crypto.getRandomValues(array);
  return btoa(String.fromCharCode.apply(null, array));
}

// Add nonce to the CSP header
const nonce = generateNonce();
const meta = document.createElement("meta");
meta.httpEquiv = "Content-Security-Policy";
meta.content = `script-src 'self' 'nonce-${nonce}' https://www.clarity.ms https://www.googletagmanager.com/gtm.js https://www.googletagmanager.com/ns.html https://scripts.clarity.ms https://cdn.tailwindcss.com`;
document.head.insertBefore(meta, document.head.firstChild);

// Add nonce to all script tags
document.querySelectorAll("script").forEach((script) => {
  script.nonce = nonce;
});
