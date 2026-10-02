#import "/src/lib.typ": *
#import "common/pt.typ": setup
#show: setup
// --- example ---
#lista-de-figuras()
#lista-de-quadros()
#lista-de-tabelas()

= Introdução

#figure(caption: [Estrutura do trabalho acadêmico], rect(width: 6cm, height: 2cm))

#quadro(caption: [Tipos de trabalho acadêmico],
  table(columns: 2, [Tese], [Doutorado], [Dissertação], [Mestrado]))

#ajustada(caption: [Trabalhos defendidos por ano])[
  #table(columns: (4cm, 3cm),
    table.header([Ano], [Trabalhos]), [2024], [120], [2025], [135])
]
