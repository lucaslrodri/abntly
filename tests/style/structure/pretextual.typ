// The pages of the pre-textual part around the data pages (src/structure.typ): the errata, with an example (the
// reference of the work and the table of the corrections, as the author writes them); the dedication, in the middle of
// its page, centred and in italic; the acknowledgments, with a footnote; the epigraph, at the foot of its page and to
// the right. A first chapter after them, as in a work. The cases pretextual and pretextual-two-sided include it after
// `setup`.
#import "../../../src/lib.typ": errata, dedication, acknowledgments, epigraph

#errata[
  Elemento opcional da ABNT (2024, 4.2.1.2). Exemplo:

  #v(1.2em)
  AUTOR, N. do. *Título do trabalho*: subtítulo. 2026. 24 f. Tese (Doutorado) -- Universidade do Brasil,
  Brasil, 2026.

  // the columns of the table of the corrections: the width of the text of each (1.4 cm, 1 cm and twice 3 cm) and
  // the space at its sides (6 pt)
  #align(center, text(size: 10em / 12, table(columns: (1.4cm, 1cm, 3cm, 3cm).map(w => w + 12pt), stroke: 0.4pt,
    align: left, inset: (x: 6pt),
    [*Folha*], [*Linha*], [*Onde se lê*], [*Leia-se*],
    [16], [10], [auto-clavado], [autoclavado])))
]

#dedication[Este trabalho é dedicado aos meus pais,\ que me ensinaram a ler.]

#acknowledgments[
  Ao orientador, Prof. Dr. Nome do Orientador, e ao coorientador, Prof. Dr. Nome do Coorientador, pela orientação.

  À Universidade do Brasil e ao Programa de Pós-Graduação, pela acolhida.

  Aos colegas do laboratório, pelas conversas sobre margens, entrelinhas e notas de rodapé#footnote[Uma nota de
    rodapé nos agradecimentos, numa página pré-textual.].
]

#epigraph[_“A forma é o conteúdo\ que sobe à superfície.”\ (Autor desconhecido)_]

= Introdução

#lorem(30)
