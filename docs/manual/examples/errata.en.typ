#import "/src/lib.typ": *
#import "common/en.typ": setup
#show: setup
#title-page[Thesis presented to the Graduate Programme of the University of Brazil, as a partial
  requirement for the degree of Doctor.]
// --- example ---
#errata[
  AUTHOR, Name of the. *Title of the work*: subtitle. 2026. 120 f. Thesis (Doctorate) --
  University of Brazil, Rio Branco, 2026.

  #align(center, table(columns: 4, align: left, stroke: 0.4pt,
    table.header([*Sheet*], [*Line*], [*Reads*], [*Should read*]),
    [16], [10], [auto-claved], [autoclaved],
    [23], [4], [analisys], [analysis],
  ))
]
