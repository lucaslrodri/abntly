#import "../prelude.typ": *
#show: chapter.with(title: [Início rápido], id: <quick-start>)

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

Todas as funções têm um nome em inglês e um nome em português (por exemplo, `cover` e `capa`), com os parâmetros e
a documentação no respectivo idioma. Este manual usa os nomes em português; a versão em inglês do manual usa os
nomes em inglês. Os dois conjuntos podem ser combinados no mesmo documento.

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
#import "@preview/abntly:0.1.1": *
```

O Typst baixa o pacote automaticamente na primeira compilação.

Para criar um trabalho novo a partir do modelo do pacote, que traz todos os elementos da estrutura comentados, use
o comando:

```sh
typst init @preview/abntly:0.1.1
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
