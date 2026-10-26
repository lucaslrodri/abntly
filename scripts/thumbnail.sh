#!/bin/sh
# Renders the thumbnail of the template for Typst Universe (typst.toml, `thumbnail`): the first page of
# template/main.typ, its cover, as thumbnail.png at the root of the package (committed; a PNG whose longer edge has
# at least 1080 px, as Typst Universe asks). The template imports the package by its name, which the script links
# to this working copy with gotpm, in a temporary package folder of its own. Only the fonts of fonts/
# (`sh scripts/fonts.sh`) are used.
set -eu
cd "$(dirname "$0")/.."
command -v gotpm > /dev/null || { echo "error: gotpm is not installed (CONTRIBUTING.md, Setup)" >&2; exit 1; }
# @preview/abntly:<version>, the name the template and the examples import, resolves to this working copy only
# while the script runs: gotpm links it in a package folder of its own (TYPST_PACKAGE_PATH, read by typst, tt and
# gotpm), never in the system's, so every other work keeps getting the version published on Typst Universe
TYPST_PACKAGE_PATH=$(mktemp -d)
export TYPST_PACKAGE_PATH
trap 'rm -rf "$TYPST_PACKAGE_PATH"' EXIT
gotpm install -e -n preview > /dev/null
typst compile --font-path fonts --ignore-system-fonts --pages 1 --ppi 150 template/main.typ thumbnail.png
echo thumbnail.png
