#!/bin/sh
# Renders the reference pictures of the cases of Tytanic that are whole works: the two full examples
# (tests/examples/pt and tests/examples/en, the works of examples/) and the template (tests/template), a picture per
# page, in the `ref/` folder of each case. These pictures are not in the repository (103 pages, 4 MB, and every
# change of a page would write its picture again in the history): without them the three cases only compile, as in
# a fresh clone; with them, `tt run` compares each page with its picture.
#
# Run it once to turn the comparison on, and again after a change that is meant to change the pages; a change that
# is not shows up as a failure of `tt run`, with the differences in the `diff/` folder of the case.
# `sh scripts/examples.sh --remove` deletes the pictures, and the cases only compile again.
#
# The works import the package by its name, which the script links to this working copy with gotpm, in a
# temporary package folder of its own. Only the fonts of fonts/ (`sh scripts/fonts.sh`) are used; any warning
# fails the run.
set -eu
cd "$(dirname "$0")/.."

cases="examples/pt examples/en template"

if [ "${1:-}" = "--remove" ]; then
  for case in $cases; do
    rm -rf "tests/$case/ref"
  done
  echo "removed the reference pictures of: $cases"
  exit 0
fi

command -v gotpm > /dev/null || { echo "error: gotpm is not installed (CONTRIBUTING.md, Setup)" >&2; exit 1; }
# @preview/abntly:<version>, the name the template and the examples import, resolves to this working copy only
# while the script runs: gotpm links it in a package folder of its own (TYPST_PACKAGE_PATH, read by typst, tt and
# gotpm), never in the system's, so every other work keeps getting the version published on Typst Universe
TYPST_PACKAGE_PATH=$(mktemp -d)
export TYPST_PACKAGE_PATH
trap 'rm -rf "$TYPST_PACKAGE_PATH"' EXIT
gotpm install -e -n preview > /dev/null
# a case with a `ref/` folder is one Tytanic compares; without it, one it only compiles
for case in $cases; do
  mkdir -p "tests/$case/ref"
done
# shellcheck disable=SC2086
tt update --font-path fonts --warnings promote $cases
for case in $cases; do
  echo "tests/$case/ref/*.png"
done
