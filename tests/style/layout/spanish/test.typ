/// Synopsis: Um trabalho em espanhol, um idioma sem tradução no pacote: as palavras em `names` e o idioma por regra
#import "../../../common.typ": *
#import "../../../../src/lib.typ": config-names
#show: setup.with(names: config-names(chapter: "Capítulo", contents: "Índice", references: "Referencias",
  algorithm: "Algoritmo", frame: "Cuadro", source: "Fuente", legend: "Leyenda", note: "Nota",
  own-work: "elaboración propia.", part: "Parte", continues: "(continúa)", continuation: "(continuación)",
  conclusion: "(conclusión)"))
#set text(lang: "es")
#include "../body.typ"
