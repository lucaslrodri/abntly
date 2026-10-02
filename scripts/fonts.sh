#!/bin/sh
# Downloads New Computer Modern, the family the package uses, from CTAN into fonts/, which is git-ignored: the roman
# and the sans in the cuts 08 and 10, the mono and the maths. Typst embeds only the roman and the maths at 10 pt, so
# the sans (the headings), the mono (the code) and the cut 08 (the superscripts) come from here.
#
# Then it installs those files for the current user, so that the editor and `typst compile` find them without
# `--font-path`: on macOS in ~/Library/Fonts, on Linux in ~/.local/share/fonts (then `fc-cache`). On Windows, use
# scripts/fonts.ps1.
#
#   sh scripts/fonts.sh               downloads and installs
#   sh scripts/fonts.sh --no-install  only downloads (the CI)
#
# Use fonts/ with `typst compile --font-path fonts --ignore-system-fonts ...` (or `tt run --font-path fonts`);
# `typst fonts --font-path fonts` lists the family names Typst sees ("New Computer Modern", "New Computer Modern
# 08", "New Computer Modern Sans", ...). Running it again downloads and copies only what is missing or changed.
set -eu
cd "$(dirname "$0")/.."

install=1
case "${1:-}" in
  --no-install) install=0 ;;
  "") ;;
  *) echo "usage: sh scripts/fonts.sh [--no-install]" >&2; exit 2 ;;
esac

# CTAN mirrors, in order. The redirector (mirrors.ctan.org) comes last: some of the mirrors it picks answer a script
# with an anti-bot "verification" page instead of the file, so every download is checked as a zip.
MIRRORS="https://ctan.math.illinois.edu https://mirrors.mit.edu/CTAN https://ftp.fau.de/ctan https://mirrors.ctan.org"

# One sentinel per download: when it is missing, its archive is fetched again.
#   archive (under <mirror>/fonts/) | sentinel | files to extract
fetch() {
  archive=$1
  sentinel=$2
  shift 2
  if [ -f "fonts/$sentinel" ]; then
    return 0
  fi
  echo "missing in fonts/: $sentinel (downloading $archive.zip)"
  for mirror in $MIRRORS; do
    if curl -fsSL --retry 2 -o "$tmp/$archive.zip" "$mirror/fonts/$archive.zip" 2> /dev/null &&
      unzip -tq "$tmp/$archive.zip" > /dev/null 2>&1; then
      unzip -q -j -o "$tmp/$archive.zip" "$@" -d fonts
      return 0
    fi
    echo "  $mirror did not deliver $archive.zip; trying the next mirror" >&2
  done
  echo "error: could not download $archive.zip from CTAN" >&2
  exit 1
}

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p fonts

# New Computer Modern: Roman and Sans in 08 and 10, Mono in 10, the maths (the Uncial and Devanagari cuts stay out)
fetch newcomputermodern NewCM08-Regular.otf \
  '*/NewCM08-*.otf' '*/NewCM10-*.otf' '*/NewCMSans08-*.otf' '*/NewCMSans10-*.otf' \
  '*/NewCMMono10-*.otf' '*/NewCMMath-*.otf'

echo "fonts/: $(ls fonts | wc -l | tr -d ' ') files"

[ "$install" = 1 ] || exit 0

# What is installed: the Regular and Bold weights with their italics and obliques (not the Book weight)
package="NewCM10-Regular NewCM10-Italic NewCM10-Bold NewCM10-BoldItalic NewCM08-Regular NewCM08-Italic
  NewCMSans10-Regular NewCMSans10-Oblique NewCMSans10-Bold NewCMSans10-BoldOblique NewCMSans08-Regular
  NewCMSans08-Oblique NewCMMono10-Regular NewCMMono10-Italic NewCMMono10-Bold NewCMMono10-BoldOblique
  NewCMMath-Regular NewCMMath-Bold"

case "$(uname -s)" in
  Darwin) target="$HOME/Library/Fonts" ;;
  Linux) target="${XDG_DATA_HOME:-$HOME/.local/share}/fonts" ;;
  *)
    echo "error: to install the fonts on this system, run scripts/fonts.ps1 (Windows) or copy the New Computer" \
      "Modern files of fonts/ to its font folder" >&2
    exit 1
    ;;
esac
mkdir -p "$target"
copied=0
for f in $package; do
  if ! cmp -s "fonts/$f.otf" "$target/$f.otf"; then
    cp -f "fonts/$f.otf" "$target/$f.otf"
    copied=$((copied + 1))
  fi
done
if [ "$copied" -gt 0 ] && command -v fc-cache > /dev/null 2>&1 && [ "$(uname -s)" = Linux ]; then
  fc-cache -f "$target"
fi
echo "$target: $copied of $(echo $package | wc -w | tr -d ' ') New Computer Modern files installed or updated"
