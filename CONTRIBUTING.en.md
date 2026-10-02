# Development

<p align="center">
  <a href="CONTRIBUTING.md">Português</a> · <strong>English</strong>
</p>

This file describes the development environment of the package: the tools, the folders, the tests and the build
scripts. To use the package, see the [README](README.en.md) and the [manual](docs/manual-en.pdf).

## Tools

| Tool | What for |
| ---- | -------- |
| [Typst](https://typst.app/) ≥ 0.15.0 | compiling the package, the manual and the examples |
| [Tytanic](https://typst-community.github.io/tytanic/) 0.4.1 (`tt`) | the test cases |

The scripts are `sh` and run on macOS and Linux. On Windows, only `scripts/fonts.ps1` has a version of its own; the
others need WSL or Git Bash.

## Setup

```sh
git clone https://github.com/lucaslrodri/abntly
cd abntly
sh scripts/link.sh     # makes @preview/abntly:<version> resolve to this copy (--remove undoes it)
sh scripts/fonts.sh    # downloads New Computer Modern into fonts/ and installs it (Windows: scripts/fonts.ps1)
```

The template, the examples and the READMEs import the package by its name, `@preview/abntly:0.1.0`, as an author
does. `scripts/link.sh` links the repository into Typst's local package directory, so that this name resolves to the
working copy in `typst compile`, in `tt` and in the editor. The other tests import `src/lib.typ` by its path.

## Folders

| Folder | Contents |
| ------ | -------- |
| [`src/`](src/) | the package; `src/lib.typ` is the entry point |
| [`template/`](template/) | the template of a new work |
| [`examples/`](examples/) | the basic example and the full example, in Portuguese and in English |
| [`docs/manual/`](docs/manual/) | the sources of the manuals, in Portuguese (`pt/`) and in English (`en/`), and the small works of their examples |
| [`docs/readme/`](docs/readme/) | the pictures of the READMEs |
| [`tests/`](tests/) | the test suite |
| [`scripts/`](scripts/) | the scripts for installing, building and checking |

The code, its comments and the scripts are written in English. The manuals, the READMEs and this file have a version
in Portuguese and one in English. Only `src/`, `template/`, `typst.toml`, `LICENSE`, `README.md` and `thumbnail.png`
go to Typst Universe (the `exclude` of `typst.toml` and `scripts/package.sh` list the rest); `README.en.md` stays in
the repository, and `README.md` reaches it by the address of the tag.

## Tests

```sh
sh scripts/check.sh                                    # everything the CI runs
tt run --font-path fonts --warnings promote            # only the Tytanic suite
tt run --font-path fonts -e 'regex:^unit/'              # only the unit tests
tt update --font-path fonts style/typography/section   # writes the reference of a case again
```

The cases are in `tests/<category>/.../test.typ`:

| Category | What it checks |
| -------- | -------------- |
| `style/` | the pages of each case against its reference pictures (`ref/`) |
| `unit/` | each module of `src/`, with `assert` on what the functions return; the case passes when it compiles |
| `docs/` | the two manuals compile |
| `examples/` and `template/` | the two full examples and the template |

The reference pictures of the full examples and of the template (103 pages, 4 MB) are not in the repository.
Without them, those three cases only compile. `sh scripts/examples.sh` renders the pictures, and from then on each
page is compared; run it again when a change of the pages is intended (`--remove` deletes the pictures).

`scripts/check.sh` runs the suite and also checks that the READMEs show the basic example as it is, that the PDFs of
the full examples and the pictures and the PDFs of the manual are what the sources give today, and that the two
manuals hold the same things in the same order. The CI ([`.github/workflows/tests.yml`](.github/workflows/tests.yml)) runs the same script on every push.

## Building

| Script | What it builds |
| ------ | -------------- |
| `sh scripts/manual.sh` | the pictures of the examples of the manual and the two PDFs, `docs/manual-pt.pdf` and `docs/manual-en.pdf` |
| `sh scripts/readme.sh` | the basic example and its picture in the two READMEs, and the PDFs of the full examples, `docs/example-pt.pdf` and `docs/example-en.pdf` |
| `sh scripts/thumbnail.sh` | `thumbnail.png`, the cover of the template |
| `sh scripts/examples.sh` | the reference pictures of the full examples and of the template |
| `sh scripts/package.sh` | the files published on Typst Universe, in `dist/preview/abntly/<version>/` |

The PDFs of the manuals and of the full examples, the pictures of the examples of the manual, the pictures of the
READMEs and `thumbnail.png` are committed. After changing the package, run `sh scripts/manual.sh` and
`sh scripts/readme.sh`: `check.sh` fails when one of them is out of date.

## New version

The READMEs reach what is in the repository (the manuals, the examples and their PDFs, the template, the licence, the
README in the other language, the pictures) by the address of the tag of the version (`v0.1.0`); only the anchors
are relative, because `README.md` is shown on Typst Universe without the repository around it. When the version
changes in `typst.toml`:

1. change the version in the imports (`@preview/abntly:<version>`) of the template, the examples, the manual and
   the READMEs, and in the links of the READMEs;
2. run `sh scripts/link.sh`, `sh scripts/manual.sh`, `sh scripts/readme.sh` and `sh scripts/thumbnail.sh`;
3. commit, then create and push the tag: `git tag v<version> && git push origin main v<version>`. The tag makes
   the links and the pictures of the READMEs work and starts [`release.yml`](.github/workflows/release.yml), which
   runs the tests, assembles the package with `scripts/package.sh` (it refuses a tag that differs from the version),
   creates a work from the assembled package and compiles it, runs the checker of typst/packages, publishes the
   GitHub release (zip and manuals) and pushes the branch `abntly-<version>` to the fork of typst/packages;
4. open the pull request `abntly:<version>` in typst/packages from the link in the summary of the workflow, with
   the checklist of its template filled in. After the merge, the version is on
   [Typst Universe](https://typst.app/universe/) within minutes. Published versions are immutable: a fix is a new
   version.

While the pull request is not merged, the version can be redone: delete the release and the tag
(`gh release delete v<version> --cleanup-tag` and `git tag -d v<version>`), fix, commit and create the tag again. The
workflow force-pushes the branch and the pull request updates by itself.

## Publishing

`release.yml` reaches typst/packages through a fork and a token, set up once:

1. a fork of [typst/packages](https://github.com/typst/packages). If the fork is not called `<owner>/packages`, set
   the repository variable `REGISTRY_FORK` (Settings > Secrets and variables > Actions > Variables) to `owner/name`;
2. a fine-grained personal access token restricted to the fork, with **Contents: read and write**, saved as the
   repository secret `REGISTRY_TOKEN`. If the push is refused for lack of the `workflow` scope, sync the `main`
   branch of the fork with typst/packages: the branch is created from their current `main`, which may carry workflow
   files that the fork does not have yet.

To rehearse the workflow on this machine, with Docker open: `act push -W .github/workflows/release.yml -e
.github/act/release.json`. The external steps (checker, release, push) are skipped; `sh scripts/package.sh` gives the
same files in `dist/`.
