#!/bin/sh
# Renders the thumbnail of the template for Typst Universe (typst.toml, `thumbnail`): the first page of
# template/main.typ, its cover, as thumbnail.png at the root of the package (committed; a PNG whose longer edge has
# at least 1080 px, as Typst Universe asks). The template imports the package by its name: `sh scripts/link.sh`
# first. Only the fonts of fonts/ (`sh scripts/fonts.sh`) are used.
set -eu
cd "$(dirname "$0")/.."
sh scripts/link.sh --check
typst compile --font-path fonts --ignore-system-fonts --pages 1 --ppi 150 template/main.typ thumbnail.png
echo thumbnail.png
