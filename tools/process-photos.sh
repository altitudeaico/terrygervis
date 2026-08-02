#!/usr/bin/env bash
#
# process-photos.sh — turn a raw iPhone photo/video dump into web-ready,
# location-scrubbed assets for the Ascent Collection progress site.
#
# Runs entirely on your Mac (where the "Code Quest Photos" folder already is).
# No large upload needed.
#
# What it does:
#   * Surveys the source folder (counts, types, sizes, date range)   [survey]
#   * HEIC/HEIF  -> web JPG   (resized, orientation baked in)         [process]
#   * MOV/AVI    -> web MP4   (H.264/AAC, faststart) + poster frame   [process]
#   * JPG/PNG    -> web JPG   (resized)                               [process]
#   * Strips ALL metadata incl. GPS from every image                 [process]
#   * Strips location metadata from every video                      [process]
#   * Builds thumbnails                                              [process]
#   * Verifies no GPS survives + all outputs are valid              [process]
#   * Writes a manifest (CSV + JSON) with sizes, dimensions, sha256 [process]
#   * Optionally installs web images into ./assets and pushes        [flags]
#
# Usage:
#   tools/process-photos.sh survey  ["/path/to/Code Quest Photos"]
#   tools/process-photos.sh process ["/path/to/Code Quest Photos"] ["/path/to/output"]
#
# Process flags (after the paths):
#   --install     also copy web images + thumbs into ./assets (repo)
#   --push        git add/commit/push processed assets to the current branch
#   --full-video  keep original video resolution (default caps long edge at 1280)
#
# Examples:
#   tools/process-photos.sh survey
#   tools/process-photos.sh process
#   tools/process-photos.sh process "$HOME/Downloads/Code Quest Photos" --install
#
set -euo pipefail

# ----------------------------- configuration --------------------------------
WEB_MAX=1400          # long edge (px) for web images — matches existing assets
THUMB_MAX=480         # long edge (px) for thumbnails
JPG_QUALITY=82        # web JPG quality
VIDEO_MAX=1280        # long edge (px) cap for re-encoded video (unless --full-video)
POSTER_AT=1           # seconds into the clip to grab the poster frame

DEFAULT_SRC="$HOME/Downloads/Code Quest Photos"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEFAULT_OUT="$REPO_ROOT/codequest-processed"

# ----------------------------- helpers --------------------------------------
c_reset=$'\033[0m'; c_bold=$'\033[1m'; c_dim=$'\033[2m'
c_grn=$'\033[32m'; c_ylw=$'\033[33m'; c_red=$'\033[31m'; c_cyn=$'\033[36m'
say()  { printf '%s\n' "$*"; }
info() { printf '%s%s%s\n' "$c_cyn" "$*" "$c_reset"; }
ok()   { printf '%s%s%s\n' "$c_grn" "$*" "$c_reset"; }
warn() { printf '%s%s%s\n' "$c_ylw" "$*" "$c_reset"; }
err()  { printf '%s%s%s\n' "$c_red" "$*" "$c_reset" >&2; }
die()  { err "ERROR: $*"; exit 1; }

lc() { printf '%s' "$1" | tr '[:upper:]' '[:lower:]'; }

# image backend detection: macOS 'sips' is primary; ImageMagick + heif-convert
# are cross-platform fallbacks (also lets the pipeline run/verify off a Mac).
HAVE_SIPS=0; command -v sips >/dev/null 2>&1 && HAVE_SIPS=1
MAGICK=""
command -v magick  >/dev/null 2>&1 && MAGICK=magick
[ -z "$MAGICK" ] && command -v convert >/dev/null 2>&1 && MAGICK=convert

# make a resized web JPG:  mk_web_jpg IN OUT MAXEDGE QUALITY
mk_web_jpg() {
  local in="$1" out="$2" max="$3" q="$4" ext; ext="$(lc "${in##*.}")"
  if [ "$HAVE_SIPS" = 1 ]; then
    sips -s format jpeg -s formatOptions "$q" -Z "$max" "$in" --out "$out" >/dev/null 2>&1
    return $?
  fi
  # fallback: ImageMagick (+ heif-convert to decode HEIC if IM lacks the delegate)
  local dec="$in" tmp=""
  if { [ "$ext" = heic ] || [ "$ext" = heif ]; } \
       && ! { [ -n "$MAGICK" ] && "$MAGICK" -list format 2>/dev/null | grep -qi heic; }; then
    command -v heif-convert >/dev/null 2>&1 || return 1
    tmp="${out}.__dec.png"; heif-convert -q 100 "$in" "$tmp" >/dev/null 2>&1 || return 1
    dec="$tmp"
  fi
  [ -n "$MAGICK" ] || return 1
  "$MAGICK" "$dec" -auto-orient -resize "${max}x${max}>" -quality "$q" "$out" >/dev/null 2>&1
  local rc=$?; [ -n "$tmp" ] && rm -f "$tmp"; return $rc
}

# echo "W H" for an image
img_dims() {
  if [ "$HAVE_SIPS" = 1 ]; then
    local w h
    w=$(sips -g pixelWidth  "$1" 2>/dev/null | awk '/pixelWidth/{print $2}')
    h=$(sips -g pixelHeight "$1" 2>/dev/null | awk '/pixelHeight/{print $2}')
    echo "${w:-0} ${h:-0}"
  else
    identify -format '%w %h' "$1" 2>/dev/null || echo "0 0"
  fi
}

sha() { { shasum -a 256 "$1" 2>/dev/null || sha256sum "$1" 2>/dev/null; } | awk '{print $1}'; }

# ----------------------------- preflight ------------------------------------
preflight() {
  local need_brew=()
  # need an image backend: sips (macOS, built-in) OR ImageMagick
  if [ "$HAVE_SIPS" != 1 ] && [ -z "$MAGICK" ]; then
    die "No image backend — macOS has 'sips' built in; otherwise: brew install imagemagick"
  fi
  command -v exiftool >/dev/null 2>&1 || need_brew+=(exiftool)
  command -v ffmpeg   >/dev/null 2>&1 || need_brew+=(ffmpeg)
  if [ "${#need_brew[@]}" -gt 0 ]; then
    err "Missing tools: ${need_brew[*]}"
    err "Install them with:"
    err "    brew install ${need_brew[*]}"
    exit 1
  fi
}

# ----------------------------- file classification --------------------------
# echoes one of: image_heic | image_other | video | skip
classify() {
  local ext; ext="$(lc "${1##*.}")"
  case "$ext" in
    heic|heif)            echo image_heic ;;
    jpg|jpeg|png|tif|tiff|webp) echo image_other ;;
    mov|mp4|m4v|avi)      echo video ;;
    *)                    echo skip ;;
  esac
}

# ----------------------------- survey ---------------------------------------
survey() {
  local src="$1"
  [ -d "$src" ] || die "Source folder not found: $src"
  info "== SURVEY =="
  say  "Source: $src"
  say  ""

  local total=0 bytes=0
  declare -A count_by_ext bytes_by_ext
  local heic=0 vid=0 other=0 skip=0

  while IFS= read -r -d '' f; do
    local ext sz; ext="$(lc "${f##*.}")"
    sz=$(stat -f%z "$f" 2>/dev/null || stat -c%s "$f" 2>/dev/null || echo 0)
    total=$((total+1)); bytes=$((bytes+sz))
    count_by_ext[$ext]=$(( ${count_by_ext[$ext]:-0} + 1 ))
    bytes_by_ext[$ext]=$(( ${bytes_by_ext[$ext]:-0} + sz ))
    case "$(classify "$f")" in
      image_heic) heic=$((heic+1));;
      video)      vid=$((vid+1));;
      image_other) other=$((other+1));;
      skip)       skip=$((skip+1));;
    esac
  done < <(find "$src" -type f ! -name '.*' -print0)

  say "By file type:"
  printf "  %-8s %8s  %12s\n" "ext" "count" "size"
  for ext in $(printf '%s\n' "${!count_by_ext[@]}" | sort); do
    printf "  %-8s %8d  %12s\n" ".$ext" "${count_by_ext[$ext]}" \
      "$(human "${bytes_by_ext[$ext]}")"
  done
  say ""
  say "Rollup:"
  say "  HEIC/HEIF images : $heic"
  say "  Other images     : $other"
  say "  Videos           : $vid"
  say "  Skipped (other)  : $skip"
  say "  TOTAL files      : $total"
  say "  TOTAL size       : $(human "$bytes")"
  say ""

  # capture / date range from EXIF (best effort, needs exiftool)
  if command -v exiftool >/dev/null 2>&1; then
    info "Date range (EXIF DateTimeOriginal / CreateDate):"
    { exiftool -q -q -m -d '%Y-%m-%d' -T -DateTimeOriginal -CreateDate -FileModifyDate \
      "$src" 2>/dev/null | awk 'NF{for(i=1;i<=NF;i++) if($i ~ /^[0-9]{4}-/){print $i; break}}' \
      | sort | sed -n '1p;$p' | awk 'NR==1{a=$0} END{if(a==""){print "  (no EXIF dates found)"} else {print "  earliest: "a"\n  latest:   "$0}}'; } || true
    say ""
    info "GPS / location present in source (first 15 with coordinates):"
    exiftool -q -q -m -if '$gpslatitude' -T -FileName -GPSLatitude -GPSLongitude "$src" 2>/dev/null \
      | head -15 | sed 's/^/  /' || true
    say "  (these coordinates will be removed by 'process')"
  fi
  say ""
  ok "Survey complete. Nothing was changed."
  say "When ready, run:  tools/process-photos.sh process \"$src\""
}

human() {  # bytes -> human readable
  local b=${1:-0}
  awk -v b="$b" 'BEGIN{
    split("B KB MB GB TB",u," "); i=1;
    while(b>=1024 && i<5){b/=1024;i++}
    printf (i==1?"%d %s":"%.1f %s"), b, u[i]
  }'
}

# ----------------------------- process --------------------------------------
process() {
  local src="$1" out="$2" install="$3" push="$4" full_video="$5"
  [ -d "$src" ] || die "Source folder not found: $src"
  preflight

  local WEB="$out/web" THUMB="$out/thumbs" VID="$out/video" POST="$out/posters"
  mkdir -p "$WEB" "$THUMB" "$VID" "$POST"
  local manifest_csv="$out/manifest.csv" manifest_json="$out/manifest.json"
  local log="$out/process.log"
  : > "$log"

  info "== PROCESS =="
  say "Source: $src"
  say "Output: $out"
  say ""

  printf "source,type,output,width,height,bytes,sha256,gps_stripped\n" > "$manifest_csv"
  printf '[\n' > "$manifest_json"
  local first_json=1
  local n_img=0 n_vid=0 n_skip=0 n_fail=0

  json_row() { # source type output w h bytes sha gps
    [ $first_json -eq 1 ] && first_json=0 || printf ',\n' >> "$manifest_json"
    printf '  {"source":"%s","type":"%s","output":"%s","width":%s,"height":%s,"bytes":%s,"sha256":"%s","gps_stripped":%s}' \
      "$1" "$2" "$3" "${4:-0}" "${5:-0}" "${6:-0}" "$7" "$8" >> "$manifest_json"
  }

  # unique, filesystem-safe base name (dedupe collisions across subfolders)
  declare -A used
  safe_base() {
    local raw="$1" b
    b="$(printf '%s' "$raw" | tr ' /' '__' | tr -cd '[:alnum:]._-')"
    b="${b%.*}"
    local cand="$b" i=2
    while [ -n "${used[$cand]:-}" ]; do cand="${b}-$i"; i=$((i+1)); done
    used[$cand]=1
    printf '%s' "$cand"
  }

  while IFS= read -r -d '' f; do
    local kind; kind="$(classify "$f")"
    local rel; rel="${f#"$src"/}"
    local base; base="$(safe_base "$rel")"

    case "$kind" in
      image_heic|image_other)
        local o="$WEB/$base.jpg"
        if mk_web_jpg "$f" "$o" "$WEB_MAX" "$JPG_QUALITY" >>"$log" 2>&1; then
          # strip ALL metadata (incl. GPS); orientation already baked into pixels
          exiftool -q -q -m -all= -overwrite_original "$o" >>"$log" 2>&1 || true
          # thumbnail from the web image
          local t="$THUMB/$base.jpg"
          mk_web_jpg "$o" "$t" "$THUMB_MAX" "$JPG_QUALITY" >>"$log" 2>&1 || true
          exiftool -q -q -m -all= -overwrite_original "$t" >>"$log" 2>&1 || true
          local w h sz sh dims
          dims="$(img_dims "$o")"; w="${dims% *}"; h="${dims#* }"
          sz=$(stat -f%z "$o" 2>/dev/null || stat -c%s "$o"); sh="$(sha "$o")"
          printf '%s,image,%s,%s,%s,%s,%s,yes\n' "$rel" "web/$base.jpg" "${w:-0}" "${h:-0}" "$sz" "$sh" >> "$manifest_csv"
          json_row "$rel" "image" "web/$base.jpg" "${w:-0}" "${h:-0}" "$sz" "$sh" "true"
          n_img=$((n_img+1)); printf '.'
        else
          warn "FAILED image: $rel"; n_fail=$((n_fail+1))
        fi
        ;;
      video)
        local o="$VID/$base.mp4" scale=""
        [ "$full_video" = "no" ] && scale="-vf scale='min($VIDEO_MAX,iw)':'-2':force_original_aspect_ratio=decrease"
        # re-encode, strip ALL metadata (incl. location), web-friendly faststart
        if ffmpeg -y -i "$f" $scale -map_metadata -1 -c:v libx264 -preset medium -crf 22 \
             -pix_fmt yuv420p -c:a aac -b:a 128k -movflags +faststart "$o" >>"$log" 2>&1; then
          local p="$POST/$base.jpg"
          ffmpeg -y -ss "$POSTER_AT" -i "$o" -frames:v 1 -q:v 3 "$p" >>"$log" 2>&1 || \
            ffmpeg -y -i "$o" -frames:v 1 -q:v 3 "$p" >>"$log" 2>&1 || true
          [ -f "$p" ] && exiftool -q -q -m -all= -overwrite_original "$p" >>"$log" 2>&1 || true
          local sz sh; sz=$(stat -f%z "$o" 2>/dev/null || stat -c%s "$o"); sh="$(sha "$o")"
          printf '%s,video,%s,,,%s,%s,yes\n' "$rel" "video/$base.mp4" "$sz" "$sh" >> "$manifest_csv"
          json_row "$rel" "video" "video/$base.mp4" 0 0 "$sz" "$sh" "true"
          n_vid=$((n_vid+1)); printf 'v'
        else
          warn "FAILED video: $rel"; n_fail=$((n_fail+1))
        fi
        ;;
      skip) n_skip=$((n_skip+1)) ;;
    esac
  done < <(find "$src" -type f ! -name '.*' -print0)

  printf '\n]\n' >> "$manifest_json"
  say ""

  # --------------------------- verification ---------------------------------
  info "== VERIFY =="
  local leaks=0
  while IFS= read -r -d '' img; do
    if exiftool -q -q -m -s -s -s -GPSLatitude -GPSLongitude "$img" 2>/dev/null | grep -q .; then
      err "GPS STILL PRESENT: $img"; leaks=$((leaks+1))
    fi
  done < <(find "$WEB" "$THUMB" "$POST" -type f -name '*.jpg' -print0 2>/dev/null)

  local empties=0
  while IFS= read -r -d '' o; do
    [ -s "$o" ] || { err "EMPTY OUTPUT: $o"; empties=$((empties+1)); }
  done < <(find "$WEB" "$THUMB" "$VID" "$POST" -type f -print0 2>/dev/null)

  say ""
  ok "== SUMMARY =="
  say "  Images processed : $n_img"
  say "  Videos processed : $n_vid"
  say "  Skipped          : $n_skip"
  say "  Failures         : $n_fail"
  say "  GPS leaks        : $leaks   $( [ $leaks -eq 0 ] && echo '(clean)' )"
  say "  Empty outputs    : $empties"
  say "  Manifest         : $manifest_csv"
  say "                     $manifest_json"
  say "  Log              : $log"
  [ $leaks -eq 0 ] && [ $empties -eq 0 ] && [ $n_fail -eq 0 ] \
    && ok "All checks passed." || warn "Review warnings above."

  # --------------------------- install into repo ----------------------------
  if [ "$install" = "yes" ]; then
    info "== INSTALL into repo assets =="
    mkdir -p "$REPO_ROOT/assets/codequest" "$REPO_ROOT/assets/codequest/thumbs"
    cp -f "$WEB"/*.jpg   "$REPO_ROOT/assets/codequest/"        2>/dev/null || true
    cp -f "$THUMB"/*.jpg "$REPO_ROOT/assets/codequest/thumbs/" 2>/dev/null || true
    cp -f "$POST"/*.jpg  "$REPO_ROOT/assets/codequest/"        2>/dev/null || true
    cp -f "$manifest_csv" "$REPO_ROOT/assets/codequest/manifest.csv" 2>/dev/null || true
    ok "Copied web images + thumbnails into assets/codequest/"
    warn "Note: re-encoded videos are large — NOT copied into the repo by default."
    warn "      They live in: $VID"
  fi

  # --------------------------- push -----------------------------------------
  if [ "$push" = "yes" ]; then
    info "== PUSH =="
    ( cd "$REPO_ROOT"
      local branch; branch="$(git rev-parse --abbrev-ref HEAD)"
      git add assets/codequest tools/process-photos.sh 2>/dev/null || true
      if git diff --cached --quiet; then
        warn "Nothing staged to commit."
      else
        git commit -m "Add processed Code Quest photos (web assets + thumbnails, GPS stripped)" >/dev/null
        for d in 2 4 8 16; do
          git push -u origin "$branch" && { ok "Pushed to $branch"; break; } || { warn "push failed, retrying in ${d}s"; sleep "$d"; }
        done
      fi
    )
  fi

  say ""
  ok "Done."
}

# ----------------------------- entrypoint -----------------------------------
main() {
  local cmd="${1:-}"; shift || true
  case "$cmd" in
    survey)
      local src="${1:-$DEFAULT_SRC}"
      survey "$src"
      ;;
    process)
      local src="$DEFAULT_SRC" out="$DEFAULT_OUT"
      local install=no push=no full_video=no
      local positional=()
      for a in "$@"; do
        case "$a" in
          --install) install=yes ;;
          --push) push=yes ;;
          --full-video) full_video=yes ;;
          --*) die "Unknown flag: $a" ;;
          *) positional+=("$a") ;;
        esac
      done
      [ "${#positional[@]}" -ge 1 ] && src="${positional[0]}"
      [ "${#positional[@]}" -ge 2 ] && out="${positional[1]}"
      process "$src" "$out" "$install" "$push" "$full_video"
      ;;
    ""|-h|--help|help)
      sed -n '2,40p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
      ;;
    *)
      die "Unknown command: $cmd  (use: survey | process | help)"
      ;;
  esac
}
main "$@"
