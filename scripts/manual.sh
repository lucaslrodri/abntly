#!/bin/sh
# Builds the manual of the package (docs/manual): every small work of docs/manual/examples/ becomes the pictures of
# its pages, docs/manual/examples/out/<name>.<lang>-<page>.svg, which the manual shows beside its code; then the two
# PDFs, docs/manual-pt.pdf and docs/manual-en.pdf. The pictures and the PDFs are committed: the README points to the
# PDFs, and the cases of tests/docs compile the manual without this script. Only the fonts of fonts/
# (`sh scripts/fonts.sh`) are used; any warning fails the run.
#
# The pictures are rendered into a temporary folder and swapped in only when every example compiled: an editor
# preview that compiles the manual meanwhile never finds a picture missing, and a broken example leaves out/ as it
# was.
#
# `sh scripts/manual.sh --check` writes nothing: it fails when a picture or a PDF is not what the sources give today,
# when a picture has no example, when an example of one language has no pair in the other, or when the two versions
# do not hold the same things in the same order (scripts/check.sh runs it). On the CI (`CI` set) a PDF that differs
# only warns: its bytes may depend on the system, and the pictures and the sources are checked all the same.
set -eu
cd "$(dirname "$0")/.."

check=false
[ "${1:-}" = "--check" ] && check=true

examples=docs/manual/examples
out=$examples/out
tmp=$examples/.out.tmp
rm -rf "$tmp"
mkdir -p "$tmp" "$out"
trap 'rm -rf "$tmp"' EXIT

fail() {
  echo "error: $*" >&2
  exit 1
}

# typst compile, failing on any warning: the source, the output
compile() {
  if ! typst compile --root . --font-path fonts --ignore-system-fonts --diagnostic-format short \
    --creation-timestamp 0 "$1" "$2" 2> "$tmp/typst.log"; then
    cat "$tmp/typst.log" >&2
    exit 1
  fi
  if grep -q "warning:" "$tmp/typst.log"; then
    cat "$tmp/typst.log" >&2
    fail "$1 compiles with warnings"
  fi
}

# every example has its pair in the other language: the two manuals show the same examples
for source in "$examples"/*.pt.typ; do
  pair="${source%.pt.typ}.en.typ"
  [ -f "$pair" ] || fail "$source has no pair $pair"
done
for source in "$examples"/*.en.typ; do
  pair="${source%.en.typ}.pt.typ"
  [ -f "$pair" ] || fail "$source has no pair $pair"
done

for source in "$examples"/*.typ; do
  name=$(basename "$source" .typ)
  compile "$source" "$tmp/$name-{p}.svg"
done
rm -f "$tmp/typst.log"

if $check; then
  stale=false
  for picture in "$tmp"/*.svg; do
    name=$(basename "$picture")
    cmp -s "$picture" "$out/$name" || { echo "error: $out/$name is out of date" >&2; stale=true; }
  done
  for picture in "$out"/*.svg; do
    [ -f "$tmp/$(basename "$picture")" ] || { echo "error: $picture has no example" >&2; stale=true; }
  done
  for lang in pt en; do
    compile "docs/manual/$lang/manual.typ" "$tmp/manual-$lang.pdf"
    if ! cmp -s "$tmp/manual-$lang.pdf" "docs/manual-$lang.pdf"; then
      if [ -n "${CI:-}" ]; then
        echo "warning: docs/manual-$lang.pdf differs from what the sources give here" >&2
      else
        echo "error: docs/manual-$lang.pdf is out of date" >&2
        stale=true
      fi
    fi
  done
  if $stale; then
    fail "run \`sh scripts/manual.sh\`"
  fi
  # the two versions hold the same things in the same order: the marks the helpers of the manual leave
  # (`<manual-mark>`, docs/manual/template.typ), one per line; a function is named differently in each language and a
  # norm joins two sections with "e" or "and", so those two are compared by their kind and by their sections
  marks() {
    typst eval --root . --font-path fonts --ignore-system-fonts 'query(<manual-mark>).map(it => it.value)' \
      --in "docs/manual/$1/manual.typ" | awk '{ gsub(/\},\{/, "}\n{"); print }' |
      sed -e '/"kind":"reference"/s/"value":.*/"value":"..."}/' -e 's/ and / e /g'
  }
  marks pt > "$tmp/marks-pt"
  marks en > "$tmp/marks-en"
  diff "$tmp/marks-pt" "$tmp/marks-en" > "$tmp/marks.diff" ||
    { cat "$tmp/marks.diff" >&2; fail "the two versions of the manual do not hold the same things"; }
  exit 0
fi

# the new pictures first (a rename replaces the old file in one step), then the leftovers of examples that lost
# pages
(cd "$tmp" && ls) > "$tmp/.new"
for picture in "$tmp"/*.svg; do
  mv -f "$picture" "$out/"
done
for picture in "$out"/*.svg; do
  grep -qxF "$(basename "$picture")" "$tmp/.new" || rm -f "$picture"
done
echo "$out/*.svg"

mkdir -p "$tmp"
for lang in pt en; do
  compile "docs/manual/$lang/manual.typ" "docs/manual-$lang.pdf"
  echo "docs/manual-$lang.pdf"
done
