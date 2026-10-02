/// Synopsis: O índice (src/index.typ): as entradas, a ordem da NBR 6033, os links das páginas e as remissivas
#import "../common.typ": *
#import "../../../src/index.typ": *

#set text(lang: "pt")

// --- an entry ---------------------------------------------------------------------------------------------------------
#let blank = (term: none, pages: (), sub: (), see: none, see-also: none)
// the pair, with one page or a list of them
#assert.eq(entry(("Termo", 3)), blank + (term: "Termo", pages: (3,)))
#assert.eq(entry(("Termo", (3, "5-7"))), blank + (term: "Termo", pages: (3, "5-7")))
// the dictionary, its keys in English or in Portuguese, its sub-headings entries too
#assert.eq(entry((term: "Termo", pages: 3, see: "Outro")), blank + (term: "Termo", pages: (3,), see: "Outro"))
#assert.eq(entry((termo: "Termo", paginas: (3, 8), ver: "Outro", ver-tambem: [Mais um])),
  blank + (term: "Termo", pages: (3, 8), see: "Outro", see-also: [Mais um]))
#assert.eq(entry((term: "Termo", sub: (("de um tipo", 4), (termo: "de outro", paginas: 5)))).sub,
  (blank + (term: "de um tipo", pages: (4,)), blank + (term: "de outro", pages: (5,))))
#fails(() => entry("Termo"), "index: an entry is a dictionary")
#fails(() => entry(("Termo", 3, 4)), "index: an entry is a dictionary")
#fails(() => entry((term: "Termo", page: 3)), "index: an entry takes the keys term, termo, pages, paginas")
#fails(() => entry((pages: 3)), "index: an entry has a term")

// --- the order of NBR 6033 --------------------------------------------------------------------------------------------
// without the accents, the capitals as the small letters, the numbers before the letters; the sub-headings too
#let terms(entries) = ordered(entries.map(entry)).map(e => e.term)
#assert.eq(terms((("Órgão", 1), ("abelha", 2), ("Zebra", 3), ("3D", 4), ("Água", 5), ("agulha", 6))),
  ("3D", "abelha", "Água", "agulha", "Órgão", "Zebra"))
#assert.eq(ordered((entry((term: "A", sub: (("z", 1), ("b", 2), ("É", 3)))),)).first().sub.map(e => e.term),
  ("b", "É", "z"))

// --- a page as a link -------------------------------------------------------------------------------------------------
#let to(page) = (page: page, x: 0pt, y: 0pt)
// the printed number against the physical page, up to the last page of the work
#assert.eq(page-link(3, offset: 2, last: 10), link(to(5), "3"))
#assert.eq(page-link(10, offset: 2, last: 10), link(to(12), "10"))
// a page that the work does not have is text
#assert.eq(page-link(0, offset: 2, last: 10), "0")
#assert.eq(page-link(11, offset: 2, last: 10), "11")
// a string of figures as the number; a range, each bound to its own page
#assert.eq(page-link("3", offset: 2, last: 10), link(to(5), "3"))
#let range = page-link("5-7", offset: 1, last: 10)
#assert.eq(text-of(range), "5-7")
#assert.eq(range.children.filter(c => c.func() == link).map(c => c.dest), (to(6), to(8)))
// a range past the last page keeps the bound it has
#assert.eq(page-link("9-12", last: 10).children.filter(c => c.func() == link).map(c => c.dest), (to(9),))
// what is not a number stays as it is
#assert.eq(text-of(page-link("xii", last: 10)), "xii")
#assert.eq(text-of(page-link([passim], last: 10)), "passim")

// --- the lines of an entry --------------------------------------------------------------------------------------------
#context {
  let page = page-link.with(last: 0)
  let line = lines(entry((term: "Entropia", pages: (12, "15-18"), see: "Calor", see-also: [Energia])), 0, page)
  assert.eq(text-of(line), "Entropia, 12, 15-18, ver Calor, ver também Energia")
  // the sub-headings after it, each a paragraph further in
  let group = lines(entry((term: "Entropia", sub: (("de mistura", 16), ("padrão", 18)))), 0, page)
  assert.eq(group.children.map(text-of), ("Entropia", "de mistura, 16", "padrão, 18"))
}

// --- the index --------------------------------------------------------------------------------------------------------
#fails(() => index(("A", 1), colunas: 2), "index: takes the entries as positional arguments")
#fails(() => index(("A", 1), columns: 0), "index: columns is a positive integer")
#fails(() => index(("A", 1), columns: "2"), "index: columns is a positive integer")
#fails(() => index(("A", 1), sort: 1), "index: sort is true or false")
#fails(() => index("A"), "index: an entry is a dictionary")

// an index of three initials, one of them with sub-headings, and one in the order given
#index(("Zinco", 1), (term: "Água", pages: (1, "1-2"), sub: (("pesada", 1),), see-also: "Zinco"), ("Ácido", 1),
  (term: "Base", see: "Ácido"))
#index(("Zinco", 1), ("Ácido", 1), columns: 1, sort: false)
