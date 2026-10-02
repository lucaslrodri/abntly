// The work of the page examples of the manual in English: the main function with the data every example shares
// (the ones the manual shows in its section on the data of the work). An example applies it before its marker
// line, so that only the element it is about is shown.
#import "/src/lib.typ": *

#let setup = abntly.with(lang: "en", info: config-info(
  title: [Title of the work],
  subtitle: [subtitle],
  author: "Name of the Author",
  advisor: (name: "Prof. Dr. Name of the Advisor", gender: "f"),
  institution: [University of Brazil],
  program: [Graduate Programme],
  location: [Rio Branco],
  year: 2026,
  work-type: "thesis",
))
