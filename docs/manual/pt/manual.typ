// The manual of abntly in Portuguese (docs/manual-pt.pdf). The content is in `chapters/`, a file per chapter, the
// same files as `../en/chapters/`, so that the two versions go together and the same sources can feed a site later
// (a page per chapter). Build: `sh scripts/manual.sh`, which renders the pages of the examples first.
#import "prelude.typ": *

#show: project.with(
  title: [abntly],
  subtitle: [Trabalhos acadêmicos nas normas da ABNT, em Typst],
  author: "Lucas Lima Rodrigues",
  date: [1º de outubro de 2026],
  abstract: [
    O *abntly* é um template do #link("https://typst.app")[Typst] para trabalhos acadêmicos condizentes com as
    normas da Associação Brasileira de Normas Técnicas (ABNT), especialmente a ABNT NBR 14724:2024, Trabalhos
    acadêmicos — Apresentação. A lista completa das normas que o pacote atende está na Seção @norms.
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
