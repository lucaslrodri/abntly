#import "/src/lib.typ": *
#import "common/pt.typ": setup
#show: setup
// --- example ---
#lista-de-siglas(
  (key: "abnt", short: "ABNT", long: [Associação Brasileira de Normas Técnicas]),
  (key: "ibge", short: "IBGE", long: [Instituto Brasileiro de Geografia e Estatística]),
)

#lista-de-simbolos(
  ($d_(a b)$, [Distância euclidiana]),
  ($O(n)$, [Ordem de um algoritmo]),
)

= Introdução

As normas da @abnt definem a estrutura do trabalho, e as tabelas seguem as normas do @ibge.
Na segunda menção, apenas a sigla é exibida: @abnt.
