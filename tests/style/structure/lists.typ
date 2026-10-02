// The lists of illustrations and of tables (src/structure.typ): of the figures, of the quadros and of the tables,
// one after the other, and a chapter with what they list: two figures, the second with a title of two lines in the
// list, a quadro and a table of the IBGE. The cases lists and lists-two-sided include it after `setup`.
#import "../../../src/lib.typ": list-of-figures, list-of-frames, list-of-tables, source, frame, fitted

#list-of-figures()
#list-of-frames()
#list-of-tables()

= Introdução

#lorem(20)

#figure(caption: [Distribuição dos trabalhos acadêmicos por região do país])[
  #rect(width: 6cm, height: 1cm, fill: black)
  #source[IBGE (2025).]
]

#figure(caption: [Número de trabalhos acadêmicos defendidos nas universidades públicas e privadas do país, por região
  e por área do conhecimento])[
  #rect(width: 6cm, height: 1cm, fill: black)
  #source[IBGE (2025).]
]

#frame(caption: [Tipos de trabalho acadêmico])[
  #table(columns: 2, [Tipo], [Objetivo], [Tese], [Doutorado])
  #source[Elaboração própria.]
]

#fitted(caption: [Produção de casulos do bicho-da-seda, por Unidade da Federação -- Brasil -- 1974])[
  #table(columns: 3, align: (left, right, right),
    table.header([Unidade da Federação], [Produção (t)], [Percentual (%)]),
    [Paraná], [4~210], [61,2])
  #source[IBGE (1975).]
]
