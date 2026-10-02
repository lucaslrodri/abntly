// Full example of an academic work with the abntly package, written in English with the English names of the API.
// The example gathers every element of the structure (NBR 14724:2024, section 4) and, in its chapters, the elements
// of the text. The text of each chapter is in a file of the folder `chapters/`.
//
// To compile from the root of the repository:
//   sh scripts/link.sh
//   typst compile --font-path fonts examples/en/main.typ
#import "@preview/abntly:0.1.0": *

#show: abntly.with(
  lang: "en",
  info: config-info(
    title: [Typesetting academic works in Typst],
    subtitle: [a full example in the ABNT standards],
    author: (name: "Name of the", surname: "Author"),
    advisor: (name: "Prof. Dr. Name of the Advisor", gender: "f"),
    co-advisor: "Prof. Dr. Name of the Co-advisor",
    institution: [University of Brazil],
    program: [Graduate Programme in Information Science],
    area: [Organization of information],
    location: [Rio Branco],
    year: 2026,
    work-type: "thesis",
  ),
)

// --- Pre-textual elements -------------------------------------------------------------------------------------------
#cover()

#title-page[
  Thesis presented to the Graduate Programme in Information Science of the University of Brazil, in partial
  fulfilment of the requirements for the degree of Doctor in Information Science.
]

#catalog-card()

#errata[
  AUTHOR, Name of the. *Typesetting academic works in Typst*: a full example in the ABNT standards. 2026. Thesis
  (Doctorate in Information Science) -- University of Brazil, Rio Branco, 2026.

  #align(center, table(columns: 4, align: left, stroke: 0.4pt,
    table.header([*Sheet*], [*Line*], [*Where it reads*], [*Read*]),
    [12], [8], [standardisation], [standardization],
    [27], [3], [Figure 3], [Figure 4],
  ))
]

#approval-page(
  (title: [Prof. Dr.], name: [Name of the Advisor], role: [Supervisor], institution: [University of Brazil]),
  (title: [Prof. Dr.], name: [Name of the Co-advisor], role: [Co-supervisor],
    institution: [University of Brazil]),
  (title: [Prof. Dr.], name: [Name of the First Guest], role: [Guest], institution: [Another University]),
  (title: [Prof. Dr.], name: [Name of the Second Guest], role: [Guest], institution: [Research Institute]),
)

#dedication[
  This work is dedicated to those who read the standards \
  before they start to write.
]

#acknowledgments[
  I thank my advisor, for the careful reading of every version of this work, and my co-advisor, for the suggestions
  on the experiments.

  I thank my colleagues at the laboratory, for the discussions, and my family, for the support during the whole
  course.

  I thank, at last, the people who maintain the open-source programs used to typeset this document.
]

#epigraph[
  _“Text of the epigraph, chosen by the author \
  to open the work.”_ \
  (Author of the epigraph)
]

#abstract[
  This work is an example of an academic work typeset with the abntly package, which applies the ABNT standards
  to documents written in Typst. The example gathers the pre-textual, textual and post-textual elements defined
  by NBR 14724:2024 and shows, in a chapter of its own, how to write sections, lists, citations, footnotes,
  illustrations, tables and equations. The text of the other chapters is only illustrative. The code of this
  example can be used as the starting point of a new work, or read to check how a given element is written.

  #keywords[academic works][standardization][ABNT][Typst]
]

#abstract(lang: "pt")[
  Este trabalho é um exemplo de trabalho acadêmico composto com o pacote abntly, que aplica as normas da ABNT a
  documentos escritos em Typst. O exemplo reúne os elementos pré-textuais, textuais e pós-textuais definidos pela
  NBR 14724:2024 e mostra, em um capítulo próprio, como escrever as seções, as alíneas, as citações, as notas de
  rodapé, as ilustrações, as tabelas e as equações. O texto dos demais capítulos é apenas ilustrativo.

  #keywords[trabalhos acadêmicos][normalização][ABNT][Typst]
]

#list-of-figures()
#list-of-frames()
#list-of-tables()
#list-of(raw, title: [List of Algorithms])

#list-of-acronyms(
  (key: "abnt", short: "ABNT", long: [Brazilian Association of Technical Standards]),
  (key: "ibge", short: "IBGE", long: [Brazilian Institute of Geography and Statistics]),
  (key: "nbr", short: "NBR", long: [Brazilian Standard]),
)

#list-of-symbols(
  ($n$, [Number of documents in the sample]),
  ($overline(x)$, [Arithmetic mean]),
  ($sigma$, [Standard deviation]),
)

#outline()

// --- Textual elements -----------------------------------------------------------------------------------------------
#include "chapters/introduction.typ"

#part[Preparing the research]
#include "chapters/elements.typ"

#part[Background and results]
#include "chapters/background.typ"
#include "chapters/results.typ"

#include "chapters/conclusion.typ"

// --- Post-textual elements ------------------------------------------------------------------------------------------
#bibliography("refs.bib")

#glossary(
  (key: "textblock", short: "text block",
    description: [area of the page bounded by the margins, where the text is printed]),
  (key: "typst", short: "Typst", description: [markup-based typesetting system]),
  (key: "dash", short: "em dash",
    description: [punctuation mark (—) that separates the number and the title of an illustration]),
)

#show: appendix

= Checklist of the work

Before the deposit, the author can check the following items:
+ the required elements are present, in the order of the standard;
+ every illustration and every table has a title and a source and is cited in the text;
+ every work cited is in the list of references.

== Items of the printed version

In the printed version, the links are set in black and the work uses the two-sided margins.

= Additional data

#lorem(60)

#show: annex

= Document prepared by a third party

The annex reproduces a text or a document that was not prepared by the author and that serves as a foundation or
as evidence. #lorem(40)

// --- Index ----------------------------------------------------------------------------------------------------------
#index(
  (term: "Algorithms", pages: 23),
  (term: "Citations", pages: "20-21", sub: ((term: "direct", pages: 21), (term: "indirect", pages: 20))),
  (term: "Equations", pages: 23),
  (term: "Figures", see: "Illustrations"),
  (term: "Footnotes", pages: 21),
  (term: "Frames", pages: 22),
  (term: "Illustrations", pages: "21-22", see-also: "Tables"),
  (term: "Lists", pages: 20),
  (term: "Tables", pages: (23, "29-31")),
)
