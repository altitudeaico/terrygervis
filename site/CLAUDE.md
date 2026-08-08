# Terry Jervis — site sandbox

Static site. No build step, no framework, no dependencies. Open `index.html` in a browser
and it works. That is deliberate: it should still work in five years without anyone
running `npm install`.

## What this is

A sandbox demonstrating what a rebuilt terryjervisofficial.com could be, built to answer a
proposal from a third party to rebuild on Squarespace. It is not live and not approved.

## Where this lives

This folder sits at `site/` inside the `altitudeaico/terrygervis` repo. The repo root holds
a different thing — the Ascent Collection production progress page, which Reginald has the
link to. **Do not move these files to the repo root.** Doing so overwrites that page.

- `altitudeaico.github.io/terrygervis/` — production progress (leave alone)
- `altitudeaico.github.io/terrygervis/site/` — this sandbox

All paths here are relative, so the folder can be renamed or moved without editing anything.

## Structure

```
index.html          Home — the mission, the two projects, the record, the route to commission
about.html          Stub
work.html           Stub, with a StaRRship case study started
coins.html          Stub, links to the existing GHL launch page
contact.html        Stub — the thing the current site has no version of at all
assets/css/site.css All tokens and components. Everything is here.
```

## Design system

Tokens live at the top of `site.css` under `:root`. Change them there and the whole site follows.

| Token | Value | Use |
|---|---|---|
| `--ink` | `#05061C` | Page ground |
| `--royal` | `#02066F` | Royal Blue, brand primary |
| `--purple` | `#7851A9` | Royal Purple, gradient partner |
| `--gold` / `--gold-lt` | `#C9A24B` / `#E8CE86` | Gilt headings, rules, buttons |
| `--paper` | `#F2EFE6` | Light bands |

Type: **Bodoni Moda** for display (numismatic, high-contrast — chosen to echo coin relief),
**Archivo** for body, **IBM Plex Mono** for labels, years and specifications (echoing
aircraft data plates and engine schematics).

Use `.gilt` on a span for the gold gradient text. Use `.eyebrow` for mono labels.
Sections alternate `.band--royal` and `.band--light`.

## The signature element

The hero resolves the purpose statement into a measured scale running 1940 → 2040, with the
coin collection pinned at one end and StaRRship at the other. This is the argument the whole
site is making: they are not two projects, they are one mission pointing both ways. Do not
remove it without replacing the argument it makes.

## Hard rules

1. **No photography until rights are confirmed.** The King Charles portrait, the Rolls-Royce
   and Bentley marks, and the Getty-credited images of Lena Horne and Mona Baptiste are all
   unresolved. The site is designed to look finished without them.
2. **500 sets, 38mm, 24ct gold finish, 1944 Merlin engine.** These numbers appear across the
   coin page, the launch page and the spec. They must agree everywhere.
3. **Forms post into GoHighLevel**, never a second database. Terry's warm audience is the
   asset on this account and it should not be split across platforms.
4. **No investment or value-appreciation language** anywhere near the collection.

## Open decisions

- Which email addresses go public (contact page has deliberate `REPLACE@example.com` placeholders)
- Whether Terry needs to self-edit copy. If yes, add a git-backed CMS (Decap or Tina) rather
  than moving platform.
- Payment route for the collection — Stripe Payment Links is the likely answer, not a store.

## Deploying

GitHub Pages works but has no access control, and this is a private client preview.
Cloudflare Pages or Netlify are better here: same free tier, plus password protection,
custom domains and redirects.

Keep `<meta name="robots" content="noindex, nofollow">` in every page head until it goes live,
and remove the `.sandbox` banner div at that point.
