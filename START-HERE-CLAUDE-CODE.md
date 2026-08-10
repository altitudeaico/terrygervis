# Ascent Collection — hero film draft: full run prompt

Task: assemble the 90-second DRAFT of the Ascent Collection launch film
with ffmpeg, and log the work in the repo. Client review copy due
tomorrow — favour a finished draft over any single perfect detail.

## Working setup

Work inside the terrygervis repo clone. This zip
(film-draft-kit.zip, in ~/Downloads or here) contains:
- CLAUDE-CODE-ASSEMBLY-PROMPT.md  ← the full build recipe. READ IT
  FIRST and follow it exactly — the conform-first order and the
  ffmpeg flags in it pre-solve known failures (xfade stream
  mismatches, embedded thumbnail streams, encode timeouts).
- captions.srt                    ← burn these as styled subtitles
- VO-PACK.md                      ← reference only (the script/timings)
- log/                            ← production journal for the repo

## Step 0 — repo safety (same rules as always)
- Working tree clean, then `git pull`.
- The repo ROOT (index.html, assets/, gate files, financials.html,
  status.html) is a live page the client links to. NEVER modify it.
- site/ is the website sandbox. Don't touch it this session.
- Unzip log/ from the kit into the repo root — a NEW folder,
  add-only. Verify with git status that nothing existing changed.

## Step 1 — asset inventory (do this BEFORE building anything)
Create film/ at the repo root with subfolders film/src/ and film/out/.
Find and copy into film/src/, reporting each as FOUND or MISSING:

- reveal.mp4      Reg's ~65s 1080p/25fps silent product reveal —
                  likely named like "Royal Box Collection" or similar;
                  search ~/Downloads and any project folders
- heroes.mp4      heroes ensemble clip, 1280x720/24fps, ~10s
- aircraft (jpg/png)  Mustang + Spitfire plate still
- endcard.png     title/offer card, 1920x1080
- emblem.png      gold "Together We Triumph" emblem, TRANSPARENT bg
- vo-s1.mp3 vo-s3.mp3 vo-s4.mp3 vo-s5.mp3 vo-s6.mp3 vo-s7.mp3 vo-s8.mp3
- music.mp3       orchestral cue, 95s+

ffprobe every video/audio file and report duration, resolution, fps,
and stream layout (flag any file with more than one video stream).

STOP and show me the inventory before proceeding. If anything is
missing I'll tell you where it is. Do not substitute, generate, or
download imagery yourself.

## Step 2 — build
Follow CLAUDE-CODE-ASSEMBLY-PROMPT.md steps 1–7 exactly:
conform → segments → xfade chain (fadewhite into the coin reveal) →
emblem bug over the watermark corner → caption burn → VO placement +
music duck → loudnorm → background render to
film/out/ascent-hero-DRAFT-v1.mp4

Deviations allowed ONLY for: trimming reveal.mp4 to its best 56s
(keep the lid-lift and coin reveals intact), and nudging VO adelay
values ±1s if a take visibly overruns its scene. Log any deviation.

## Step 3 — verify (from the recipe, do not skip)
- ffprobe the master: 87–91s, 1920x1080, 25fps, 1 video + 1 audio stream
- Extract frames at 4s / 20s / 60s / 85s: captions render, bug in
  place, no black frames at joins
- Extract audio at 18s: VO clearly above music
Report what you verified and anything you couldn't.

## Step 4 — log and commit
- Append to log/2026-08-10-hero-film-draft.md: what you did, anything
  that broke and the fix, deviations from the recipe. Tick the Status
  checkboxes that now apply.
- Add the master's final duration + file size to log/FILM-VERSIONS.md.
- Commit "Hero film draft v1 + production log" and push to main
  (explicit permission).
- DO NOT commit film/src/ — add film/src/ to .gitignore (source
  footage is large and private). Committing film/out/ is fine if the
  master is under ~90MB; if larger, gitignore it too and tell me —
  I'll take the file directly.

## Constraints
- Never modify or delete anything at the repo root beyond ADDING
  log/ and film/.
- Never force-push. Use my existing git credentials; never print them.
- If anything is ambiguous, stop and ask.
