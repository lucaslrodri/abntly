#import "/src/lib.typ": *
// --- example ---
#show: trabalho-academico.with(sistema-de-citacao: "overcite")

= Introdução

A gestão escolar é o tema de uma das obras citadas @luck2010[p. 12]. A obra de
#cite(<oliveira1943>, form: "prose") trata da geologia do Brasil. Duas obras podem ser
citadas em uma só chamada @cruz1998 @maciel2019.

#bibliography("refs.bib")
