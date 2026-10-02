/// Subject: Layout da página
// The pages of a work, as the layout of the package sets them (src/layout.typ): two pre-textual elements, counted
// without a number; two primary sections (chapters), the first one with two sections, one of them with a title long
// enough to take two lines in the running header, and a subsection, over pages enough to show a recto and a verso; a
// footnote in each chapter, the second one numbered 1 again; a table of the IBGE with the call of a specific note,
// linked to it; the references, post-textual, over two pages. The textual part starts by itself, at the first
// numbered heading. The cases of the subject set it one-sided, two-sided, in English, in Spanish and without links.
#import "../../../src/lib.typ": source, note, call, fitted

#heading(numbering: none)[Resumo]

#lorem(120)

#heading(numbering: none)[Agradecimentos]

#lorem(80)

= Introdução

#lorem(150)#footnote[Uma nota de rodapé no primeiro capítulo, cujo número leva de volta à chamada.]

#lorem(150)

== Primeira seção

#lorem(150)

#lorem(150)

== Uma seção de título comprido o bastante para ocupar duas linhas no cabeçalho corrido de uma página ímpar

#lorem(150)

=== Uma subseção, que não vai ao cabeçalho

#lorem(150)

#lorem(150)

#lorem(150)

= Desenvolvimento

#lorem(100)#footnote[A primeira nota do segundo capítulo: a numeração recomeça.]

#fitted(caption: [Produção de casulos por região])[
  #table(columns: (4cm, 3cm), align: (left, right),
    table.header([Região], [Produção (t)]),
    [Sul #call(1)], [4 210],
    [Sudeste], [2 670])
  #source[IBGE (1975).]
  #note(call: 1)[Inclui a produção do Vale do Ribeira.]
]

== Uma seção do segundo capítulo

#lorem(150)

#lorem(150)

#heading(numbering: none)[Referências]

#lorem(150)

#lorem(150)

#lorem(150)

#lorem(150)
