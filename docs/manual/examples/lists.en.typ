#import "/src/lib.typ": *
#import "common/en.typ": setup
#show: setup
// --- example ---
#list-of-figures()
#list-of-frames()
#list-of-tables()

= Introduction

#figure(caption: [Structure of the academic work], rect(width: 6cm, height: 2cm))

#frame(caption: [Types of academic work],
  table(columns: 2, [Thesis], [Doctorate], [Dissertation], [Master's]))

#fitted(caption: [Works defended per year])[
  #table(columns: (4cm, 3cm),
    table.header([Year], [Works]), [2024], [120], [2025], [135])
]
