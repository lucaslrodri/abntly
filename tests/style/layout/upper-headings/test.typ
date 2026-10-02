/// Synopsis: As seções primárias em caixa alta, por uma regra do autor, e as partes do trabalho marcadas à mão
// The primary headings in capitals are a rule of the author: `#show heading.where(level: 1): upper`. The parts of
// the work by hand: `front-matter`, `main-matter` and `back-matter`, where the automatic ones would do the same, and
// the plain headings they number or not.
#import "../../../common.typ": *
#import "../../../../src/lib.typ": front-matter, main-matter, back-matter
#show: setup
#show heading.where(level: 1): upper

#show: front-matter
= Resumo

#lorem(120)

#show: main-matter
= Introdução

#lorem(150)

== Uma seção

#lorem(150)

#lorem(150)

#lorem(150)

#show: back-matter
= Referências

#lorem(150)
