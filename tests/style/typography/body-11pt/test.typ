/// Synopsis: A seção fictícia com o corpo de 11 pt, mudado por uma regra `set`, e uma tabela
// The size of the body is not an option of `abntly`: the author sets it after `#show: abntly`, and every other size
// follows it, in `em` (src/fonts.typ). The mock section and a table of the IBGE after it show the sizes.
#import "../../../common.typ": *
#import "../../../../src/lib.typ": fitted, source
#show: setup
#set text(size: 11pt)
#include "../body.typ"

#fitted(caption: [Uma tabela no corpo de 11 pt])[
  #table(columns: (3cm, 3cm), align: (left, right), table.header([Unidade], [Produção]), [Paraná], [4 210])
  #source[IBGE (1975).]
]
