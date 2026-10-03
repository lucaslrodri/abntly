/// Synopsis: Os elementos do texto (src/elements.typ): a tabela do IBGE, a numeração das equações, o que vai sob a ilustração, as assinaturas
#import "../common.typ": *
#import "../../../src/elements.typ": *
#import "../../../src/spacing.typ": figure-spacing, line-spacing

#set text(lang: "pt")

// --- the table of the IBGE --------------------------------------------------------------------------------------------
// the columns of a table, from its `columns`
#assert.eq(column-count(3), 3)
#assert.eq(column-count((1fr, auto, 2cm)), 3)
#assert.eq(column-count(auto), 1)
#assert.eq(column-count(2cm), 1)

// the rows of a header: its cells over the columns, each as wide and as tall as its spans, the rules left out
#assert.eq(row-count(table.header([A], [B]), 2), 1)
#assert.eq(row-count(table.header([A], [B], [C], [D]), 2), 2)
#assert.eq(row-count(table.header(table.cell(colspan: 2)[AB], table.hline(), [A], [B]), 2), 2)
#assert.eq(row-count(table.header(table.cell(rowspan: 2)[A], [B], [C]), 2), 2)
#assert.eq(row-count(table.header(), 2), 0)

// the rules of a table of the IBGE, in em of the body
#assert.eq(rules, (heavy: 0.08, light: 0.05, double: 2 / 12))

// a marker is a cell of no height across the table
#let m = marker(3, <abntly-table-start>)
#assert.eq((m.colspan, m.inset), (3, 0pt))

// the table rebuilt: the same columns, the header again with the rules of the IBGE, a label of its own
#let rebuilt = ibge(table(columns: (1fr, 1fr), stroke: 1pt, table.header([A], [B]), [1], [2], [3], [4]), 10em / 12)
#assert.eq(rebuilt.label, <abntly-ibge>)
#assert.eq(rebuilt.columns, (1fr, 1fr))
#assert.eq(type(rebuilt.stroke), function)
#let header = rebuilt.children.first()
#assert.eq(header.func(), table.header)
// the heavy rule at the top, 0.08 em of the body in the text of the table, and the light ones under the header
#assert.eq(header.children.filter(c => c.func() == table.hline).map(c => c.stroke.thickness),
  (0.08em * 1.2, 0.05em * 1.2, 0.05em * 1.2))
// the markers of the start and of the end, the last in a footer that does not repeat
#assert.eq(rebuilt.children.at(1).body.label, <abntly-table-start>)
#assert.eq(rebuilt.children.last().func(), table.footer)
#assert.eq(rebuilt.children.last().repeat, false)

// the table of a plain figure (`ibge-table`): the author's table with the label the rule of `elements` rebuilds, only
// with a header, which the rebuild needs
#let plain = ibge-table(columns: 2, align: center, table.header([A], [B]), [1], [2])
#assert.eq(plain.func(), table)
#assert.eq(plain.label, <abntly-ibge-table>)
#assert.eq((plain.columns, plain.align), ((auto, auto), center))
#fails(() => ibge-table(columns: 2, [1], [2]),
  "ibge-table: takes the arguments of table with the header in table.header(...)")
// rebuilt as any table of the IBGE: the label of the author's table is not a field of the new one
#assert.eq(ibge(plain, 10em / 12).label, <abntly-ibge>)

// --- the numbering of the equations -----------------------------------------------------------------------------------
// a pattern with two numbers counts by chapter
#assert(by-chapter("(1.1)"))
#assert(by-chapter("(1.1a)"))
#assert(not by-chapter("(1)"))
#assert(not by-chapter("(1a)"))
#assert(not by-chapter((..n) => [x]))
// in an appendix, its letter in the place of the number of the chapter
#assert.eq(lettered("(1.1)", none), "(1.1)")
#assert.eq(lettered("(1.1)", "appendix"), "(A.1)")
#assert.eq(lettered("(1.1a)", "annex"), "(A.1a)")

// --- what goes under an illustration ----------------------------------------------------------------------------------
#let u = under([Fonte:], [IBGE.])
#assert.eq(u.label, <abntly-under>)
#assert.eq(u.func(), block)
#assert.eq(u.width, 100%)
#assert.eq(u.above, figure-spacing.gap - 10em / 12)
// the word, a no-break space and the text
#assert.eq(text-of(u), "Fonte:\u{a0}IBGE.")

#assert.eq(source[IBGE.].label, <abntly-under>)
#assert.eq(source().label, <abntly-under>)
#fails(() => source([um], [dois]), "source: takes at most one argument")
#fails(() => source(corpo: [um]), "source: takes at most one argument")
#assert.eq(legend[Azul: o mar.].label, <abntly-under>)

// a note with its word, with another one, or with a call in the place of the word
#assert.eq(text-of(note(word: [Notas])[a e b.]), "Notas:\u{a0}a e b.")
#assert.eq(text-of(note(call: 1)[a nota.]), "1\u{a0}a nota.")
#assert.eq(note[uma nota.].label, <abntly-under>)

// the call of a note is glued to the word before it
#assert.eq(call(1).children.first(), h(0pt, weak: true))

// --- the figures of the package ---------------------------------------------------------------------------------------
#let q = frame(caption: [Um quadro])[corpo]
#assert.eq((q.func(), q.kind), (figure, "quadro"))
#let a = algorithm(caption: [Um algoritmo], raw("x", block: true))
#assert.eq((a.func(), a.kind), (figure, raw))
#assert.eq(auto-ref(<x>).func(), ref)
#assert.eq(auto-ref(<x>).supplement, auto-name)
#assert.eq(auto-ref(<x>, form: "page").form, "page")
#assert.eq(hanging([a], [b]).columns, (auto, auto))
#assert.eq(sub-reference, "1a")

// --- the stamp and the nature -----------------------------------------------------------------------------------------
#let s = bare(stamp(note: [uma nota])[RASCUNHO])
#assert.eq(s.func(), align)
#assert.eq(s.body.func(), rotate)
#assert.eq(s.body.angle, -45deg)
#assert.eq(text-of(stamp(color: blue, size: 2em)[RASCUNHO]), "RASCUNHO")
#assert.eq(text-of(s), "RASCUNHOuma nota")
#assert.eq(bare(stamp(angle: 30deg)[R]).body.angle, 30deg)

#let p = preamble[Tese apresentada.]
#assert.eq(p.func(), align)
#assert.eq((p.alignment, p.body.width), (right, 50%))

// --- the signatures ---------------------------------------------------------------------------------------------------
#let member = (title: [Prof. Dr.], name: [Fulano de Tal], role: [Orientador], institution: [Universidade])
#assert.eq(text-of(signature(member)), "Prof. Dr. Fulano de Tal\n Orientador\n Universidade")
// the keys in Portuguese, the role left out
#assert.eq(text-of(signature(("titulação": [Dra.], nome: [Beltrana], "instituição": [Instituto]))),
  "Dra. Beltrana\n Instituto")
#assert.eq(text-of(signature((titulacao: [Dra.], nome: [Beltrana], instituicao: [Instituto], papel: [Membro]))),
  "Dra. Beltrana\n Membro\n Instituto")
// content as the author writes it, and two members one under the other
#assert.eq(text-of(signature([Fulano de Tal \ Orientador])), "Fulano de Tal \n Orientador")
#assert.eq(bare(signature(member, member).body).children.filter(c => c.func() == block).len(), 2)
// after a text in single spacing, the first rule a single line nearer
#assert.eq(signatures((member,)).above - signatures((member,), line: 1.2em).above, line-spacing - 1.2em)
#fails(() => signature(), "signature: takes one member of the board or more")
#fails(() => signature(nome: [Fulano]), "signature: takes one member of the board or more")
#fails(() => signature((name: [Fulano], title: [Dr.], cargo: [x])), "signature: unknown field \"cargo\"")
#fails(() => signature((name: [Fulano], title: [Dr.])), "missing institution")
#fails(() => signature((title: [Dr.], institution: [U])), "missing name")

// --- the subfigures ---------------------------------------------------------------------------------------------------
// the parts with their labels or without them, what goes under the set last; a part that is not a figure (a cell of
// the grid) and one as wide as its column, which has no width of its own
#let set-of = subfigures(figure(rect(height: 1cm), caption: [A primeira]), <parte-a>,
  figure(rect(width: 100%, height: 2cm), caption: [A segunda]), grid.cell(colspan: 2, align(center)[entre as partes]),
  figure(rect(), caption: [A terceira]), source[IBGE.], caption: [O conjunto], label: <conjunto>,
  columns: (4cm, 4cm))
#assert.eq(set-of.func(), (context none).func())
#set-of
#subfigures(figure(rect(), caption: [Uma]), figure(rect(), caption: [Outra]), caption: [Sem rótulos])
// the set and its parts are figures, the parts counted apart; the label of a part is the one the author gave
#context {
  let figures = query(figure.where(kind: image))
  assert.eq(figures.filter(f => f.outlined).len(), 2)
  assert.eq(figures.filter(f => not f.outlined).len(), 5)
  assert.eq(query(<conjunto>).len(), 1)
  assert.eq(text-of(query(<parte-a>).first().caption.body), "A primeira")
}

// the page of a part and the one of a figure lying down are content, which the cases of tests/style show
#assert.eq(type(sideways[corpo]), content)
#assert.eq(type(part[Título]), content)
