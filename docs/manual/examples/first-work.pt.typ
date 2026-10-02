#import "/src/lib.typ": *
// --- example ---
#show: trabalho-academico.with(
  dados: config-dados(
    titulo: [Título do trabalho],
    autor: "Nome do Autor",
    orientador: "Prof. Dr. Nome Sobrenome",
    instituicao: [Universidade do Brasil],
    local: [Rio Branco],
    ano: 2026,
  ),
)

#capa()
#folha-de-rosto[Dissertação apresentada à
  Universidade do Brasil, como requisito
  parcial para a obtenção do título de
  Mestre.]
#outline()

= Introdução

O texto do trabalho começa aqui.

== Objetivos

Uma seção secundária.
