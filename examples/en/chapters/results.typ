#import "@preview/abntly:0.1.0": *

= Results <ch-results>

This chapter shows a table that takes more than one page and a table lying on its side. The rest of the text is
filler.

== A table over more than one page

#auto-ref(<tab-long>) does not fit one page. Its title and its header are repeated on the next page, with the marks
"(continued)" and "(concluded)".

#fitted(label: <tab-long>, caption: [Documents analysed, by municipality -- 2025])[
  #table(columns: (5cm, 3cm, 3cm), align: (left, right, right),
    table.header([Municipality], [Documents], [Percentage (%)]),
    ..range(1, 46).map(i => ([Municipality #i], [#(i * 37)], [#calc.round(i * 37 / 383.0, digits: 1)])).flatten())
  #source()
  #note[Fictitious data, used only in this example.]
]

== A table lying on its side

A table wider than the text block can be turned, on a page of its own, with the function `sideways`.

#sideways[
  #fitted(caption: [Documents analysed, by region and by year])[
    #table(columns: (3cm,) + (2.4cm,) * 6, align: (left,) + (right,) * 6,
      table.header([Region], [2020], [2021], [2022], [2023], [2024], [2025]),
      [North], [190], [210], [230], [250], [260], [280],
      [Northeast], [520], [540], [570], [590], [610], [640],
      [Centre-West], [240], [250], [270], [280], [300], [310],
      [Southeast], [980], [1 010], [1 040], [1 090], [1 120], [1 160],
      [South], [390], [410], [420], [440], [450], [470])
    #source()
  ]
]

== Discussion

#lorem(220)

#lorem(180)
