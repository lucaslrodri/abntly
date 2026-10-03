#import "../prelude.typ": *
#show: chapter.with(title: [Regras gerais de apresentação], id: <general-rules>)

A seção 5 da ABNT NBR 14724:2024 define as regras gerais de apresentação do trabalho: formato, espaçamento,
paginação, numeração das seções, citações, siglas, equações, ilustrações e tabelas. A função principal aplica
essas regras a todo o documento (@main-function[Seção]). Este capítulo descreve cada regra, o que o pacote faz e o
que cabe ao autor escrever.

== Formato e margens <format>

#norm-box("NBR 14724:2024, 5.1", "required", "implemented")[
  O texto deve ser apresentado em cor preta; outras cores podem ser usadas apenas nas ilustrações. Se impresso, o
  trabalho deve usar papel branco ou reciclado, no formato A4. As margens do anverso são de 3 cm (esquerda e
  superior) e de 2 cm (direita e inferior); no verso, de 3 cm (direita e superior) e de 2 cm (esquerda e inferior).
  Os elementos pré-textuais começam no anverso da folha, com exceção da ficha catalográfica. Recomenda-se que os
  elementos textuais e pós-textuais sejam apresentados no anverso e no verso das folhas.
]

A função principal define o formato A4 e as margens da norma. Por padrão, o trabalho é formatado para leitura na
tela ou para impressão apenas no anverso: todas as páginas têm as margens do anverso.

Com `frente-e-verso: true`, o trabalho é formatado para impressão nos dois lados da folha. As margens do verso são
espelhadas, as seções primárias e os elementos pré-textuais começam em página ímpar, e o número da página fica no
lado externo. O exemplo a seguir mostra uma página par (verso) e uma página ímpar (anverso).

#page-example("two-sided", pages: (2, 3))

#remark[
  Por padrão, os links (remissões, citações, sumário e endereços) são exibidos na cor `indigo-escuro`, o que
  facilita a leitura na tela. Na versão impressa, em que todo o texto deve ser preto, use `hiperlink: black` na
  função principal.
]

== Fonte <font>

#norm-box("NBR 14724:2024, 5.1", "recommended", "implemented")[
  Recomenda-se a fonte tamanho 12 para todo o texto, inclusive a capa. As citações com mais de três linhas, as
  notas de rodapé, a paginação, a ficha catalográfica e as fontes e legendas das ilustrações e das tabelas devem
  ter tamanho menor e uniforme.
]

O texto é composto em tamanho 12. Os elementos que a norma manda reduzir são compostos em tamanho 10. O texto
das tabelas também usa o tamanho 10, que pode ser alterado no parâmetro `tamanho-da-fonte-da-tabela` da função
principal.

Todos os tamanhos são proporcionais ao tamanho do texto. Para alterá-lo, use uma regra `set` após a chamada da
função principal, como em `#set text(size: 11pt)`.

#remark[
  A norma não define a família tipográfica. O pacote usa a New Computer Modern, com serifa no texto e sem serifa
  nos títulos #pill("decision"). Na capa, na folha de rosto e na folha de aprovação, o título e os demais elementos
  usam tamanhos maiores que 12 #pill("decision").
]

== Espaçamento <spacing>

#norm-box("NBR 14724:2024, 5.2", "required", "implemented")[
  Todo o texto deve ser digitado com espaçamento de 1,5 entre as linhas. São digitados em espaço simples: as
  citações com mais de três linhas, as notas de rodapé, as referências, os títulos das ilustrações e das tabelas,
  as fontes e as legendas, e a natureza do trabalho. As referências são separadas entre si por um espaço simples em
  branco.
]

O pacote aplica o espaçamento de 1,5 ao texto e o espaço simples aos elementos listados pela norma. Nenhuma
configuração é necessária.

#remark[
  A norma não define o recuo nem o espaço entre os parágrafos. O pacote usa um recuo de 1,3 cm na primeira linha
  e acrescenta 0,2 cm entre os parágrafos #pill("decision"). Para alterá-los, use uma regra `set par` após a
  chamada da função principal.
]

O parágrafo que continua depois de uma equação destacada, de uma citação longa ou de uma lista pertence ao anterior
e começa sem o recuo: escreva-o com `sem-recuo`.

```example
A potência é dada por
$ P = V I $

#sem-recuo[em que $V$ é a tensão e $I$ a corrente.]
```

#reference("sem-recuo")

== Paginação <pagination>

#norm-box("NBR 14724:2024, 5.3", "required", "implemented")[
  As páginas pré-textuais são contadas a partir da folha de rosto, mas não são numeradas. A numeração aparece a
  partir da primeira página da parte textual, em algarismos arábicos, no canto superior direito, a 2 cm da borda
  superior, com o último algarismo a 2 cm da borda direita. Em trabalhos em frente e verso, o número fica no canto
  superior direito do anverso e no canto superior esquerdo do verso. As páginas dos apêndices e dos anexos
  continuam a numeração do texto.
]

O pacote conta as páginas a partir da folha de rosto e exibe o número a partir da primeira seção primária
numerada, na posição definida pela norma. A capa não é contada. O exemplo a seguir mostra o topo de duas páginas
do trabalho em frente e verso da @format[Seção].

#page-example("two-sided", pages: (2, 3), crop: (0, 0.13))

#remark[
  Ao lado do número, o pacote exibe um cabeçalho com o título da seção primária, em itálico, sobre um traço. Em
  frente e verso, a página ímpar exibe o título da seção secundária. A página que abre uma seção primária exibe
  apenas o número. A norma não prevê esse cabeçalho #pill("decision").
]

O cabeçalho identifica a seção primária pela palavra "Capítulo". Como a norma organiza o trabalho em seções, e
não em capítulos, a palavra pode ser substituída no parâmetro `nomes` da função principal:

```typ
#show: trabalho-academico.with(
  nomes: config-nomes(chapter: "Seção"),
)
```

== Seções <sections>

#norm-box("NBR 14724:2024, 5.2.2, 5.2.3 e 5.4; NBR 6024:2012, 4.1", "required", "implemented")[
  O indicativo numérico de uma seção, em algarismos arábicos, precede o título, alinhado à esquerda e separado por
  um espaço, sem ponto, hífen ou outro sinal. A numeração progressiva vai até a seção quinária. Os títulos das
  seções primárias começam em página nova (em página ímpar, nos trabalhos em frente e verso). Em um título com mais
  de uma linha, as linhas seguintes são alinhadas sob a primeira letra do título. Os títulos são destacados
  tipograficamente, de forma hierárquica, no texto e no sumário. Os títulos sem indicativo numérico, como os da
  errata, dos resumos, das listas, do sumário e das referências, são centralizados.
]

As seções são escritas com os títulos do Typst, de `=` (seção primária) a `=====` (seção quinária). O pacote
numera os títulos, abre uma página nova a cada seção primária e destaca os níveis pelo tamanho da fonte, como no
exemplo a seguir.

#page-example("headings", crop: (0, 0.62))

Para um título sem indicativo numérico, use `#heading(numbering: none)[Título]`. Um título primário sem indicativo é
centralizado.

#remark[
  A norma pede que os títulos sejam separados do texto por um espaço de 1,5 entre as linhas. O pacote usa
  distâncias próprias, maiores antes do título que depois dele, para ligar o título ao texto que o segue
  #pill("decision").
]

== Alíneas e subalíneas <items>

#norm-box("NBR 6024:2012, 4.2 e 4.3", "required", "implemented")[
  Os assuntos de uma seção que não têm título próprio são subdivididos em alíneas. O texto que antecede as alíneas
  termina em dois-pontos. Cada alínea é indicada por uma letra minúscula seguida de parêntese, com recuo em relação
  à margem esquerda. O texto da alínea começa por letra minúscula e termina em ponto e vírgula; a última termina em
  ponto final. As linhas seguintes do texto começam sob a primeira letra do texto da alínea. As subalíneas começam
  por travessão seguido de espaço, com recuo em relação à alínea, e o texto da alínea que as antecede termina em
  dois-pontos.
]

As alíneas são escritas com a lista numerada do Typst (`+`), e as subalíneas, com uma lista (`-`) dentro de uma
alínea. O pacote gera as letras, os travessões e os recuos. A pontuação do texto é escrita pelo autor, como no
exemplo a seguir.

```example
O pacote configura automaticamente:
+ o formato da página e as margens;
+ os elementos do texto:
  - as ilustrações e as tabelas;
  - as equações;
+ as citações e a lista de referências.
```

== Citações diretas <quotes>

#norm-box("NBR 14724:2024, 5.5; NBR 10520:2023, 7.1", "required", "implemented")[
  As citações diretas de até três linhas ficam no texto, entre aspas duplas. As citações diretas com mais de três
  linhas são destacadas com recuo padronizado em relação à margem esquerda (recomenda-se 4 cm), com letra menor
  que a do texto, em espaço simples e sem aspas.
]

A citação direta curta é escrita no próprio parágrafo, entre aspas. A citação direta com mais de três linhas é
escrita com a função `quote` do Typst, com `block: true`. O pacote aplica o recuo de 4 cm, o tamanho 10 e o
espaço simples, como no exemplo a seguir. A indicação da fonte é descrita no @references[Capítulo].

```example
O parágrafo anterior à citação termina em dois-pontos:

#quote(block: true)[
  Texto de uma citação direta com mais de três linhas. A
  citação é destacada do parágrafo, com recuo de 4 cm em
  relação à margem esquerda, em tamanho menor que o do
  texto, em espaço simples e sem aspas @autor2026[p. 10].
]
```

== Notas de rodapé <footnotes>

#norm-box("NBR 14724:2024, 5.2.1; NBR 10520:2023, 8", "required", "implemented")[
  As notas de rodapé ficam dentro das margens, separadas do texto por um espaço simples e por um filete de 5 cm, a
  partir da margem esquerda. São digitadas em espaço simples e com fonte menor. A partir da segunda linha, o texto
  da nota é alinhado sob a primeira letra da primeira palavra, de forma a destacar o expoente. As notas são
  indicadas por números arábicos sequenciais; recomenda-se reiniciar a numeração a cada capítulo ou parte, e não a
  cada página.
]

As notas são escritas com a função `footnote` do Typst. O pacote define o filete, o tamanho, o espaçamento e o
alinhamento das notas, e reinicia a numeração a cada seção primária. O exemplo a seguir mostra a parte
inferior de uma página com duas notas.

#page-example("footnote", crop: (0.68, 1))

#remark[
  A NBR 10520:2023 (seção 6.2.2) não permite o sistema numérico de citação em um trabalho com notas. Se o trabalho
  tiver notas de rodapé, use o sistema autor-data (@citation-systems[Seção]).
]

== Ilustrações <figures>

#norm-box("NBR 14724:2024, 5.8", "required", "implemented")[
  Qualquer ilustração é precedida de sua palavra designativa (figura, gráfico, mapa, quadro, fotografia, entre
  outras), seguida do número de ordem no texto, em algarismos arábicos, de travessão e do título. Imediatamente
  após a ilustração, são indicadas a fonte consultada, a legenda, as notas e outras informações necessárias. A
  ilustração produzida pelo próprio autor também indica essa informação na fonte. A ilustração é citada no texto e
  inserida o mais próximo possível do trecho a que se refere. O título, a fonte, a legenda e as notas respeitam as
  margens da ilustração.
]

As ilustrações são escritas com a função `figure` do Typst. O pacote posiciona o título acima da ilustração, com a
palavra designativa, o número e o travessão. A fonte, a legenda e as notas são escritas dentro da figura, depois da
ilustração, com as funções `fonte`, `legenda` e `nota`, como no exemplo a seguir. Sem argumento, `fonte`
indica que a ilustração foi elaborada pelo próprio autor.

```example
#figure(caption: [Trabalhos defendidos por região])[
  #rect(width: 8cm, height: 2.5cm, fill: luma(200))
  #fonte[IBGE (2025).]
  #legenda[Barras: número de trabalhos.]
  #nota[Dados coletados em 2024.]
]
```

A função `figure` centraliza o título e a fonte na largura da mancha gráfica. Para limitar o título, a fonte, a
legenda e as notas à largura da ilustração, como pede a norma, use a função `ajustada`, que aceita os mesmos
argumentos. O exemplo a seguir mostra uma figura com um título mais largo que a ilustração.

```example
#ajustada(caption: [Distribuição dos trabalhos
  acadêmicos por região do país, de 2020 a 2024])[
  #rect(width: 8cm, height: 2.5cm, fill: luma(200))
  #fonte()
]
```

A palavra designativa das figuras é "Figura". Para outro tipo de ilustração, como um gráfico ou um mapa, informe os
parâmetros `kind` e `supplement` da função `figure`. Cada tipo tem numeração própria e pode ter a sua lista
(@lists[Seção]):

```typ
#figure(kind: "grafico", supplement: [Gráfico], caption: [Trabalhos por ano])[
  #image("grafico.svg")
  #fonte()
]
```

=== Quadros

O quadro é uma ilustração com informações textuais, organizadas em linhas e colunas. A função `quadro` gera a
figura com a palavra "Quadro" e numeração própria. Uma tabela dentro do quadro recebe linhas fechadas, e o texto
mantém o tamanho do corpo, como no exemplo a seguir.

```example
#quadro(caption: [Tipos de trabalho acadêmico])[
  #table(columns: 2,
    [*Tipo*], [*Grau*],
    [Tese], [Doutorado],
    [Dissertação], [Mestrado])
  #fonte()
]
```

#reference("fonte", "legenda", "nota", "quadro", "ajustada")

== Tabelas <tables>

#norm-box("NBR 14724:2024, 5.9; IBGE, Normas de apresentação tabular (1993)", "required", "implemented")[
  As tabelas são citadas no texto, inseridas o mais próximo possível do trecho a que se referem e padronizadas
  conforme as normas de apresentação tabular do IBGE. Segundo essas normas, a moldura da tabela tem, no mínimo, três
  traços horizontais (um separa o topo, um separa o cabeçalho e um separa o rodapé) e não tem traços verticais que
  a delimitem à esquerda e à direita. O rodapé contém a fonte, a nota geral e as notas específicas, cada uma
  precedida da respectiva chamada. A tabela que ultrapassa uma página repete o título e o cabeçalho em cada
  página, com as indicações "continua", "continuação" e "conclusão"; o traço que fecha a tabela e o rodapé
  aparecem apenas na última página.
]

A tabela apresenta dados numéricos; para informações textuais, use um quadro (@figures[Seção]). Uma tabela é
escrita com a função `table` do Typst, com o cabeçalho em `table.header`, dentro da função `ajustada`. O pacote
desenha os traços horizontais, reduz o texto para o tamanho 10 e limita o título e o rodapé à largura da tabela.
O autor não escreve nenhum traço.

A fonte e as notas são escritas depois da tabela, com `fonte` e `nota`. Uma nota específica é escrita com
`nota(chamada: 1)`, e a chamada correspondente é inserida na célula com `chamada(1)`, como no
exemplo a seguir.

```example
#ajustada(caption: [Produção de casulos do bicho-da-seda,
  por Unidade da Federação -- Brasil -- 1974])[
  #table(columns: (4cm, 3cm, 3cm),
    align: (left, right, right),
    table.header([Unidade da Federação],
      [Produção (t)], [Percentual (%)]),
    [Paraná], [4 210], [61,2],
    [São Paulo #chamada(1)], [2 670], [38,8])
  #fonte[IBGE (1975).]
  #nota[Dados sujeitos a revisão.]
  #nota(chamada: 1)[Inclui a produção do Vale do Ribeira.]
]
```

Uma tabela que não cabe em uma página continua na página seguinte, com o título, o cabeçalho e as indicações do
IBGE. Nenhuma configuração é necessária. O exemplo a seguir mostra uma tabela de 40 linhas em duas
páginas.

#page-example("long-table", pages: (1, 2))

Fora da função `ajustada`, uma tabela em uma `figure` comum recebe os mesmos traços com `tabela-ibge`, escrita com os
argumentos de `table`: o título, a fonte e as notas passam a ocupar a largura da mancha gráfica, e a figura pode
flutuar com `placement`. Uma `figure` não continua nas páginas seguintes.

```example
#figure(caption: [Produção de casulos do bicho-da-seda,
  por Unidade da Federação -- Brasil -- 1974])[
  #tabela-ibge(columns: (4cm, 3cm, 3cm),
    align: (left, right, right),
    table.header([Unidade da Federação],
      [Produção (t)], [Percentual (%)]),
    [Paraná], [4 210], [61,2],
    [São Paulo], [2 670], [38,8])
  #fonte[IBGE (1975).]
]
```

#remark[
  Uma tabela sem `table.header`, ou fora de `ajustada` e de `tabela-ibge`, não recebe os traços do IBGE: ela mantém
  as linhas definidas pelo autor.
]

#reference("tabela-ibge", "chamada")

== Equações <equations>

#norm-box("NBR 14724:2024, 5.7", "recommended", "implemented")[
  Para facilitar a leitura, recomenda-se que as equações e fórmulas sejam destacadas no texto e, se necessário,
  numeradas com algarismos arábicos entre parênteses, alinhados à direita. Nas menções seguintes, pode-se usar
  apenas o número. No texto, é permitido o uso de uma entrelinha maior, que comporte os elementos da equação
  (expoentes, índices e outros).
]

As equações são escritas com a sintaxe matemática do Typst. Uma equação destacada só é numerada se tiver um
rótulo; a remissão ao rótulo gera o número entre parênteses. Em uma equação de várias linhas, cada linha pode ter
o seu rótulo, como no exemplo a seguir.

```example
Uma equação sem rótulo não é numerada:
$ E = m c^2 $
Com rótulo, a equação recebe um número:
$ F = m a $ <eq-newton>
Em várias linhas, apenas a linha com rótulo é numerada:
$ (a + b)^2 &= (a + b)(a + b) \
            &= a^2 + 2 a b + b^2 #<eq-quadrado> $
A @eq-newton e a @eq-quadrado são citadas pelo número.
```

Dois parâmetros da função principal controlam a numeração:

- `numeracao-das-equacoes` define o formato. O padrão, `"(1.1)"`, numera as equações por seção primária
  #pill("decision"); `"(1)"` numera ao longo de todo o trabalho, como nos exemplos da norma;
- `modo-de-numeracao-das-equacoes` define quais equações são numeradas. O padrão, `"rotulo"`, numera apenas as
  equações com rótulo; `"linha"` numera todas as linhas.

== Remissões <cross-references>

#norm-box("NBR 14724:2024, 5.7, 5.8 e 5.9; NBR 6024:2012, 4.4", "required", "implemented")[
  As ilustrações e as tabelas devem ser citadas no texto. Nas menções a uma equação, pode-se usar apenas o número.
  As seções são citadas pelo indicativo, como em "na seção 3" ou "ver 3.3".
]

Para citar um elemento no texto, atribua um rótulo a ele (`<rotulo>`) e use uma remissão. Há três formas:

- `@rotulo` gera apenas o número, como em "1" ou "(1.1)". A palavra que o antecede é escrita pelo autor;
- `@rotulo[Figura]` gera a palavra informada e o número, com um único link;
- `#auto-ref(<rotulo>)` gera a palavra adequada ao elemento ("Figura", "Tabela", "Seção", "Equação") e o número.
  Com `form: "page"`, gera a página do elemento.

Na função `ajustada`, o rótulo é informado no parâmetro `rotulo`. O exemplo a seguir mostra as três
formas.

```example
#figure(caption: [Estrutura do trabalho])[
  #rect(width: 6cm, height: 1.5cm, fill: luma(200))
  #fonte()
] <fig-estrutura>

#ajustada(rotulo: <tab-defesas>,
  caption: [Trabalhos defendidos])[
  #table(columns: (3cm, 3cm), align: (left, right),
    table.header([Ano], [Trabalhos]),
    [2024], [120], [2025], [135])
  #fonte()
]

A estrutura é mostrada na figura @fig-estrutura e
detalhada na @tab-defesas[Tabela]. A
#auto-ref(<fig-estrutura>) está na
#auto-ref(<fig-estrutura>, form: "page").
```

#remark[
  Um ponto e vírgula logo após `#auto-ref(...)` encerra a expressão e não é impresso. Para imprimi-lo, escreva o
  ponto e vírgula com uma barra invertida: `\;`.
]

#reference("auto-ref")

== Siglas <abbreviations>

#norm-box("NBR 14724:2024, 5.6", "required", "implemented")[
  A sigla, quando mencionada pela primeira vez no texto, deve ser indicada entre parênteses, precedida do nome
  completo.
]

A sigla pode ser escrita diretamente no texto, como em "Associação Brasileira de Normas Técnicas (ABNT)". Para
que o pacote escreva o nome completo apenas na primeira menção, registre as siglas como dicionários na função
`lista-de-siglas` e cite-as pela chave, como em `@abnt` (@acronyms[Seção]).
