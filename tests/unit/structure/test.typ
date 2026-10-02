/// Synopsis: As páginas da estrutura (src/structure.typ): as medidas, a ordem alfabética, a numeração dos apêndices e as recusas
#import "../common.typ": *
#import "../../../src/structure.typ": *
#import "../../../src/fonts.typ": elements
#import "../../../src/info.typ": config-info

#set text(lang: "pt")

// --- a person without the academic title ------------------------------------------------------------------------------
#let named(name) = (name: name, surname: none, gender: "m", label: none)
#assert.eq(untitled(named("Prof. Dr. Nome do Orientador")).name, "Nome do Orientador")
#assert.eq(untitled(named("Profa. Dra.  Nome da Orientadora")).name, "Nome da Orientadora")
#assert.eq(untitled(named("Nome do Orientador")).name, "Nome do Orientador")
// a name that is only a title stays; content is left as it is
#assert.eq(untitled(named("Dr.")).name, "Dr.")
#assert.eq(untitled(named([Prof. Dr. Nome])).name, [Prof. Dr. Nome])
#assert.eq(untitled((name: "Dr. Nome", surname: "Sobrenome", gender: "f", label: none)),
  (name: "Nome", surname: "Sobrenome", gender: "f", label: none))

// --- the measures of the pages ----------------------------------------------------------------------------------------
// a distance of these pages, given in pt of a body of 12 pt, in em of the body
#assert.eq(pt12(12), 1em)
#assert.eq(pt12(6), 0.5em)
#assert.eq(steps, (body: pt12(17.93), large: pt12(22.25), single: pt12(14.45)))
// the size of a style as a multiple of the body
#assert.eq(scale-of("body"), 1)
#assert.eq(scale-of("cover-title"), 20.74 / 12)

// text in a style: its type, and its lines 1.5 of its size apart, or the step given
#let t = styled("cover-title", [Título])
#assert.eq(text-of(t), "Título")
#let r = row(2em, "cover-title", [Título])
#assert.eq(r.children.first(), v(2em - scale-of("cover-title") * 1em))
#assert.eq(r.children.last().func(), block)

// the place and the year, a paragraph each; the year alone without a place
#assert.eq(text-of(place-year(config-info(location: "Rio Branco", year: 2026, volume: 2), "cover-place", 1.5em)),
  "Rio Branco2026, v. 2")
#assert.eq(text-of(place-year(config-info(year: 2026), "cover-place", 1.5em)), "2026")

// the nature of the work, with the area of concentration in a paragraph of its own
#let n = nature-of([Tese apresentada.], config-info(year: 2026))
#assert.eq((n.func(), n.alignment, n.body.width), (align, right, 50%))
#context assert.eq(text-of(nature-of([Tese.], config-info(area: [Sistemas], year: 2026))),
  "Tese.Área de concentração: Sistemas")

// --- the alphabetical order (NBR 6033) --------------------------------------------------------------------------------
#assert.eq(accents.len(), 46)
#assert.eq(folded("Órgão"), "orgao")
#assert.eq(folded("AÇÃO"), "acao")
#assert.eq(folded([Índice]), "indice")
#assert.eq(folded("abc 123"), "abc 123")
// what is not text by what it is written as
#assert.eq(folded($x$), lower(repr($x$)))
#assert.eq(folded(""), "")

// --- the appendices ---------------------------------------------------------------------------------------------------
// a section of an appendix by the letter and its numbers; the appendix itself by the word and the letter
#assert.eq(appendix-numbering("appendix")(1, 2), "A.2")
#assert.eq(appendix-numbering("annex")(2, 1, 3), "B.1.3")
// (the word comes from the language of the text where the numbering is applied, so the appendix is numbered inside
// a context; its text, and not content that reads the language later, so that the bookmark of the PDF has it)
#context assert.eq(text-of(appendix-numbering("appendix")(2)), "APÊNDICE\u{a0}\u{a0}B\u{a0}\u{a0}—\u{a0}")
#context assert.eq(text-of(appendix-numbering("annex")(1)), "ANEXO\u{a0}\u{a0}A\u{a0}\u{a0}—\u{a0}")
#fails(() => appendix([corpo], divider: 1), "appendix: divider is true or false")
#fails(() => annex([corpo], divider: "não"), "annex: divider is true or false")

// --- the refusals of the pages ----------------------------------------------------------------------------------------
#fails(() => cover(middle-height: 3), "cover: middle-height is a ratio or a length")
#fails(() => cover(middle-height: auto), "cover: middle-height is a ratio or a length")
#fails(() => title-page([Tese.], middle-height: "85%"), "title-page: middle-height is a ratio or a length")
#fails(() => approval-page(membro: [x]), "approval-page: takes the members of the board")
#fails(() => approval-page(middle-height: 2), "approval-page: middle-height is auto, or a ratio or a length")
#fails(() => approval-page(draft: "sim"), "approval-page: draft is true or false")
#fails(() => catalog-card(draft: 1), "catalog-card: draft is auto, true or false")
// the height of the middle as a ratio, a length or both
#assert.eq(cover(middle-height: 12cm).func(), cover().func())
#assert.eq(cover(middle-height: 50% - 1cm).func(), cover().func())

// --- the lists --------------------------------------------------------------------------------------------------------
#fails(() => list-of(raw), "list-of: a list of another kind takes its title: list-of(raw, title: [...])")
#fails(() => list-of(figure.where(kind: "mapa")), "list-of: a list of another kind takes its title")
#fails(() => list-of-acronyms(("ABNT", [Associação]), (key: "nbr", short: "NBR", long: [Norma])),
  "list-of-acronyms: the entries are all pairs")
#fails(() => list-of-symbols(("a", [b], [c])), "list-of-symbols: the entries are all pairs")
#fails(() => list-of-acronyms("ABNT"), "list-of-acronyms: the entries are all pairs")
#fails(() => glossary(("Typst", [sistema]), (key: "abnt", short: "ABNT")), "glossary: the entries are all pairs")
#fails(() => glossary("Typst"), "glossary: the entries are all pairs")
