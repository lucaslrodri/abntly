#import "/src/lib.typ": *
#import "common/pt.typ": setup
#show: setup
= Resultados

Texto antes da tabela.

// --- example ---
#deitada[
  #ajustada(caption: [Trabalhos defendidos
    por região e por ano])[
    #table(
      columns: (3cm,) + (2.4cm,) * 6,
      align: (left,) + (right,) * 6,
      table.header([Região],
        [2019], [2020], [2021],
        [2022], [2023], [2024]),
      [Norte], [190], [210], [230], [250],
      [260], [280],
      [Sul], [390], [410], [420], [440],
      [450], [470])
    #fonte()
  ]
]
