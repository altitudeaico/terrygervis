# 2026-08-10 — Hero film draft v1

**Goal:** 90-second draft to Terry & Reg by 11 Aug.

## Approach
Reg's 65s real-product reveal is the spine (per launch_film_spec_v2).
Structure: heroes hook → aircraft still (Ken Burns) → reveal (56s trim)
→ slowed loaded-box hold → end card. VO = Script #4, seven ElevenLabs
takes placed at fixed timecodes. Captions burned (Cinzel, gold).
Gold emblem bug bottom-right from 0:00 — covers the AI watermark on
Reg's clip honestly (disclosure stays, as the brand mark).

## Decisions
- **Price in draft = Script #4 (£1,500/$1,999)** — Bolaji's call, speed
  over reconciliation. OPEN for final: July medals page says £1,200+VAT
  /$1,600. One take to re-record if it changes.
- Scene 2 is a still with slow push, not generated video — draft
  restraint; revisit on feedback.
- Draft = 90 only. 30/60 cut from the approved master, not before.
- Conform everything to 25fps (spine's rate); retiming inserts is
  safer than retiming the spine.

## Method (repeatable)
1. ElevenLabs: 7 takes per VO-PACK.md (mid-Atlantic, stability .5,
   style .3, speed .95)
2. Music: royalty-free orchestral ~95s, ducked via sidechaincompress
3. Assembly: conform-first (fps=25,settb=AVTB,setsar=1,yuv420p) →
   xfade chain (fadewhite on the coin transition) → emblem overlay →
   subtitles burn → VO placed with adelay → loudnorm I=-14 → x264
   crf19 background render
4. Verify with ffprobe + frame extraction, not by eye alone

## Gotchas hit / pre-solved
- xfade refuses mismatched streams → conform first, always
- exported MP4s can carry a thumbnail stream → -map 0:v:0 always
- 90s 1080p encode exceeds tool timeout → nohup + poll

## Status
- [x] VO generated (7 takes pulled from Drive, durations checked vs target)
- [x] Music selected (orchestral, 169s, used from start, faded to length)
- [x] Draft assembled (ascent-hero-DRAFT-v1.mp4 — 90.60s, 11.70 MB)
- [ ] Sent to Terry & Reg
- [ ] Feedback logged in FILM-VERSIONS.md

## Session — 2026-08-10 (Claude Code): asset inventory, BLOCKED
Set up `film/` (`src/`, `out/`); add-only, no existing repo files touched.
`git status` confirms only new additions. Source footage kept out of git
via `.gitignore` (`film/src/`).

**Inventory (Step 1) — result: cannot build, media missing.**
- FOUND: aircraft still (`assets/aircraft.jpg`, 1400x787 JPEG → copied to
  `film/src/aircraft.jpg`); `captions.srt` (supplied in kit).
- MISSING (nowhere on disk; no `~/Downloads`; full-FS search found only OS
  files): `reveal.mp4` (the spine), `heroes.mp4`, `endcard.png`,
  `emblem.png`, all 7 VO takes (`vo-s1/3/4/5/6/7/8.mp3`), `music.mp3`.
- Tooling: `ffmpeg`/`ffprobe` NOT installed (apt candidate 7:6.1.1 avail).
  No video/audio present to ffprobe.

Stopped per START-HERE Step 1: did not substitute, generate, or download
imagery. Awaiting (a) location/upload of the missing source + VO + music
+ endcard + emblem, and (b) go-ahead to install ffmpeg. Build resumes
conform-first per CLAUDE-CODE-ASSEMBLY-PROMPT.md once assets land.

## Session — 2026-08-10 (Claude Code): assets pulled, DRAFT v1 BUILT ✅
All media pulled from Google Drive "film-src", local sizes byte-for-byte
matched Drive. ffmpeg 6.1.1 installed. Master built, verified, in film/out.

**Deliverable:** `film/out/ascent-hero-DRAFT-v1.mp4` — **90.60s**,
1920x1080, 25fps, 1 video (h264) + 1 audio (aac) stream, **11.70 MB**.

### Cut (segments → xfade, 4×0.6s fades, fadewhite on C→D)
A heroes.png 8s · B aircraft.jpg 8s · C reveal 56s · D reveal-slow 10s ·
E endcard 11s → 90.6s picture lock. VO placed by adelay, music ducked
(sidechaincompress), VO bus loudnorm I=-16, final mix loudnorm I=-14,
music afade-out last 2s. Captions burned (EB Garamond, gold).

### Deviations from the recipe (all logged as required)
1. **Segment C trimmed at the TAIL, not the opening** (kept reveal's
   first 56s). Frame check showed the lid-lift (~5s) and the two-coin
   reveal (~10s) are in the OPENING — the recipe's generic "trim the
   slowest opening seconds" would have destroyed them, so per its own
   priority ("keep the lid-lift and coin reveals intact") I trimmed the
   tail instead.
2. **Segment D sourced from 51–56s (provenance page), not the literal
   last 5s.** The clip's final ~5s (60–65s) is a promo graphic carrying
   old "$1,400 / call 0800…" pricing that conflicts with the draft's
   $1,999/£1,500 VO + endcard. Slowing the provenance frames instead
   keeps the film price-consistent and is on-message with VO s6
   ("Royal Warrant certificate of provenance").
3. **Endcard hold 8s → 11s.** Real VO durations pushed the closing line
   (s8) past a 87.6s cut; extending E to 11s makes the film 90.6s so s8
   finishes cleanly, still inside the 87–91s spec. No voice sped up.
4. **VO adelay nudges (all ±1s, per allowance):** s3 17→16, s5 45→44,
   s6 57→58, s8 83→82 — to stop consecutive VO takes overlapping.
   Tail-silence trim (silenceremove, tail only) was attempted on the
   two over-target takes (s3 +1.9s, s5 +3.0s) but they had ~0.02–0.05s
   of trailing silence — they are full-length reads, so nothing to trim
   and (per instruction) the voice was NOT sped up; the nudges above
   absorbed the overlaps.

### Known limitations / flags for the final
- **reveal.mp4 is 640x360** (the 1.7 MB compressed copy) upscaled to
  1080p — soft. The clean master replaces it for the final.
- **heroes.png substituted for heroes.mp4** (Segment A built from the
  still: centre 16:9 crop-fill + zoompan push, no pillarbox).
- **Emblem brand-bug SKIPPED (deferred, as agreed).** Consequence: the
  "Generated by AI" watermark on Reg's clip stays visible bottom-right
  through the reveal section (~5–25s). The bug was meant to cover it.
- **Font: Cinzel unavailable** — org egress policy blocked the Google
  Fonts / CDN download (403). Used the recipe's first fallback,
  **EB Garamond** (endcard + caption burn).
- **Audio is mono** (the mono VO drove the amix channel layout); the
  music's stereo image is lost. Fine for review; revisit for the final.
- **Price flag persists:** draft = $1,999/£1,500; the reveal footage's
  later frames still carry the old £1,400/0800 promo (kept out of the
  cut by deviation #2, but present in source).
- Optional enrichment (turntable-potc.mov / turntable-tuskegee.mov) left
  in Drive, unused — draft came together without them.

### Verified (Step 3)
- ffprobe master: 90.60s / 1920x1080 / 25fps / 1 video + 1 audio ✓
- Frames @4s/20s/60s/85s: captions render (gold EB Garamond), no black
  frames at any of the 4 joins (blackframe check clean) ✓
- Audio @18s (VO active) vs @39s (music only): VO mean −13.8/peak −1.5 dB
  vs music −14.7/−4.3 dB — VO clearly above the ducked music ✓

## Session — 2026-08-11 (Claude Code): LOOK-TEST v2 ("The Keeper") ✅
First on-screen proof of the v2 gen-AI direction. Pulled 4 files from
Drive film-src (sizes byte-matched): s1-keeper.mp4, s8-handover.mp4,
ezra-ref-portrait.jpeg, ezra-ref-full.jpeg (Ezra = the Keeper character).

**Deliverable:** `film/out/ascent-LOOKTEST-v2.mp4` — 17.40s, 1920x1080,
25fps, 1 video + 1 audio, 7.75 MB.

- Both Flow/Veo clips arrived 1280x720/24fps/8s (native Veo audio, stripped
  with -an). Conformed to 1920x1080/25fps.
- Heritage grade applied to both (teal into shadows, gold into highlights,
  eq contrast/sat, subtle vignette, gentle temporal grain) — kept light,
  the clips were generated close to the look.
- Cut: s1-keeper (8s) → 0.6s crossfade → s8-handover; s8's final frame
  held +2.0s (clone) so the closing line resolves; audio+video fade over
  the final 1.5s.
- Audio: vo-s1 @1.0s, vo-s8 @8.3s, music.mp3 from start, ducked via
  sidechaincompress, VO bus loudnorm −16, final mix loudnorm −14.
- Verified: ffprobe 17.40s/1080p/25fps/1+1 ✓; frames @3s (Keeper at his
  desk) and @14s (the handover) both cinematic and consistently graded ✓;
  audio VO −14.3/−14.1 dB vs music-only gap −16.2 dB — VO above music ✓.
- Note: mix is mono again (mono VO drives amix) — carry the stereo fix
  into the full v2 build. 720p→1080p upscale on the clips is clean.
- Committed to the working branch only (NOT main), per instruction.

## Session — 2026-08-11 (Claude Code): FULL v2 CUT ("The Keeper") ✅
Built the full 90s v2 master. Only the two Flow bookends existed in Drive
(s1-keeper, s8-handover) — the middle beats aren't generated yet — so the
middle is assembled from the REAL product footage + stills, all unified
under the heritage grade so it reads as one film. Flow middles drop into
the same slots later (see FLOW-GEMINI-PROMPT-PACK.md).

**Deliverable:** `film/out/ascent-hero-v2.mp4` — 90.60s, 1920x1080, 25fps,
1 video + 1 audio, ~25 MB.

### Structure (9 segments, 8 xfades, fadewhite bloom into the reveal)
| Seg | ~time | content | source |
|---|---|---|---|
| S1 | 0–8 | Keeper at his desk | Flow (s1-keeper) |
| S2 | 8–16 | heroes, reframed (no head-crop) + slow push | still, reframed |
| S3 | 16–27 | the reveal / box open | real reveal, graded |
| S4 | 27–41 | coins / contents | real reveal, graded |
| S5 | 41–54 | the ascent — Spitfire + Mustang push | aircraft still, graded |
| S6 | 54–68 | Merlin artefact / provenance | real reveal, graded |
| S7 | 67–78 | scarcity — Royal Box / 500 sets card | real reveal, graded |
| S8 | 77–85 | the handover | Flow (s8-handover) |
| S9 | 85–90.6 | endcard | generated card, graded |
VO: all 7 takes at the v1 adelays (s1 1s … s8 82s), music from start,
sidechain-ducked, VO bus loudnorm −16, mix loudnorm −14, music afade last
2s. Captions burned, restyled as gold EB Garamond SC placards.

### Verified
- ffprobe: 90.60s / 1920x1080 / 25fps / 1 video + 1 audio ✓
- 9 beat frames extracted — consistent grade across Flow + real + stills,
  captions render, faces intact ✓
- Black-frame check clean at all 8 joins ✓
- Audio VO@18s −13.8 dB vs music-only@40.5s −14.5 dB — VO above music ✓

### Honest notes / what the Flow middles will fix
- Middle beats are the **640×360 reveal upscaled** — softer than the Flow
  bookends + aircraft; grain helps but the difference is visible. B2/C2/
  B5 etc. in the prompt pack replace these with generated cinema.
- **"Generated by AI" watermark** still shows in the reveal (S3, ~20s) —
  emblem bug remains deferred (no emblem.png supplied yet).
- **Coins beat (S4)**: the reveal's actual coin close-ups are brief, so
  S4 leans on the contents/booklet — a Flow "coins macro" clip fixes it.
- Mix is **mono** again (mono VO drives amix) — stereo pass for the final.
- Endcard caption duplicates the endcard title — trim one for the final.
- Kept on the **working branch, NOT main** — promote when the Flow
  middles land / on your sign-off.

## Session — 2026-08-11 (Claude Code): FULL v3 "Museum of Screens" ✅
The direction the client wanted: Ezra through the whole film, product
content composited ONTO surfaces inside his scenes (video wall, plinth
screen, easel screen, glass-case screen, night billboard), synced so
picture follows voice.

**Deliverable:** `film/out/ascent-hero-v3.mp4` — 90.60s, 1920x1080, 25fps,
1 video + 1 audio (**STEREO**), ~45 MB.

### Pulled + verified (5 Flow scenes, byte-matched Drive)
s3-wall, s4-plinth, s5-screen (correct 2,146,697 dup), s6-case,
s7-billboard — all 1280x720/24fps/8s. (ezra-ref stills already held.)

### Compositing (per panel, measured from a 96px grid)
- Corner-pinned our content onto each blank panel (rect overlay for the
  frontal s3/s5; ffmpeg `perspective` corner-pin for the angled
  s4/s6/s7), + screen treatment: scanlines, bezel-fit, bloom, light-spill.
- **s3** heroes photo (faces intact) on the wall + Ezra luma-restored in
  front (he stands between camera and panel).
- **s4** the two cased coins + emblem coin (from reveal) on the plinth.
- **s5** aircraft on the easel screen, then a **hard cut THROUGH to
  full-frame aircraft** for the heart of vo-s5, per the note.
- **s6** provenance/Royal-Box card (reveal) in the glass case.
- **s7** OFFER CARD I built (EB Garamond, "500 / of 500 / £1,500·$1,999"
  — text set by me, never from generated imagery) corner-pinned onto the
  night billboard, with light-spill; perspective matched.
- Screen content sources: reveal macro for coins + artefacts (turntable
  .movs were >10 MB, over the Drive-connector download cap — used the
  reveal's real coin footage instead; re-upload <10 MB to swap in).

### Cut / timing
8 beats over the locked VO timeline (vo adelays unchanged): keeper 11s ·
wall 12s · plinth 12s · screen 20s (incl. full-frame cut) · case 13s ·
billboard 11s · handover 10s · endcard 5.8s → 90.6s via 0.6s xfades.
Each Ezra scene slowed 1.25–1.625x to sit under its VO line.

### Audio — STEREO this time
7 VO takes → amix → loudnorm −16 → **panned to stereo** → sidechain-duck
music (stereo) → mix → loudnorm −14. Output 2ch/48k. Music fades last 2s.

### Verified
- ffprobe 90.60s / 1080p / 25fps / 1 video + 1 **stereo** audio ✓
- 9 beat frames: content matches the VO line at each moment ✓
- Black-frame check clean at all 7 joins ✓
- Audio VO@27 −15.3 dB vs music-only@40 −18.0 dB — VO above music ✓

### Honest notes for the final
- **Slow-mo 1.25–1.625x** on the 8s Flow scenes to fill the VO windows →
  minor judder on the most-slowed (s6). Fix: generate 10–12s Flow clips.
- s5's aircraft is still the stock plate (Ken Burns) — a Flow-animated
  aircraft would lift the full-frame moment.
- Coins/artefacts screen content is the 640x360 reveal (soft; screen
  treatment masks it). Clean re-export or turntable <10 MB improves it.
- No burned captions this round (kept the composites clean) — can add.
- Emblem bug still deferred (no emblem.png).
- Working branch only, not main.

## Session — 2026-08-11 (Claude Code): v4 — Ezra clear + content matched to VO ✅
Addressed the two v3 notes. **Deliverable:** `film/out/ascent-hero-v4.mp4`
— 90.68s, 1920x1080, 25fps, STEREO, ~50 MB.

Pulled (byte-matched Drive): s3-wall REGEN (2,078,459 — re-downloaded, not
cached), s5-lancaster (2,056,270), s5-b17 (2,050,335).

### Note 1 — Ezra no longer blocks any screen
New s3-wall has Ezra in the left third; the wall panel is fully clear, so
I corner-pin the heroes photo straight onto it (perspective) — no more
luma-restore. s4/s5/s6/s7 already kept him clear.

### Note 2 — screens now show exactly what the VO names, in order
- s3 heroes (Pilots of Caribbean / Tuskegee) ✓
- s4 the two cased coins + emblem coin ✓
- **s5 montage**, timed to the words: comp screen (Spitfire+Mustang) →
  full-frame **Spitfire/Mustang → Lancaster → B-17** (the two new Flow
  clips) → **coin obverse relief** for the women's beat.
- **s6 sequence** on the case screen: **Merlin relic → printed replica →
  Royal Warrant certificate** (from the reveal), in VO order.
- s7 offer (500 / £1,500·$1,999), my EB Garamond text.

**Women's beat — rationale (per client):** we do NOT show photographs of
Lena Horne or Mona Baptiste. Licensing and estate advertising-consent are
unresolved, so as the VO names them the screen shows the **coin obverse
relief** (from the reveal). Revisit only if written consent is secured.

### Cut / audio
8 beats over the locked VO timeline (adelays unchanged), slowed 1.25–1.5x
to sit under each line; s5 beat = screen + 11s full-frame montage. One
heritage grade throughout. **Stereo** mix (VO panned, music sidechain-
ducked, dual loudnorm, 2s fade). 90.68s.

### Verified
ffprobe 90.68s/1080p/25fps/1 video + 1 **stereo** audio ✓; 12 beat frames
— each screen matches its VO line ✓; black-frame check clean at all 7
joins ✓; VO@27 −15.3 dB vs music@37 −17.4 dB ✓.

### Notes for the final
- Still 1.25–1.5x slow-mo on the 8s Flow scenes (minor judder); 10–12s
  gens remove it. Coins/artefacts/Merlin screen content is the 640x360
  reveal (soft; screen treatment masks it) — turntables <10 MB or a clean
  re-export sharpen it. Emblem bug still deferred. No burned captions.
- Working branch only, not main.
