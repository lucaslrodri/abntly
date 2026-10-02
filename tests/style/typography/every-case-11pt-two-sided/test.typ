/// Synopsis: Todos os capítulos dos casos juntos, no corpo de 11 pt, em frente e verso: o layout não estoura
// As every-case-11pt, on both sides of the leaf: the margins mirrored on the verso.
#import "../../../common.typ": *
#show: setup.with(two-sided: true)
#set text(size: 11pt)
#include "../every-case.typ"
