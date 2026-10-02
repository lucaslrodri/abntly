// Every chapter the other cases set, one after the other, to see whether the layout overflows when the size of the
// body changes: the typography and the spacing, the elements of the text (the table of the IBGE, the long table over
// two pages, the algorithms, the subfigures, the part, the figures lying down), the references, the stamp and the
// signatures, and the pages (pre-textual, two chapters, references). The cases every-case-12pt, every-case-11pt and
// every-case-11pt-two-sided set it with each body and side; in each, no letter or rule may be out of the text block,
// no line below it and no line on top of another. Each `include` keeps its `set` rules to itself. Not here: the
// equations numbered through the work (style/elements/global-equations), an option of the numbering, whose labels are
// those of the extras.
#include "body.typ"
#include "../spacing/body.typ"
#include "../elements/body.typ"
#include "../elements/long-table.typ"
#include "../elements/extras.typ"
#include "../references/body.typ"
#include "../elements/stamp-signature.typ"
#include "../layout/body.typ"
