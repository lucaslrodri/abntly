#import "@preview/abntly:0.1.0": *

= Resultados <cap-resultados>

Este capítulo mostra uma tabela que ocupa mais de uma página e uma tabela deitada. O restante do texto é de
preenchimento.

== Tabela em mais de uma página

A #auto-ref(<tab-longa>) não cabe em uma página. O título e o cabeçalho são repetidos na página seguinte, com as
indicações "(continua)" e "(conclusão)".

#ajustada(rotulo: <tab-longa>, caption: [Documentos analisados, por município -- 2025])[
  #table(columns: (5cm, 3cm, 3cm), align: (left, right, right),
    table.header([Município], [Documentos], [Percentual (%)]),
    ..range(1, 46).map(i => ([Município #i], [#(i * 37)], [#calc.round(i * 37 / 383.0, digits: 1)])).flatten())
  #fonte()
  #nota[Dados fictícios, usados apenas neste exemplo.]
]

== Tabela deitada

Uma tabela mais larga que a mancha gráfica pode ser girada, em uma página própria, com a função `deitada`.

#deitada[
  #ajustada(caption: [Documentos analisados, por região e por ano])[
    #table(columns: (3cm,) + (2.4cm,) * 6, align: (left,) + (right,) * 6,
      table.header([Região], [2020], [2021], [2022], [2023], [2024], [2025]),
      [Norte], [190], [210], [230], [250], [260], [280],
      [Nordeste], [520], [540], [570], [590], [610], [640],
      [Centro-Oeste], [240], [250], [270], [280], [300], [310],
      [Sudeste], [980], [1 010], [1 040], [1 090], [1 120], [1 160],
      [Sul], [390], [410], [420], [440], [450], [470])
    #fonte()
  ]
]

== Discussão

#lorem(220)

#lorem(180)
