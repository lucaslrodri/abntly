#import "/src/lib.typ": *
#import "common/pt.typ": setup
#show: setup
= Resultados

#lorem(150)

// --- example ---
#ajustada(caption: [Produção de casulos do bicho-da-seda, por município -- Paraná -- 1974])[
  #table(columns: (4cm, 3cm, 3cm), align: (left, right, right),
    table.header([Município], [Produção (t)], [Percentual (%)]),
    ..range(1, 41).map(i => ([Município #i], [#(i * 47)], [#(i * 13)])).flatten())
  #fonte[IBGE (1975).]
  #nota[Municípios com produção declarada.]
]
