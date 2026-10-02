#import "/src/lib.typ": *
#import "common/pt.typ": setup
#show: setup
// --- example ---
= Introdução

O documento foi composto em @typst, e o texto fica dentro da @mancha.

#glossario(
  (key: "typst", short: "Typst",
    description: [sistema de composição tipográfica por marcação]),
  (key: "mancha", short: "mancha gráfica",
    description: [área da página delimitada pelas margens, onde o texto é impresso]),
)
