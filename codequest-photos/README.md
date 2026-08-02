# Code Quest photos

Drop the Code Quest photos into this folder.

## Uploading via the GitHub website

1. Open **github.com/altitudeaico/terrygervis**
2. Branch dropdown → select **`claude/code-quest-photos-process-787n1v`**
3. Open this **`codequest-photos/`** folder
4. **Add file → Upload files**, then drag the photos in
5. Confirm **"Commit directly to the `claude/code-quest-photos-process-787n1v` branch"** and commit

### Limits to know
- **25 MB per file** on web uploads — photos are fine; large `.MOV` videos may be rejected (those need the terminal or Git LFS).
- **100 files per commit** — upload in batches if you have more.

> Note: this repo backs a public GitHub Pages site. Raw phone photos carry GPS
> location data. If that matters, strip it before or after uploading —
> `tools/process-photos.sh` can do that.
