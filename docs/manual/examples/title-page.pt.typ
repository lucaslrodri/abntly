#import "/src/lib.typ": *
// --- example ---
#show: trabalho-academico.with(
  dados: config-dados(
    titulo: [Título do trabalho],
    subtitulo: [subtítulo],
    autor: "Nome do Autor",
    orientador: (
      nome: "Profa. Dra. Nome Sobrenome",
      genero: "f",
    ),
    coorientador: "Prof. Dr. Outro Nome",
    area: [Sistemas de energia],
    local: [Rio Branco],
    ano: 2026,
  ),
)

#folha-de-rosto[Tese apresentada ao
  Programa de Pós-Graduação da Universidade
  do Brasil, como requisito parcial para a
  obtenção do título de Doutor.]
