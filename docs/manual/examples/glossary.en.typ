#import "/src/lib.typ": *
#import "common/en.typ": setup
#show: setup
// --- example ---
= Introduction

The document was typeset in @typst, and the text stays inside the @text-block.

#glossary(
  (key: "typst", short: "Typst",
    description: [markup-based typesetting system]),
  (key: "text-block", short: "text block",
    description: [area of the page bounded by the margins, where the text is printed]),
)
