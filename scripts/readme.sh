#!/bin/sh
# Keeps the two READMEs in step with the minimal example they show: README.md (in Portuguese) with
# examples/pt/basico.typ, and README.en.md (in English) with examples/en/basic.typ. For each one it renders the pages
# of the example, joins them into one picture (docs/readme/sheet.typ -> docs/readme/<name>.png, committed) and
# rewrites what the README has between `<!-- basic:begin ... -->` and `<!-- basic:end -->`: the source of the
# example, then the picture.
#
# The picture is referenced by its raw.githubusercontent.com URL, not by a relative path: docs/ is not published, so
# on Typst Universe a relative path would be broken. The URL is the one of the tag `v<version>` (`repository` and
# `version` of typst.toml), as typst/packages recommends, so the README of a version keeps the pictures of that
# version: on GitHub they show once the tag is pushed.
#
# It also builds the PDFs of the two full examples that the READMEs link by the same kind of URL:
# docs/example-pt.pdf (examples/pt/main.typ) and docs/example-en.pdf (examples/en/main.typ), committed like the
# manuals.
#
# `sh scripts/readme.sh --check` writes nothing and fails when a README, a picture or a PDF is out of date
# (scripts/check.sh runs it); on the CI (`CI` set) a picture or a PDF that differs only warns, since its bytes may
# depend on the system. The examples import the package by its name: `sh scripts/link.sh` first. Only the fonts
# of fonts/ (`sh scripts/fonts.sh`) are used; any warning fails the run.
set -eu
cd "$(dirname "$0")/.."

out=docs/readme
tmp=$out/.tmp   # inside the project, where sheet.typ can read the pages
ppi=96

fail() {
  echo "error: $*" >&2
  exit 1
}

check=false
[ "${1:-}" = "--check" ] && check=true

repository=$(sed -n 's/^repository *= *"https:\/\/github\.com\/\(.*\)"/\1/p' typst.toml | head -n 1)
[ -n "$repository" ] || fail "typst.toml has no GitHub \`repository\`"
version=$(sed -n 's/^version *= *"\(.*\)"/\1/p' typst.toml | head -n 1)
url="https://raw.githubusercontent.com/$repository/v$version/$out"

sh scripts/link.sh --check
rm -rf "$tmp"
mkdir -p "$tmp"
trap 'rm -rf "$tmp"' EXIT

# typst compile, failing on any warning: the arguments of the compilation
compile() {
  if ! typst compile --font-path fonts --ignore-system-fonts --diagnostic-format short "$@" 2> "$tmp/typst.log"; then
    cat "$tmp/typst.log" >&2
    exit 1
  fi
  if grep -q "warning:" "$tmp/typst.log"; then
    cat "$tmp/typst.log" >&2
    fail "the example compiles with warnings"
  fi
}

stale=false
# a README, its example and the words of the caption of its picture
sync() {
  readme=$1
  source=$2
  caption=$3
  name=$(basename "$source" .typ)

  compile "$source" "$tmp/$name-{p}.svg"
  pages=$(ls "$tmp/$name"-*.svg | wc -l | tr -d ' ')
  compile --root . --ppi "$ppi" --input name="$name" --input pages="$pages" --input dir=.tmp \
    "$out/sheet.typ" "$tmp/$name.png"

  {
    echo '```typst'
    awk 1 "$source"
    echo '```'
    echo
    printf "$caption\n" "$pages" "$source" "$url/$name.png"
  } > "$tmp/$name.md"

  for marker in "^<!-- basic:begin" "^<!-- basic:end -->\$"; do
    [ "$(grep -c -- "$marker" "$readme")" = 1 ] || fail "$readme must have exactly one line matching '$marker'"
  done
  awk -v block="$tmp/$name.md" '
    index($0, "<!-- basic:begin") == 1 { print; while ((getline line < block) > 0) print line; skip = 1; next }
    $0 == "<!-- basic:end -->" { skip = 0 }
    !skip { print }
  ' "$readme" > "$tmp/$name.readme"

  if $check; then
    if ! cmp -s "$tmp/$name.png" "$out/$name.png"; then
      if [ -n "${CI:-}" ]; then
        echo "warning: $out/$name.png differs from what the example gives here" >&2
      else
        echo "error: $out/$name.png is out of date" >&2
        stale=true
      fi
    fi
    cmp -s "$tmp/$name.readme" "$readme" || { echo "error: $readme is out of date with $source" >&2; stale=true; }
    return 0
  fi
  # only what changed is written, so an up-to-date file keeps its timestamp
  cmp -s "$tmp/$name.png" "$out/$name.png" || { mv -f "$tmp/$name.png" "$out/$name.png" && echo "$out/$name.png"; }
  cmp -s "$tmp/$name.readme" "$readme" || { cp "$tmp/$name.readme" "$readme" && echo "$readme"; }
}

# the PDF of a full example, as the READMEs link it: the source, the committed PDF
pdf() {
  source=$1
  target=$2
  name=$(basename "$target")

  compile --creation-timestamp 0 "$source" "$tmp/$name"

  if $check; then
    if ! cmp -s "$tmp/$name" "$target"; then
      if [ -n "${CI:-}" ]; then
        echo "warning: $target differs from what the example gives here" >&2
      else
        echo "error: $target is out of date" >&2
        stale=true
      fi
    fi
    return 0
  fi
  cmp -s "$tmp/$name" "$target" || { mv -f "$tmp/$name" "$target" && echo "$target"; }
}

sync README.md examples/pt/basico.typ '![As %s páginas de %s](%s)'
sync README.en.md examples/en/basic.typ '![The %s pages of %s](%s)'
pdf examples/pt/main.typ docs/example-pt.pdf
pdf examples/en/main.typ docs/example-en.pdf

if $stale; then
  fail "run \`sh scripts/readme.sh\`"
fi
