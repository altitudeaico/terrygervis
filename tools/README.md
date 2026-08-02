# Photo processing — `process-photos.sh`

Turns a raw iPhone photo/video dump (HEIC + MOV) into web-ready, **location-scrubbed**
assets for the progress site. Runs on your Mac — no large upload needed.

## Why local

The remote assistant session can't ingest the full batch: the Google Drive connector
caps downloads at 10 MB and the session's network policy blocks `drive.google.com`.
The photos already live on your Mac, so processing there is both possible and faster.

## One-time setup

Built-in `sips` (macOS) does the image resizing. You also need two tools:

```bash
brew install ffmpeg exiftool
```

## Step 1 — survey (changes nothing)

```bash
tools/process-photos.sh survey
# or point at a specific folder:
tools/process-photos.sh survey "$HOME/Downloads/Code Quest Photos"
```

Prints counts by type, total size, the EXIF date range, and which files currently
carry GPS coordinates. Nothing is modified — review this first.

## Step 2 — process

```bash
tools/process-photos.sh process
```

Writes results to `codequest-processed/`:

| folder     | contents                                             |
|------------|------------------------------------------------------|
| `web/`     | resized JPGs (long edge 1400 px), **all metadata + GPS stripped** |
| `thumbs/`  | thumbnails (long edge 480 px)                        |
| `video/`   | MOV → MP4 (H.264/AAC, faststart), location stripped  |
| `posters/` | one poster-frame JPG per video                       |
| `manifest.csv` / `manifest.json` | source → output, dimensions, size, sha256, gps_stripped |
| `process.log` | full tool output for debugging                    |

After processing it **verifies** no GPS survived on any image and that every output
is non-empty, then prints a summary.

### Optional flags

- `--install` — copy web images + thumbnails into `assets/codequest/` in the repo.
- `--push` — commit those repo assets and push to the current branch (with retries).
- `--full-video` — keep original video resolution (default caps the long edge at 1280 px).

```bash
tools/process-photos.sh process "$HOME/Downloads/Code Quest Photos" --install --push
```

## Defaults you can tweak

Edit the config block at the top of the script: `WEB_MAX` (1400), `THUMB_MAX` (480),
`JPG_QUALITY` (82), `VIDEO_MAX` (1280), `POSTER_AT` (1s).
