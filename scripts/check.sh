#!/bin/sh
# Runs on this machine what .github/workflows/tests.yml runs on the CI: the Tytanic suite (the visual cases against
# their reference pictures and the unit tests), then that the READMEs are in step with the minimal example
# (scripts/readme.sh) and that the pictures and the PDFs of the manual are what the sources give today
# (scripts/manual.sh). It writes nothing but the `out/` and `diff/` folders of Tytanic.
#
# The package must be linked already (`sh scripts/link.sh`, once per clone and per version) and the fonts downloaded
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
[ -f fonts/NewCMSans10-Regular.otf ] || fail "fonts/ is missing: run \`sh scripts/fonts.sh\`"

sh scripts/link.sh --check
tt run --font-path fonts --warnings promote --no-fail-fast
sh scripts/readme.sh --check
sh scripts/manual.sh --check

echo "all checks passed"
