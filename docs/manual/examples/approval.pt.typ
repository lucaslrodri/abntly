#import "/src/lib.typ": *
#import "common/pt.typ": setup
#show: setup
#folha-de-rosto[Tese apresentada ao Programa de Pós-Graduação da Universidade do Brasil, como requisito
  parcial para a obtenção do título de Doutor.]
// --- example ---
#folha-de-aprovacao(
  (titulacao: [Profa. Dra.],
    nome: [Nome da Orientadora],
    papel: [Orientadora],
    instituicao: [Universidade do Brasil]),
  (titulacao: [Prof. Dr.],
    nome: [Nome do Convidado 1],
    papel: [Convidado 1],
    instituicao: [Outra Universidade]),
  (titulacao: [Profa. Dra.],
    nome: [Nome da Convidada 2],
    papel: [Convidada 2],
    instituicao: [Instituto de Pesquisa]),
)
