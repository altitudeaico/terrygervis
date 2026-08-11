# Ascent v3 — "The Museum of Screens" · Flow scene pack (Ezra + display surfaces)

**The concept.** Ezra carries the whole film, in different locations. The
product content (coins, aircraft, artefacts, the offer) no longer cuts in
as flat slides — it plays **on a big surface inside Ezra's scene** (a
gallery video wall, a billboard, a display screen). I composite our real
content onto those surfaces afterwards, so it's motivated and cinematic,
and I sync each surface to the exact voice-over line.

---

## THE ONE RULE that makes compositing work
Every screen scene must give me a **clean, empty surface to insert onto:**

1. **Leave the screen BLANK.** Render the display as a flat, evenly-lit
   panel in a **plain mid-tone (a dull charcoal-blue), or chroma green if
   your tool keys cleanly** — with **no content on it.** I add the content.
2. **Lock the camera** (or the slowest possible drift). A static or barely
   moving shot lets me pin the content to the panel rock-solid. Big camera
   moves across the screen are the hard case — avoid for these shots.
3. **Face the surface** roughly front-on and keep it **unobstructed** —
   Ezra stands beside / just in front of the edge, not blocking the middle.
4. Give the panel a **visible border/bezel** and clear corners so its shape
   reads. A gentle existing glow/lightspill from the panel is welcome.

If you'd rather, drop a bright-green rectangle where the screen goes — that's
the easiest for me to key. Otherwise the plain dull panel is fine.

**Keep Ezra consistent** — use the `ezra-ref-portrait/full` images as the
character reference in every scene.

---

## The scenes (5 new to generate) — each ~8–10s, 16:9, highest res

We already have **s1-keeper** (open) and **s8-handover** (close) — keep both.

| VO | Location for Ezra | The surface | What I insert on it |
|---|---|---|---|
| **s3** 0:16 "Introducing the Personalised Museum… Pilots of the Caribbean, Tuskegee Airmen… Rolls-Royce & Bentley" | Grand dim gallery, Ezra walks in | a huge **video wall** | the heroes (living photo) + RR/Bentley plate |
| **s4** 0:27 "two 38mm 24-carat gold coins" | Ezra beside a lit plinth | a tall **display screen** | the coins, macro |
| **s5** 0:44 "Spitfire, Mustang, Lancaster, B-17… Lena Horne, Mona Baptiste" | Ezra in a screening room / on a rooftop | a **cinema screen or billboard** | the aircraft ascent, then the two women |
| **s6** 0:57 "Merlin artefact… Jamaica Spitfire Fund… Royal Warrant" | Ezra at a museum case | a **display screen** in the case | the Merlin relic, comic replica, certificate |
| **s7** 1:13 "Only 500 sets… £1,500 / $1,999" | Ezra beside it, looking to camera | a bold **billboard** | the box + "500 of 500" + the price |

---

## STYLE SUFFIX — paste on the end of every prompt (keeps all scenes matched)
> Cinematic heritage-luxury look: deep navy near-black shadows, warm
> tungsten and brass lamplight, volumetric haze, gold and oxblood accents,
> shallow depth of field, filmic grain. The large display panel is a flat,
> evenly-lit blank surface in a dull charcoal-blue (no content on it),
> front-on, unobstructed, with a clear border; locked/static camera. A
> well-dressed older Black gentleman (use Ezra reference) stands beside the
> panel, not blocking it. Photoreal, 24fps, 16:9. No text, no logos, no
> watermarks.

## The five prompts

**s3 — Gallery video wall**
> A grand, dark private museum gallery. An elegant older gentleman (Ezra)
> walks slowly in from the side and stops, looking toward a very large
> blank display wall that dominates one end of the room; brass uplighters,
> glass cases and framed portraits in the shadows; dust in the light.
> [+ STYLE SUFFIX]

**s4 — Display plinth screen**
> An intimate dark exhibition alcove. Ezra stands beside a tall, lit glass
> plinth topped by a large blank vertical display panel; a soft pool of
> warm light on him, deep shadow around; he regards the panel with quiet
> pride. [+ STYLE SUFFIX]

**s5 — Screening room / billboard**
> A private screening room, Ezra seated or standing before an enormous
> blank cinema screen that fills the frame behind him, the projector beam
> cutting through haze; or alternatively a night rooftop with Ezra beside a
> huge blank billboard, city glow below. Reverent, epic scale.
> [+ STYLE SUFFIX]

**s6 — Museum case screen**
> Ezra leans in at a long museum display case; set into the case back is a
> large blank illuminated panel; raking warm light, brass fittings, deep
> navy shadow, his reflection faint in the glass. [+ STYLE SUFFIX]

**s7 — Billboard / offer**
> Ezra stands beside a bold, large blank billboard-style panel in a dark
> gallery atrium, looking directly to camera with a knowing, dignified
> expression; dramatic single-source light, haze, gold accents.
> [+ STYLE SUFFIX]

---

## What I do when these come back
For each scene I **corner-pin our content onto the blank panel**, then give
it a screen treatment so it reads as a real display — subtle bezel, faint
scanlines, a soft bloom and light-spill onto the room, graded to match the
scene. Then I cut Ezra's scenes to the locked VO + score, sync each screen
to its line, add the endcard, fix the emblem + stereo. That's the master.

**Drop the 5 clips in Drive `film-src` as** `s3-wall.mp4`, `s4-plinth.mp4`,
`s5-screen.mp4`, `s6-case.mp4`, `s7-billboard.mp4`.

---

# v4 revisions (after v3 review) — two fixes

## FIX 1 — Ezra must NEVER block the screen
Only **s3-wall** failed this (his back was in front of the panel). Rule for
every screen scene, reinforced:
> Ezra stands well to ONE SIDE (left or right third), profile or
> three-quarter, looking toward the panel — **never between the camera and
> the panel.** The ENTIRE display surface is visible, front-on, and
> unobstructed. Nothing crosses in front of the screen.

**Regenerate s3-wall** with this prompt:
> A grand dark private museum gallery. A distinguished older gentleman
> (Ezra) stands to the LEFT of frame, in three-quarter profile, looking
> toward a very large blank display wall that fills the right two-thirds of
> the frame — the whole panel visible and unobstructed. Brass uplighters,
> glass cases and portraits in shadow, dust in the light. [+ STYLE SUFFIX]

## FIX 2 — screens must show exactly what the VO names, in order
The composite can play a short SEQUENCE on a screen. What each needs:

- **s4 coins** — sharper if the **turntable .movs** are re-exported **under
  10 MB** (the connector can't pull >10 MB); otherwise I keep the reveal coins.
- **s5** — must show, timed to the words: **Spitfire → Mustang P-51D →
  Lancaster → B-17 → Lena Horne → Mona Baptiste.** I have Spitfire+Mustang.
  **Please provide:**
  - **Lancaster** and **B-17** — generate in Flow (prompts below).
  - **Lena Horne** and **Mona Baptiste** — supply REAL archival photographs
    (they are real people; we animate real photos, never fabricate them).
- **s6** — I'll re-cut from the reveal to show **Merlin engine relic →
  comic-book replica → Royal Warrant certificate**, in that order (all
  present in Reg's footage). No new asset needed.

### Flow prompts for the two missing aircraft (image or image-to-video)
**Lancaster:**
> A four-engine Avro Lancaster heavy bomber in flight through dramatic
> golden-hour cloud, three-quarter view, propellers turning, sunlight on
> the fuselage, volumetric light, epic and dignified, photoreal, 35mm film
> look, fine grain, 16:9. No text, no watermark.

**B-17:**
> A B-17 Flying Fortress in flight through towering sunlit clouds,
> three-quarter view, four propellers turning, sun glinting off polished
> aluminium, volumetric god-rays, heroic scale, photoreal, 35mm film look,
> fine grain, 16:9. No text, no watermark.

Drop new/replacement clips in Drive `film-src`: `s3-wall.mp4` (overwrite),
`s5-lancaster.mp4`, `s5-b17.mp4`, and the two women's photos as
`lena-horne.jpg`, `mona-baptiste.jpg`.
