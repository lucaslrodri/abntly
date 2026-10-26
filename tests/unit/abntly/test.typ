/// Synopsis: A função principal (src/abntly.typ) e o que o pacote exporta (src/lib.typ): os argumentos e as recusas
#import "../common.typ": *
#import "../../../src/lib.typ" as package
#import "../../../src/lib.typ": abntly, config-info, config-names, config-hyperlinks, dark-indigo
#import "../../../src/layout.typ": link-kinds, link-colours
#import "../../../src/spacing.typ": in-size, heading-block, heading-before, heading-after, line-spacing, scale
#import "../../../src/fonts.typ": elements, sizes, correction, script-size, families

// --- what the package exports -----------------------------------------------------------------------------------------
// 46 names in English and 46 in Portuguese; every name is a function, but the colour of the links
#let exported = dictionary(package)
#assert.eq(exported.len(), 46 + 46)
#for (name, value) in exported {
  if name in ("dark-indigo", "indigo-escuro") { assert.eq(type(value), color, message: name) } else {
    assert.eq(type(value), function, message: name)
  }
}
#assert.eq(package.indigo-escuro, dark-indigo)
#assert.eq(dark-indigo.to-hex(), "#372aac")

// --- the refusals of the main function --------------------------------------------------------------------------------
#fails(() => abntly(lang: "es")[corpo], "abntly: lang must be \"pt\" or \"en\"")
#fails(() => abntly(two-sided: "sim")[corpo], "abntly: two-sided must be true or false")
#fails(() => abntly(hyperlink: "blue")[corpo], "abntly: hyperlink must be a colour")
#fails(() => abntly(hyperlink: (glossary: "preto"))[corpo], "config-hyperlinks: glossary must be a colour or none")

// --- the colour of each kind of link ----------------------------------------------------------------------------------
// `config-hyperlinks` takes only the kinds, each a colour or `none`, and `others`, the colour of the kinds left out
// (dark-indigo, unless given); one colour, or `none`, is the same for every kind
#assert.eq(config-hyperlinks(glossary: black, address: none), (glossary: black, address: none, others: dark-indigo))
#fails(() => config-hyperlinks(black), "config-hyperlinks: takes only the colours of the kinds of link, by key")
#fails(() => config-hyperlinks(acronym: black), "config-hyperlinks: unknown kind of link \"acronym\"; the kinds are")
#fails(() => config-hyperlinks(glossary: "black"), "config-hyperlinks: glossary must be a colour or none")
#fails(() => config-hyperlinks(others: "none"), "config-hyperlinks: others must be a colour or none")
#assert.eq(link-colours(black), link-kinds.map(kind => (kind, black)).to-dict())
#assert.eq(link-colours(none).values().dedup(), (none,))
#let mixed = link-colours(config-hyperlinks(glossary: black, address: none))
#assert.eq((mixed.glossary, mixed.address, mixed.reference, mixed.index), (black, none, dark-indigo, dark-indigo))
#let others = link-colours(config-hyperlinks(glossary: black, others: none))
#assert.eq((others.glossary, others.address, others.outline), (black, none, none))
// a dictionary written by hand, without `others`: the kinds left out in dark-indigo
#assert.eq(link-colours((glossary: black)).reference, dark-indigo)
#fails(() => abntly(table-font-size: 10pt)[corpo], "abntly: table-font-size must be a length in em of the body")
#fails(() => abntly(table-font-size: 1em + 2pt)[corpo], "abntly: table-font-size must be a length in em of the body")
#fails(() => abntly(table-font-size: 0em)[corpo], "abntly: table-font-size must be a length in em of the body")
#fails(() => abntly(table-font-size: "10pt")[corpo], "abntly: table-font-size must be a length in em of the body")
#fails(() => abntly(equation-numbering: 1)[corpo], "abntly: equation-numbering must be a pattern")
#fails(() => abntly(equation-number-mode: "all")[corpo], "abntly: equation-number-mode must be \"label\" or \"line\"")
#fails(() => abntly(citation-system: "apa")[corpo], "abntly: citation-system must be \"alf\", \"num\"")
#fails(() => abntly(info: none)[corpo], "abntly: info comes from config-info(...)")
#fails(() => abntly(info: (titulo: [T]))[corpo], "config-info: unknown field \"titulo\"")
#fails(() => abntly(names: (capitulo: "Unidad"))[corpo], "config-names: unknown word \"capitulo\"")
// what it takes
#assert.eq(type(abntly(info: config-info(title: [T]), lang: "en", names: config-names(chapter: "Unit"),
  two-sided: true, hyperlink: none, table-font-size: 1em, equation-numbering: "(1a)", equation-number-mode: "line",
  citation-system: "ieee")[corpo]), content)

// --- the scale of the sizes (src/fonts.typ) ---------------------------------------------------------------------------
// all of it in em of the body, the body itself 1 em
#assert(sizes.values().all(s => s.abs == 0pt))
#assert.eq(sizes.base, 1em)
#assert(elements.values().all(e => "font" in e and e.size.abs == 0pt))
#assert.eq(elements.chapter.size, sizes.xxxl * correction.sans-17)
#assert.eq(script-size, (body: 8em / 12, footnote: 7em / 10))
#assert.eq(families.serif, "New Computer Modern")

// --- the distances (src/spacing.typ) ----------------------------------------------------------------------------------
// a distance of the body in the em of an element `s` times the body
#assert.eq(in-size(1.5em, 2), 0.75em)
#assert.eq(in-size(1em + 6pt, 2), 0.5em + 6pt)
// the block of each level of heading: nothing above a chapter, which opens the page
#assert.eq(heading-block(1).above, 0pt)
#for n in (2, 3, 4, 5) {
  let s = scale.heading.at(n - 1)
  assert.eq(heading-block(n).above, in-size(heading-before.at(n - 1), s) + line-spacing - 1em)
  assert.eq(heading-block(n).below, in-size(heading-after.at(n - 1) + line-spacing - 1em, s))
}
