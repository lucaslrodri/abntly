/// Synopsis: Todos os capítulos dos casos juntos, no corpo de 11 pt: o layout não estoura
// The size of the body set by the author, `#set text(size: 11pt)` after `#show: abntly`; every other size follows it,
// in `em`. No letter or rule may be out of the text block, no line below it, no line on top of another.
#import "../../../common.typ": *
#show: setup
#set text(size: 11pt)
#include "../every-case.typ"
