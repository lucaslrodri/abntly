// A table of the IBGE in a plain figure (`ibge-table`), over the same table in a `fitted`: the same rules and the
// reduced text in both, the title and the source at the width of the text block in the first, at the width of the
// table in the second; an `ibge-table` inside a `fitted`, which takes one set of rules, not two; and the paragraph
// that goes on after an equation without the indent of its first line (`no-indent`). The case ibge-table includes it
// after `#show: setup`.
#import "../../../src/lib.typ": source, note, call, fitted, ibge-table, no-indent

#set heading(numbering: "1.1")

= Tabela em figura comum

A Tabela 1 está em uma `figure` comum: o título e a fonte ocupam a largura da mancha, e a tabela tem os traços do
IBGE, como a Tabela 2, em uma `fitted`.

#figure(caption: [Produção de casulos do bicho-da-seda, por Unidade da Federação -- Brasil -- 1974])[
  #ibge-table(columns: (4cm, 3cm, 3cm), align: (left, right, right),
    table.header([Unidade da Federação], [Produção (t)], [Percentual (%)]),
    [Paraná], [4 210], [61,2],
    [São Paulo #call(1)], [2 670], [38,8])
  #source[IBGE (1975).]
  #note(call: 1)[Inclui a produção do Vale do Ribeira.]
]

#fitted(caption: [Produção de casulos do bicho-da-seda, por Unidade da Federação -- Brasil -- 1974])[
  #table(columns: (4cm, 3cm, 3cm), align: (left, right, right),
    table.header([Unidade da Federação], [Produção (t)], [Percentual (%)]),
    [Paraná], [4 210], [61,2],
    [São Paulo], [2 670], [38,8])
  #source[IBGE (1975).]
]

A Tabela 3 é uma `ibge-table` dentro de uma `fitted`: um só conjunto de traços.

#fitted(caption: [Produção de casulos -- Brasil -- 1974])[
  #ibge-table(columns: (4cm, 3cm), align: (left, right),
    table.header([Unidade da Federação], [Produção (t)]),
    [Paraná], [4 210],
    [São Paulo], [2 670])
  #source[IBGE (1975).]
]

A produção total é dada por
$ P = sum_i p_i $

#no-indent[em que $p_i$ é a produção de cada unidade: o parágrafo que continua a equação depois de uma linha em
  branco começa sem o recuo da primeira linha.]
