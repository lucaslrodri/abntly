// The lists of abbreviations and acronyms and of symbols (src/structure.typ), written by hand: the acronyms out of
// order, which the list puts in alphabetical order, one of them with a description of two lines; the symbols in the
// order given. A first chapter after them. The case acronyms includes it after `setup`.
#import "../../../src/lib.typ": list-of-acronyms, list-of-symbols

#list-of-acronyms(
  ("NBR", [Norma Brasileira]),
  ("ABNT", [Associação Brasileira de Normas Técnicas]),
  ("PDF", [Portable Document Format]),
  ("IBGE", [Instituto Brasileiro de Geografia e Estatística, a fundação pública que coleta, organiza e publica os dados
    estatísticos e geográficos do país]),
)
#list-of-symbols(
  ($a$, [Primeiro cateto de um triângulo retângulo]),
  ($b$, [Segundo cateto]),
  ($c$, [Hipotenusa]),
)

= Introdução

#lorem(30)
