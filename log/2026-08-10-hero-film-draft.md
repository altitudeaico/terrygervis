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
