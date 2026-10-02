/// Synopsis: O sumário, as referências marcando a parte pós-textual, o glossário, os apêndices, o anexo e o índice
#import "../../../common.typ": *
#import "../../../../src/lib.typ": index
#show: setup
#include "../postextual.typ"
// the index of this version, with the pages of its entries written by hand
#index(("ilustração", 3), (term: "mancha gráfica", pages: (2, 4)), (term: "quadro", see: "ilustração"),
  (term: "tabela", pages: 3, sub: ((term: "do IBGE", pages: 3),)), ("Typst", 3))
