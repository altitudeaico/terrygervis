# Terry Jervis — site sandbox

A private sandbox exploring a rebuild of terryjervisofficial.com. Static HTML and CSS,
no build step. See `CLAUDE.md` for the design system, the hard rules and the open decisions.

**This folder lives at `site/` in the repo.** The repo root holds the Ascent Collection
production progress page, which Reginald has the link to. Don't move these files to root.

- Progress page: `altitudeaico.github.io/terrygervis/`
- This sandbox: `altitudeaico.github.io/terrygervis/site/`

## Run it locally

Open `index.html`, or:

```bash
python3 -m http.server 8000
```

## Publish it

From the repo root, after dropping this folder in:

```bash
git add site
git commit -m "Add site rebuild sandbox"
git push
```

Live about a minute later at `/terrygervis/site/`. Nothing at the root is touched.

## Status

- [x] Home page
- [x] Design system and tokens
- [x] Page structure and navigation
- [ ] About — biography and awards
- [ ] Work — case studies
- [ ] Historic Coins — full collection page
- [ ] Contact — real addresses, GHL form
- [ ] Image rights confirmed, photography added
