#import "/src/lib.typ": *
#import "common/en.typ": setup
#show: setup
= Introduction

#lorem(900)

// --- example ---
#index(
  (term: "Aeronautics", pages: (1, "2-3")),
  (term: "Aviation", see: "Aeronautics"),
  (term: "Scabies", pages: 2, sub: (
    (term: "diagnosis", pages: 2),
    (term: "treatment", pages: "2-3"),
  )),
  (term: "Holidays", pages: (1, 3), see-also: "Leave"),
  ("Leave", 3),
)
