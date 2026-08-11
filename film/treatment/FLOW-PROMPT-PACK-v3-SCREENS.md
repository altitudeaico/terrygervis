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

---

# v6 asset prompts (storyboard v5 polish pass)

Filenames to drop in Drive `film-src` in brackets. Append the STYLE SUFFIX
to the environment/Flow prompts; the MOTION note is built into the animate
prompts.

## #4 — Bentley, moving (Flow, text-to-video) [`bentley.mp4`]
> A silver Bentley Continental GT in a slow cinematic reveal: three-quarter
> front view, gliding forward as the camera tracks alongside; long soft
> strip-light reflections sweep down the polished bodywork, the matrix
> grille and chrome catching warm light; wet reflective floor, deep
> navy-to-black gradient backdrop, volumetric haze. Slow, luxurious dolly.
> Photoreal, ray-traced reflections and global illumination, high dynamic
> range, cinematic film grain, 16:9. No text, no logos, no watermark.

(Optional matching Rolls-Royce shot — same treatment, a Rolls-Royce saloon,
`rolls-royce.mp4` — if you want to alternate RR/Bentley on the line.)

## #5 — Box-opening → light-bloom transition (Flow) [`coins-boxopen.mp4`]
> A luxurious dark presentation box, closed, on oxblood leather under a
> single warm brass light; the lid slowly lifts and a warm golden light
> blooms from within, growing to a soft white-gold flare that fills the
> centre of frame. Locked camera, front-on, macro; deep navy shadows,
> brass and velvet, volumetric light, dust motes. The bloom must peak
> near-WHITE so it can dissolve into a product reveal. Photoreal,
> cinematic, high dynamic range, fine grain, 16:9. No text, no watermark.

I composite your coin assets at the bloom peak — box opens → white flare →
coins. (Works for both coin reveals.)

## #6 — Spitfire/Mustang, animated (Flow, image-to-video — feed aircraft.jpg) [`s5-spitfire.mp4`]
> Animate this photograph of a Spitfire and a red-tailed Mustang P-51D
> flying together through golden sunlit clouds: both aircraft fly forward
> and bank gently, propellers spinning to a blur, sunlight flaring off the
> canopies and polished fuselage, clouds drifting past, faint heat shimmer;
> camera tracks alongside in a slow parallel move. Keep both aircraft and
> their markings exactly as in the photo. Golden-hour heritage grade, 35mm
> film look, fine grain, 16:9. Subtle photoreal motion only; no morphing,
> no new aircraft, no text, no watermark.

## #9 — Lena Horne, animated (GEMINI, image-to-video — feed her photo) [`lena-horne.mp4`]
> Bring this archival portrait of Lena Horne gently to life as a living
> photograph: a soft breath, a slow turn of the head toward camera, a
> gentle blink, the faintest warm smile; delicate drifting light, subtle
> film-grain shimmer, a very slow push-in. Keep her likeness, features,
> hair and 1940s styling exactly as in the photograph — do not alter,
> beautify or restyle her face. Reverent, dignified, warm archival colour,
> shallow depth of field, 16:9. Subtle photoreal motion only; no morphing;
> no text, no watermark.

(Real person → feed a genuine Lena Horne photo; proceed on your likeness-
clearance decision, which we log on arrival.)

## #11/12/14 — s6 case must be HEAD-ON (Flow, regenerate) [overwrite `s6-case.mp4`]
The angled glass case causes perspective skew on the artefacts. Replace it
with a FLAT, FRONT-ON panel:
> Ezra stands in the RIGHT third of frame, three-quarter profile, looking
> left toward a large FLAT display panel mounted FRONT-ON to the camera —
> the panel face square and parallel to the lens, NOT angled, NOT inside a
> glass case — filling the left two-thirds, fully visible and unobstructed,
> with a clean rectangular bezel and clear corners. A dark heritage museum
> room, a brass picture-light above the panel, deep navy shadow, volumetric
> haze. The panel is a blank, evenly-lit dull charcoal-blue surface, no
> content. Locked/static camera. [+ STYLE SUFFIX]

Result: Merlin → comic → Top Guns → certificate composite square, no skew.

## #13 — "The First Top Guns", animated (GEMINI, image-to-video — feed the airmen photo) [`topguns.mp4`]
> Bring this colourised 1940s photograph of Caribbean RAF airmen to life as
> a living photograph: the men breathe and shift slightly, a couple share a
> quiet laugh, subtle head-turns; faint dust and haze drift; gentle
> film-grain shimmer; a very slow push-in. Keep every face and the
> composition exactly as in the photo — no new people, no facial
> distortion. Warm archival grade, shallow depth of field, 16:9. Subtle
> photoreal motion only; no text, no watermark.

## #15 — Offer card — DONE (my side)
Rebuilt richer: navy + gold double frame, "OWN A PIECE OF HISTORY" (EB
Garamond SC), "Only 500 sets released worldwide", "£1,500 · $1,999", URL.
Replaces the flat v3 card on the s7 billboard.
