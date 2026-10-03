#import "@preview/abntly:0.1.0": *

// a simple bar chart, drawn with the shapes of Typst, for the figures of the example
#let bars(..values) = box(height: 3cm, stack(dir: ltr, spacing: 6mm, ..values.pos().map(v => align(bottom,
  rect(width: 1cm, height: v * 1mm, fill: luma(150))))))

= Elements of the text <ch-elements>

This chapter shows how the elements of the text are written and how the package presents them. The rules of each
element are in section 5 of @nbr 14724:2024 and in the standards it cites.

== Sections

The sections are numbered progressively, down to the fifth level. The title of a primary section starts on a new
page, and the levels are set apart by the size of the type.

=== Tertiary section

Text of a tertiary section.

==== Quaternary section

Text of a quaternary section.

===== Quinary section

Text of a quinary section.

== Lists

The subjects that have no title of their own are divided into lettered items (alíneas):
+ the text before the items ends with a colon;
+ each item starts with a lower-case letter and ends with a semicolon:
  - the sub-items start with a dash;
  - the item before the sub-items ends with a colon;
+ the last item ends with a period.

== Citations

The citations follow the author-date system. A work can be cited between parentheses @luck2010 or in the sentence,
as in #cite(<oliveira1943>, form: "prose"). In direct quotations, the call includes the page @luck2010[p. 12]. A
work with three authors is cited with every surname @cruz1998; with four or more, by the first author, followed by
"et al." @maciel2019. Two works can be cited in one call @santos1994 @romano1996. Entities are cited by their name
@abnt2024, and works without an author, by the first word of the title @anteprojeto1987[p. 55].

A direct quotation of up to three lines stays in the text, "between double quotation marks" @author2026[p. 10]. A
direct quotation of more than three lines is set apart:

#quote(block: true)[
  Text of a direct quotation of more than three lines. The quotation is set apart from the paragraph, indented
  4 cm from the left margin, in a size smaller than that of the text, in single spacing and without quotation
  marks @author2026[p. 11].
]

The other works in the list of references show other kinds of document: a thesis @aguiar2009, a dissertation in
electronic form @coelho2009, a journal article @delucca2009, a newspaper article @verissimo2010 and a paper
presented at an event @brayner1994.

== Footnotes

The footnotes are numbered through each chapter.#footnote[Text of a short footnote.] In a note of more than one
line, the following lines are aligned under the first letter of the text.#footnote[Text of a longer footnote, with
  enough words to take more than one line and to show how the text of the note is aligned in relation to its
  number.]

== Illustrations

Every illustration has its title above it and its source under it. #auto-ref(<fig-defenses>) shows a figure with
a source, a legend and a note.

#figure(caption: [Works defended per year])[
  #bars(12, 18, 15, 24, 28)
  #source()
  #legend[Bars: number of works defended in each year, from 2021 to 2025.]
  #note[Fictitious data, used only in this example.]
] <fig-defenses>

With the function `fitted`, the title and the source stay within the width of the illustration, as in
#auto-ref(<fig-fitted>).

#fitted(label: <fig-fitted>, caption: [Works defended per year, with the title limited to the width of the
  illustration])[
  #bars(12, 18, 15, 24, 28)
  #source()
]

A frame (quadro) presents textual information, as #auto-ref(<frm-kinds>) does.

#frame(caption: [Kinds of academic work])[
  #table(columns: 2,
    [*Kind*], [*Degree*],
    [Final course work], [Undergraduate],
    [Dissertation], [Master's],
    [Thesis], [Doctorate])
  #source()
] <frm-kinds>

Subfigures gather several parts in one figure: Figure @sub-a and Figure @sub-b are parts of
#auto-ref(<fig-parts>).

#subfigures(
  figure(bars(12, 18, 15), caption: [First three years]), <sub-a>,
  figure(bars(24, 28, 30), caption: [Last three years]), <sub-b>,
  caption: [Works defended in two periods],
  label: <fig-parts>,
)[
  #source()
]

== Tables

The tables follow the tabular presentation standards of the @ibge. #auto-ref(<tab-defenses>) has a general note
and a specific note.

#fitted(label: <tab-defenses>, caption: [Works defended, by kind -- University of Brazil -- 2024-2025])[
  #table(columns: (5cm, 2.5cm, 2.5cm), align: (left, right, right),
    table.header([Kind], [2024], [2025]),
    [Final course works], [212], [230],
    [Dissertations], [86], [94],
    [Theses #call(1)], [34], [41])
  #source()
  #note[Fictitious data, used only in this example.]
  #note(call: 1)[Includes the theses defended under joint supervision.]
]

A table in a plain `figure` takes the same rules with `ibge-table`; the title and the source keep the width of the
text block, and the figure may float, as #auto-ref(<tab-grants>) does.

#figure(placement: auto, caption: [Grants awarded, by level -- University of Brazil -- 2025])[
  #ibge-table(columns: (5cm, 2.5cm), align: (left, right),
    table.header([Level], [Grants]),
    [Master's], [120],
    [Doctorate], [85])
  #source()
] <tab-grants>

== Equations

The arithmetic mean of $n$ values is given by @eq-mean:
$ overline(x) = 1 / n sum_(i = 1)^n x_i $ <eq-mean>
An equation without a label is not numbered:
$ sigma^2 = 1 / n sum_(i = 1)^n (x_i - overline(x))^2 $
In an equation of several lines, only the line with a label takes a number, as @eq-square:
$ (a + b)^2 &= (a + b)(a + b) \
            &= a^2 + 2 a b + b^2 #<eq-square> $
The text that goes on after an equation, past a blank line, starts without the indent of its first line, with
`no-indent`:
$ s = sqrt(sigma^2) $

#no-indent[where $s$ is the standard deviation.]

== Algorithms

An algorithm is an illustration of code, with a title and a source, as #auto-ref(<alg-mean>).

#algorithm(caption: [Mean of a list of numbers])[
  ```python
  def mean(values):
      total = 0
      for v in values:
          total = total + v
      return total / len(values)
  ```
  #source()
] <alg-mean>

== Cross-references

A cross-reference can be written in three ways. The plain one gives only the number, as in "figure
@fig-defenses". The one with the word gives the name and the number, as in "@tab-defenses[Table]". The function
`auto-ref` finds the name of the element: #auto-ref(<fig-defenses>), #auto-ref(<frm-kinds>),
#auto-ref(<tab-defenses>), #auto-ref(<ch-elements>) and #auto-ref(<eq-mean>). It also gives the page of the
element: #auto-ref(<fig-defenses>) is on #auto-ref(<fig-defenses>, form: "page").
