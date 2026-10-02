/// Synopsis: Todas as páginas da estrutura juntas, no corpo de 11 pt, em frente e verso: o layout não estoura
// As every-case-11pt, on both sides of the leaf: the margins mirrored on the verso. No letter or rule may be out of
// the text block, no line below it, no line on top of another.
#import "../../../common.typ": *
#import "../info.typ": info
#show: setup.with(info: info, two-sided: true)
#set text(size: 11pt)
#include "../every-case.typ"
