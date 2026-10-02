#import "/src/lib.typ": *
// --- example ---
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

#capa()
