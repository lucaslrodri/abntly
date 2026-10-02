/// Synopsis: Um trabalho sem links, com as equações "(1.1a)" e sem os dados: as remissões, as marcas do cabeçalho, a tabela em três páginas
// What only the layout runs, in a work with `hyperlink: none` and `equation-numbering: "(1.1a)"`, without the title
// nor the author in its data and without a post-textual mark: every form of a reference written again without its
// link, the marks of the running header, a table of the IBGE over three pages, the forms of a title of a figure, the
// subalíneas. The assertions read what a function gives where it runs (`context`) and compare the room a reference
// takes with the room of what it must write.
#import "../common.typ": *
#import "../../../src/lib.typ": *
#import "../../../src/layout.typ": chapter-mark, section-mark, textual-start, postextual-start

#show: abntly.with(info: config-info(year: 2026), hyperlink: none, equation-numbering: "(1.1a)")

// the data a part of a page receives: what the work does not have is `none`
#with-info(d => {
  assert.eq((d.title, d.full-title, d.author, d.author-inverted, d.author-reference), (none,) * 5)
  assert.eq((d.advisor, d.advisor-label, d.co-advisor, d.co-advisor-label, d.work-type), (none,) * 5)
  assert.eq(text-of(d.year-volume), "2026")
  assert.eq((d.area-label, d.preamble, d.keywords), ("Área de concentração", none, ("layout", "remissões")))
  assert.eq(d.data, config-info(year: 2026))
})

// an abstract in the language of the work, said by name
#abstract(lang: "pt")[
  Um resumo em português, com o idioma dito.

  #keywords("layout", "remissões")
]

#outline()

// an outline the author writes, of the figures: its entries as Typst sets them, less their links
#heading(numbering: none, outlined: false)[Figuras] <figuras>
#outline(title: none, target: figure.where(kind: image))

= Introdução <intro>

Uma figura#footnote[A nota do texto.] <nota> com o seu título, uma sem número e uma sem palavra.

#figure(rect(width: 4cm, height: 1cm), caption: [Uma figura]) <fig>

#figure(rect(width: 4cm, height: 1cm), numbering: none, caption: [Uma figura sem número])

#figure(rect(width: 4cm, height: 1cm), supplement: none, caption: [Uma figura sem palavra])

#subfigures(
  figure(rect(width: 3cm, height: 1cm), caption: [A primeira parte]), <parte-a>,
  figure(rect(width: 3cm, height: 1cm), caption: [A segunda parte]), <parte-b>,
  caption: [Um conjunto], label: <conjunto>)

// a quadro in a box as wide as its table keeps the lines of the author
#fitted(kind: "quadro", supplement: [Quadro], caption: [Um quadro], label: <quadro>,
  table(columns: (3cm, 3cm), [a], [b], [c], [d]))

== Uma seção <sec>

As alíneas com subalíneas escritas como alíneas:

+ a primeira alínea:
  + uma subalínea;
  + outra subalínea;
+ a segunda alínea.

As linhas de uma equação dividem o número dela, com uma letra:

$ a &= b + c #<linha-a> \
    &= d     #<linha-b> $

$ x = y $ <eq>

As remissões sem link: a figura @fig, a #ref(<fig>, supplement: auto), a @fig[Figura] e a #auto-ref(<fig>)\; o
#auto-ref(<quadro>)\; o #auto-ref(<intro>)\; a seção @sec e a #auto-ref(<sec>)\; as partes @parte-b e
#auto-ref(<parte-a>)\; as equações @eq, @linha-b e #auto-ref(<linha-a>)\; as páginas #ref(<fig>, form: "page") e
#auto-ref(<fig>, form: "page")\; a nota @nota.

// a reference written again without its link takes the room of what it must write (`same-room`)
// only the number; the word of the element, with `supplement: auto`; the word the author gives; the one `auto-ref` finds
#same-room([@fig], [1])
#same-room(ref(<fig>, supplement: auto), [Figura~1])
#same-room([@fig[Figura]], [Figura~1])
#same-room(auto-ref(<fig>), [Figura~1])
#same-room(auto-ref(<quadro>), [Quadro~1])
#same-room(auto-ref(<intro>), [Capítulo~1])
#same-room([@sec], [1.1])
#same-room(auto-ref(<sec>), [Seção~1.1])
// a part of a set of subfigures: the number of the set and its letter
#same-room([@parte-b], [3b])
#same-room(auto-ref(<parte-a>), [Figura~3a])
// an equation and a line of one
#same-room([@eq], [(1.2)])
#same-room([@linha-b], [(1.1b)])
#same-room(auto-ref(<linha-a>), [Equação~(1.1a)])
// a footnote by its call; a page by its number
#same-room([@nota], super[1])
#context same-room(ref(<fig>, form: "page"), [#counter(page).at(<fig>).first()])
#context same-room(auto-ref(<fig>, form: "page"), [p.~#counter(page).at(<fig>).first()])

// a table of the IBGE over three pages: "(continua)", "(continuação)", "(conclusão)"
#fitted(caption: [Os quadrados dos números], label: <longa>,
  table(columns: (3cm, 3cm), align: (left, right), table.header([Número], [Quadrado]),
    ..range(1, 81).map(i => ([#i], [#(i * i)])).flatten()))

#context {
  let start = query(<abntly-table-start>).first().location().page()
  let end = query(<abntly-table-end>).first().location().page()
  assert.eq(end - start, 2)
}

#show: appendix

= Um apêndice <ap>

O texto do apêndice, que remete a ele mesmo: o apêndice @ap, o @ap[Apêndice] e o #auto-ref(<ap>)\; a seção @ap-sec e
a #auto-ref(<ap-sec>).

== Uma seção do apêndice <ap-sec>

#same-room([@ap], [A])
#same-room([@ap[Apêndice]], [Apêndice~A])
#same-room(auto-ref(<ap>), [Apêndice~A])
#same-room([@ap-sec], [A.1])
#same-room(auto-ref(<ap-sec>), [Seção~A.1])

#pagebreak()
A segunda página do apêndice, com a marca dele no cabeçalho.

// the parts of the work and the marks of the running header
#context {
  // the textual part starts at the first numbered primary section; nothing marks the post-textual one
  assert.eq(textual-start(), query(<intro>).first().location().page())
  assert.eq(postextual-start(), none)
  let mark(label) = text-of(chapter-mark(query(label).first()))
  assert.eq(mark(<intro>), "Capítulo 1. Introdução")
  assert.eq(mark(<ap>), "APÊNDICE A. Um apêndice")
  // a primary heading without a number, by its title alone
  assert.eq(mark(<figuras>), "Figuras")
  assert.eq(text-of(section-mark(query(<sec>).first())), "1.1. Uma seção")
  assert.eq(text-of(section-mark(query(<ap-sec>).first())), "A.1. Uma seção do apêndice")
}

// an algorithm whose code a rule of the author sets with blocks of its own (as the lines of the package codly): the
// blocks keep their widths, so the code starts beside the number of its line, and not past the text block
#{
  show raw.where(block: true): it => grid(columns: (auto, 1fr), block[1], [#metadata(none)<code-column>#it.text])
  algorithm(caption: [Um algoritmo com as linhas numeradas], raw("x = 1", block: true))
}
#context assert(query(<code-column>).first().location().position().x < 5cm)
