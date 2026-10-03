#import "../prelude.typ": *
#show: chapter.with(title: [General presentation rules], id: <general-rules>)

Section 5 of ABNT NBR 14724:2024 defines the general presentation rules of the work: format, spacing, pagination,
numbering of the sections, citations, acronyms, equations, illustrations and tables. The main function applies
these rules to the whole document (@main-function[Section]). This chapter describes each rule, what the package
does and what is left for the author to write.

== Format and margins <format>

#norm-box("NBR 14724:2024, 5.1", "required", "implemented")[
  The text must be presented in black; other colours may be used only in the illustrations. If printed, the work
  must use white or recycled paper, in A4 format. The margins of the recto are 3 cm (left and top) and 2 cm (right
  and bottom); on the verso, 3 cm (right and top) and 2 cm (left and bottom). The pre-textual elements start on the
  recto of the sheet, except for the catalog card. It is recommended that the textual and post-textual elements be
  presented on the recto and on the verso of the sheets.
]

The main function sets the A4 format and the margins of the standard. By default, the work is formatted for reading
on screen or for printing on the recto only: every page has the margins of the recto.

With `two-sided: true`, the work is formatted for printing on both sides of the sheet. The margins of the verso are
mirrored, the primary sections and the pre-textual elements start on an odd page, and the page number goes on the
outer side. The following example shows an even page (verso) and an odd page (recto).

#page-example("two-sided", pages: (2, 3))

#remark[
  By default, the links (cross-references, citations, table of contents and addresses) are shown in the colour
  `dark-indigo`, which makes reading on screen easier. In the printed version, in which all the text must be black,
  use `hyperlink: black` in the main function.
]

== Font <font>

#norm-box("NBR 14724:2024, 5.1", "recommended", "implemented")[
  Font size 12 is recommended for the whole text, including the cover. The citations of more than three lines, the
  footnotes, the page numbers, the catalog card and the sources and legends of the illustrations and of the tables
  must have a smaller and uniform size.
]

The text is set in size 12. The elements that the standard says to reduce are set in size 10. The text of the
tables also uses size 10, which can be changed in the `table-font-size` parameter of the main function.

All the sizes are proportional to the size of the text. To change it, use a `set` rule after the call of the main
function, as in `#set text(size: 11pt)`.

#remark[
  The standard does not define the typeface. The package uses New Computer Modern, with serifs in the text and
  without serifs in the headings #pill("decision"). On the cover, on the title page and on the approval sheet, the
  title and the other elements use sizes larger than 12 #pill("decision").
]

== Spacing <spacing>

#norm-box("NBR 14724:2024, 5.2", "required", "implemented")[
  All the text must be typed with a spacing of 1.5 between the lines. The following are typed in single spacing:
  the citations of more than three lines, the footnotes, the references, the titles of the illustrations and of the
  tables, the sources and the legends, and the nature of the work. The references are separated from each other by
  one blank single space.
]

The package applies the spacing of 1.5 to the text and single spacing to the elements listed by the standard. No
setting is needed.

#remark[
  The standard defines neither the indent nor the space between paragraphs. The package uses an indent of 1.3 cm on
  the first line and adds 0.2 cm between paragraphs #pill("decision"). To change them, use a `set par` rule after
  the call of the main function.
]

The paragraph that goes on after a displayed equation, a long quote or a list belongs to the one before it and
starts without the indent: write it with `no-indent`.

```example
The power is given by
$ P = V I $

#no-indent[where $V$ is the voltage and $I$ the current.]
```

#reference("no-indent")

== Pagination <pagination>

#norm-box("NBR 14724:2024, 5.3", "required", "implemented")[
  The pre-textual pages are counted from the title page on, but are not numbered. The numbering appears from the
  first page of the textual part on, in Arabic numerals, in the top right corner, 2 cm from the top edge, with the
  last digit 2 cm from the right edge. In two-sided works, the number goes in the top right corner of the recto and
  in the top left corner of the verso. The pages of the appendices and of the annexes continue the numbering of the
  text.
]

The package counts the pages from the title page on and shows the number from the first numbered primary section
on, in the position defined by the standard. The cover is not counted. The following example shows the top of two
pages of the two-sided work of @format[Section].

#page-example("two-sided", pages: (2, 3), crop: (0, 0.13))

#remark[
  Beside the number, the package shows a running header with the title of the primary section, in italics, over a
  rule. In a two-sided work, the odd page shows the title of the secondary section. The page that opens a primary
  section shows only the number. The standard does not provide for this header #pill("decision").
]

The running header identifies the primary section by the word "Chapter". Since the standard organises the work in
sections, and not in chapters, the word can be replaced in the `names` parameter of the main function:

```typ
#show: abntly.with(
  lang: "en",
  names: config-names(chapter: "Section"),
)
```

== Sections <sections>

#norm-box("NBR 14724:2024, 5.2.2, 5.2.3 and 5.4; NBR 6024:2012, 4.1", "required", "implemented")[
  The number of a section, in Arabic numerals, comes before the title, aligned to the left and separated by one
  space, without a period, a hyphen or another sign. The progressive numbering goes down to the quinary section.
  The titles of the primary sections start on a new page (on an odd page, in two-sided works). In a title of more
  than one line, the following lines are aligned under the first letter of the title. The titles are emphasised
  typographically, in a hierarchy, in the text and in the table of contents. The titles without a section number,
  such as those of the errata, the abstracts, the lists, the table of contents and the references, are centred.
]

The sections are written with Typst headings, from `=` (primary section) to `=====` (quinary section). The package
numbers the headings, opens a new page at each primary section and distinguishes the levels by the font size, as in
the example below.

#page-example("headings", crop: (0, 0.62))

For a heading without a section number, use `#heading(numbering: none)[Title]`. A primary heading without a number
is centred.

#remark[
  The standard asks that the titles be separated from the text by one space of 1.5 between the lines. The package
  uses distances of its own, larger before the title than after it, to tie the title to the text that follows it
  #pill("decision").
]

== Items and subitems <items>

#norm-box("NBR 6024:2012, 4.2 and 4.3", "required", "implemented")[
  The subjects of a section that have no title of their own are subdivided into items. The text that comes before
  the items ends with a colon. Each item is marked by a lowercase letter followed by a parenthesis, indented from
  the left margin. The text of the item starts with a lowercase letter and ends with a semicolon; the last one ends
  with a period. The following lines of the text start under the first letter of the text of the item. The subitems
  start with a dash followed by a space, indented from the item, and the text of the item that comes before them
  ends with a colon.
]

The items are written with Typst's numbered list (`+`), and the subitems, with a list (`-`) inside an item. The
package creates the letters, the dashes and the indents. The punctuation of the text is written by the author, as
in the example below.

```example
The package sets up automatically:
+ the page format and the margins;
+ the elements of the text:
  - the illustrations and the tables;
  - the equations;
+ the citations and the list of references.
```

== Direct citations <quotes>

#norm-box("NBR 14724:2024, 5.5; NBR 10520:2023, 7.1", "required", "implemented")[
  Direct citations of up to three lines stay in the text, between double quotation marks. Direct citations of more
  than three lines are set off with a standard indent from the left margin (4 cm is recommended), in a smaller font
  than that of the text, in single spacing and without quotation marks.
]

A short direct citation is written in the paragraph itself, between quotation marks. A direct citation of more
than three lines is written with Typst's `quote` function, with `block: true`. The package applies the indent of
4 cm, size 10 and single spacing, as in the example below. The indication of the source is described in
@references[Chapter].

```example
The paragraph before the citation ends with a colon:

#quote(block: true)[
  Text of a direct citation of more than three lines. The
  citation is set off from the paragraph, with an indent of
  4 cm from the left margin, in a smaller size than that of
  the text, in single spacing and without quotation marks
  @autor2026[p. 10].
]
```

== Footnotes <footnotes>

#norm-box("NBR 14724:2024, 5.2.1; NBR 10520:2023, 8", "required", "implemented")[
  The footnotes stay within the margins, separated from the text by a single space and by a rule of 5 cm, starting
  at the left margin. They are typed in single spacing and in a smaller font. From the second line on, the text of
  the note is aligned under the first letter of the first word, so as to set off the superscript. The notes are
  marked by sequential Arabic numerals; it is recommended to restart the numbering at each chapter or part, and not
  at each page.
]

The notes are written with Typst's `footnote` function. The package sets the rule, the size, the spacing and the
alignment of the notes, and restarts the numbering at each primary section. The following example shows the
lower part of a page with two notes.

#page-example("footnote", crop: (0.68, 1))

#remark[
  NBR 10520:2023 (section 6.2.2) does not allow the numeric citation system in a work with notes. If the work has
  footnotes, use the author-date system (@citation-systems[Section]).
]

== Illustrations <figures>

#norm-box("NBR 14724:2024, 5.8", "required", "implemented")[
  Any illustration is preceded by its designative word (figure, chart, map, frame (quadro), photograph, among
  others), followed by its order number in the text, in Arabic numerals, a dash and the title. Right after the
  illustration come the source consulted, the legend, the notes and other necessary information. An illustration
  produced by the author also gives this information in the source. The illustration is cited in the text and
  inserted as close as possible to the passage it refers to. The title, the source, the legend and the notes stay
  within the margins of the illustration.
]

The illustrations are written with Typst's `figure` function. The package places the title above the illustration,
with the designative word, the number and the dash. The source, the legend and the notes are written inside the
figure, after the illustration, with the functions `source`, `legend` and `note`, as in the example below.
Without an argument, `source` states that the illustration was prepared by the author.

```example
#figure(caption: [Works defended by region])[
  #rect(width: 8cm, height: 2.5cm, fill: luma(200))
  #source[IBGE (2025).]
  #legend[Bars: number of works.]
  #note[Data collected in 2024.]
]
```

The `figure` function centres the title and the source on the width of the text block. To keep the title, the
source, the legend and the notes within the width of the illustration, as the standard asks, use the function
`fitted`, which takes the same arguments. The following example shows a figure with a title wider than the
illustration.

```example
#fitted(caption: [Distribution of the academic works
  by region of the country, from 2020 to 2024])[
  #rect(width: 8cm, height: 2.5cm, fill: luma(200))
  #source()
]
```

The designative word of the figures is "Figure". For another type of illustration, such as a chart or a map, give
the `kind` and `supplement` parameters of the `figure` function. Each type has its own numbering and can have its
own list (@lists[Section]):

```typ
#figure(kind: "chart", supplement: [Chart], caption: [Works per year])[
  #image("chart.svg")
  #source()
]
```

=== Frames

A frame is an illustration with textual information, arranged in rows and columns. The function `frame` creates the
figure with the word "Frame" and its own numbering. A table inside the frame takes closed lines, and the text keeps
the size of the body, as in the example below.

```example
#frame(caption: [Types of academic work])[
  #table(columns: 2,
    [*Type*], [*Degree*],
    [Thesis], [Doctorate],
    [Dissertation], [Master's])
  #source()
]
```

#reference("source", "legend", "note", "frame", "fitted")

== Tables <tables>

#norm-box("NBR 14724:2024, 5.9; IBGE, Normas de apresentação tabular (1993)", "required", "implemented")[
  The tables are cited in the text, inserted as close as possible to the passage they refer to and standardised
  according to the tabular presentation standards of the IBGE. According to these standards, the border of the
  table has at least three horizontal rules (one separates the top, one separates the header and one separates the
  footer) and has no vertical rules closing it on the left and on the right. The footer contains the source, the
  general note and the specific notes, each preceded by its call. A table that goes beyond one page repeats the
  title and the header on each page, with the indications "continua" (continues), "continuação" (continuation) and
  "conclusão" (conclusion); the rule that closes the table and the footer appear only on the last page.
]

A table presents numerical data; for textual information, use a frame (quadro) (@figures[Section]). A table is
written with Typst's `table` function, with the header in `table.header`, inside the function `fitted`. The package
draws the horizontal rules, reduces the text to size 10 and keeps the title and the footer within the width of the
table. The author writes no rule.

The source and the notes are written after the table, with `source` and `note`. A specific note is written with
`note(call: 1)`, and the matching call is inserted in the cell with `call(1)`, as in the example below.

```example
#fitted(caption: [Production of silkworm cocoons,
  by Federation Unit -- Brazil -- 1974])[
  #table(columns: (4cm, 3cm, 3cm),
    align: (left, right, right),
    table.header([Federation Unit],
      [Production (t)], [Percentage (%)]),
    [Paraná], [4 210], [61.2],
    [São Paulo #call(1)], [2 670], [38.8])
  #source[IBGE (1975).]
  #note[Data subject to revision.]
  #note(call: 1)[Includes the production of the Ribeira Valley.]
]
```

A table that does not fit on one page continues on the next page, with the title, the header and the indications of
the IBGE. No setting is needed. The following example shows a table of 40 rows on two pages.

#page-example("long-table", pages: (1, 2))

Outside `fitted`, a table in a plain `figure` takes the same rules with `ibge-table`, written with the arguments of
`table`: the title, the source and the notes then keep the width of the text block, and the figure may float with
`placement`. A `figure` does not go on over pages.

```example
#figure(caption: [Production of silkworm cocoons,
  by Federation Unit -- Brazil -- 1974])[
  #ibge-table(columns: (4cm, 3cm, 3cm),
    align: (left, right, right),
    table.header([Federation Unit],
      [Production (t)], [Percentage (%)]),
    [Paraná], [4 210], [61.2],
    [São Paulo], [2 670], [38.8])
  #source[IBGE (1975).]
]
```

#remark[
  A table without `table.header`, or outside `fitted` and `ibge-table`, does not take the rules of the IBGE: it keeps
  the lines set by the author.
]

#reference("ibge-table", "call")

== Equations <equations>

#norm-box("NBR 14724:2024, 5.7", "recommended", "implemented")[
  To make reading easier, it is recommended that the equations and formulas be set off in the text and, if
  necessary, numbered with Arabic numerals in parentheses, aligned to the right. In the following mentions, only
  the number may be used. In the text, a larger line spacing may be used, to hold the elements of the equation
  (exponents, indices and others).
]

The equations are written with Typst's math syntax. A display equation is numbered only if it has a label; the
cross-reference to the label gives the number in parentheses. In an equation of several lines, each line can have
its own label, as in the example below.

```example
An equation without a label is not numbered:
$ E = m c^2 $
With a label, the equation takes a number:
$ F = m a $ <eq-newton>
With several lines, only the line with a label is numbered:
$ (a + b)^2 &= (a + b)(a + b) \
            &= a^2 + 2 a b + b^2 #<eq-square> $
Equations @eq-newton and @eq-square are cited by number.
```

Two parameters of the main function control the numbering:

- `equation-numbering` sets the format. The default, `"(1.1)"`, numbers the equations by primary section
  #pill("decision"); `"(1)"` numbers them throughout the work, as in the examples of the standard;
- `equation-number-mode` sets which equations are numbered. The default, `"label"`, numbers only the equations
  with a label; `"line"` numbers every line.

== Cross-references <cross-references>

#norm-box("NBR 14724:2024, 5.7, 5.8 and 5.9; NBR 6024:2012, 4.4", "required", "implemented")[
  The illustrations and the tables must be cited in the text. In the mentions of an equation, only the number may
  be used. The sections are cited by their number, as in "na seção 3" (in section 3) or "ver 3.3" (see 3.3).
]

To cite an element in the text, give it a label (`<label>`) and use a cross-reference. There are three forms:

- `@label` gives only the number, as in "1" or "(1.1)". The word that comes before it is written by the author;
- `@label[Figure]` gives the word given and the number, with a single link;
- `#auto-ref(<label>)` gives the word that suits the element ("Figure", "Table", "Section", "Equation") and the
  number. With `form: "page"`, it gives the page of the element.

In the function `fitted`, the label is given in the `label` parameter. The following example shows the three
forms.

```example
#figure(caption: [Structure of the work])[
  #rect(width: 6cm, height: 1.5cm, fill: luma(200))
  #source()
] <fig-structure>

#fitted(label: <tab-defences>,
  caption: [Works defended])[
  #table(columns: (3cm, 3cm), align: (left, right),
    table.header([Year], [Works]),
    [2024], [120], [2025], [135])
  #source()
]

The structure is shown in figure @fig-structure and
detailed in @tab-defences[Table].
#auto-ref(<fig-structure>) is on
#auto-ref(<fig-structure>, form: "page").
```

#remark[
  A semicolon right after `#auto-ref(...)` ends the expression and is not printed. To print it, write the semicolon
  with a backslash: `\;`.
]

#reference("auto-ref")

== Acronyms <abbreviations>

#norm-box("NBR 14724:2024, 5.6", "required", "implemented")[
  An acronym, when mentioned for the first time in the text, must be given in parentheses, preceded by the full
  name.
]

An acronym can be written directly in the text, as in "Associação Brasileira de Normas Técnicas (ABNT)". For the
package to write the full name only on the first mention, register the acronyms as dictionaries in the function
`list-of-acronyms` and cite them by the key, as in `@abnt` (@acronyms[Section]).
