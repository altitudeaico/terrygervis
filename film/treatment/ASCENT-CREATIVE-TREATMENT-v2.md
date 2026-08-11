# Ascent Collection — Hero Film · Creative Treatment v2
### "THE KEEPER" · character-led, gen-AI cinematic · supersedes the v1 slideshow

**Why v2.** v1 was a competent assembly and a dead film: stills with Ken
Burns pushes, a caption track, a good VO and score carrying dead weight.
It looked like slides. This version keeps what works — **the VO and the
music stay exactly as they are** — and rebuilds everything you *see* as
directed, generated cinema.

---

## The idea (one line)
A custodian of memory, alone in his private museum after hours, tells us
why some stories must never fade — and in the last breath places the
legacy into a younger hand. The archive **breathes** around him:
photographs move, aircraft climb, gold catches the light. *The
Personalised Museum isn't a product on a table — it's the room we're
standing in.*

## The character — THE KEEPER
A distinguished Black British / Caribbean gentleman, late 60s–70s, with a
veteran's bearing and a curator's poise. Dark three-piece suit, a poppy
or squadron pin, a signet ring; reading glasses he removes to look
straight at us. Warm, unhurried, proud. **He is the voice-over given a
body** — the storyteller. He is also, quietly, a man who lived some of
this, or whose father did. At the very end a *younger* hand enters frame
to receive the box: "a legacy you can pass on."

> The Keeper is a FICTIONAL character we author — safe to generate.
> The airmen, the Tuskegee pilots, Lena Horne and Mona Baptiste are REAL
> historical people — we **animate the supplied archival photography**,
> we never fabricate new likenesses of them. (Respect + rights.)

## The world — THE PERSONALISED MUSEUM
A private, lamplit gallery at night. Churchill War Rooms crossed with a
Cartier salon. Deep navy shadows; pools of warm tungsten and brass
picture-lights; glass vitrines glowing; a Rolls-Royce Merlin engine block
on a plinth like sculpture; framed colourised portraits of Caribbean RAF
and Tuskegee airmen watching from the walls; a Spitfire silhouette in the
dark. Mahogany, oxblood leather, brass, velvet, gold. Darkness is a
feature, not a fault.

## Visual system (lock it — every asset obeys this)
- **Palette:** near-black navy `#05061C` · tungsten gold `#C9A24B` /
  `#E8CE86` · oxblood `#5A1418` · brass `#B08D57` · smoke grey.
- **Grade:** teal-lifted shadows, gold highlights, filmic contrast, soft
  highlight halation, fine grain. One shared `.cube` LUT across all clips.
- **Light:** low-key, single warm motivated source (lamps / picture
  lights), volumetric haze and god-rays, hard specular gold on coins/brass.
- **Lens:** 35mm for the room (immersive), 85–100mm macro for coins /
  hands / artefacts, shallow depth of field. **Slow, weighted moves only**
  — dolly, push-in, rack focus, slow orbit. No zoompan. No slideshow.
- **Type:** inscriptional caps (Cinzel / Trajan feel; EB Garamond SC as
  our render fallback), gold, letter-spaced, museum-placard lower-thirds
  and centre cards; a thin gold rule motif.
- **Transitions:** motivated light-bloom dissolves (the elevated version
  of the old fadewhite), match-cuts (gold coin → sun → propeller hub),
  dust/smoke wipes, dips through black. Optional 2.39:1 letterbox.

---

## The cut — 8 beats, locked to the existing VO + music timeline
(VO placements unchanged: s1≈1s · s3≈16s · s4≈27s · s5≈44s · s6≈58s ·
s7≈73s · s8≈82s · ~90s total. Captions stay, restyled as placards.)

| # | Time | VO | On screen | Source |
|---|------|----|-----------|--------|
| 1 | 0:00–0:08 | s1 "some stories should never fade / held in your hands" | Black → dust-mote beam → slow push through the dark gallery; a picture-light ticks on over a colourised airman portrait; the Keeper's silhouette enters, faces the wall. | Flow T2V (gallery dolly) + Gemini animate portrait (breath/blink) |
| 2 | 0:08–0:16 | (score build) | **The heroes live.** The group photo MOVING — airmen shift and laugh, the woman lifts the saxophone, smoke curls, a plane drones over. Every face whole. Dissolve to the Keeper watching it as memory. | Gemini/Veo I2V on the reframed+outpainted heroes photo |
| 3 | 0:16–0:27 | s3 "Introducing the Personalised Museum… Pilots of the Caribbean, Tuskegee Airmen… Rolls-Royce & Bentley" | The Keeper's hands lift the box onto oxblood leather under a brass lamp; macro; the lid rises and light spills (motivated bloom). | Real reveal lid-lift, regraded, over a Flow-generated desk/room |
| 4 | 0:27–0:35 | s4 "two 38mm 24-carat gold coins" | Extreme macro: a coin turns, a soft strip-light sweeps the relief; the second rests in oxblood velvet; rack focus between them. | Real coins, macro + grade (Flow beauty-move if needed) |
| 5 | 0:44–0:57 | s5 "Spitfire, Mustang, Lancaster, B-17… Lena Horne, Mona Baptiste" | **The ascent.** Cut to sky — the Spitfire + Mustang climb through towering cloud, sun flare; reverent inserts of Lancaster & B-17; two dignified living-portraits of the women at war. | Gemini/Veo animate aircraft plate; Flow T2V Lancaster/B-17 in cloud; Gemini animate portraits |
| 6 | 0:57–1:12 | s6 "Merlin artefact… Jamaica Spitfire Fund… Royal Warrant" | The Merlin relic on its plinth, raking light, slow orbit; the comic replica; the Royal Warrant with wax seal and gold foil; the Keeper's hand on the vitrine glass. | Real artefacts + Flow-generated plinth/room; Gemini parallax on stills |
| 7 | 1:13–1:22 | s7 "only 500 sets… £1,500 / $1,999" | A numbered certificate "No. ___ / 500"; the box closes with weight; the Keeper looks up to us. | Generated numbered card + real box-close, graded |
| 8 | 1:23–1:30 | s8 "a legacy you can pass on… empower our future by honouring our past" | **The pass.** The Keeper places the box into a younger hand entering frame; eyes meet; pull back through the gallery, portraits watching; rise to the endcard. | Flow T2V handover + gallery pull-back; animated endcard |

---

## Assembly plan (my side, when your clips come back)
1. Conform every returned clip: `fps=25, 1920x1080, yuv420p, settb=AVTB,
   setsar=1`, `-map 0:v:0`, strip audio (same conform discipline as v1).
2. Apply the shared teal-gold **`.cube` LUT** (`lut3d`) to every clip so
   generated + real footage match; add fine grain, subtle halation on
   highlights, light-leak dissolves at the joins.
3. Rebuild the timeline against the **unchanged** VO + music mix from v1
   (keep the sidechain duck, dual loudnorm, fade-out).
4. Restyle titles as museum placards; add name lower-thirds; drop the
   emblem bug when supplied.
5. Verify as before (ffprobe + frame extraction + audio spot-check), log,
   deliver.

The ffmpeg grade / LUT / xfade-timebase gotchas are pre-solved in the
`video-grade-reframe` skill — I'll use it for the finish.

## What I need from you
- Generate the clips in **Google Flow / Gemini** from
  `FLOW-GEMINI-PROMPT-PACK.md` (next file). Aim: 16:9, highest res
  offered, 5–10s each, no on-clip text.
- Confirm the **Keeper** direction (or tell me to swing to "The
  Inheritor" / "The Pilot's Ascent" — both are storyboarded in my head).
- Supply the **emblem.png** (transparent) and confirm final **price**.

## Deviations / limitations still standing from v1
Compressed 640×360 reveal (soft — clean master needed for the real
grade), Cinzel blocked by egress (EB Garamond stand-in), price flag,
mono audio on the v1 mix. All carried into v2 planning.
