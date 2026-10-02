// Exemplo completo de trabalho acadêmico com o pacote abntly, escrito com os nomes em português da API. O exemplo
// reúne todos os elementos da estrutura (NBR 14724:2024, seção 4) e, nos capítulos, os elementos do texto. O texto
// de cada capítulo fica em um arquivo da pasta `capitulos/`.
//
// Para compilar a partir da raiz do repositório:
//   sh scripts/link.sh
//   typst compile --font-path fonts examples/pt/main.typ
#import "@preview/abntly:0.1.0": *

#show: trabalho-academico.with(
  dados: config-dados(
    titulo: [Composição de trabalhos acadêmicos em Typst],
    subtitulo: [um exemplo completo nas normas da ABNT],
    autor: (nome: "Nome do", sobrenome: "Autor"),
    orientador: (nome: "Profa. Dra. Nome da Orientadora", genero: "f"),
    coorientador: "Prof. Dr. Nome do Coorientador",
    instituicao: [Universidade do Brasil],
    programa: [Programa de Pós-Graduação em Ciência da Informação],
    area: [Organização da informação],
    local: [Rio Branco],
    ano: 2026,
    tipo: "tese",
  ),
)

// --- Elementos pré-textuais -----------------------------------------------------------------------------------------
#capa()

#folha-de-rosto[
  Tese apresentada ao Programa de Pós-Graduação em Ciência da Informação da Universidade do Brasil, como requisito
  parcial para a obtenção do título de Doutor em Ciência da Informação.
]

#ficha-catalografica()

#errata[
  AUTOR, Nome do. *Composição de trabalhos acadêmicos em Typst*: um exemplo completo nas normas da ABNT. 2026.
  Tese (Doutorado em Ciência da Informação) -- Universidade do Brasil, Rio Branco, 2026.

  #align(center, table(columns: 4, align: left, stroke: 0.4pt,
    table.header([*Folha*], [*Linha*], [*Onde se lê*], [*Leia-se*]),
    [12], [8], [normatização], [normalização],
    [27], [3], [Figura 3], [Figura 4],
  ))
]

#folha-de-aprovacao(
  (titulacao: [Profa. Dra.], nome: [Nome da Orientadora], papel: [Orientadora],
    instituicao: [Universidade do Brasil]),
  (titulacao: [Prof. Dr.], nome: [Nome do Coorientador], papel: [Coorientador],
    instituicao: [Universidade do Brasil]),
  (titulacao: [Profa. Dra.], nome: [Nome da Convidada], papel: [Convidada], instituicao: [Outra Universidade]),
  (titulacao: [Prof. Dr.], nome: [Nome do Convidado], papel: [Convidado], instituicao: [Instituto de Pesquisa]),
)

#dedicatoria[
  Este trabalho é dedicado a quem lê as normas \
  antes de começar a escrever.
]

#agradecimentos[
  Agradeço à minha orientadora, pela leitura atenta de cada versão deste trabalho, e ao meu coorientador, pelas
  sugestões sobre os experimentos.

  Agradeço aos colegas do laboratório, pelas discussões, e à minha família, pelo apoio durante todo o curso.

  Agradeço, por fim, às pessoas que mantêm os programas de código aberto usados na composição deste documento.
]

#epigrafe[
  _“Texto da epígrafe, escolhido pelo autor \
  para abrir o trabalho.”_ \
  (Autor da epígrafe)
]

#resumo[
  Este trabalho é um exemplo de trabalho acadêmico composto com o pacote abntly, que aplica as normas da ABNT a
  documentos escritos em Typst. O exemplo reúne os elementos pré-textuais, textuais e pós-textuais definidos pela
  NBR 14724:2024 e mostra, em um capítulo próprio, como escrever as seções, as alíneas, as citações, as notas de
  rodapé, as ilustrações, as tabelas e as equações. O texto dos demais capítulos é apenas ilustrativo. O código
  deste exemplo pode ser usado como ponto de partida para um trabalho novo ou consultado para verificar como um
  elemento específico é escrito.

  #palavras-chave[trabalhos acadêmicos][normalização][ABNT][Typst]
]

#resumo(idioma: "en")[
  This work is an example of an academic work typeset with the abntly package, which applies the ABNT standards
  to documents written in Typst. The example gathers the pre-textual, textual and post-textual elements defined
  by NBR 14724:2024 and shows, in a chapter of its own, how to write sections, lists, citations, footnotes,
  illustrations, tables and equations. The text of the other chapters is only illustrative.

  #palavras-chave[academic works][standardization][ABNT][Typst]
]

#lista-de-figuras()
#lista-de-quadros()
#lista-de-tabelas()
#lista-de(raw, titulo: [Lista de algoritmos])

#lista-de-siglas(
  (key: "abnt", short: "ABNT", long: [Associação Brasileira de Normas Técnicas]),
  (key: "ibge", short: "IBGE", long: [Instituto Brasileiro de Geografia e Estatística]),
  (key: "nbr", short: "NBR", long: [Norma Brasileira]),
)

#lista-de-simbolos(
  ($n$, [Número de documentos da amostra]),
  ($overline(x)$, [Média aritmética]),
  ($sigma$, [Desvio padrão]),
)

#outline()

// --- Elementos textuais ---------------------------------------------------------------------------------------------
#include "capitulos/introducao.typ"

#parte[Preparação da pesquisa]
#include "capitulos/elementos.typ"

#parte[Referencial e resultados]
#include "capitulos/referencial.typ"
#include "capitulos/resultados.typ"

#include "capitulos/conclusao.typ"

// --- Elementos pós-textuais -----------------------------------------------------------------------------------------
#bibliography("refs.bib")

#glossario(
  (key: "mancha", short: "mancha gráfica",
    description: [área da página delimitada pelas margens, onde o texto é impresso]),
  (key: "typst", short: "Typst", description: [sistema de composição tipográfica por marcação]),
  (key: "travessao", short: "travessão",
    description: [sinal de pontuação (—) que separa o número e o título de uma ilustração]),
)

#show: apendice

= Roteiro de verificação do trabalho

Antes do depósito, o autor pode conferir os seguintes itens:
+ os elementos obrigatórios estão presentes e na ordem da norma;
+ todas as ilustrações e tabelas têm título e fonte e são citadas no texto;
+ todas as obras citadas estão na lista de referências.

== Itens da versão impressa

Na versão impressa, os links são compostos em preto e o trabalho usa as margens de frente e verso.

= Dados complementares

#lorem(60)

#show: anexo

= Documento elaborado por terceiros

O anexo reproduz um texto ou documento que não foi elaborado pelo autor e que serve de fundamentação ou de
comprovação. #lorem(40)

// --- Índice ---------------------------------------------------------------------------------------------------------
#indice(
  (termo: "Algoritmos", paginas: 23),
  (termo: "Alíneas", paginas: 20),
  (termo: "Citações", paginas: "20-21", sub: ((termo: "diretas", paginas: 21), (termo: "indiretas", paginas: 20))),
  (termo: "Equações", paginas: 23),
  (termo: "Figuras", ver: "Ilustrações"),
  (termo: "Ilustrações", paginas: "21-22", ver-tambem: "Tabelas"),
  (termo: "Notas de rodapé", paginas: 21),
  (termo: "Quadros", paginas: 22),
  (termo: "Tabelas", paginas: (23, "29-31")),
)
