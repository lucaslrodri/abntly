#import "../prelude.typ": *
#show: chapter.with(title: [Structure of the academic work], id: <structure>)

ABNT NBR 14724:2024 (section 4) divides the academic work into an external part and an internal part. The internal
part is made up of pre-textual, textual and post-textual elements. @elements[Table] lists the elements in the order
in which they must appear, shows whether they are required and gives the corresponding function of the package.

In the document, the functions must be called in the same order as in the table. The sections of this chapter
describe each element.

#data-table([Elements of the academic work], (1fr, 2.4cm, 6.2cm), ([Element], [Standard], [Package]),
  label: <elements>,
  table.cell(colspan: 3, text(font: api.sans, fill: luma(90))[External part]),
  [Cover], pill("required"), [`cover`],
  table.cell(colspan: 3, text(font: api.sans, fill: luma(90))[Pre-textual elements]),
  [Title page], pill("required"), [`title-page`],
  [Cataloguing data (verso of the title page)], pill("required"), [`catalog-card`],
  [Errata], pill("optional"), [`errata`],
  [Approval sheet], pill("required"), [`approval-page`],
  [Dedication], pill("optional"), [`dedication`],
  [Acknowledgements], pill("optional"), [`acknowledgments`],
  [Epigraph], pill("optional"), [`epigraph`],
  [Abstract in the vernacular language], pill("required"), [`abstract`, `keywords`],
  [Abstract in a foreign language], pill("required"), [`abstract(lang: "pt")`],
  [List of illustrations], pill("optional"), [`list-of-figures`, `list-of-frames`, \ `list-of`],
  [List of tables], pill("optional"), [`list-of-tables`],
  [List of abbreviations and acronyms], pill("optional"), [`list-of-acronyms`],
  [List of symbols], pill("optional"), [`list-of-symbols`],
  [Table of contents], pill("required"), [`outline` (Typst function)],
  table.cell(colspan: 3, text(font: api.sans, fill: luma(90))[Textual elements]),
  [Introduction, development and conclusion], pill("required"), [text of the author, with headings in `=`],
  table.cell(colspan: 3, text(font: api.sans, fill: luma(90))[Post-textual elements]),
  [References], pill("required"), [`bibliography` (Typst function)],
  [Glossary], pill("optional"), [`glossary`],
  [Appendix], pill("optional"), [`appendix`],
  [Annex], pill("optional"), [`annex`],
  [Index], pill("optional"), [`index`],
)

== Data of the work <work-data>

The data of the work (title, author, advisor, institution, location and year) are given only once, with the
function `config-info`, in the `info` parameter of the main function. The cover, the title page, the approval sheet
and the catalog card use these data automatically. They are also written to the metadata of the PDF.
The following example gives the data of a thesis.

```typ
#show: abntly.with(
  lang: "en",
  info: config-info(
    title: [Title of the work],
    subtitle: [subtitle],
    author: "Name of the Author",
    advisor: (
      name: "Prof. Dr. Name of the Advisor",
      gender: "f",
    ),
    institution: [University of Brazil],
    program: [Graduate Programme],
    location: [Rio Branco],
    year: 2026,
    work-type: "thesis",
  ),
)
```

Fields that are not given are left out of the pages. The author and the advisors can be given as text or as a
dictionary, which makes it possible to separate the given name from the surname, to state the gender (for the label
"Orientadora", in a work in Portuguese) or to set a custom label.

The page examples of the next sections use these data. To highlight the element described, the call of the main
function is left out of the code from @catalog-card[Section] on.

#reference("config-info")

== Cover (required) <cover>

#norm-box("NBR 14724:2024, 4.1.1", "required", "implemented")[
  The cover must contain, in this order: name of the institution (optional); name of the author; title; subtitle,
  if any, preceded by a colon; number of the volume, if there is more than one; location (city) of the institution;
  year of deposit (delivery).
]

The function `cover` creates the cover from the data given in `config-info`. The institution and the programme
appear at the top, followed by the author. If the `version` field is given, the version of the work appears below
the title. The cover is not counted in the page numbering. The following example shows the code and the cover
generated.

#page-example("cover")

#remark[
  The standard defines only the elements of the cover and their order. The font, the emphasis of the title and the
  vertical position of the elements are decisions of the package #pill("decision").
]

=== Customisation

To customise the cover, use the parameters `top`, `middle` and `bottom`, which replace the corresponding part of the
page with custom content. The function `with-info` gives access to the data of the work inside that content. The
parameter `middle-height` controls the vertical position of the title: larger values move the title up.

In the example below, the institution is written in capital letters and the title is moved up.

#page-example("cover-custom")

#reference("cover")

#reference("with-info", description: true)

== Title page (required) <title-page>

#norm-box("NBR 14724:2024, 4.2.1.1.1", "required", "implemented")[
  The recto of the title page must contain, in this order: name of the author; title; subtitle, if any; number of
  the volume, if there is more than one; nature of the work (type of the work, aim, institution to which it is
  submitted and area of concentration); name of the advisor and, if any, of the co-advisor; location; year of
  deposit.
]

The function `title-page` creates the title page. The text of the nature of the work is passed as the content of
the function; the other elements come from `config-info`. If the `area` field is given, the area of concentration
appears in a paragraph of its own, below the nature. The label of the advisor is "Supervisor"; in a work in
Portuguese, it depends on the gender given ("Orientador" or "Orientadora"). The following example shows the
title page of a thesis.

#page-example("title-page")

#norm-box("NBR 14724:2024, 5.2", "required", "implemented")[
  On the title page and on the approval sheet, the nature of the work must be typed in single spacing and aligned
  from the middle of the text block to the right margin.
]

The page count of the work starts on the title page. The text of the nature is reused automatically on the approval
sheet.

Like the cover, the title page accepts the parameters `top`, `middle`, `bottom` and `middle-height`. To build a
page of your own with the block of the nature, use the function `preamble`.

#reference("title-page", "preamble")

== Catalog card (required) <catalog-card>

#norm-box("NBR 14724:2024, 4.2.1.1.2 and 5.3", "required", "partial")[
  The verso of the title page must contain the international cataloguing-in-publication data, according to the
  cataloguing code in force. In electronic format, these data must come immediately after the title page. The verso
  of the title page is neither counted nor numbered.
]

The function `catalog-card` creates the page with the catalog card, at the bottom of the page. It must be called
right after the title page. The card is built from the data of `config-info`. The subjects are the keywords of the
abstract in the language of the work, and the number of pages is computed automatically.
The following example shows the lower part of the page generated.

#page-example("catalog-card", pages: (2,), crop: (0.6, 1))

The card created by the package is provisional and, for that reason, takes the stamp "PROVISIONAL CARD". The final
card is issued by the library of the institution, with the call number and the classification. To use it, give the
file received from the library in the `card` parameter:

```typ
#catalog-card(card: image("card.pdf", width: 13.5cm))
```

#remark[
  The page of the card is counted among the pages of the work. The standard states that the verso of the title page
  is not counted #pill("partial").
]

#reference("catalog-card")

== Errata (optional) <errata>

#norm-box("NBR 14724:2024, 4.2.1.2", "optional", "implemented")[
  The errata must be inserted right after the title page and consists of the reference of the work and the text of
  the errata. It is presented on a loose or inserted sheet, added to the work after it is printed.
]

The function `errata` creates the title "Errata sheet" and inserts the content given. The reference of the work and
the table of the corrections are written by the author, as in the example below.

#page-example("errata", pages: (2,), crop: (0, 0.4))

#reference("errata")

== Approval sheet (required) <approval-page>

#norm-box("NBR 14724:2024, 4.2.1.3", "required", "implemented")[
  The approval sheet must be inserted after the title page and contain: name of the author; title and subtitle, if
  any; nature of the work; date of approval; name, academic title and signature of the members of the examining
  board and the institutions they belong to. The date of approval and the signatures are added after the work is
  approved.
]

The function `approval-page` creates the approval sheet. The members of the board are given as dictionaries, with
the keys `name`, `title` and `institution` (required) and `role` (optional). The author, the title and the nature of
the work come from `config-info` and from the title page.

Before the defence, the sheet is provisional: the date is left blank, to be filled in, and the page takes the stamp
"PROVISIONAL SHEET", as in the example below.

#page-example("approval", pages: (2,))

After the approval, give the date in the `date` parameter and remove the stamp with `draft: false`. In
the example below, the members of the board are in variables (`advisor`, `first-examiner` and
`second-examiner`), with the same dictionaries as in the previous example.

#page-example("approval-final", pages: (2,))

#remark[
  The standard does not include the location and the year among the elements of the approval sheet. The package
  shows them at the bottom of the page #pill("decision").
]

When the institution provides the signed and scanned approval sheet, it can be inserted as an image, on a page
without margins:

```typ
#page(margin: 0pt, header: none, image("approval-sheet.pdf", width: 100%))
```

=== Customisation

The approval sheet accepts the parameters `top`, `middle`, `bottom` and `middle-height`, like the cover. The
function `signature` creates the signature lines in custom content. In the example below, the lower
part of the page is replaced, and two signatures are placed side by side.

#page-example("approval-custom", pages: (2,))

#reference("approval-page", "signature")

== Dedication (optional) <dedication>

#norm-box("NBR 14724:2024, 4.2.1.4 and 5.2.4", "optional", "implemented")[
  The dedication must be inserted after the approval sheet. The page has neither a title nor a section number. It
  is recommended that the text be aligned from the middle of the text block to the right margin, at the bottom of
  the page.
]

The function `dedication` creates the page of the dedication, without a title. By default, the text is set in
italics, centred, in the middle of the page, as in the example below.

#page-example("dedication")

#remark[
  The default position of the text is a decision of the package #pill("decision"). To follow the recommendation of
  the standard, position the text with Typst's `place` function, as in the example below.
]

#page-example("dedication-right")

#reference("dedication")

== Acknowledgements (optional) <acknowledgments>

#norm-box("NBR 14724:2024, 4.2.1.5 and 5.2.3", "optional", "implemented")[
  The acknowledgements must be inserted after the dedication. The title, without a section number, is centred.
]

The function `acknowledgments` creates the title "Acknowledgements" and inserts the text given, as in
the example below.

#page-example("acknowledgments", crop: (0, 0.3))

#reference("acknowledgments")

== Epigraph (optional) <epigraph>

#norm-box("NBR 14724:2024, 4.2.1.6 and 5.2.4", "optional", "implemented")[
  The epigraph must be inserted after the acknowledgements. The page has neither a title nor a section number. It
  is recommended that the text be aligned from the middle of the text block to the right margin, at the bottom of
  the page. Epigraphs may also appear on the opening pages of the primary sections; these follow the rules of the
  citations.
]

The function `epigraph` creates the page of the epigraph, without a title. The text is aligned to the right, at the
bottom of the page. The line breaks (`\`) and the italics are set by the author, as in the example below.

#page-example("epigraph")

#remark[
  The alignment of each line to the right is a decision of the package #pill("decision"). To follow the
  recommendation of the standard, put the text in a block with half the width of the text block, aligned to the
  left: `#epigraph(block(width: 50%, align(left)[...]))`.
]

#reference("epigraph")

== Abstracts (required) <abstracts>

#norm-box("NBR 14724:2024, 4.2.1.7 and 4.2.1.8; NBR 6028:2021, 4.1", "required", "implemented")[
  The abstract in the vernacular language and the abstract in a foreign language are required. The abstract is made
  up of concise sentences, in a single paragraph, and should have from 150 to 500 words in academic works. The
  keywords come right below the abstract, preceded by the expression "Palavras-chave" (Keywords), followed by a
  colon, separated from each other by semicolons and ended by a period. They are written with lowercase initials,
  except for proper nouns and scientific names.
]

#remark[
  The standard does not set the number of keywords: NBR 6028:2021 only says how to write them, and its example has
  five. The "three to five" limit often asked for is a rule of the institution or of the journal. The function
  `keywords` takes any number of them.
]

The function `abstract` creates the title and the text of the abstract. The keywords are given at the end of the
text, with the function `keywords`, one per argument. The `lang` parameter sets the language of the abstract in a
foreign language: the title, the label of the keywords and the hyphenation become those of that language.
The following example creates the two abstracts, each on a page.

#page-example("abstract", pages: (1, 2))

The package has the terms "Abstract" and "Keywords" in Portuguese, English, Spanish and French. For another
language, give the title and the label:

```typ
#abstract(lang: "de", title: [Zusammenfassung])[
  Text der Zusammenfassung.

  #keywords(label: [Schlüsselwörter])[Schriftsatz][ABNT]
]
```

#reference("abstract", "keywords")

== Lists of illustrations and of tables (optional) <lists>

#norm-box("NBR 14724:2024, 4.2.1.9 and 4.2.1.10", "optional", "implemented")[
  The lists are drawn up in the order in which the items appear in the text. Each item is designated by its
  specific name and number, a dash, the title and the page number. When necessary, a list of its own is recommended
  for each type of illustration (frames (quadros), charts, maps and others).
]

The functions `list-of-figures`, `list-of-frames` and `list-of-tables` create the lists of the figures, of the
frames and of the tables of the work. Each list starts on a new page, with its title centred.
The following example shows the top of each of the three pages generated.

#page-example("lists", pages: (1, 2, 3), crop: (0, 0.2))

For another type of illustration, such as charts or maps, create the figures with the `kind` and `supplement`
parameters of the `figure` function and create the list with `list-of`, giving the kind and the title, as in
the example below.

#page-example("list-kind", crop: (0, 0.2))

#reference("list-of", "list-of-figures", "list-of-frames", "list-of-tables")

== Lists of abbreviations and acronyms and of symbols (optional) <acronyms>

#norm-box("NBR 14724:2024, 4.2.1.11 and 4.2.1.12", "optional", "implemented")[
  The list of abbreviations and acronyms is the alphabetical list of the abbreviations and acronyms used in the
  text, followed by the corresponding expressions written in full. A list of its own is recommended for each type.
  The list of symbols is drawn up in the order in which the symbols appear in the text, with the meaning of each
  one.
]

The functions `list-of-acronyms` and `list-of-symbols` create the two lists. The acronyms are sorted alphabetically
by the package; the symbols are shown in the order given. The entries can be written in two ways:

- as pairs, `("ABNT", [Associação Brasileira de Normas Técnicas])`: the list is only printed;
- as dictionaries, with the keys `key`, `short` and `long`: the acronym can also be cited in the text by the key
  (`@abnt`). The first mention shows the expression in full, followed by the acronym in parentheses, and the
  following ones show only the acronym, as NBR 14724:2024 (section 5.6) asks.

The following example uses dictionaries for the acronyms and pairs for the symbols and shows the top of the
three pages generated.

#page-example("acronyms", pages: (1, 2, 3), crop: (0, 0.2))

#reference("list-of-acronyms", "list-of-symbols")

== Table of contents (required) <summary>

#norm-box("NBR 14724:2024, 4.2.1.13; NBR 6027:2012", "required", "implemented")[
  The table of contents is the last pre-textual element. The section numbers are aligned to the left, and it is
  recommended that the titles be aligned by the margin of the title of the longest section number, including those
  of the post-textual elements. The page numbers are presented at the right margin. The pre-textual elements are
  not included in the table of contents. It is recommended that the items have the same typographic presentation as
  the sections in the text.
]

The table of contents is created by Typst's `outline` function; the package sets the title and the presentation of
the entries. The titles of the pre-textual elements created by the package do not enter the table of contents. The
titles of the post-textual elements enter without a section number, aligned with the titles of the sections, as in
the example below.

#page-example("outline", crop: (0, 0.5))

#remark[
  In the table of contents, the titles of the primary sections are shown in capital letters; in the text, in upper
  and lower case #pill("decision"). To use the same form in both, add the rule
  `#show heading.where(level: 1): upper` after the call of the main function.
]

== Textual elements <textual>

#norm-box("NBR 14724:2024, 4.2.2", "required", "implemented")[
  The text is made up of an introductory part, with the objectives and the reasons of the work; the development,
  which details the research or the study carried out; and a concluding part. The work is not divided into
  chapters: it is organised in sections. The naming of the titles is up to the author.
]

The textual elements are written directly in the document, with Typst headings: `=` for the primary sections, `==`
for the secondary ones, and so on. The presentation of the sections is described in @sections[Section].

The package identifies the parts of the work automatically:

- the pre-textual part goes from the start of the document to the first numbered primary section. The pages are
  counted, but show no number;
- the textual part starts at the first numbered primary section. From there on, the pages show the number and the
  running header;
- the post-textual part starts at the list of references.

The functions `front-matter`, `main-matter` and `back-matter` mark the start of each part by hand. They are needed
only when the work writes the pre-textual or post-textual titles as plain headings, or when the text starts without
a numbered heading, as in the example below.

#page-example("parts", pages: (1, 2, 3))

#reference("front-matter", "main-matter", "back-matter")

== References (required) <references-list>

#norm-box("NBR 14724:2024, 4.2.3.1; NBR 6023:2025", "required", "implemented")[
  The references are drawn up according to NBR 6023.
]

The list of references is created by Typst's `bibliography` function, from a `.bib` file with the works cited. The
package sets the title and the presentation of the list:

```typ
#bibliography("refs.bib")
```

@references[Chapter] describes the citations, the list of references and the `.bib` file.

== Glossary (optional) <glossary>

#norm-box("NBR 14724:2024, 4.2.3.2", "optional", "implemented")[
  The glossary is drawn up in alphabetical order.
]

The function `glossary` creates the glossary, with the terms sorted alphabetically by the package. As in the lists
of acronyms, the entries can be pairs or dictionaries. With dictionaries, which have the keys `key`, `short` and
`description`, the terms can be cited in the text by the key, as in the example below.

#page-example("glossary", pages: (1, 2), crop: (0, 0.2))

#reference("glossary")

== Appendices and annexes (optional) <appendices>

#norm-box("NBR 14724:2024, 4.2.3.3, 4.2.3.4 and 5.3", "optional", "implemented")[
  The title of each appendix is preceded by the word "APÊNDICE" (APPENDIX), a consecutive capital letter and a
  dash. When the letters of the alphabet run out, doubled letters are used. The typographic emphasis is the same as
  that of the primary sections. The same applies to the annexes, with the word "ANEXO" (ANNEX). The pages of the
  appendices and of the annexes continue the numbering of the text.
]

The functions `appendix` and `annex` are used with a `show` rule. From the rule on, each primary heading (`=`) is
an appendix or an annex, identified by the word, the letter and the dash. The sections of an appendix are numbered
with its letter, as in "A.1". The following example shows the three pages generated.

#page-example("appendix", pages: (2, 3, 4))

#remark[
  The page with the title "Appendices" (or "Annexes"), inserted before the first appendix, is not required by the
  standard #pill("decision"). To leave it out, use `divider: false`, as in the rule of the annex in the example.
]

#reference("appendix", "annex")

== Index (optional) <index>

#norm-box("NBR 14724:2024, 4.2.3.5; NBR 6034:2004, 6", "optional", "implemented")[
  The index is the last element of the work. The entries are presented on separate lines, with progressive indents
  for the subheadings. Consecutive pages are indicated by the first and the last numbers, joined by a hyphen, and
  non-consecutive ones are separated by commas. The cross-references "ver" (see) and "ver também" (see also) are
  typographically emphasised.
]

The function `index` creates the index from the entries given by the author. Each entry is a dictionary with the
keys `term` (the heading), `pages` (a number, a range such as `"2-3"` or a list of them), `sub` (the subheadings,
which are entries too), `see` and `see-also` (the cross-references). A simple entry can be written as a pair,
`("Term", 3)`. The package sorts the entries alphabetically, according to NBR 6033:1989, and turns each page into
a link, as in the example below.

#page-example("index", pages: (3,), crop: (0, 0.3))

#remark[
  The package does not collect the terms in the text: the pages of each entry are given by the author. For that
  reason, check the index at the end, when the pagination of the work is settled.
]

#reference("index")
