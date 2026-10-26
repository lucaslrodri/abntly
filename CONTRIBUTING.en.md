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
| [gotpm](https://github.com/npikall/gotpm) 0.8.0 | installing the package into Typst's package directory |

The scripts are `sh` and run on macOS and Linux. On Windows, only `scripts/fonts.ps1` has a version of its own; the
others need WSL or Git Bash. gotpm runs on the three systems (`brew install npikall/tap/gotpm`, or the installer in
its README).

## Setup

```sh
git clone https://github.com/lucaslrodri/abntly
cd abntly
gotpm install -e      # @local/abntly:<version>, a link to this copy (editable)
sh scripts/fonts.sh   # downloads New Computer Modern into fonts/ and installs it (Windows: scripts/fonts.ps1)
```

During development, the package is always installed under `@local`, never under `@preview` in the system's package
directory. A `@preview/abntly:<version>` installed there would take the place of the version published on Typst
Universe, in every work on the machine. With `gotpm install -e`, `#import "@local/abntly:<version>": *` resolves to
the working copy in `typst compile` and in the editor.

The template, the examples and the READMEs import the package by its published name, `@preview/abntly:0.1.1`, as an
author does (Typst Universe requires it of the template). The scripts that compile them (`check.sh`, `examples.sh`,
`readme.sh`, `thumbnail.sh`) link that name to the working copy only while they run, in a temporary package
directory, the one of `TYPST_PACKAGE_PATH`, which `typst`, `tt` and gotpm read. A new version needs no step of its
own. The other tests import `src/lib.typ` by its path.

### Local installation with gotpm

gotpm installs the package into Typst's package directory, with the same commands on macOS, Linux and Windows:

```sh
gotpm install -e                                  # @local/abntly:<version>, a link to this copy (editable)
gotpm install                                     # @local/abntly:<version>, a copy with only the package's files
gotpm install -r github.com/lucaslrodri/abntly    # the highest v<version> tag on GitHub, without this copy (-t HEAD: main)
```

The copy holds what goes to Typst Universe: the `exclude` of `typst.toml` and `.gitignore` are left out, as in
`scripts/package.sh`. `-f` replaces an installation of the same version (of a link, only the link is deleted),
`gotpm list` shows what is installed and `gotpm uninstall abntly -V <version>` removes it. Then
`#import "@local/abntly:<version>": *` works before the version reaches Typst Universe. Two cautions:

- the template imports `@preview/abntly:<version>`, and gotpm does not rewrite that import. A work created with
  `typst init @local/abntly:<version>` compiles with the version on Typst Universe; to use the local copy, change
  `@preview` to `@local` in it;
- on Windows, `-e` (a symbolic link) needs Developer Mode or an administrator terminal; without them, use
  `gotpm install`, which copies.

## Folders

| Folder | Contents |
| ------ | -------- |
| [`src/`](src/) | the package; `src/lib.typ` is the entry point |
| [`template/`](template/) | the template of a new work |
| [`examples/`](examples/) | the basic example and the full example, in Portuguese and in English |
| [`docs/manual/`](docs/manual/) | the sources of the manuals, in Portuguese (`manual-pt.typ`) and in English (`manual-en.typ`), and the small works of their examples |
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

Run directly, `tt` needs the name `@preview/abntly:<version>` in the cases that compile the template and the
examples. Link it first, in a temporary package directory of the terminal session, as the scripts do:

```sh
export TYPST_PACKAGE_PATH=$(mktemp -d) && gotpm install -e -n preview
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

All of the publishing goes through gotpm: `gotpm bump` changes the version, and `gotpm publish` takes the package to
Typst Universe. The READMEs reach what is in the repository (the manuals, the examples and their PDFs, the template,
the licence, the README in the other language, the pictures) by the address of the tag of the version (`v0.1.1`);
only the anchors are relative, because `README.md` is shown on Typst Universe without the repository around it. For a
new version:

1. `gotpm bump patch` (or `minor`, `major`, or the version, as `gotpm bump 0.2.0`) changes the version of
   `typst.toml`, and only it;
2. change the version in the imports (`@preview/abntly:<version>`) of the template, the examples, the manual and
   the READMEs, and in the links of the READMEs; `git grep -n "abntly:<previous version>\|v<previous version>"`
   shows the places;
3. run `gotpm install -e` (the `@local` of the new version), `sh scripts/manual.sh`, `sh scripts/readme.sh` and
   `sh scripts/thumbnail.sh`;
4. commit, then create and push the tag: `git tag v<version> && git push origin main v<version>`. The tag makes
   the links and the pictures of the READMEs work and starts [`release.yml`](.github/workflows/release.yml), which
   runs the tests, publishes through `gotpm publish` (below) and creates the GitHub release, with the zip of the
   package, the manuals and the examples;
5. open the pull request `abntly:<version>` in typst/packages from the link in the summary of the workflow, with the
   checklist of its template filled in (`gotpm publish` suggests another title, `release: abntly <version>`;
   typst/packages asks for `abntly:<version>`). After the merge, the version is on
   [Typst Universe](https://typst.app/universe/) within minutes. Published versions are immutable: a fix is a new
   version.

While the pull request is not merged, the version can be redone: delete the release and the tag
(`gh release delete v<version> --cleanup-tag` and `git tag -d v<version>`), fix, commit and create the tag again.
`gotpm publish` adds a commit to the branch already on the fork, and the pull request updates by itself; with no
change in the package, it fails, since there is nothing to publish.

## Publishing

`gotpm publish` does, in this order:

1. it runs the gate of `typst.toml` (`[tool.gotpm] pre-publish-hook`), `sh scripts/package.sh --check`, and stops
   when it fails. The gate assembles the published files in `dist/` and checks:
   - the tag (`RELEASE_TAG`, on the CI) against the version of `typst.toml`;
   - the imports of the package and the links of the READMEs at the right version;
   - a work created by `typst init` from the published files only, which has to compile;
   - the version not yet on Typst Universe;
   - the checker of the pull requests of typst/packages (`ghcr.io/typst/package-check`), through Docker. Without
     Docker, the checker is skipped with a note; on the CI, it is required;
2. it clones the fork of typst/packages (the `fork.url` of gotpm's configuration) and creates the branch
   `abntly-<version>` from the `main` of the fork;
3. it copies the package into `packages/preview/abntly/<version>/`, with the same rules as the installation: the
   `exclude` of `typst.toml` and what `.gitignore` ignores are left out (the files of `scripts/package.sh`);
4. it commits and pushes the branch to the fork. The pull request is left to the author.

The fork and the token are set up once:

1. a fork of [typst/packages](https://github.com/typst/packages). If the fork is not called `<owner>/packages`, set
   the repository variable `REGISTRY_FORK` (Settings > Secrets and variables > Actions > Variables) to `owner/name`;
2. a fine-grained personal access token restricted to the fork, with **Contents: read and write**, saved as the
   repository secret `REGISTRY_TOKEN`. `release.yml` hands it to the git of `gotpm publish`.

To publish from this machine, without the CI, set up the fork once and run gotpm at the root of the clean working
copy, at the tag of the version:

```sh
gotpm config set fork.url https://github.com/<owner>/packages
gotpm publish --local -m "abntly:<version>"   # rehearsal: the commit in the clone of the fork, no push
gotpm publish -m "abntly:<version>"           # the push, with the git credentials of this machine
```

The clone of the fork stays in gotpm's data directory (`gotpm locate` shows the directories). `gotpm publish` copies
the working copy, not the tag: publish from a clean tree, at the tag. The GitHub release, in that case, is made by
hand: `sh scripts/package.sh dist` and `gh release create v<version> --verify-tag --generate-notes` with the zip and
the PDFs.

To rehearse the workflow on this machine, with Docker open: `act push -W .github/workflows/release.yml -e
.github/act/release.json`. Under act, `gotpm publish` runs with `--local`, and the release and the checker of
typst/packages are skipped.
