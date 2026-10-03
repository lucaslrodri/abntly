/// Synopsis: Os espaçamentos (src/spacing.typ): o parágrafo sem o recuo da primeira linha
#import "../common.typ": *
#import "../../../src/spacing.typ": no-indent, indent

// --- the paragraph without the indent of its first line ---------------------------------------------------------------
// a `par` whose first line has no indent, whatever the indent of the text (`indent`, which `spacing` sets)
#let p = no-indent[em que a entrada varia.]
#assert.eq(p.func(), par)
#assert.eq(p.first-line-indent, (amount: 0pt))
#assert.eq(text-of(p.body), "em que a entrada varia.")
#assert.eq(indent, 1.3cm)
