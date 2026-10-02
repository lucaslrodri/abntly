// The list of abbreviations and acronyms with keys, over the package glossarium (src/structure.typ): the same list
// as acronyms.typ, and a chapter that cites two of them with `@key`, the first mention with the long form. The case
// acronyms-keyed includes it after `setup`.
#import "../../../src/lib.typ": list-of-acronyms

#list-of-acronyms(
  (key: "nbr", short: "NBR", long: [Norma Brasileira]),
  (key: "abnt", short: "ABNT", long: [Associação Brasileira de Normas Técnicas]),
  (key: "pdf", short: "PDF", long: [Portable Document Format]),
  (key: "ibge", short: "IBGE", long: [Instituto Brasileiro de Geografia e Estatística, a fundação pública que coleta,
    organiza e publica os dados estatísticos e geográficos do país]),
)

= Introdução

As normas da @abnt dão a forma do trabalho; uma @nbr da @abnt dá a estrutura.
