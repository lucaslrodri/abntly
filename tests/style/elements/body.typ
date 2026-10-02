/// Subject: Elementos do texto
// A chapter with every element of the text whose form src/elements.typ sets: a figure with its title, source, legend
// and note; a quadro (closed lines); a table in the pattern of the IBGE (a `fitted` with a table with a header),
// with a call and its specific note; a numbered equation, referred to in the text; alíneas with subalíneas; a second
// figure whose title, source, legend and note all take two lines. The table over two pages is in long-table.typ, a
// case of its own. A case includes it after `#show: setup`.
#import "../../../src/lib.typ": source, legend, note, call, frame, fitted

#set heading(numbering: "1.1")

= Elementos do texto

A norma pede que cada ilustração seja precedida da palavra designativa, do número e do título, e seguida da fonte, da
legenda e das notas, como na figura abaixo.

#figure(caption: [Distribuição dos trabalhos acadêmicos por região do país e por área do conhecimento, nos anos de
  2020 a 2024])[
  #rect(width: 8cm, height: 2cm, fill: black)
  #source[IBGE (2025).]
  #legend[Barras: número de trabalhos.]
  #note[Os dados foram coletados durante o segundo semestre de 2024 e revisados pela equipe antes da publicação
    deste trabalho.]
]

O quadro é uma ilustração, e pode ter as linhas fechadas:

#frame(caption: [Tipos de trabalho acadêmico])[
  #table(columns: 2, [Tipo], [Objetivo], [Tese], [Doutorado], [Dissertação], [Mestrado])
  #source()
]

A tabela segue as normas de apresentação tabular do IBGE: três traços horizontais, nenhum nas laterais, a fonte e as
notas no rodapé, o título e o rodapé na largura da tabela.

// the table does not fit what is left of the first page: it starts a page
#pagebreak()
#fitted(caption: [Produção de casulos do bicho-da-seda, por Unidade da Federação -- Brasil -- 1974])[
  #table(columns: (3cm, 3cm, 3cm), align: (left, right, right),
    table.header([Unidade da Federação], [Produção (t)], [Percentual (%)]),
    [Paraná], [4 210], [61,2],
    [São Paulo #call(1)], [2 670], [38,8],
    [Minas Gerais], [-], [-])
  #source[IBGE (1975).]
  #note[Sinal convencional utilizado: - dado numérico igual a zero não resultante de arredondamento.]
  #note(call: 1)[Inclui a produção do Vale do Ribeira.]
]

Os lados de um triângulo retângulo obedecem à relação
$ a^2 + b^2 = c^2 $ <pitagoras>
como mostra a @pitagoras, numerada à direita. As alíneas seguem a NBR 6024:
+ a primeira alínea, com um texto comprido o bastante para quebrar a linha e mostrar onde começa a segunda linha
  do texto;
+ a segunda alínea, com subalíneas:
  - a primeira subalínea, também comprida para quebrar a linha e mostrar onde começa a segunda linha dela;
  - a segunda subalínea;
+ a terceira alínea.

Quando o título, a fonte, a legenda e a nota passam de uma linha, cada um enche a largura da mancha, e as linhas
seguintes começam sob a primeira letra do texto.

// the second figure does not fit the rest of the page: it starts a page
#pagebreak()
#figure(caption: [Distribuição dos trabalhos acadêmicos defendidos entre 2020 e 2024 por região do país, por área do
  conhecimento e por nível do curso, da graduação ao doutorado])[
  #rect(width: 8cm, height: 2cm, fill: black)
  #source[adaptado de Instituto Brasileiro de Geografia e Estatística (2025), com os dados do Censo da Educação
    Superior de 2024 e das bases de teses e dissertações das universidades federais.]
  #legend[as barras escuras mostram os trabalhos de graduação e as claras os de pós-graduação; a linha tracejada
    marca a média nacional de cada região no período.]
  #note[os trabalhos defendidos em mais de uma instituição foram contados uma vez só, na instituição que concedeu
    o título, e os dados de 2024 são preliminares e podem mudar na revisão.]
]

O texto termina aqui.

