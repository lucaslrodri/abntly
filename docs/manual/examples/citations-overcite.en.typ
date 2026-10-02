#import "/src/lib.typ": *
// --- example ---
#show: abntly.with(lang: "en", citation-system: "overcite")

= Introduction

School management is the subject of one of the works cited @luck2010[p. 12]. The work of
#cite(<oliveira1943>, form: "prose") deals with the geology of Brazil. Two works can be
cited in a single call @cruz1998 @maciel2019.

#bibliography("refs.bib")
