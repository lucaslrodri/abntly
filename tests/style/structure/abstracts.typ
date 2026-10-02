// The two abstracts (src/structure.typ): the one in Portuguese, of two paragraphs, and the one in English, each with
// its keywords; a first chapter after them, as in a work. The cases abstracts and abstracts-two-sided include it
// after `setup`.
#import "../../../src/lib.typ": abstract, keywords

#abstract[
  Este trabalho apresenta uma forma de compor um trabalho acadêmico conforme as normas da Associação Brasileira de
  Normas Técnicas: o pacote abntly, escrito em Typst, que aplica as regras ao documento inteiro. A pesquisa parte da
  NBR 14724, que dá a estrutura do trabalho e as regras gerais de apresentação, e das normas que ela cita para o
  resumo, o sumário, as citações e as referências.

  Para cada elemento, um caso de teste compõe um pequeno trabalho, e as páginas de cada caso são comparadas com as
  imagens de referência.

  #keywords[composição tipográfica][trabalhos acadêmicos][ABNT][normalização][Typst]
]

#abstract(lang: "en")[
  This work presents a way of typesetting an academic work according to the standards of the Brazilian Association
  of Technical Standards: the abntly package, written in Typst, which applies the rules to the whole document.

  #keywords[typesetting][academic works][ABNT][standardization][Typst]
]

= Introdução

#lorem(30)
