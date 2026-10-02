// Trabalho acadêmico mínimo: só os elementos obrigatórios da ABNT NBR 14724:2024, na ordem da norma.
#import "@preview/abntly:0.1.0": *

#show: trabalho-academico.with(
  dados: config-dados(
    titulo: [Título do trabalho],
    autor: "Nome do Autor",
    orientador: "Prof. Dr. Nome do Orientador",
    instituicao: [Universidade do Brasil],
    local: [Rio Branco],
    ano: 2026,
  ),
)

// Elementos pré-textuais
#capa()
#folha-de-rosto[
  Dissertação apresentada à Universidade do Brasil, como requisito parcial para a obtenção do título de Mestre.
]
#ficha-catalografica()
#folha-de-aprovacao(
  (titulacao: [Prof. Dr.], nome: [Nome do Orientador], instituicao: [Universidade do Brasil]),
  (titulacao: [Profa. Dra.], nome: [Nome da Convidada], instituicao: [Outra Universidade]),
)
#resumo[
  Texto do resumo, em um único parágrafo.

  #palavras-chave[primeira][segunda][terceira]
]
#resumo(idioma: "en")[
  Abstract text, in a single paragraph.

  #palavras-chave[first][second][third]
]
#outline()

// Elementos textuais
= Introdução

Texto da introdução, com uma citação @luck2010.

= Desenvolvimento

Texto do desenvolvimento.

= Conclusão

Texto da conclusão.

// Elementos pós-textuais
#bibliography("refs.bib")
