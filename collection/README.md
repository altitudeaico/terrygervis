# Legacy & Heritage — Pilots of the Caribbean x Tuskegee Airmen

Static HTML, CSS and one small JS file. No build step, no dependencies.
Open index.html in a browser.

Covers pages 1 to 14 of Reginald's v6 outline, on a single continuous
journey: hero, film slot, the shared story, women at war, the collection,
craftsmanship, first edition and price, our mission, Terry Jervis, the
RAF magazine article, the closing salute, registration.

## The press slot (page 9)

The RAF Magazine 128 article is a panel waiting on the supplied PDF. Put
its path into data-pdf and a download panel replaces the placeholder:

    <div class="press-slot" data-pdf="assets/raf-128-article.pdf">

## The closing salute (page 14)

Built from the client's own closing page: RAF and USAF, the two brand
marks, the trans-Atlantic line and the contact details. The Rolls-Royce
and Bentley marks that appear on his version are deliberately NOT placed,
pending written clearance. The files sit in assets/ ready to drop in.

## Locked facts (do not change without checking Supabase tj_fact)

- 500 sets in the first edition; 1,000 ever produced worldwide
- Pre-sale GBP 1,500 / USD 1,999, post free, one per household
- Coins 38mm, 50g, 5mm, 24ct gold finish on bronze
- Allow six weeks for the bespoke process from purchase date
- Registration captures name, phone, email. No payment at this stage.

The 9,999 figure, the GBP 1,200 + VAT price and the old certificate spec
(36mm, 39.9g, sterling silver) are superseded and appear nowhere.

## Deliberately not asserted

- Contents count. The copy doc lists nine items, the supplied banner says
  ten. The page shows the supplied artwork without stating a number.
- Merlin engine year. Sources say 1940s, 1943 and 1944. The page does not
  name a year.
- Statuettes. Present only in the older v5 FAQ. Left out.
- Investment and value-appreciation language. Left out entirely.

## The video slot

Page 2 of the outline has a VIDEO panel. The section is built and waiting
on a hosting URL. To activate it, put a YouTube or Vimeo id into the
data-embed attribute:

    <div class="video-frame" data-embed="dQw4w9WgXcQ">

Numeric ids load Vimeo, anything else loads YouTube. That is the only
change needed. The two supplied mp4 files (40MB combined) are not in the
repo; host them externally and use the id.

## Assets

All 16 images are Reginald's own, optimised to max 1600px wide.
7.4MB total, down from 21MB. The hero loads eagerly, everything else is
lazy loaded.

Two are AI-generated placeholders standing in for real product
photography: hero-collection.jpg and presentation.jpg.

The founder portrait is an empty slot awaiting a supplied image.

Full Drive-to-repo mapping is in Supabase, table tj_asset_map.

## Cache-busting on styles.css and script.js

Both are linked as `styles.css?v=N` / `script.js?v=N` in index.html.
GitHub Pages' CDN (and browsers) can otherwise keep serving a stale
copy of these two files even after a fresh push, while index.html
itself updates fine and small direct-image-src changes work
correctly since those get new filenames. Symptom looks like "the
HTML changed but old styling/behaviour is still showing." Whenever
you edit styles.css or script.js, bump the `?v=N` number in both
places in index.html in the same commit.

## Before this can go live

- Hosting destination. GoDaddy is not being renewed and the contents were
  reported missing on 13 September. Nothing here depends on the platform:
  relative paths, no build step, deploys anywhere.
- Written clearance for the Lena Horne and Mona Baptiste photography, and
  for the Rolls-Royce and Bentley marks and support wording. The Bentley
  file is named "logo_example" in the source, so confirm it is the
  approved mark. Neither partner logo is currently placed on the page.
- Real contact addresses and the GoHighLevel form endpoint. The form
  currently validates and shows a confirmation message only.
- The remaining Terry pages from Reginald.
