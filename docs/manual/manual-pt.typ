// The manual of abntly in Portuguese (docs/manual-pt.pdf), in one file: a chapter is a primary heading with its label,
// and the chapters are those of `manual-en.typ`, in the same order. Build: `sh scripts/manual.sh`, which renders the
// pages of the examples first.
#import "template.typ": *

// the helpers of the template, in Portuguese
#let lang = "pt"
#let project = project.with(lang: lang)
#let pill = pill.with(lang: lang)
#let norm-box = norm-box.with(lang: lang)
#let remark = remark.with(lang: lang)
#let page-example = page-example.with(lang: lang)
#let bib-example = bib-example.with(lang: lang)
#let reference = reference.with(lang: lang)
#let api-index = api-index.with(lang: lang)

#show: project.with(
  title: [abntly],
  subtitle: [Trabalhos acadêmicos nas normas da ABNT, em Typst],
  author: "Lucas Lima Rodrigues",
  date: [1º de outubro de 2026],
  abstract: [
    O *abntly* é um template do #link("https://typst.app")[Typst] para trabalhos acadêmicos condizentes com as
    normas da Associação Brasileira de Normas Técnicas (ABNT), especialmente a ABNT NBR 14724:2024, Trabalhos
    acadêmicos — Apresentação. A lista completa das normas que o pacote atende está na Seção @norms.
  ],
)

= Início rápido <quick-start>

== Escopo <scope>

Este manual descreve o pacote *abntly*, que formata trabalhos acadêmicos escritos em
#link("https://typst.app")[Typst] de acordo com as normas da ABNT. O pacote é destinado a trabalhos de conclusão de
curso, dissertações e teses. Outros tipos de documento, como artigos, relatórios técnicos e projetos de pesquisa,
não fazem parte do escopo.

O manual toma como base a ABNT NBR 14724:2024, que define a estrutura e as regras gerais de apresentação dos
trabalhos acadêmicos e remete às demais normas (@norms[Seção]). Para cada elemento do trabalho, o manual apresenta:

- o que a norma exige, de forma resumida;
- a função do pacote que atende a esse requisito;
- um exemplo de uso, com o resultado.

O manual não substitui o texto das normas, que deve ser consultado em caso de dúvida.

== Sobre o pacote <about>

O abntly aplica a formatação da ABNT a todo o documento por meio da sua função principal, `trabalho-academico`
(@main-function[Seção]), chamada uma única vez no início do arquivo. A partir dessa chamada, o pacote configura
automaticamente:

- o formato da página e as margens;
- as fontes e os espaçamentos;
- a numeração das páginas e das seções;
- a formatação de ilustrações, tabelas e equações;
- as citações e a lista de referências.

Os elementos da estrutura do trabalho, como a capa, a folha de rosto e os resumos, são gerados por funções
próprias, descritas no @structure[Capítulo].

Todas as funções têm um nome em inglês e um nome em português (por exemplo, `cover` e `capa`), com os parâmetros e a
documentação no respectivo idioma. Este manual usa os nomes em português; a versão em inglês do manual usa os nomes em
inglês. Os dois conjuntos podem ser combinados no mesmo documento. Na referência de cada função, o nome em inglês
aparece ao lado do nome em português e leva à função no manual em inglês; a ajuda da função no editor também termina com
ele.

O idioma do trabalho não depende dos nomes usados. Ele é definido no parâmetro `idioma` da função principal
(@main-function[Seção]): um trabalho escrito com os nomes em inglês sai em português, a menos que `lang: "en"` seja
informado.

== Normas atendidas <norms>

O pacote implementa os requisitos das normas listadas a seguir.

#data-table([Normas atendidas pelo pacote], (5.6cm, 1fr), ([Norma], [Finalidade]),
  [*ABNT NBR 14724:2024* \ Trabalhos acadêmicos — Apresentação],
  [Define a estrutura do trabalho acadêmico e as regras gerais de apresentação: formato, margens, espaçamento,
    paginação, ilustrações e tabelas. É a norma principal; as demais são citadas por ela. O pacote segue a versão
    corrigida de 2025.],
  [*ABNT NBR 6024:2012* \ Numeração progressiva das seções de um documento — Apresentação],
  [Define a numeração das seções, as alíneas e as subalíneas.],
  [*ABNT NBR 6027:2012* \ Sumário — Apresentação],
  [Define a apresentação do sumário.],
  [*ABNT NBR 6028:2021* \ Resumo, resenha e recensão — Apresentação],
  [Define a redação e a apresentação do resumo e das palavras-chave.],
  [*ABNT NBR 10520:2023* \ Citações em documentos — Apresentação],
  [Define a apresentação das citações: os sistemas de chamada autor-data e numérico, as citações diretas e
    indiretas e as notas.],
  [*ABNT NBR 6023:2025* \ Referências — Elaboração],
  [Define os elementos das referências, a ordem deles e a forma de apresentação.],
  [*ABNT NBR 6034:2004* \ Índice — Apresentação],
  [Define a apresentação do índice.],
  [*ABNT NBR 6033:1989* \ Ordem alfabética],
  [Define os critérios de ordenação alfabética, usados nas listas, no glossário e no índice.],
  [*IBGE (1993)* \ Normas de apresentação tabular],
  [Define a apresentação das tabelas, conforme indicado pela NBR 14724.],
)

== Instalação <install>

O pacote requer o Typst #package.compiler ou superior. Para usá-lo, adicione a seguinte linha no início do arquivo:

```typ
#import "@preview/abntly:0.1.0": *
```

O Typst baixa o pacote automaticamente na primeira compilação.

Para criar um trabalho novo a partir do modelo do pacote, que traz todos os elementos da estrutura comentados, use
o comando:

```sh
typst init @preview/abntly:0.1.0
```

== Dependências <dependencies>

O abntly depende de outros pacotes do Typst e das fontes da família *New Computer Modern*. Os pacotes são baixados
automaticamente junto com o abntly. Parte das fontes já acompanha o Typst; as demais precisam ser instaladas.

#data-table([Dependências do pacote], (5cm, 1.6cm, 1fr), ([Dependência], [Tipo], [Uso]),
  ..dependencies.map(((name, version)) => ([#raw(name) #version], [Pacote], (
    equate: [Numeração das equações e das linhas de uma equação.],
    glossarium: [Siglas, símbolos e termos do glossário citados no texto por uma chave.],
    linguify: [Termos gerados pelo pacote, no idioma do texto.],
    subpar: [Subfiguras.],
  ).at(name))).flatten(),
  [New Computer Modern], [Fonte], [Texto. Acompanha o Typst.],
  [New Computer Modern Math], [Fonte], [Equações. Acompanha o Typst.],
  [New Computer Modern Sans], [Fonte], [Títulos. Precisa ser instalada.],
  [New Computer Modern Mono], [Fonte], [Código. Precisa ser instalada.],
  [New Computer Modern 08], [Fonte], [Sobrescritos e subscritos. Precisa ser instalada.],
)

Para instalar as fontes que não acompanham o Typst:

+ baixe o pacote #link("https://ctan.org/pkg/newcomputermodern")[`newcomputermodern`] no CTAN;
+ na pasta `otf`, instale os arquivos `NewCM10-*`, `NewCM08-*`, `NewCMSans10-*`, `NewCMSans08-*`, `NewCMMono10-*` e
  `NewCMMath-*` (os arquivos com `Book` no nome não são usados);
+ no #link("https://typst.app")[typst.app], envie esses arquivos para o projeto em vez de instalá-los.

#remark[
  Sem essas fontes, o documento é compilado com fontes substitutas, e o Typst emite um aviso para cada família
  ausente, como `unknown font family: new computer modern sans`.
]

== Função principal <main-function>

A função `trabalho-academico` é a função principal do pacote. Ela aplica a formatação da ABNT a todo o documento e
deve ser usada com uma regra `show`, logo após a importação. Os dados do trabalho são informados no parâmetro
`dados` (@work-data[Seção]).

O exemplo a seguir gera um trabalho com capa, folha de rosto, sumário e um capítulo:

#page-example("first-work", pages: (1, 2, 4))

Os demais parâmetros definem o idioma, a impressão em frente e verso, a cor dos links, o tamanho da fonte das
tabelas, a numeração das equações e o sistema de citação.

Configurações que não são parâmetros da função podem ser alteradas com regras `set` do Typst após a chamada. Por
exemplo, `#set text(size: 11pt)` altera o tamanho da fonte, e os demais tamanhos se ajustam proporcionalmente.

#reference("trabalho-academico", "indigo-escuro")

#reference("config-nomes", description: true)

== Convenções do manual <how-to-read>

Cada elemento é apresentado em até quatro blocos. O primeiro resume o que a norma exige:

#norm-box("NBR 14724:2024, 5.1", "required", "implemented")[
  O texto deve ser apresentado em cor preta; outras cores podem ser usadas apenas nas ilustrações. Se impresso, o
  trabalho deve usar papel branco ou reciclado, no formato A4.
]

As etiquetas indicam a situação do elemento na norma (#pill("required"), #pill("optional") ou
#pill("recommended")) e no pacote (#pill("implemented") ou #pill("partial")). A etiqueta
#pill("decision") indica um ponto que a norma não define e que foi decidido pelo pacote, como a fonte ou a posição
de um elemento na página.

O segundo bloco é um exemplo, com o código e o resultado, como o que vem a seguir. Os exemplos de páginas inteiras
mostram as páginas geradas.

```example
#figure(caption: [Distribuição por região])[
  #rect(width: 6cm, height: 2cm)
  #fonte()
]
```

As observações aparecem em caixas como esta:

#remark[
  Uma observação indica um cuidado de uso, uma limitação do pacote ou uma escolha que depende da instituição.
]

O último bloco é a referência da função, com a assinatura, o tipo e o valor padrão de cada parâmetro e a descrição
de cada um.

= Estrutura do trabalho acadêmico <structure>

A ABNT NBR 14724:2024 (seção 4) divide o trabalho acadêmico em parte externa e parte interna. A parte interna é
composta por elementos pré-textuais, textuais e pós-textuais. A @elements[Tabela] lista os elementos na ordem em que
devem aparecer, indica se são obrigatórios e mostra a função correspondente no pacote.

No documento, as funções devem ser chamadas na mesma ordem da tabela. As seções deste capítulo descrevem cada
elemento.

#data-table([Elementos do trabalho acadêmico], (1fr, 2.4cm, 6.2cm), ([Elemento], [Na norma], [No pacote]),
  label: <elements>,
  table.cell(colspan: 3, text(font: api.sans, fill: luma(90))[Parte externa]),
  [Capa], pill("required"), [`capa`],
  table.cell(colspan: 3, text(font: api.sans, fill: luma(90))[Elementos pré-textuais]),
  [Folha de rosto], pill("required"), [`folha-de-rosto`],
  [Dados de catalogação (verso da folha de rosto)], pill("required"), [`ficha-catalografica`],
  [Errata], pill("optional"), [`retificacao`],
  [Folha de aprovação], pill("required"), [`folha-de-aprovacao`],
  [Dedicatória], pill("optional"), [`dedicatoria`],
  [Agradecimentos], pill("optional"), [`agradecimentos`],
  [Epígrafe], pill("optional"), [`epigrafe`],
  [Resumo na língua vernácula], pill("required"), [`resumo`, `palavras-chave`],
  [Resumo em língua estrangeira], pill("required"), [`resumo(idioma: "en")`],
  [Lista de ilustrações], pill("optional"), [`lista-de-figuras`, `lista-de-quadros`, `lista-de`],
  [Lista de tabelas], pill("optional"), [`lista-de-tabelas`],
  [Lista de abreviaturas e siglas], pill("optional"), [`lista-de-siglas`],
  [Lista de símbolos], pill("optional"), [`lista-de-simbolos`],
  [Sumário], pill("required"), [`outline` (função do Typst)],
  table.cell(colspan: 3, text(font: api.sans, fill: luma(90))[Elementos textuais]),
  [Introdução, desenvolvimento e conclusão], pill("required"), [texto do autor, com títulos em `=`],
  table.cell(colspan: 3, text(font: api.sans, fill: luma(90))[Elementos pós-textuais]),
  [Referências], pill("required"), [`bibliography` (função do Typst)],
  [Glossário], pill("optional"), [`glossario`],
  [Apêndice], pill("optional"), [`apendice`],
  [Anexo], pill("optional"), [`anexo`],
  [Índice], pill("optional"), [`indice`],
)

== Dados do trabalho <work-data>

Os dados do trabalho (título, autor, orientador, instituição, local e ano) são informados uma única vez, com a
função `config-dados`, no parâmetro `dados` da função principal. A capa, a folha de rosto, a folha de aprovação e a
ficha catalográfica usam esses dados automaticamente. Eles também são gravados nos metadados do PDF. O
exemplo a seguir informa os dados de uma tese.

```typ
#show: trabalho-academico.with(
  dados: config-dados(
    titulo: [Título do trabalho],
    subtitulo: [subtítulo],
    autor: "Nome do Autor",
    orientador: (
      nome: "Profa. Dra. Nome da Orientadora",
      genero: "f",
    ),
    instituicao: [Universidade do Brasil],
    programa: [Programa de Pós-Graduação],
    local: [Rio Branco],
    ano: 2026,
    tipo: "tese",
  ),
)
```

Campos não informados são omitidos das páginas. O autor e os orientadores podem ser informados como texto ou como
dicionário, o que permite separar o nome do sobrenome, indicar o gênero (para o rótulo "Orientadora") ou definir um
rótulo personalizado.

Os exemplos de página das próximas seções usam esses dados. Para destacar o elemento descrito, a chamada da função
principal é omitida do código a partir da @catalog-card[Seção].

#reference("config-dados")

== Capa (obrigatório) <cover>

#norm-box("NBR 14724:2024, 4.1.1", "required", "implemented")[
  A capa deve conter, nesta ordem: nome da instituição (opcional); nome do autor; título; subtítulo, se houver,
  precedido de dois-pontos; número do volume, se houver mais de um; local (cidade) da instituição; ano de depósito
  (entrega).
]

A função `capa` gera a capa a partir dos dados informados em `config-dados`. A instituição e o programa aparecem no
topo, seguidos do autor. Se o campo `versao` for informado, a versão do trabalho aparece abaixo do título. A capa
não é contada na numeração das páginas. O exemplo a seguir mostra o código e a capa gerada.

#page-example("cover")

#remark[
  A norma define apenas os elementos da capa e a ordem deles. A fonte, o destaque do título e a posição vertical
  dos elementos são decisões do pacote #pill("decision").
]

=== Personalização

Para personalizar a capa, use os parâmetros `topo`, `meio` e `pe`, que substituem a parte correspondente da página
por um conteúdo personalizado. A função `com-dados` dá acesso aos dados do trabalho dentro desse conteúdo. O
parâmetro `altura-do-meio` controla a posição vertical do título: valores maiores deslocam o título para cima.

No exemplo a seguir, a instituição é escrita em maiúsculas e o título é deslocado para cima.

#page-example("cover-custom")

#reference("capa")

#reference("com-dados", description: true)

== Folha de rosto (obrigatório) <title-page>

#norm-box("NBR 14724:2024, 4.2.1.1.1", "required", "implemented")[
  O anverso da folha de rosto deve conter, nesta ordem: nome do autor; título; subtítulo, se houver; número do
  volume, se houver mais de um; natureza do trabalho (tipo do trabalho, objetivo, instituição a que é submetido e
  área de concentração); nome do orientador e, se houver, do coorientador; local; ano de depósito.
]

A função `folha-de-rosto` gera a folha de rosto. O texto da natureza do trabalho é passado como conteúdo da
função; os demais elementos vêm de `config-dados`. Se o campo `area` for informado, a área de concentração aparece
em um parágrafo próprio, abaixo da natureza. O rótulo do orientador ("Orientador" ou "Orientadora") depende do
gênero informado. O exemplo a seguir mostra a folha de rosto de uma tese.

#page-example("title-page")

#norm-box("NBR 14724:2024, 5.2", "required", "implemented")[
  Na folha de rosto e na folha de aprovação, a natureza do trabalho deve ser digitada em espaço simples e alinhada
  do meio da mancha gráfica para a margem direita.
]

A contagem das páginas do trabalho começa na folha de rosto. O texto da natureza é reaproveitado automaticamente
na folha de aprovação.

Assim como a capa, a folha de rosto aceita os parâmetros `topo`, `meio`, `pe` e `altura-do-meio`. Para montar uma
página própria com o bloco da natureza, use a função `preambulo`.

#reference("folha-de-rosto", "preambulo")

== Ficha catalográfica (obrigatório) <catalog-card>

#norm-box("NBR 14724:2024, 4.2.1.1.2 e 5.3", "required", "partial")[
  O verso da folha de rosto deve conter os dados internacionais de catalogação na publicação, conforme o código de
  catalogação vigente. Em formato eletrônico, esses dados devem vir imediatamente após a folha de rosto. O verso da
  folha de rosto não é contado nem numerado.
]

A função `ficha-catalografica` gera a página com a ficha catalográfica, na parte inferior da página. Ela deve ser
chamada logo após a folha de rosto. A ficha é montada com os dados de `config-dados`. Os assuntos são as
palavras-chave do resumo no idioma do trabalho, e o número de páginas é calculado automaticamente. O
exemplo a seguir mostra a parte inferior da página gerada.

#page-example("catalog-card", pages: (2,), crop: (0.6, 1))

A ficha gerada pelo pacote é provisória e, por isso, recebe o carimbo "FICHA PROVISÓRIA". A ficha definitiva é
emitida pela biblioteca da instituição, com o número de chamada e a classificação. Para usá-la, informe o arquivo
recebido da biblioteca no parâmetro `ficha`:

```typ
#ficha-catalografica(ficha: image("ficha.pdf", width: 13.5cm))
```

#remark[
  A página da ficha entra na contagem das páginas do trabalho. A norma determina que o verso da folha de rosto não
  seja contado #pill("partial").
]

#reference("ficha-catalografica")

== Errata (opcional) <errata>

#norm-box("NBR 14724:2024, 4.2.1.2", "optional", "implemented")[
  A errata deve ser inserida logo após a folha de rosto e é constituída pela referência do trabalho e pelo texto da
  errata. É apresentada em papel avulso ou encartado, acrescida ao trabalho depois de impresso.
]

A função `retificacao` gera o título "Errata" e insere o conteúdo informado. A referência do trabalho e a tabela das
correções são escritas pelo autor, como no exemplo a seguir.

#page-example("errata", pages: (2,), crop: (0, 0.4))

#reference("retificacao")

== Folha de aprovação (obrigatório) <approval-page>

#norm-box("NBR 14724:2024, 4.2.1.3", "required", "implemented")[
  A folha de aprovação deve ser inserida após a folha de rosto e conter: nome do autor; título e subtítulo, se
  houver; natureza do trabalho; data de aprovação; nome, titulação e assinatura dos membros da banca examinadora e
  instituições a que pertencem. A data de aprovação e as assinaturas são colocadas após a aprovação do trabalho.
]

A função `folha-de-aprovacao` gera a folha de aprovação. Os membros da banca são informados como dicionários, com
as chaves `nome`, `titulacao` e `instituicao` (obrigatórias) e `papel` (opcional). O autor, o título e a natureza
do trabalho vêm de `config-dados` e da folha de rosto.

Antes da defesa, a folha é provisória: a data fica em branco, para preenchimento, e a página recebe o carimbo
"FOLHA PROVISÓRIA", como no exemplo a seguir.

#page-example("approval", pages: (2,))

Depois da aprovação, informe a data no parâmetro `data` e remova o carimbo com `provisoria: false`. No
exemplo a seguir, os membros da banca estão em variáveis (`orientadora`, `convidado` e `convidada`),
com os mesmos dicionários do exemplo anterior.

#page-example("approval-final", pages: (2,))

#remark[
  A norma não inclui o local e o ano entre os elementos da folha de aprovação. O pacote os exibe na parte inferior
  da página #pill("decision").
]

Quando a instituição fornece a folha de aprovação assinada e digitalizada, ela pode ser inserida como imagem, em
uma página sem margens:

```typ
#page(margin: 0pt, header: none, image("folha-de-aprovacao.pdf", width: 100%))
```

=== Personalização

A folha de aprovação aceita os parâmetros `topo`, `meio`, `pe` e `altura-do-meio`, como a capa. A função
`assinatura` gera as linhas de assinatura em um conteúdo personalizado. No exemplo a seguir, a parte
inferior da página é substituída, e duas assinaturas são colocadas lado a lado.

#page-example("approval-custom", pages: (2,))

#reference("folha-de-aprovacao", "assinatura")

== Dedicatória (opcional) <dedication>

#norm-box("NBR 14724:2024, 4.2.1.4 e 5.2.4", "optional", "implemented")[
  A dedicatória deve ser inserida após a folha de aprovação. A página não tem título nem indicativo numérico.
  Recomenda-se que o texto seja alinhado do meio da mancha gráfica para a margem direita, na parte inferior da
  página.
]

A função `dedicatoria` gera a página da dedicatória, sem título. Por padrão, o texto é composto em itálico,
centralizado, no meio da página, como no exemplo a seguir.

#page-example("dedication")

#remark[
  A posição padrão do texto é uma decisão do pacote #pill("decision"). Para seguir a recomendação da norma,
  posicione o texto com a função `place` do Typst, como no exemplo a seguir.
]

#page-example("dedication-right")

#reference("dedicatoria")

== Agradecimentos (opcional) <acknowledgments>

#norm-box("NBR 14724:2024, 4.2.1.5 e 5.2.3", "optional", "implemented")[
  Os agradecimentos devem ser inseridos após a dedicatória. O título, sem indicativo numérico, é centralizado.
]

A função `agradecimentos` gera o título "Agradecimentos" e insere o texto informado, como no
exemplo a seguir.

#page-example("acknowledgments", crop: (0, 0.3))

#reference("agradecimentos")

== Epígrafe (opcional) <epigraph>

#norm-box("NBR 14724:2024, 4.2.1.6 e 5.2.4", "optional", "implemented")[
  A epígrafe deve ser inserida após os agradecimentos. A página não tem título nem indicativo numérico.
  Recomenda-se que o texto seja alinhado do meio da mancha gráfica para a margem direita, na parte inferior da
  página. Também podem constar epígrafes nas páginas de abertura das seções primárias; essas seguem as regras das
  citações.
]

A função `epigrafe` gera a página da epígrafe, sem título. O texto é alinhado à direita, na parte inferior da
página. As quebras de linha (`\`) e o itálico são definidos pelo autor, como no exemplo a seguir.

#page-example("epigraph")

#remark[
  O alinhamento de cada linha à direita é uma decisão do pacote #pill("decision"). Para seguir a recomendação da
  norma, coloque o texto em um bloco com metade da largura da mancha, alinhado à esquerda:
  `#epigrafe(block(width: 50%, align(left)[...]))`.
]

#reference("epigrafe")

== Resumos (obrigatório) <abstracts>

#norm-box("NBR 14724:2024, 4.2.1.7 e 4.2.1.8; NBR 6028:2021, 4.1", "required", "implemented")[
  O resumo na língua vernácula e o resumo em língua estrangeira são obrigatórios. O resumo é composto por frases
  concisas, em parágrafo único, e convém que tenha de 150 a 500 palavras nos trabalhos acadêmicos. As
  palavras-chave vêm logo abaixo do resumo, antecedidas da expressão "Palavras-chave", seguida de dois-pontos,
  separadas entre si por ponto e vírgula e finalizadas por ponto. São grafadas com iniciais minúsculas, exceto os
  substantivos próprios e os nomes científicos.
]

#remark[
  A norma não fixa a quantidade de palavras-chave: a NBR 6028:2021 diz só como grafá-las, e o exemplo dela traz
  cinco. O limite "de três a cinco" que costuma ser pedido é regra da instituição ou do periódico. A função
  `palavras-chave` aceita qualquer número delas.
]

A função `resumo` gera o título e o texto do resumo. As palavras-chave são informadas no fim do texto, com a função
`palavras-chave`, uma por argumento. O parâmetro `idioma` define o idioma do resumo em língua estrangeira: o
título, o rótulo das palavras-chave e a hifenização passam a ser os desse idioma. O exemplo a seguir gera
os dois resumos, cada um em uma página.

#page-example("abstract", pages: (1, 2))

O pacote tem os termos "Resumo" e "Palavras-chave" em português, inglês, espanhol e francês. Para outro idioma,
informe o título e o rótulo:

```typ
#resumo(idioma: "de", titulo: [Zusammenfassung])[
  Text der Zusammenfassung.

  #palavras-chave(rotulo: [Schlüsselwörter])[Schriftsatz][ABNT]
]
```

#reference("resumo", "palavras-chave")

== Listas de ilustrações e de tabelas (opcional) <lists>

#norm-box("NBR 14724:2024, 4.2.1.9 e 4.2.1.10", "optional", "implemented")[
  As listas são elaboradas na ordem em que os itens aparecem no texto. Cada item é designado por seu nome
  específico e número, travessão, título e número da página. Quando necessário, recomenda-se uma lista própria
  para cada tipo de ilustração (quadros, gráficos, mapas e outros).
]

As funções `lista-de-figuras`, `lista-de-quadros` e `lista-de-tabelas` geram as listas das figuras, dos quadros e
das tabelas do trabalho. Cada lista começa em uma página nova, com o título centralizado. O exemplo a seguir
mostra o início de cada uma das três páginas geradas.

#page-example("lists", pages: (1, 2, 3), crop: (0, 0.2))

Para outro tipo de ilustração, como gráficos ou mapas, crie as figuras com os parâmetros `kind` e `supplement` da
função `figure` e gere a lista com `lista-de`, informando o tipo e o título, como no exemplo a seguir.

#page-example("list-kind", crop: (0, 0.2))

#reference("lista-de", "lista-de-figuras", "lista-de-quadros", "lista-de-tabelas")

== Listas de abreviaturas e siglas e de símbolos (opcional) <acronyms>

#norm-box("NBR 14724:2024, 4.2.1.11 e 4.2.1.12", "optional", "implemented")[
  A lista de abreviaturas e siglas é a relação alfabética das abreviaturas e siglas utilizadas no texto, seguidas
  das expressões correspondentes por extenso. Recomenda-se uma lista própria para cada tipo. A lista de símbolos é
  elaborada na ordem em que os símbolos aparecem no texto, com o significado de cada um.
]

As funções `lista-de-siglas` e `lista-de-simbolos` geram as duas listas. As siglas são ordenadas alfabeticamente
pelo pacote; os símbolos são exibidos na ordem informada. As entradas podem ser escritas de duas formas:

- como pares, `("ABNT", [Associação Brasileira de Normas Técnicas])`: a lista é apenas impressa;
- como dicionários, com as chaves `key`, `short` e `long`: a sigla também pode ser citada no texto pela chave
  (`@abnt`). A primeira menção exibe a expressão por extenso, seguida da sigla entre parênteses, e as seguintes
  exibem apenas a sigla, como pede a NBR 14724:2024 (seção 5.6).

O exemplo a seguir usa dicionários para as siglas e pares para os símbolos e mostra o início das três
páginas geradas.

#page-example("acronyms", pages: (1, 2, 3), crop: (0, 0.2))

#reference("lista-de-siglas", "lista-de-simbolos")

== Sumário (obrigatório) <summary>

#norm-box("NBR 14724:2024, 4.2.1.13; NBR 6027:2012", "required", "implemented")[
  O sumário é o último elemento pré-textual. Os indicativos das seções são alinhados à esquerda, e recomenda-se que
  os títulos sejam alinhados pela margem do título do indicativo mais extenso, inclusive os dos elementos
  pós-textuais. A paginação é apresentada à margem direita. Os elementos pré-textuais não constam no sumário.
  Recomenda-se que os itens tenham a mesma apresentação tipográfica das seções no texto.
]

O sumário é gerado pela função `outline` do Typst; o pacote define o título e a apresentação das entradas. Os
títulos dos elementos pré-textuais gerados pelo pacote não entram no sumário. Os títulos dos elementos
pós-textuais entram sem indicativo, alinhados com os títulos das seções, como no exemplo a seguir.

#page-example("outline", crop: (0, 0.5))

#remark[
  No sumário, os títulos das seções primárias são exibidos em letras maiúsculas; no texto, em maiúsculas e
  minúsculas #pill("decision"). Para usar a mesma grafia nos dois, acrescente a regra
  `#show heading.where(level: 1): upper` após a chamada da função principal.
]

== Elementos textuais <textual>

#norm-box("NBR 14724:2024, 4.2.2", "required", "implemented")[
  O texto é composto por uma parte introdutória, com os objetivos e as razões do trabalho; pelo desenvolvimento,
  que detalha a pesquisa ou o estudo realizado; e por uma parte conclusiva. O trabalho não é dividido em capítulos:
  é organizado em seções. A nomenclatura dos títulos fica a critério do autor.
]

Os elementos textuais são escritos diretamente no documento, com os títulos do Typst: `=` para as seções
primárias, `==` para as secundárias, e assim por diante. A apresentação das seções é descrita na @sections[Seção].

O pacote identifica as partes do trabalho automaticamente:

- a parte pré-textual vai do início do documento até a primeira seção primária numerada. As páginas são contadas,
  mas não exibem número;
- a parte textual começa na primeira seção primária numerada. A partir dela, as páginas exibem o número e o
  cabeçalho;
- a parte pós-textual começa na lista de referências.

As funções `pretextual`, `textual` e `postextual` marcam o início de cada parte manualmente. Elas só são
necessárias quando o trabalho escreve os títulos pré-textuais ou pós-textuais como títulos comuns, ou quando o
texto começa sem um título numerado, como no exemplo a seguir.

#page-example("parts", pages: (1, 2, 3))

#reference("pretextual", "textual", "postextual")

== Referências (obrigatório) <references-list>

#norm-box("NBR 14724:2024, 4.2.3.1; NBR 6023:2025", "required", "implemented")[
  As referências são elaboradas conforme a NBR 6023.
]

A lista de referências é gerada pela função `bibliography` do Typst, a partir de um arquivo `.bib` com as obras
citadas. O pacote define o título e a apresentação da lista:

```typ
#bibliography("refs.bib")
```

O @references[Capítulo] descreve as citações, a lista de referências e o arquivo `.bib`.

== Glossário (opcional) <glossary>

#norm-box("NBR 14724:2024, 4.2.3.2", "optional", "implemented")[
  O glossário é elaborado em ordem alfabética.
]

A função `glossario` gera o glossário, com os termos ordenados alfabeticamente pelo pacote. Como nas listas de
siglas, as entradas podem ser pares ou dicionários. Com dicionários, que têm as chaves `key`, `short` e
`description`, os termos podem ser citados no texto pela chave, como no exemplo a seguir.

#page-example("glossary", pages: (1, 2), crop: (0, 0.2))

#reference("glossario")

== Apêndices e anexos (opcional) <appendices>

#norm-box("NBR 14724:2024, 4.2.3.3, 4.2.3.4 e 5.3", "optional", "implemented")[
  O título de cada apêndice é precedido da palavra "APÊNDICE", de uma letra maiúscula consecutiva e de um
  travessão. Esgotadas as letras do alfabeto, usam-se letras dobradas. O destaque tipográfico é o mesmo das seções
  primárias. O mesmo vale para os anexos, com a palavra "ANEXO". As páginas dos apêndices e dos anexos continuam a
  numeração do texto.
]

As funções `apendice` e `anexo` são usadas com uma regra `show`. A partir da regra, cada título primário (`=`) é
um apêndice ou um anexo, identificado pela palavra, pela letra e pelo travessão. As seções de um apêndice são
numeradas com a letra dele, como em "A.1". O exemplo a seguir mostra as três páginas geradas.

#page-example("appendix", pages: (2, 3, 4))

#remark[
  A página com o título "Apêndices" (ou "Anexos"), inserida antes do primeiro apêndice, não é exigida pela norma
  #pill("decision"). Para omiti-la, use `divisoria: false`, como na regra do anexo no exemplo.
]

#reference("apendice", "anexo")

== Índice (opcional) <index>

#norm-box("NBR 14724:2024, 4.2.3.5; NBR 6034:2004, 6", "optional", "implemented")[
  O índice é o último elemento do trabalho. As entradas são apresentadas em linhas separadas, com recuo progressivo
  para os subcabeçalhos. As páginas consecutivas são indicadas pelos números extremos, ligados por hífen, e as não
  consecutivas são separadas por vírgula. As remissivas "ver" e "ver também" são destacadas tipograficamente.
]

A função `indice` gera o índice a partir das entradas informadas pelo autor. Cada entrada é um dicionário com as
chaves `termo` (o cabeçalho), `paginas` (um número, uma faixa como `"2-3"` ou uma lista deles), `sub` (os
subcabeçalhos, que também são entradas), `ver` e `ver-tambem` (as remissivas). Uma entrada simples pode ser
escrita como um par, `("Termo", 3)`. O pacote ordena as entradas alfabeticamente, conforme a NBR 6033:1989, e
transforma cada página em um link, como no exemplo a seguir.

#page-example("index", pages: (3,), crop: (0, 0.3))

#remark[
  O pacote não coleta os termos no texto: as páginas de cada entrada são informadas pelo autor. Por isso, confira o
  índice ao final, quando a paginação do trabalho estiver definida.
]

#reference("indice")

= Regras gerais de apresentação <general-rules>

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
- `#remissao(<rotulo>)` gera a palavra adequada ao elemento ("Figura", "Tabela", "Seção", "Equação") e o número.
  Com `forma: "pagina"`, gera a página do elemento.

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
#remissao(<fig-estrutura>) está na
#remissao(<fig-estrutura>, forma: "pagina").
```

#remark[
  Um ponto e vírgula logo após `#remissao(...)` encerra a expressão e não é impresso. Para imprimi-lo, escreva o
  ponto e vírgula com uma barra invertida: `\;`.
]

#reference("remissao")

== Siglas <abbreviations>

#norm-box("NBR 14724:2024, 5.6", "required", "implemented")[
  A sigla, quando mencionada pela primeira vez no texto, deve ser indicada entre parênteses, precedida do nome
  completo.
]

A sigla pode ser escrita diretamente no texto, como em "Associação Brasileira de Normas Técnicas (ABNT)". Para
que o pacote escreva o nome completo apenas na primeira menção, registre as siglas como dicionários na função
`lista-de-siglas` e cite-as pela chave, como em `@abnt` (@acronyms[Seção]).

= Elementos além da norma <extras>

Este capítulo descreve os elementos que as normas da ABNT não definem, mas que são comuns em trabalhos acadêmicos:
algoritmos, subfiguras, partes, figuras deitadas e carimbos. O algoritmo e as subfiguras são ilustrações e seguem
as regras da @figures[Seção]. Para os demais, a apresentação é uma decisão do pacote #pill("decision").

== Algoritmos <algorithms>

#norm-box("NBR 14724:2024, 5.8", "decision")[
  A norma não trata de algoritmos, mas a lista de palavras designativas das ilustrações é aberta. Como qualquer
  ilustração, o algoritmo tem a palavra designativa, o número, o travessão e o título acima, e a fonte abaixo.
]

A função `algoritmo` gera uma ilustração de código ou de pseudocódigo, com a palavra "Algoritmo" e numeração
própria. Ela aceita os mesmos argumentos de `figure`. O código é escrito em um bloco de código do Typst, e a fonte
é indicada com `fonte`, como no exemplo a seguir. Um algoritmo longo continua na página seguinte.

````example
#algoritmo(caption: [Média de uma lista de números])[
  ```python
  def media(valores):
      total = 0
      for v in valores:
          total = total + v
      return total / len(valores)
  ```
  #fonte()
]
````

Para gerar a lista de algoritmos, use `lista-de(raw, titulo: [Lista de algoritmos])` (@lists[Seção]).

#reference("algoritmo")

== Subfiguras <subfigures>

#norm-box("NBR 14724:2024, 5.8", "decision")[
  A norma não trata de figuras compostas por partes. O conjunto segue as regras das ilustrações: o título acima e a
  fonte, a legenda e as notas abaixo.
]

A função `subfiguras` gera uma figura composta por partes. Cada parte é uma `figure`, seguida do seu rótulo. O
título do conjunto fica acima, e o título de cada parte, abaixo dela, precedido de uma letra. A fonte do conjunto
é informada depois das partes. A remissão a uma parte gera o número do conjunto e a letra, como no
exemplo a seguir. A função não pode ser usada dentro de `ajustada`.

```example
#subfiguras(
  figure(rect(width: 5cm, height: 2.5cm, fill: luma(200)),
    caption: [Região Norte]), <sub-norte>,
  figure(rect(width: 5cm, height: 2.5cm, fill: luma(200)),
    caption: [Região Sul]), <sub-sul>,
  titulo: [Trabalhos defendidos em duas regiões],
  rotulo: <sub-regioes>,
)[
  #fonte[IBGE (2025).]
]

A Figura @sub-regioes compara a Região Norte (Figura
@sub-norte) com a Região Sul (Figura @sub-sul).
```

#reference("subfiguras")

== Partes <parts>

A função `parte` gera a página de abertura de uma parte, uma divisão do texto acima das seções primárias. A
página não tem cabeçalho nem número e exibe a palavra "Parte", o número em algarismos romanos e o título. A seção
primária seguinte começa em uma página nova, e a numeração das seções continua de uma parte para a outra, como no
exemplo a seguir.

#page-example("part", pages: (1, 2))

#reference("parte")

== Figuras e tabelas deitadas <sideways>

A função `deitada` gira uma figura ou uma tabela em 90°, em uma página própria. Ela é indicada para o conteúdo
mais largo que a mancha gráfica. A página permanece em pé, com as mesmas margens e o mesmo cabeçalho, e o texto
continua na página seguinte, como no exemplo a seguir.

#page-example("sideways", pages: (2,))

#reference("deitada")

== Carimbos <stamps>

A função `carimbo` gera uma marca-d'água para o fundo da página, como "RASCUNHO". Ela é usada no parâmetro
`background` da página: com `#set page(background: ...)`, o carimbo aparece em todas as páginas seguintes, como no
exemplo a seguir.

#page-example("stamp")

A ficha catalográfica e a folha de aprovação têm carimbos próprios, controlados pelo parâmetro `provisoria`
(@catalog-card[Seção] e @approval-page[Seção]).

#reference("carimbo")

= Citações e referências <references>

As citações seguem a ABNT NBR 10520:2023, e a lista de referências, a ABNT NBR 6023:2025. O autor registra as
obras em um arquivo `.bib` e as cita no texto pela chave. O pacote compõe as chamadas e a lista com as funções
`cite` e `bibliography` do Typst.

== Sistemas de chamada <citation-systems>

#norm-box("NBR 10520:2023, 6", "required", "implemented")[
  As citações são indicadas no texto por um sistema de chamada: autor-data ou numérico. O sistema adotado deve ser
  seguido ao longo de todo o trabalho. No sistema numérico, a numeração das fontes é consecutiva, em algarismos
  arábicos, e remete à lista de referências, na ordem em que as fontes aparecem no texto. A numeração pode ser
  indicada entre parênteses, alinhada ao texto, ou em expoente. O sistema numérico não pode ser usado em um
  trabalho com notas.
]

O sistema de chamada é definido no parâmetro `sistema-de-citacao` da função principal. A @systems[Tabela] lista os
valores aceitos. O sistema define a forma das chamadas e a ordem da lista de referências.

#data-table([Sistemas de chamada], (2.4cm, 3.4cm, 4cm, 1fr),
  ([Valor], [Sistema], [Chamada], [Lista de referências]), label: <systems>,
  [`"alf"`], [Autor-data (padrão)], [(Luck, 2010, p. 12)], [Em ordem alfabética.],
  [`"num"`], [Numérico, entre parênteses], [(1, p. 12)], [Na ordem das citações, com o número antes de cada
    referência.],
  [`"overcite"`], [Numérico, em expoente], [#super[1, p. 12]], [Como em `"num"`.],
  [`"ieee"`], [Numérico, entre colchetes], [[1, p. 12]], [Como em `"num"`. Os colchetes não estão previstos na
    norma #pill("decision").],
)

O exemplo a seguir mostra um parágrafo no sistema numérico, com o início da página do texto e da página das
referências.

#page-example("citations-num", pages: (1, 2), crop: (0, 0.22))

O mesmo parágrafo, com as chamadas em expoente:

#page-example("citations-overcite", crop: (0, 0.22))

E com as chamadas entre colchetes:

#page-example("citations-ieee", crop: (0, 0.22))

== Citações no texto <citations>

#norm-box("NBR 10520:2023, 6.1", "required", "partial")[
  No sistema autor-data, a fonte é indicada pelo sobrenome do autor ou pelo nome da entidade, em letras maiúsculas
  e minúsculas, seguido da data. Nas citações diretas, acrescenta-se a página. Quando o autor faz parte da frase,
  a data e a página ficam entre parênteses. Uma fonte com quatro ou mais autores pode ser citada pelo primeiro
  autor, seguido de "et al.". Autores com o mesmo sobrenome e a mesma data são distinguidos pelas iniciais dos
  prenomes, e obras do mesmo autor e do mesmo ano, por letras minúsculas após a data. Várias obras em uma mesma
  chamada são separadas por ponto e vírgula, de preferência em ordem alfabética. Uma fonte sem autoria é citada
  pela primeira palavra do título, seguida de "[...]".
]

Uma obra é citada pela chave que ela tem no arquivo `.bib`. A @cite-forms[Tabela] lista as formas de citação. A
página, ou outra localização, é informada entre colchetes, depois da chave.

#data-table([Formas de citação], (7.4cm, 1fr), ([Código], [Uso]), label: <cite-forms>,
  [`@chave`], [Chamada entre parênteses.],
  [`@chave[p. 12]`], [Chamada com a página, para as citações diretas.],
  [`#cite(<chave>, form: "prose")`], [Autor na frase, com a data entre parênteses.],
  [`#cite(<chave>, form: "prose", supplement: [p. 12])`], [Autor na frase, com a página.],
  [`#cite(<chave>, form: "author")`], [Apenas o nome do autor.],
  [`#cite(<chave>, form: "full")`], [Referência completa, no texto.],
  [`@chave-a @chave-b`], [Várias obras em uma mesma chamada.],
  [`#citacao-de-citacao([Autor], 1990, <chave>)`], [Citação de citação (@apud[Seção]).],
)

O exemplo a seguir mostra as formas de citação no sistema autor-data, com as obras da lista de
referências deste manual.

```example
Um autor @luck2010, com a página @luck2010[p. 12] e na
frase: #cite(<luck2010>, form: "prose", supplement: [p. 12]).

Dois autores @oliveira1943, três autores @cruz1998 e
quatro autores @maciel2019. Na frase:
#cite(<oliveira1943>, form: "prose") e
#cite(<maciel2019>, form: "prose").

Várias obras @luck2010 @cruz1998. Obras do mesmo autor e
do mesmo ano @freyre1936a @freyre1936b. Autores com o
mesmo sobrenome @barbosaC1958 @barbosaO1958.

Entidade @abnt2024 e obra sem autoria
@anteprojeto1987[p. 55].
```

Uma obra sem autoria é citada pela primeira palavra do título, seguida de "[...]". Se o título começa por artigo
ou por palavra monossilábica, a palavra seguinte também é incluída. Para definir outra forma, informe o campo
`shorttitle` na entrada do arquivo `.bib`.

#remark[
  Um ponto da norma não é atendido #pill("partial"). Nas citações de várias obras do mesmo autor, as datas são
  separadas por ponto e vírgula, como em "(Dreyfuss, 1989; 1991)", e não por vírgula.
]

== Citação de citação <apud>

#norm-box("NBR 10520:2023, 7.3", "required", "implemented")[
  Na citação de citação, os elementos são indicados nesta ordem: autoria ou primeira palavra do título do documento
  original; data; página do documento original, se houver; a expressão "apud"; autoria ou primeira palavra do título
  da fonte consultada; data; página da fonte consultada, se houver. Na lista de referências, consta apenas a fonte
  consultada.
]

A função `citacao-de-citacao` gera a citação de citação. O autor e a data do documento original são escritos na
chamada, porque esse documento não está no arquivo `.bib`. A fonte consultada é informada pela chave e entra na
lista de referências. Os parâmetros `pagina` e `complemento` informam a página do documento original e a da fonte
consultada. Com `forma: "frase"`, o autor do documento original faz parte da frase, como no exemplo a seguir.

```example
Entre parênteses: #citacao-de-citacao([Silva], 1990,
  <autor2026>, pagina: [p. 5], complemento: [p. 10]).

Na frase: #citacao-de-citacao([Silva], 1990, <autor2026>,
  forma: "frase").
```

Nos sistemas numéricos, a fonte consultada é indicada pelo número.

#reference("citacao-de-citacao")

== Lista de referências <bibliography>

#norm-box("NBR 6023:2025, 6.3, 6.6, 6.7 e 9; NBR 14724:2024, 5.2", "required", "implemented")[
  As referências são elaboradas em espaço simples, alinhadas à margem esquerda e separadas entre si por uma linha
  em branco de espaço simples. O recurso tipográfico usado para destacar o título é uniforme em todas as
  referências; a obra sem autoria entra pelo título, com a primeira palavra em letras maiúsculas e sem outro
  destaque. Para os documentos online, registram-se o endereço eletrônico, precedido de "Disponível em:", e a data
  de acesso, precedida de "Acesso em:". No sistema alfabético, as referências são reunidas em ordem alfabética; no
  sistema numérico, seguem a ordem em que as obras são citadas no texto.
]

A lista de referências é gerada pela função `bibliography` do Typst, chamada depois do texto:

```typ
#bibliography("refs.bib")
```

O pacote gera o título "Referências", centralizado e sem número, e compõe cada referência conforme a norma. O
título da obra é destacado em negrito. Por padrão, a lista contém apenas as obras citadas no texto; com
`full: true`, contém todas as obras do arquivo. A lista de referências deste manual, na página
#context counter(page).at(query(bibliography).first().location()).first(), é gerada dessa forma.

== Arquivo de referências <bib-file>

As obras são registradas em um arquivo `.bib`, no formato do BibLaTeX. Cada entrada tem um tipo (`@book`,
`@article`), uma chave e os campos da obra. A @bib-fields[Tabela] resume como escrever os casos mais comuns.

#data-table([Campos do arquivo de referências], (3.2cm, 1fr), ([Caso], [Como escrever]), label: <bib-fields>,
  [Subtítulo], [No campo `title`, depois de dois-pontos: `title = {Título: subtítulo}`. O destaque termina nos
    dois-pontos.],
  [Entidade como autor], [Com chaves duplas: `author = {{Associação Brasileira de Normas Técnicas}}`.],
  [Tese e dissertação], [`@phdthesis`, com o tipo e o grau em `type`, a instituição em `publisher`, o local em
    `address` e o ano em `year`.],
  [Parte de livro], [`@incollection`, com o título da parte em `title` e o do livro em `booktitle`. O autor do
    livro vai em `bookauthor`; os organizadores, em `editor`, com `editortype = {organizer}`.],
  [Artigo], [`@article`, com o periódico em `journaltitle`, o local em `address` e os campos `volume`, `number` e
    `pages`.],
  [Trabalho em evento], [`@inproceedings`, com o evento em `eventtitle`, o número do evento em `edition`, o local
    em `venue` e `booktitle = {Anais [...]}`.],
  [Documento online], [O endereço em `url` e a data de acesso em `urldate`, no formato `2026-10-01`.],
  [Obra sem autoria], [Sem o campo `author`. O campo `shorttitle` define a chamada, se necessário.],
)

Os exemplos a seguir mostram a entrada do arquivo `.bib` e a referência gerada, para os tipos de documento mais
usados. As obras são exemplos da NBR 6023:2025.

=== Livro

#bib-example("luck2010")

=== Livro de entidade

#bib-example("abnt2024")

=== Tese

#bib-example("aguiar2009")

=== Dissertação em meio eletrônico

#bib-example("coelho2009")

=== Parte de livro

#bib-example("santos1994")

=== Parte de livro com organizadores

#bib-example("romano1996")

=== Artigo de periódico

#bib-example("delucca2009")

=== Artigo de jornal em meio eletrônico

#bib-example("verissimo2010")

=== Trabalho apresentado em evento

#bib-example("brayner1994")

=== Obra sem autoria

#bib-example("anteprojeto1987")

#remark[
  Alguns tipos de documento da NBR 6023:2025 não são compostos conforme a norma #pill("partial"): o evento no todo,
  a legislação e a jurisprudência, as patentes, o fascículo de periódico e os documentos cartográficos em
  periódicos. Alguns elementos também não têm campo próprio, como a data aproximada entre colchetes e a numeração
  do ano de um periódico ("ano 3"). Nesses casos, confira a referência gerada com o texto da norma.
]

= Índice das funções <api-index>

Este capítulo lista as funções e as variáveis do pacote, em ordem alfabética, com a página em que cada uma é
descrita. O pacote também exporta as mesmas funções com nomes em inglês, descritas na versão em inglês deste
manual.

#api-index()

// the works the examples cite, as the package sets the list of references of a work
#bibliography("examples/refs.bib")
