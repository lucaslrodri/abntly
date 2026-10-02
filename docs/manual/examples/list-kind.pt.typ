#import "/src/lib.typ": *
#import "common/pt.typ": setup
#show: setup
// --- example ---
#lista-de("grafico", titulo: [Lista de gráficos])

= Resultados

#figure(kind: "grafico", supplement: [Gráfico], caption: [Trabalhos defendidos por ano],
  rect(width: 6cm, height: 3cm))
