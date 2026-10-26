// The works of missing.yml, without place, publisher or date, each set by the package after a text marker,
// `QQ<key>QQ`, as in corpus.typ; then a call in the author-date system of the work without a date, "(Dias, [s. d.])",
// and the list at the end. No justification and no hyphenation, so that each reference reads as the entry gives it.
#set par(justify: false)
#set text(hyphenate: false)

#let works = "missing.yml"
#let keys = read(works).matches(regex("(?m)^([a-z-]+):$")).map(m => m.captures.first())

#for key in keys {
  par([#("QQ" + key + "QQ") #cite(label(key), form: "full")])
}
#par[#"QQchamadaQQ" A obra sem data numa chamada: @sem-data.]

#bibliography(works)
