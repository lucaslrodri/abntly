/// Synopsis: Um trabalho com as partes do autor nas páginas de dados, a numeração das equações por função e as marcas das partes
// What only the layout runs, in a work whose pages of data take the author's own parts, whose equations are numbered
// by a function, and which marks its textual and its post-textual parts: the master of the pages with its own
// parts, the title page and the approval sheet with the author's, the catalog card without the type of the work and
// with one written as content, the entries of the summary after the post-textual mark, an outline of the figures
// with links. The assertions read what a function gives where it runs (`context`).
#import "../common.typ": *
#import "../../../src/lib.typ": *
#import "../../../src/layout.typ": chapter-mark, textual-start, postextual-start
#import "../../../src/structure.typ": _sheet
#import "../../../src/info.typ": work

#let data = config-info(title: [O título], subtitle: [o subtítulo], author: "Nome do Autor", year: 2026,
  work-type: [Monografia (Especialização)], institution: [Universidade do Brasil])
#show: abntly.with(info: data, equation-numbering: (..n) => numbering("[1]", ..n))

// the master of the three pages, with its own parts: the author, the title, the year
#page(header: none, _sheet())

// the title page with the author's top and bottom, the package's middle
#title-page(top: [O TOPO DO AUTOR], bottom: [O PÉ DO AUTOR])[A natureza do trabalho.]

// the card with a type of work written as content; the data as the pages receive them
#catalog-card()
#with-info(d => {
  assert.eq(d.work-type, [Monografia (Especialização)])
  assert.eq(text-of(d.full-title), "O título: o subtítulo")
  assert.eq((d.author, d.author-inverted, text-of(d.author-reference)),
    ("Nome do Autor", "Autor, Nome do", "AUTOR, Nome do"))
  assert.eq(d.preamble, [A natureza do trabalho.])
})

// the approval sheet in the two boxes, with the author's top, a date and no place
#let member = (title: [Prof. Dr.], name: [Fulano de Tal], institution: [Universidade do Brasil])
#approval-page(member, top: [O TOPO DA FOLHA], date: [1º de outubro de 2026], middle-height: 83%)
// and with the author's middle, in the default arrangement (`middle-height: auto`)
#approval-page(member, middle: [O MEIO DO AUTOR], draft: false)

// a work without a type: the card leaves its note out
#work.update(config-info(title: [Outro título], author: "Outro Autor", year: 2026))
#catalog-card(draft: false)
#with-info(d => assert.eq((d.work-type, d.title), (none, [Outro título])))

#outline()

// an outline the author writes, of the figures, with its links
#heading(numbering: none, outlined: false)[Figuras]
#outline(title: none, target: figure.where(kind: image))

#show: main-matter

= Um capítulo <cap>

#figure(rect(width: 4cm, height: 1cm), caption: [Uma figura]) <fig>

Uma equação numerada pela função do autor, e a remissão a ela, a @eq, como o Typst a escreve.

$ x = y $ <eq>

// a primary heading numbered by a function gives its own mark to the running header
#heading(numbering: (..n) => [§#n.pos().first() ])[Numerado por função] <funcao>

O texto da primeira página.
#pagebreak()
O texto da segunda página, com a marca do título no cabeçalho.

#show: back-matter

= Um título pós-textual <pos>

// a numbered primary heading of the post-textual part outside `appendix` and `annex` is an appendix in the summary
#set heading(numbering: "A.1")
= Um material <material>

#context {
  // the marks of the parts
  assert.eq(textual-start(), query(<abntly-main-matter>).first().location().page())
  assert.eq(postextual-start(), query(<abntly-back-matter>).first().location())
  let mark(label) = text-of(chapter-mark(query(label).first()))
  assert.eq(mark(<cap>), "Capítulo 1. Um capítulo")
  assert.eq(mark(<funcao>), "§2 Numerado por função")
  assert.eq(mark(<pos>), "Um título pós-textual")
}
// the equation by the function of the author
#same-room([@eq], [[1]])
