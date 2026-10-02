/// Subject: Citação de citação
// The citation of a citation (`apud`, NBR 10520:2023, 7.3): between parentheses and in the sentence, with the pages
// and without them, and the list of references, which has only the sources consulted. The cases apud-alf, apud-num,
// apud-overcite and apud-ieee set it in each citation system: the source consulted comes by its names and its year
// in the author-date system, and by its number in the numeric ones.
#import "../../../src/lib.typ": apud

= Citação de citação

Entre parênteses: #apud([Cagliari], 1986, <luck2010>, page: [p. 104], supplement: [p. 55]). Sem páginas:
#apud([Assis], 1997, <luck2010>). Na frase:
#apud([Freire], 1994, <cruz1998>, page: [p. 13], supplement: [p. 25], form: "prose") e
#apud("Boss e Krauss", "2007", <luck2010>, form: "prose"). Fim.

#bibliography("refs.bib")
