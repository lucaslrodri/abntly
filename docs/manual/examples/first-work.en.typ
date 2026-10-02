#import "/src/lib.typ": *
// --- example ---
#show: abntly.with(
  lang: "en",
  info: config-info(
    title: [Title of the work],
    author: "Name of the Author",
    advisor: "Prof. Dr. Name Surname",
    institution: [University of Brazil],
    location: [Rio Branco],
    year: 2026,
  ),
)

#cover()
#title-page[Dissertation presented to the
  University of Brazil, as a partial
  requirement for the degree of Master.]
#outline()

= Introduction

The text of the work starts here.

== Objectives

A secondary section.
