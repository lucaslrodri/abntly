#!/bin/sh
# Assembles the files that are published on Typst Universe into <target>/preview/abntly/<version>/ (default target:
# dist/), the layout of `packages/` in https://github.com/typst/packages, so <target> also works as a package path:
# `typst init --package-path dist @preview/abntly:<version> work`.
#
# Only the list below is published. The rest of the repository (tests, manuals, examples, scripts, CI, the English
# README) stays out of typst/packages, as its guidelines ask (docs/tips.md, "What to commit? What to exclude?"):
# the README reaches the manuals, the examples and their PDFs, the template, the licence and the English README by
# their GitHub URL, at the tag of the version. fonts/ (downloaded by scripts/fonts.sh) and .gitignore are not copied
# either. gotpm publishes the same files: it leaves out the `exclude` of typst.toml and what .gitignore ignores.
#
# `sh scripts/package.sh --check [target]` is the gate of `gotpm publish` (its pre-publish hook, in typst.toml):
# besides the checks below, it creates a work from the published files only and compiles it, refuses a version
# already on Typst Universe and runs the checker of the pull requests of typst/packages (with Docker; skipped, with
# a note, on a machine without it, but required on the CI).
set -eu
cd "$(dirname "$0")/.."

files="typst.toml LICENSE README.md thumbnail.png src template"

name=$(sed -n 's/^name *= *"\(.*\)"/\1/p' typst.toml | head -n 1)
version=$(sed -n 's/^version *= *"\(.*\)"/\1/p' typst.toml | head -n 1)
check=false
if [ "${1:-}" = "--check" ]; then
  check=true
  shift
fi
target=${1:-dist}
out="$target/preview/$name/$version"

fail() {
  echo "error: $*" >&2
  exit 1
}

# A release tag (`v<version>`), when given by the CI, must match the manifest.
if [ -n "${RELEASE_TAG:-}" ] && [ "$RELEASE_TAG" != "v$version" ]; then
  fail "tag $RELEASE_TAG does not match the version of typst.toml ($version)"
fi

rm -rf "$out"
mkdir -p "$out"
for f in $files; do
  [ -e "$f" ] || fail "$f is missing"
  mkdir -p "$out/$(dirname "$f")"
  cp -R "$f" "$out/$f"
done
find "$out" -name .DS_Store -delete

# Every import of the package itself must use the published name and this version: a work created from the template
# has to compile untouched, and the READMEs are what people copy from.
if grep -rn "@local/" "$out" --include='*.typ' --include='*.md' >&2; then
  fail "the files above import from @local; published files must use @preview/$name:$version"
fi
stale=$(grep -rnoE "@preview/$name:[0-9]+\.[0-9]+\.[0-9]+" "$out" --include='*.typ' --include='*.md' \
  | grep -v ":@preview/$name:$version\$" || true)
if [ -n "$stale" ]; then
  echo "$stale" >&2
  fail "the references above do not point to version $version"
fi

# The READMEs reach what is in the repository (the manuals, the examples and their PDFs, the template, the licence,
# the README in the other language, the pictures) by its GitHub URL at the tag of this version: README.md is shown
# on Typst Universe without the repository around it, and README.en.md is read on GitHub at any ref. Only anchors
# (`#...`) may be relative. The badges read typst.toml of main through an encoded URL: not matched here.
repository=$(sed -n 's/^repository *= *"https:\/\/github\.com\/\(.*\)"/\1/p' typst.toml | head -n 1)
for readme in "$out/README.md" README.en.md; do
  relative=$(grep -noE '(\]\(|href=")[^)" ]+' "$readme" | grep -vE '^[0-9]+:(\]\(|href=")(https?://|#)' || true)
  if [ -n "$relative" ]; then
    echo "$readme: $relative" >&2
    fail "the links above are relative; use the GitHub URL at the tag v$version"
  fi
  stale=$(grep -noE "(github\.com/$repository/(blob|raw|tree)|raw\.githubusercontent\.com/$repository)/[^/]+/" "$readme" \
    | grep -v "/v$version/\$" || true)
  if [ -n "$stale" ]; then
    echo "$readme: $stale" >&2
    fail "the links above must point to the tag v$version"
  fi
done

if $check; then
  # what an author does: create a work from the published files only, and compile it untouched
  [ -f fonts/NewCMSans10-Regular.otf ] || fail "fonts/ is missing: run \`sh scripts/fonts.sh\`"
  work=$(mktemp -d)
  trap 'rm -rf "$work"' EXIT
  typst init --package-path "$target" "@preview/$name:$version" "$work/work" > /dev/null 2>&1 ||
    fail "typst init does not create a work from the published template"
  typst compile --package-path "$target" --font-path fonts --ignore-system-fonts "$work/work/main.typ" \
    "$work/work.pdf" || fail "a work created from the published template does not compile"

  # versions on Typst Universe are immutable: a fix is a new version
  if curl -fsI "https://packages.typst.org/preview/$name-$version.tar.gz" > /dev/null 2>&1; then
    fail "$name:$version is already on Typst Universe"
  fi

  # the checker of the pull requests of typst/packages, offline, from the package cache the compilation above filled
  if docker info > /dev/null 2>&1; then
    case $out in /*) data=$out ;; *) data=$PWD/$out ;; esac
    cache=$(typst info -f yaml | sed -n 's/^ *package-cache-path: *//p')
    docker run --rm -v "$data:/data" -v "$cache:/.cache/typst/packages:ro" ghcr.io/typst/package-check check ||
      fail "the checker of typst/packages refused the package"
  elif [ -n "${CI:-}" ] && [ -z "${ACT:-}" ]; then
    fail "the CI needs Docker for the checker of typst/packages"
  else
    echo "note: Docker is not running; the checker of typst/packages was skipped" >&2
  fi
fi

echo "$out"
