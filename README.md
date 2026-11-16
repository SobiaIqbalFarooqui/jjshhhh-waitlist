# jjshhhh waiting list

A single static page: the jjshhhh wordmark, what jjshhhh is, and a waiting-list form that saves emails to Supabase.

```
index.html              the whole page (styles and script inline)
assets/                 wordmark SVG and background image
supabase/schema.sql     the "emails" table and its insert-only security rule
```

## Run it locally

Any static server works, for example:

```bash
npx serve .
```

## Supabase

The page posts to the `emails` table using the project's public anon key, which is safe to ship in the browser because row-level security only allows inserts. If you ever create a fresh Supabase project, run `supabase/schema.sql` in its SQL Editor, then swap `SUPABASE_URL` and `SUPABASE_ANON_KEY` near the bottom of `index.html`.

Sign-ups appear in Supabase under **Table Editor → emails**, where you can also export them as CSV.

## Deploy

It's plain HTML, so GitHub Pages, Netlify or Vercel can serve the repo root as-is with no build step.
