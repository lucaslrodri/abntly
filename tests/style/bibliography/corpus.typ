// The 43 examples of section 7 of NBR 6023:2025, one per item that has an EXEMPLO of its own (norma-6023-2025.bib,
// written in the fields of hayagriva as the recipe of each example), each set by the package after a text marker,
// `QQ<key>QQ`, which says in the text of the page which entry the reference after it is, so that it can be read
// beside the example of the norm. The marker is a string: a label would vanish from the text. No justification and no
// hyphenation, so that each reference reads as the entry gives it; the list at the end is the same entries, as a work
// shows them.
#set par(justify: false)
#set text(hyphenate: false)

#let corpus = "norma-6023-2025.bib"
#let keys = read(corpus).matches(regex("(?m)^@[a-z]+[{]([^,\\s]+),")).map(m => m.captures.first())

#for key in keys {
  par([#("QQ" + key + "QQ") #cite(label(key), form: "full")])
}
#par[#"QQENDQQ"]

#bibliography(corpus)
