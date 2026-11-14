---
name: new-papers
description: Check DBLP for new publications, add them to the bibliography, and ask the user whether to announce each one in the news or add it to a research line. Runs weekly from a Claude Desktop scheduled task; can also be run by hand.
---

# New papers from DBLP

This usually runs unattended from a scheduled task. When there is nothing new,
finish quickly with a single line. Only involve the user when there are new
papers. Never run `bin/deploy`: uploading needs the university VPN, and the
user always does it by hand.

## 1. Preconditions

1. `git status --porcelain`. If anything is uncommitted, stop and say:
   "Skipped the DBLP check: the working tree has uncommitted changes." Don't
   stash, commit or discard the user's work.
2. If a local branch `dblp-sync` exists, an earlier run was not pushed. Check it
   out and go to step 3 ("resume"), using `git log master..dblp-sync` to see
   what it already has.
3. Otherwise `git checkout master && git pull --ff-only`.

## 2. Look for new papers

Run `bin/sync-dblp --dry-run --json`.

- Exit code 0: nothing new. Reply "No new papers in DBLP." and stop.
- Exit code 1: DBLP's SPARQL endpoint failed. Report the error in one line and stop.
- Exit code 10: new papers.
  1. `git checkout -b dblp-sync`
  2. `bin/sync-dblp`: this adds the entries to `_bibliography/papers.bib` and
     writes `_data/new_papers.json`.
  3. Commit `papers.bib` with "Add new publications from DBLP".

## 3. Ask the user about each paper

For each paper in `_data/new_papers.json`, find its abstract to judge the
topic. Try the DOI landing page with WebFetch, or
`https://api.crossref.org/works/<doi>`. If neither works, use the title and venue.

Read the research lines in `_pages/research.md` (front matter `lines:` and the
section text) and `_data/research_papers.yml`, then decide which line, if any,
fits best. The six ids are:

- `performance-measurement`
- `process-of-process-mining`
- `productivity-collaboration`
- `ai-conversational-bpm`
- `predictive-monitoring`
- `compliance-management`

If the PushNotification tool is available, send one notification first:
"N new papers from DBLP need your input".

Then use AskUserQuestion, two questions per paper and at most two papers per
call. Put the paper's short title in each header and question, because the
user may see only the dialog.

- **News:** "Announce '<title>' (<venue> <year>) in the news?" Options: "No",
  "Yes, its own news item", and, when two or more papers are new, "Yes, one
  item for all the new papers".
- **Research line:** "Add '<title>' to a research line's key publications?"
  This is a multiSelect. Your suggestion comes first, marked "(Recommended)",
  then "None", then one or two other plausible lines. The user can type any
  other line under "Other".

## 4. Apply the answers

- **Research line:** append the key (e.g. `DBLP:journals/infsof/RossiMMRR26`)
  to that line's list in `_data/research_papers.yml`. Put it first if it is
  the newest paper there. Keep 6–9 keys per line; if a list grows past 9,
  tell the user which older paper they might drop, but don't drop it yourself.
- **News:** create `_news/<short-slug>.md` in the style of `_news/bpm26.md`.
  - Front matter: `layout: post`, `date: <today> 10:00:00`, `inline: true`,
    `related_posts: false`.
  - One or two sentences. Use the full venue name rather than the DBLP
    abbreviation ("Information and Software Technology", not "Inf. Softw.
    Technol."). Link the title to `https://doi.org/<doi>`, or to the url when
    there is no DOI. Mention co-authors only if it reads naturally.
  - Several papers in one item: a short intro sentence and a bullet list.
  - Show the text to the user in your final summary, so they can ask for changes.
- Don't edit the prose of `_pages/research.md`. If a paper opens a clearly new
  topic, say so in the summary instead.

## 5. Check and commit

1. Build:
   `export GITHUB_TOKEN=$(gh auth token) JEKYLL_ENV=production; rbenv exec bundle exec jekyll build`
   (about 90 s). It must finish without `Research papers:` warnings.
2. `npx prettier --write` on the files you changed (not on `papers.bib`).
3. Commit on `dblp-sync`, e.g. "Highlight new DBLP papers in news and research lines".
4. Summarize for the user:

   - the papers added;
   - the news text;
   - the research-line changes.

   Then ask with AskUserQuestion: "Publish these changes now?" Options:
   "Yes, push to master" and "Not yet, keep the dblp-sync branch".

## 6. Publish (only on "yes")

1. `git checkout master && git pull --ff-only && git merge --ff-only dblp-sync`.
   If the merge can't fast-forward, use a normal merge instead.
2. `git push`, then `git branch -d dblp-sync`.
3. Wait for the deploy: `gh run watch $(gh run list --workflow deploy.yml --limit 1 --json databaseId --jq '.[0].databaseId') --exit-status`.
4. End with: "The site is built in the gh-pages branch. Connect to the VPN and run `bin/deploy` to put it live."

On "not yet": switch back to master, keep the branch, and say that the next
run, or running `/new-papers` by hand, will pick it up again.
