#import "/src/lib.typ": *
#import "common/en.typ": setup
#show: setup
// --- example ---
#list-of-acronyms(
  (key: "abnt", short: "ABNT", long: [Associação Brasileira de Normas Técnicas]),
  (key: "ibge", short: "IBGE", long: [Instituto Brasileiro de Geografia e Estatística]),
)

#list-of-symbols(
  ($d_(a b)$, [Euclidean distance]),
  ($O(n)$, [Order of an algorithm]),
)

= Introduction

The standards of the @abnt define the structure of the work, and the tables follow the
standards of the @ibge. On the second mention, only the acronym is shown: @abnt.
