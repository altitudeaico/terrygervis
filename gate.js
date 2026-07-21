/* Soft password gate for the private preview.
   Note: this is client-side only. It keeps casual visitors out, but the page
   files remain public on GitHub, so it is not real encryption. */
(function () {
  var PW = "potc2026";
  var KEY = "ac_gate_v1";
  var root = document.documentElement;

  // Already unlocked this session — reveal and stop.
  try {
    if (sessionStorage.getItem(KEY) === "1") { root.classList.remove("gated"); return; }
  } catch (e) {}

  var EYE_OPEN =
    '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>';
  var EYE_OFF =
    '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/></svg>';

  var SEAL =
    '<svg class="seal" viewBox="0 0 100 100" aria-hidden="true"><defs><linearGradient id="gseal" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#E4C976"/><stop offset="1" stop-color="#B98A2E"/></linearGradient></defs><circle cx="50" cy="50" r="46" fill="none" stroke="url(#gseal)" stroke-width="1.5"/><circle cx="50" cy="50" r="38" fill="none" stroke="url(#gseal)" stroke-width="1" opacity=".6"/><path d="M50 16l3.2 9.8H63l-7.9 5.8 3 9.8L50 35.4l-8.1 6 3-9.8-7.9-5.8h9.8z" fill="url(#gseal)"/></svg>';

  function build() {
    var ov = document.createElement("div");
    ov.id = "gate";
    ov.innerHTML =
      '<div class="card">' +
        SEAL +
        "<h2>The Ascent Collection</h2>" +
        "<p>Private preview. Please enter the password to continue.</p>" +
        '<div class="field">' +
          '<input id="gpw" type="password" placeholder="Password" autocomplete="off" autocapitalize="off" autocorrect="off" spellcheck="false" aria-label="Password">' +
          '<button class="eye" id="geye" type="button" aria-label="Show password">' + EYE_OPEN + "</button>" +
        "</div>" +
        '<button class="enter" id="genter" type="button">Enter</button>' +
        '<div class="err" id="gerr">That password did not match. Please try again.</div>' +
      "</div>";
    document.body.appendChild(ov);

    var inp = ov.querySelector("#gpw");
    var eye = ov.querySelector("#geye");
    var btn = ov.querySelector("#genter");
    var err = ov.querySelector("#gerr");
    var shown = false;

    setTimeout(function () { inp.focus(); }, 40);

    // Show / hide password characters.
    eye.addEventListener("click", function () {
      shown = !shown;
      inp.type = shown ? "text" : "password";
      eye.innerHTML = shown ? EYE_OFF : EYE_OPEN;
      eye.setAttribute("aria-label", shown ? "Hide password" : "Show password");
      inp.focus();
    });

    function submit() {
      if (inp.value === PW) {
        try { sessionStorage.setItem(KEY, "1"); } catch (e) {}
        root.classList.remove("gated");
        ov.parentNode && ov.parentNode.removeChild(ov);
      } else {
        err.classList.add("show");
        inp.select();
      }
    }

    btn.addEventListener("click", submit);
    inp.addEventListener("keydown", function (e) {
      if (e.key === "Enter") submit();
      else err.classList.remove("show");
    });
  }

  if (document.body) build();
  else document.addEventListener("DOMContentLoaded", build);
})();
