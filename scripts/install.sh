#!/bin/sh
# Installs the package as it is at the latest version tag on GitHub (the highest `v<major>.<minor>.<patch>`) into
# Typst's local package directory, under the `local` namespace: `#import "@local/abntly:<version>": *` and
# `typst init @local/abntly:<version> <folder>` then work without Typst Universe, before the version reaches it.
#
# Only the files published on Typst Universe are installed (the list below, kept in step with scripts/package.sh).
# The template imports the package as `@preview/abntly:<version>`, as Typst Universe requires; the installed copy
# imports it from `@local`, so that a work created from it compiles. Running it again replaces that version.
#
#   sh scripts/install.sh
#   curl -fsSL https://raw.githubusercontent.com/lucaslrodri/abntly/main/scripts/install.sh | sh
#
# It does not depend on the working copy, hence the second form. On Windows, use scripts/install.ps1.
# `TYPST_PACKAGE_PATH`, when set, replaces the local package directory, as it does for Typst.
set -eu

repo=lucaslrodri/abntly
files="typst.toml LICENSE README.md thumbnail.png src template"

fail() {
  echo "error: $*" >&2
  exit 1
}

# The tags come sorted by name, not by version: v0.10.0 would come before v0.9.0.
tags=$(curl -fsSL "https://api.github.com/repos/$repo/tags?per_page=100") || fail "could not list the tags of $repo"
version=$(printf '%s\n' "$tags" |
  sed -n 's/.*"name": *"v\([0-9]*\.[0-9]*\.[0-9]*\)".*/\1/p' |
  sort -t . -k 1,1n -k 2,2n -k 3,3n | tail -n 1)
[ -n "$version" ] || fail "no tag v<major>.<minor>.<patch> found in $repo"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
curl -fsSL -o "$tmp/source.tar.gz" "https://github.com/$repo/archive/refs/tags/v$version.tar.gz"
tar -xzf "$tmp/source.tar.gz" -C "$tmp"
tree=$(find "$tmp" -mindepth 1 -maxdepth 1 -type d | head -n 1)

name=$(sed -n 's/^name *= *"\(.*\)"/\1/p' "$tree/typst.toml" | head -n 1)
manifest=$(sed -n 's/^version *= *"\(.*\)"/\1/p' "$tree/typst.toml" | head -n 1)
[ "$manifest" = "$version" ] || fail "the tag v$version holds version $manifest in typst.toml"

if [ -n "${TYPST_PACKAGE_PATH:-}" ]; then
  packages=$TYPST_PACKAGE_PATH
else
  case "$(uname -s)" in
    Darwin) packages="$HOME/Library/Application Support/typst/packages" ;;
    *) packages="${XDG_DATA_HOME:-$HOME/.local/share}/typst/packages" ;;
  esac
fi
out="$packages/local/$name/$version"

# A symlink there points to a working copy, as scripts/link.sh makes under `preview`: it is left alone.
[ -L "$out" ] && fail "$out is a symlink; remove it first"
rm -rf "$out"
mkdir -p "$out"
for f in $files; do
  [ -e "$tree/$f" ] || fail "$f is missing from the tag v$version"
  cp -R "$tree/$f" "$out/$f"
done

find "$out/template" -name '*.typ' | while read -r f; do
  sed "s|@preview/$name:$version|@local/$name:$version|g" "$f" > "$f.tmp"
  mv "$f.tmp" "$f"
done

echo "@local/$name:$version -> $out"
