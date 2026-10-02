#import "/src/lib.typ": *
#import "common/pt.typ": setup
#show: setup
#folha-de-rosto[Tese apresentada ao Programa de Pós-Graduação da Universidade do Brasil, como requisito
  parcial para a obtenção do título de Doutor.]
#let orientadora = (titulacao: [Profa. Dra.], nome: [Nome da Orientadora], papel: [Orientadora],
  instituicao: [Universidade do Brasil])
#let convidado = (titulacao: [Prof. Dr.], nome: [Nome do Convidado], papel: [Convidado],
  instituicao: [Outra Universidade])
// --- example ---
#folha-de-aprovacao(pe: com-dados(d => {
  align(left)[Aprovado em:
    #box(width: 3cm, repeat[\_])]
  v(1cm)
  grid(columns: 2,
    assinatura(orientadora),
    assinatura(convidado))
  v(1cm)
  [#d.location \ #d.year]
}))
