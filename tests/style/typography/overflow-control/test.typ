/// Synopsis: O controle dos casos de estouro: uma página que estoura de cada jeito que os outros casos não podem mostrar
// What the every-case cases must not show, set on purpose: a word that cannot break, past the right margin; a table
// of the IBGE wider than the text block, its rules and letters out of it; a line placed on top of another; a block
// that cannot break, taller than what is left of the page, its lines below the text block.
#import "../../../common.typ": *
#import "../../../../src/lib.typ": fitted, source
#show: setup
#set text(size: 11pt)

= Um capítulo que estoura

#text(hyphenate: false)[Umapalavraquenaopodequebraremlugarnenhumeporissopassadamargemdireitadapaginadotrabalhoacademicoemonze]

#fitted(caption: [Larga demais], width: 18cm)[
  #table(columns: (9cm, 9cm), align: (left, right), table.header([Região], [Valor]), [Sul], [10])
  #source[IBGE.]
]

Uma linha de texto comum.#place(dy: -0.9em)[Uma linha por cima da outra.]

#block(breakable: false)[#lorem(800)]
