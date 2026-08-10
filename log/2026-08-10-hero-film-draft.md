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
- [ ] VO generated
- [ ] Music selected
- [ ] Draft assembled (ascent-hero-DRAFT-v1.mp4)
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
