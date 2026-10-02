// The work of the page examples of the manual in Portuguese: the main function with the data every example shares
// (the ones the manual shows in its section on the data of the work). An example applies it before its marker
// line, so that only the element it is about is shown.
#import "/src/lib.typ": *

#let setup = trabalho-academico.with(dados: config-dados(
  titulo: [Título do trabalho],
  subtitulo: [subtítulo],
  autor: "Nome do Autor",
  orientador: (nome: "Profa. Dra. Nome da Orientadora", genero: "f"),
  instituicao: [Universidade do Brasil],
  programa: [Programa de Pós-Graduação],
  local: [Rio Branco],
  ano: 2026,
  tipo: "tese",
))
