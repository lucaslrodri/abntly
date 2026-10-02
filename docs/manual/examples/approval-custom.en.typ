#import "/src/lib.typ": *
#import "common/en.typ": setup
#show: setup
#title-page[Thesis presented to the Graduate Programme of the University of Brazil, as a partial
  requirement for the degree of Doctor.]
#let advisor = (title: [Prof. Dr.], name: [Name of the Advisor], role: [Advisor],
  institution: [University of Brazil])
#let examiner = (title: [Prof. Dr.], name: [Name of the Examiner], role: [Examiner],
  institution: [Institution of the examiner])
// --- example ---
#approval-page(bottom: with-info(d => {
  align(left)[Approved on:
    #box(width: 3cm, repeat[\_])]
  v(1cm)
  grid(columns: 2,
    signature(advisor),
    signature(examiner))
  v(1cm)
  [#d.location \ #d.year]
}))
