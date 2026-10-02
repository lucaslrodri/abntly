// Every page of the structure the other cases of this subject set, one after the other, to see whether the layout
// overflows when the size of the body changes (as tests/style/typography/every-case.typ does for the chapters of the
// text): the data pages (the cover, the title page, the catalog card, the approval sheet), the pages of the
// pre-textual part, the abstracts, the lists, the acronyms and the symbols, the summary and the post-textual part with
// its appendices and annexes, and the index. The cases every-case-12pt, every-case-11pt and
// every-case-11pt-two-sided set it with each body and side, with the data of info.typ; in each, no letter or rule may
// be out of the text block, no line below it and no line on top of another. Each `include` keeps its `set` rules to
// itself.
#import "../../../src/lib.typ": index
#include "body.typ"
#include "pretextual.typ"
#include "abstracts.typ"
#include "lists.typ"
#include "acronyms.typ"
#include "postextual.typ"
#index(("ilustração", 3), (term: "mancha gráfica", pages: (2, 4)), (term: "quadro", see: "ilustração"),
  (term: "tabela", pages: 3, sub: ((term: "do IBGE", pages: 3),)), ("Typst", 3))
