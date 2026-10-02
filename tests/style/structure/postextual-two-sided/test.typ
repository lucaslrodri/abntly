/// Synopsis: O sumário, a parte pós-textual e o índice em frente e verso
#import "../../../common.typ": *
#import "../../../../src/lib.typ": index
#show: setup.with(two-sided: true)
#include "../postextual.typ"
// the index of this version, with the pages of its entries written by hand
#index(("ilustração", 5), (term: "mancha gráfica", pages: (3, 7)), (term: "quadro", see: "ilustração"),
  (term: "tabela", pages: 5, sub: ((term: "do IBGE", pages: 5),)), ("Typst", 5))
