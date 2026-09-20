document.getElementById('interestForm').addEventListener('submit',function(e){e.preventDefault();document.getElementById('status').textContent='Prototype only — Growth Lab connection will be wired in the next build pass.';});
/* Mobile nav: hamburger toggle for the section-link dropdown. */
(function () {
  var toggle = document.getElementById('menuToggle');
  var header = document.querySelector('.nav');
  var links = document.getElementById('navLinks');
  if (!toggle || !header || !links) return;
  function closeMenu() {
    header.classList.remove('menu-open');
    toggle.setAttribute('aria-expanded', 'false');
  }
  toggle.addEventListener('click', function () {
    var isOpen = header.classList.toggle('menu-open');
    toggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
  });
  links.querySelectorAll('a').forEach(function (a) {
    a.addEventListener('click', closeMenu);
  });
  window.addEventListener('resize', function () {
    if (window.innerWidth > 900) closeMenu();
  });
})();
/* Video slot: set data-embed on .video-frame to a YouTube or Vimeo id and the
   player replaces the placeholder. Nothing else needs changing. */
(function () {
  var f = document.querySelector('.video-frame');
  if (!f) return;
  var id = (f.getAttribute('data-embed') || '').trim();
  if (!id) return;
  var src = /^\d+$/.test(id)
    ? 'https://player.vimeo.com/video/' + id
    : 'https://www.youtube-nocookie.com/embed/' + id;
  var i = document.createElement('iframe');
  i.src = src;
  i.title = 'Promotional film';
  i.allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; picture-in-picture';
  i.allowFullscreen = true;
  f.innerHTML = '';
  f.appendChild(i);
})();

/* Press slot: set data-pdf on .press-slot to the article PDF path and a
   download panel replaces the placeholder. */
(function () {
  var s = document.querySelector('.press-slot');
  if (!s) return;
  var src = (s.getAttribute('data-pdf') || '').trim();
  if (!src) return;
  s.innerHTML =
    '<div class="press-live"><span class="doc">128</span>' +
    '<p>Royal Air Force annual magazine</p>' +
    '<a class="btn" href="' + src + '" target="_blank" rel="noopener">Read the article</a></div>';
})();
