#import "/src/lib.typ": *
#import "common/pt.typ": setup
#show: setup
#folha-de-rosto[Tese apresentada ao Programa de Pós-Graduação da Universidade do Brasil, como requisito
  parcial para a obtenção do título de Doutor.]
#let orientadora = (titulacao: [Profa. Dra.], nome: [Nome da Orientadora], papel: [Orientadora],
  instituicao: [Universidade do Brasil])
#let convidado = (titulacao: [Prof. Dr.], nome: [Nome do Convidado 1], papel: [Convidado 1],
  instituicao: [Outra Universidade])
#let convidada = (titulacao: [Profa. Dra.], nome: [Nome da Convidada 2], papel: [Convidada 2],
  instituicao: [Instituto de Pesquisa])
// --- example ---
#folha-de-aprovacao(
  orientadora, convidado, convidada,
  data: [30 de setembro de 2026],
  provisoria: false,
)
