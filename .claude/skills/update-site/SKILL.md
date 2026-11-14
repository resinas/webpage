---
name: update-site
description: Make a change the user asks for on the personal web page (news, bio, research lines, teaching, repositories, layout), check it in a local build and screenshot, then commit and, after confirmation, push so CI builds gh-pages.
---

# Update the web page

The user describes a change ("add a news item about…", "update the courses",
"add this paper to the compliance line"). Follow `CLAUDE.md` for where things
live, then:

1. **Start clean.** On `master`, `git pull --ff-only`. If there are
   uncommitted changes that aren't yours, ask before touching them.
2. **Make the change** in the right data file or page (see the map in
   `CLAUDE.md`). Prefer editing data files (`_data/*.yml`, `_news/`) over
   adding HTML to pages. Ask only if the request is really ambiguous, such as
   a news date or which research line.
3. **Build:**
   `export GITHUB_TOKEN=$(gh auth token) JEKYLL_ENV=production; rbenv exec bundle exec jekyll build`.
   Fix any warnings it prints from the site's own plugins (`Research papers:`,
   `GitHub repo info:`).
4. **Look at it.** Serve and screenshot the changed page(s) at desktop and
   phone width. The site lives under `/resinas`, so serve a folder holding a
   `resinas` symlink to `_site`:
   ```sh
   d=$(mktemp -d); ln -s "$PWD/_site" "$d/resinas"
   python3 -m http.server 8765 --directory "$d" &   # stop it afterwards
   "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless \
     --hide-scrollbars --window-size=1280,1800 --screenshot="$d/desktop.png" \
     http://localhost:8765/resinas/<page>/
   ```
   Use `--window-size=500,1800` for phone width; Chrome won't go narrower in
   headless mode. Read the PNGs to check them, and also check dark mode when
   the change involves colours.
5. **Format.** Run `npx prettier --write <changed files>`, then
   `npx prettier --check .` must pass. Don't run Prettier on `papers.bib`.
6. **Commit** with a short message describing the change. Show the user a
   summary and the screenshots, and ask with AskUserQuestion whether to push.
7. **On yes:** `git push`, then watch the deploy run:
   `gh run watch $(gh run list --workflow deploy.yml --limit 1 --json databaseId --jq '.[0].databaseId') --exit-status`.
   If the run fails, read its log (`gh run view --log-failed`) and fix it.
8. **Finish** with: "The site is built in the gh-pages branch. Connect to the
   VPN and run `bin/deploy` to put it live." Never run `bin/deploy` yourself.
