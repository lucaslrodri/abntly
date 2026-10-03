#import "../prelude.typ": *
#show: chapter.with(title: [Estrutura do trabalho acadêmico], id: <structure>)

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
  [Errata], pill("optional"), [`errata`],
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

A função `errata` gera o título "Errata" e insere o conteúdo informado. A referência do trabalho e a tabela das
correções são escritas pelo autor, como no exemplo a seguir.

#page-example("errata", pages: (2,), crop: (0, 0.4))

#reference("errata")

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
