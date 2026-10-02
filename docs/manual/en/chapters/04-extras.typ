#import "../prelude.typ": *
#show: chapter.with(title: [Elements beyond the standard], id: <extras>)

This chapter describes the elements that the ABNT standards do not define, but that are common in academic works:
algorithms, subfigures, parts, sideways figures and stamps. The algorithm and the subfigures are illustrations and
follow the rules of @figures[Section]. For the others, the presentation is a decision of the package
#pill("decision").

== Algorithms <algorithms>

#norm-box("NBR 14724:2024, 5.8", "decision")[
  The standard does not deal with algorithms, but the list of designative words of the illustrations is open. Like
  any illustration, the algorithm has the designative word, the number, the dash and the title above it, and the
  source below it.
]

The function `algorithm` creates an illustration of code or of pseudocode, with the word "Algorithm" and its own
numbering. It takes the same arguments as `figure`. The code is written in a Typst code block, and the source is
given with `source`, as in the example below. A long algorithm continues on the next page.

````example
#algorithm(caption: [Mean of a list of numbers])[
  ```python
  def mean(values):
      total = 0
      for v in values:
          total = total + v
      return total / len(values)
  ```
  #source()
]
````

To create the list of algorithms, use `list-of(raw, title: [List of Algorithms])` (@lists[Section]).

#reference("algorithm")

== Subfigures <subfigures>

#norm-box("NBR 14724:2024, 5.8", "decision")[
  The standard does not deal with figures made of parts. The set follows the rules of the illustrations: the title
  above and the source, the legend and the notes below.
]

The function `subfigures` creates a figure made of parts. Each part is a `figure`, followed by its label. The title
of the set goes above it, and the title of each part, below the part, preceded by a letter. The source of the set
is given after the parts. The cross-reference to a part gives the number of the set and the letter, as in
the example below. The function cannot be used inside `fitted`.

```example
#subfigures(
  figure(rect(width: 5cm, height: 2.5cm, fill: luma(200)),
    caption: [North Region]), <sub-north>,
  figure(rect(width: 5cm, height: 2.5cm, fill: luma(200)),
    caption: [South Region]), <sub-south>,
  caption: [Works defended in two regions],
  label: <sub-regions>,
)[
  #source[IBGE (2025).]
]

Figure @sub-regions compares the North Region (Figure
@sub-north) with the South Region (Figure @sub-south).
```

#reference("subfigures")

== Parts <parts>

The function `part` creates the opening page of a part, a division of the text above the primary sections. The
page has neither a header nor a number and shows the word "Part", the number in Roman numerals and the title. The
primary section that follows starts on a new page, and the numbering of the sections continues from one part to the
next, as in the example below.

#page-example("part", pages: (1, 2))

#reference("part")

== Sideways figures and tables <sideways>

The function `sideways` turns a figure or a table by 90°, on a page of its own. It is meant for content wider than
the text block. The page stays upright, with the same margins and the same header, and the text continues on the
next page, as in the example below.

#page-example("sideways", pages: (2,))

#reference("sideways")

== Stamps <stamps>

The function `stamp` creates a watermark for the background of the page, such as "DRAFT". It is used in the
`background` parameter of the page: with `#set page(background: ...)`, the stamp appears on all the following
pages, as in the example below.

#page-example("stamp")

The catalog card and the approval sheet have stamps of their own, controlled by the `draft` parameter
(@catalog-card[Section] and @approval-page[Section]).

#reference("stamp")
