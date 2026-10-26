#!/bin/sh
# Runs on this machine what .github/workflows/tests.yml runs on the CI: the Tytanic suite (the visual cases against
# their reference pictures and the unit tests), then that the READMEs are in step with the minimal example
# (scripts/readme.sh) and that the pictures and the PDFs of the manual are what the sources give today
# (scripts/manual.sh). It writes nothing but the `out/` and `diff/` folders of Tytanic.
#
# The name of the package, `@preview/abntly:<version>`, is linked to this working copy by gotpm, in a temporary
# package folder of the run (so a new version needs no step of its own). The fonts must be downloaded
# (`sh scripts/fonts.sh`): only fonts/ and the fonts embedded in Typst are used, so the result does not depend on
# the fonts of the machine.
set -eu
cd "$(dirname "$0")/.."

fail() {
  echo "error: $*" >&2
  exit 1
}

command -v typst > /dev/null || fail "typst is not installed"
command -v tt > /dev/null || fail "tt (Tytanic) is not installed"
command -v gotpm > /dev/null || fail "gotpm is not installed (CONTRIBUTING.md, Setup)"
[ -f fonts/NewCMSans10-Regular.otf ] || fail "fonts/ is missing: run \`sh scripts/fonts.sh\`"

# @preview/abntly:<version>, the name the template and the examples import, resolves to this working copy only
# while the script runs: gotpm links it in a package folder of its own (TYPST_PACKAGE_PATH, read by typst, tt and
# gotpm), never in the system's, so every other work keeps getting the version published on Typst Universe
TYPST_PACKAGE_PATH=$(mktemp -d)
export TYPST_PACKAGE_PATH
trap 'rm -rf "$TYPST_PACKAGE_PATH"' EXIT
gotpm install -e -n preview > /dev/null
tt run --font-path fonts --warnings promote --no-fail-fast
sh scripts/readme.sh --check
sh scripts/manual.sh --check

echo "all checks passed"
