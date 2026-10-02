#import "/src/lib.typ": *
#show: trabalho-academico.with(
  dados: config-dados(
    titulo: [Título do trabalho],
    subtitulo: [subtítulo],
    autor: "Nome do Autor",
    instituicao: [Universidade do Brasil],
    programa: [Programa de Pós-Graduação],
    local: [Rio Branco],
    ano: 2026,
  ),
)
// --- example ---
#capa(
  topo: com-dados(d => [
    #upper(d.institution) \
    #d.program
    #v(3cm)
    #d.author
  ]),
  altura-do-meio: 60%,
)
