#import "/src/lib.typ": *
#import "common/pt.typ": setup
#show: setup
= Introdução

#lorem(900)

// --- example ---
#indice(
  (termo: "Aeronáutica", paginas: (1, "2-3")),
  (termo: "Aviação", ver: "Aeronáutica"),
  (termo: "Escabiose", paginas: 2, sub: (
    (termo: "diagnóstico", paginas: 2),
    (termo: "tratamento", paginas: "2-3"),
  )),
  (termo: "Férias", paginas: (1, 3), ver-tambem: "Licença"),
  ("Licença", 3),
)
