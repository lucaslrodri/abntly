// The manual of abntly in English (docs/manual-en.pdf). The content is in `chapters/`, a file per chapter, the
// same files as `../pt/chapters/`, so that the two versions go together and the same sources can feed a site later
// (a page per chapter). Build: `sh scripts/manual.sh`, which renders the pages of the examples first.
#import "prelude.typ": *

#show: project.with(
  title: [abntly],
  subtitle: [Academic works in the ABNT standards, in Typst],
  author: "Lucas Lima Rodrigues",
  date: [October 1, 2026],
  abstract: [
    *abntly* is a #link("https://typst.app")[Typst] template for academic works that comply with the standards of
    the Associação Brasileira de Normas Técnicas (ABNT), especially ABNT NBR 14724:2024, Trabalhos acadêmicos —
    Apresentação. The full list of the standards the package implements is in @norms[Section].
  ],
)

#include "chapters/01-quick-start.typ"
#include "chapters/02-structure.typ"
#include "chapters/03-general-rules.typ"
#include "chapters/04-extras.typ"
#include "chapters/05-references.typ"
#include "chapters/06-api-index.typ"

// the works the examples cite, as the package sets the list of references of a work
#bibliography("../examples/refs.bib")
