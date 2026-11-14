# Personal web page (Jekyll, al-folio theme)

Manuel Resinas's academic page, served at https://personal.us.es/resinas/
(`baseurl: /resinas`).

## Publishing pipeline

1. A push to `master` makes the GitHub Actions workflow `deploy.yml` build the
   site and publish it to the `gh-pages` branch. Pull requests are built but
   not published.
2. The university server needs the VPN with MFA, so uploading is manual: the
   user runs `bin/deploy` from their laptop while on the VPN. **Never run
   `bin/deploy`.** End every change with a reminder to run it.
3. Don't push to `master` without the user's confirmation.

## Where things live

| Content                                         | File                                                                                                          |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| Bio, home page                                  | `_pages/about.md` (layout `_layouts/about.liquid`)                                                            |
| News                                            | `_news/*.md` (see `_news/bpm26.md` for the style)                                                             |
| Publications                                    | `_bibliography/papers.bib`: DBLP standard-format entries with `DBLP:` keys; add new ones with `bin/sync-dblp` |
| Research lines                                  | `_pages/research.md` (front matter `lines:` with the cards, plus one section per line)                        |
| Key papers per research line                    | `_data/research_papers.yml` (DBLP keys by line id)                                                            |
| Software/tools                                  | `_data/repositories.yml` (feeds the repositories page and the research page's "Tools:" lines)                 |
| Teaching, former PhD students, consulting hours | `_pages/teaching.md`                                                                                          |

## Skills

- `/new-papers`: weekly DBLP check (run by a Claude Desktop scheduled task).
  Adds new papers and asks whether to announce them or add them to a research line.
- `/update-site`: the routine for any other change: edit, build, screenshot,
  commit, confirm, push.

## Local build

- Ruby 3.2.11 via rbenv:
  `export GITHUB_TOKEN=$(gh auth token) JEKYLL_ENV=production; rbenv exec bundle exec jekyll build`
  (about 90 s). `GITHUB_TOKEN` avoids GitHub API rate limits for the repo cards.
- Formatting: `npx prettier --check .` must pass. CI checks it.

## Content conventions

- Research lines: the "process of process mining" line is about understanding
  and supporting analysts, with emphasis on visual analytics, not about new
  mining algorithms. Present compliance management as an established line,
  not as ongoing or new work.
- News: short, with the full venue name and a DOI link.
