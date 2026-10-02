#import "/src/lib.typ": *
#import "common/en.typ": setup
#show: setup
= Results

#lorem(150)

// --- example ---
#fitted(caption: [Production of silkworm cocoons, by municipality -- Paraná -- 1974])[
  #table(columns: (4cm, 3cm, 3cm), align: (left, right, right),
    table.header([Municipality], [Production (t)], [Percentage (%)]),
    ..range(1, 41).map(i => ([Municipality #i], [#(i * 47)], [#(i * 13)])).flatten())
  #source[IBGE (1975).]
  #note[Municipalities with declared production.]
]
