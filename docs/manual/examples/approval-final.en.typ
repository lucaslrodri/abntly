#import "/src/lib.typ": *
#import "common/en.typ": setup
#show: setup
#title-page[Thesis presented to the Graduate Programme of the University of Brazil, as a partial
  requirement for the degree of Doctor.]
#let advisor = (title: [Prof. Dr.], name: [Name of the Advisor], role: [Advisor],
  institution: [University of Brazil])
#let first-examiner = (title: [Prof. Dr.], name: [Name of Examiner 1], role: [Examiner 1],
  institution: [Another University])
#let second-examiner = (title: [Prof. Dr.], name: [Name of Examiner 2], role: [Examiner 2],
  institution: [Research Institute])
// --- example ---
#approval-page(
  advisor,
  first-examiner,
  second-examiner,
  date: [September 30, 2026],
  draft: false,
)
