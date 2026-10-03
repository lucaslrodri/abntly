// Minimal academic work: only the required elements of ABNT NBR 14724:2024, in the order of the standard.
#import "@preview/abntly:0.1.0": *

#show: abntly.with(
  lang: "en",
  info: config-info(
    title: [Title of the work],
    author: "Name of the Author",
    advisor: "Prof. Dr. Name of the Advisor",
    institution: [University of Brazil],
    location: [Rio Branco],
    year: 2026,
  ),
)

// Pre-textual elements
#cover()
#title-page[
  Dissertation presented to the University of Brazil, in partial fulfilment of the requirements for the degree of
  Master.
]
#catalog-card()
#approval-page(
  (title: [Prof. Dr.], name: [Name of the Advisor], institution: [University of Brazil]),
  (title: [Prof. Dr.], name: [Name of the Examiner], institution: [Another University]),
)
#abstract[
  Abstract text, in a single paragraph.

  #keywords[first][second][third]
]
#abstract(lang: "pt")[
  Texto do resumo, em um único parágrafo.

  #keywords[primeira][segunda][terceira]
]
#outline()

// Textual elements
= Introduction

Text of the introduction, with a citation @luck2010.

= Development

Text of the development.

= Conclusion

Text of the conclusion.

// Post-textual elements
#bibliography("refs.bib")
