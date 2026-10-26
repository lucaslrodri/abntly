/// Synopsis: As listas com chaves (src/structure.typ): a citação de uma entrada (@abnt) leva à linha dela na lista
// The lists written with keys, over the package glossarium: the list of acronyms, the list of symbols and the
// glossary. Glossarium gives each entry its labels (`<abnt>`, `<abnt:short>`...) where its invisible glossary is, and
// a citation in the text (`@abnt`) is a link to them; so each list prints that glossary one entry at a time, at the
// line of the entry, and a citation leads to its line, not to one place for the whole list.
#import "../common.typ": *
#import "../../../src/lib.typ": *

#show: abntly

#list-of-acronyms(
  (key: "nbr", short: "NBR", long: [Norma Brasileira]),
  (key: "abnt", short: "ABNT", long: [Associação Brasileira de Normas Técnicas]),
  (key: "pdf", short: "PDF", long: [Portable Document Format]),
)
#list-of-symbols(
  (key: "c", short: $c$, long: [velocidade da luz no vácuo]),
  (key: "g", short: $g$, long: [aceleração da gravidade]),
)

= Introdução

As normas da @abnt e uma @nbr; o @pdf; $c$ (@c) e $g$ (@g); o @typst e a @mancha.

#glossary(
  (key: "typst", short: "Typst", description: [sistema de composição tipográfica por marcação]),
  (key: "mancha", short: "mancha gráfica", description: [área da página dentro das margens, onde vai o texto]),
)

// each label of an entry on a line of its own, in the order the list prints them (the acronyms and the glossary in
// alphabetical order, the symbols in the order given), and below the title of its list
#context {
  let at(key) = locate(label(key)).position()
  let lists = (
    ("Lista de abreviaturas e siglas", ("abnt", "nbr", "pdf")),
    ("Lista de símbolos", ("c", "g")),
    ("Glossário", ("mancha", "typst")),
  )
  for (title, keys) in lists {
    let head = query(heading.where(level: 1)).find(h => h.body == [#title])
    assert(head != none, message: "no heading " + title)
    let top = head.location().position()
    let places = keys.map(at)
    for (key, p) in keys.zip(places) {
      assert.eq(p.page, top.page, message: key + ": not on the page of its list")
      assert(p.y > top.y, message: key + ": not below the title of its list")
    }
    for i in range(1, keys.len()) {
      assert(places.at(i).y > places.at(i - 1).y, message: keys.at(i) + " is not on a line below "
        + keys.at(i - 1) + " (" + repr(places.at(i).y) + " and " + repr(places.at(i - 1).y) + ")")
    }
  }
}
