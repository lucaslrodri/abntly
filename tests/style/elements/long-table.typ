// A table over two pages (a `fitted` with a table with a header), as the IBGE (8.3) asks: the header on every page,
// "(continua)" on the first, the title again with "(conclusão)" on the last, the closing rule and the source only
// there. The case long-table includes it after `#show: setup`.
#import "../../../src/lib.typ": source, note, fitted

#set heading(numbering: "1.1")

= Tabela em duas páginas

A tabela abaixo não cabe na página: o cabeçalho volta na página seguinte, com o título e a palavra de cada página.

#fitted(caption: [Produção de casulos do bicho-da-seda, por município -- Paraná -- 1974])[
  #table(columns: (3cm, 3cm, 3cm), align: (left, right, right),
    table.header([Município], [Produção (t)], [Percentual (%)]),
    ..range(1, 41).map(i => ([Município #i], [#(i * 47)], [#(i * 13)])).flatten())
  #source[IBGE (1975).]
  #note[Municípios com produção declarada.]
]
