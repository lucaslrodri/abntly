// The manual of abntly in English (docs/manual-en.pdf), in one file: a chapter is a primary heading with its label, and
// the chapters are those of `manual-pt.typ`, in the same order. Build: `sh scripts/manual.sh`, which renders the pages
// of the examples first.
#import "template.typ": *

// the helpers of the template, in English
#let lang = "en"
#let project = project.with(lang: lang)
#let pill = pill.with(lang: lang)
#let norm-box = norm-box.with(lang: lang)
#let remark = remark.with(lang: lang)
#let page-example = page-example.with(lang: lang)
#let bib-example = bib-example.with(lang: lang)
#let reference = reference.with(lang: lang)
#let api-index = api-index.with(lang: lang)

#show: project.with(
  title: [abntly],
  subtitle: [Academic works in the ABNT standards, in Typst],
  author: "Lucas Lima Rodrigues",
  date: [October 1, 2026],
  abstract: [
    *abntly* is a #link("https://typst.app")[Typst] template for academic works that comply with the standards of
    the Associação Brasileira de Normas Técnicas (ABNT), especially ABNT NBR 14724:2024, Trabalhos acadêmicos —
    Apresentação. The full list of the standards the package implements is in @norms[Section].
  ],
)

= Quick start <quick-start>

== Scope <scope>

This manual describes the *abntly* package, which formats academic works written in
#link("https://typst.app")[Typst] according to the ABNT standards. The package is intended for final course works,
dissertations and theses. Other types of document, such as articles, technical reports and research projects, are
outside its scope.

The manual is based on ABNT NBR 14724:2024, which defines the structure and the general presentation rules of
academic works and refers to the other standards (@norms[Section]). For each element of the work, the manual
presents:

- what the standard requires, in summary;
- the function of the package that meets this requirement;
- an example of use, with the result.

The manual does not replace the text of the standards, which must be consulted in case of doubt.

== About the package <about>

abntly applies the ABNT formatting to the whole document through its main function, `abntly`
(@main-function[Section]), called only once at the top of the file. From that call on, the package sets up
automatically:

- the page format and the margins;
- the fonts and the spacing;
- the numbering of the pages and of the sections;
- the formatting of illustrations, tables and equations;
- the citations and the list of references.

The elements of the structure of the work, such as the cover, the title page and the abstracts, are created by
functions of their own, described in @structure[Chapter].

Every function has an English name and a Portuguese name (for example, `cover` and `capa`), with the parameters and the
documentation in the respective language. This manual uses the English names; the Portuguese version of the manual uses
the Portuguese ones. The two sets can be combined in the same document. In the reference of each function, the
Portuguese name is shown beside the English one and links to the function in the Portuguese manual; the help of the
function in the editor ends with it too.

The language of the work does not depend on the names used. It is set in the `lang` parameter of the main function
(@main-function[Section]): a work written with the English names comes out in Portuguese, unless `lang: "en"` is
given.

== Standards implemented <norms>

The package implements the requirements of the standards listed below.

#data-table([Standards implemented by the package], (5.6cm, 1fr), ([Standard], [Purpose]),
  [*ABNT NBR 14724:2024* \ Trabalhos acadêmicos — Apresentação],
  [Defines the structure of the academic work and the general presentation rules: format, margins, spacing,
    pagination, illustrations and tables. It is the main standard; the others are cited by it. The package follows
    the corrected version of 2025.],
  [*ABNT NBR 6024:2012* \ Numeração progressiva das seções de um documento — Apresentação],
  [Defines the numbering of the sections, the items and the subitems.],
  [*ABNT NBR 6027:2012* \ Sumário — Apresentação],
  [Defines the presentation of the table of contents.],
  [*ABNT NBR 6028:2021* \ Resumo, resenha e recensão — Apresentação],
  [Defines the writing and the presentation of the abstract and of the keywords.],
  [*ABNT NBR 10520:2023* \ Citações em documentos — Apresentação],
  [Defines the presentation of the citations: the author-date and numeric citation systems, the direct and
    indirect citations and the notes.],
  [*ABNT NBR 6023:2025* \ Referências — Elaboração],
  [Defines the elements of the references, their order and their form of presentation.],
  [*ABNT NBR 6034:2004* \ Índice — Apresentação],
  [Defines the presentation of the index.],
  [*ABNT NBR 6033:1989* \ Ordem alfabética],
  [Defines the criteria of alphabetical ordering, used in the lists, in the glossary and in the index.],
  [*IBGE (1993)* \ Normas de apresentação tabular],
  [Defines the presentation of the tables, as indicated by NBR 14724.],
)

== Installation <install>

The package requires Typst #package.compiler or later. To use it, add the following line at the top of the file:

```typ
#import "@preview/abntly:0.1.1": *
```

Typst downloads the package automatically on the first compilation.

To create a new work from the template of the package, which has every element of the structure with comments, use
the command:

```sh
typst init @preview/abntly:0.1.1
```

== Dependencies <dependencies>

abntly depends on other Typst packages and on the fonts of the *New Computer Modern* family. The packages are
downloaded automatically along with abntly. Some of the fonts come with Typst; the others must be installed.

#data-table([Dependencies of the package], (5cm, 1.6cm, 1fr), ([Dependency], [Type], [Use]),
  ..dependencies.map(((name, version)) => ([#raw(name) #version], [Package], (
    equate: [Numbering of the equations and of the lines of an equation.],
    glossarium: [Acronyms, symbols and glossary terms cited in the text by a key.],
    linguify: [Terms generated by the package, in the language of the text.],
    subpar: [Subfigures.],
  ).at(name))).flatten(),
  [New Computer Modern], [Font], [Text. Comes with Typst.],
  [New Computer Modern Math], [Font], [Equations. Comes with Typst.],
  [New Computer Modern Sans], [Font], [Headings. Must be installed.],
  [New Computer Modern Mono], [Font], [Code. Must be installed.],
  [New Computer Modern 08], [Font], [Superscripts and subscripts. Must be installed.],
)

To install the fonts that do not come with Typst:

+ download the package #link("https://ctan.org/pkg/newcomputermodern")[`newcomputermodern`] from CTAN;
+ in the `otf` folder, install the files `NewCM10-*`, `NewCM08-*`, `NewCMSans10-*`, `NewCMSans08-*`, `NewCMMono10-*`
  and `NewCMMath-*` (the files with `Book` in their name are not used);
+ on #link("https://typst.app")[typst.app], upload these files to the project instead of installing them.

#remark[
  Without these fonts, the document is compiled with fallback fonts, and Typst issues a warning for each missing
  family, such as `unknown font family: new computer modern sans`.
]

== Main function <main-function>

The function `abntly` is the main function of the package. It applies the ABNT formatting to the whole document and
must be used with a `show` rule, right after the import. The data of the work are given in the `info` parameter
(@work-data[Section]).

The following example creates a work with a cover, a title page, a table of contents and one chapter:

#page-example("first-work", pages: (1, 2, 4))

The other parameters set the language, two-sided printing, the colour of the links, the font size of the tables,
the numbering of the equations and the citation system. The default language is Portuguese; the examples of this
manual are works in English, so they pass `lang: "en"`.

Settings that are not parameters of the function can be changed with Typst `set` rules after the call. For
example, `#set text(size: 11pt)` changes the font size, and the other sizes scale with it.

#reference("abntly", "dark-indigo")

#reference("config-names", description: true)

== Conventions of the manual <how-to-read>

Each element is presented in up to four blocks. The first one summarises what the standard requires:

#norm-box("NBR 14724:2024, 5.1", "required", "implemented")[
  The text must be presented in black; other colours may be used only in the illustrations. If printed, the work
  must use white or recycled paper, in A4 format.
]

The pills show the status of the element in the standard (#pill("required"), #pill("optional") or
#pill("recommended")) and in the package (#pill("implemented") or #pill("partial")). The pill
#pill("decision") marks a point that the standard does not define and that was decided by the package, such as the
font or the position of an element on the page.

The second block is an example, with the code and the result, like the one that follows. The examples of whole
pages show the pages generated.

```example
#figure(caption: [Distribution by region])[
  #rect(width: 6cm, height: 2cm)
  #source()
]
```

Remarks appear in boxes like this one:

#remark[
  A remark points out a caution of use, a limitation of the package or a choice that depends on the institution.
]

The last block is the reference of the function, with the signature, the type and the default value of each
parameter and the description of each one.

= Structure of the academic work <structure>

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

= General presentation rules <general-rules>

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

= Elements beyond the standard <extras>

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

= Citations and references <references>

The citations follow ABNT NBR 10520:2023, and the list of references, ABNT NBR 6023:2025. The author records the
works in a `.bib` file and cites them in the text by the key. The package sets the calls and the list with Typst's
`cite` and `bibliography` functions.

== Citation systems <citation-systems>

#norm-box("NBR 10520:2023, 6", "required", "implemented")[
  The citations are indicated in the text by a call system: author-date or numeric. The system adopted must be
  followed throughout the work. In the numeric system, the numbering of the sources is consecutive, in Arabic
  numerals, and refers to the list of references, in the order in which the sources appear in the text. The
  numbering can be given in parentheses, in line with the text, or as a superscript. The numeric system cannot be
  used in a work with notes.
]

The citation system is set in the `citation-system` parameter of the main function. @systems[Table] lists the
values accepted. The system defines the form of the calls and the order of the list of references.

#data-table([Citation systems], (2.4cm, 3.4cm, 4cm, 1fr),
  ([Value], [System], [Call], [List of references]), label: <systems>,
  [`"alf"`], [Author-date (default)], [(Luck, 2010, p. 12)], [In alphabetical order.],
  [`"num"`], [Numeric, in parentheses], [(1, p. 12)], [In the order of the citations, with the number before each
    reference.],
  [`"overcite"`], [Numeric, as a superscript], [#super[1, p. 12]], [As in `"num"`.],
  [`"ieee"`], [Numeric, in brackets], [[1, p. 12]], [As in `"num"`. The brackets are not provided for in the
    standard #pill("decision").],
)

The following example shows a paragraph in the numeric system, with the top of the page of the text and of the page
of the references.

#page-example("citations-num", pages: (1, 2), crop: (0, 0.22))

The same paragraph, with the calls as superscripts:

#page-example("citations-overcite", crop: (0, 0.22))

And with the calls in brackets:

#page-example("citations-ieee", crop: (0, 0.22))

== Citations in the text <citations>

#norm-box("NBR 10520:2023, 6.1", "required", "partial")[
  In the author-date system, the source is indicated by the surname of the author or by the name of the entity, in
  upper and lower case, followed by the date. In direct citations, the page is added. When the author is part of
  the sentence, the date and the page go in parentheses. A source with four or more authors can be cited by the
  first author, followed by "et al.". Authors with the same surname and the same date are distinguished by the
  initials of their given names, and works by the same author and of the same year, by lowercase letters after the
  date. Several works in the same call are separated by semicolons, preferably in alphabetical order. A source
  without an author is cited by the first word of the title, followed by "[...]".
]

A work is cited by the key it has in the `.bib` file. @cite-forms[Table] lists the forms of citation. The page, or
another location, is given in brackets, after the key.

#data-table([Forms of citation], (7.4cm, 1fr), ([Code], [Use]), label: <cite-forms>,
  [`@key`], [Call in parentheses.],
  [`@key[p. 12]`], [Call with the page, for direct citations.],
  [`#cite(<key>, form: "prose")`], [Author in the sentence, with the date in parentheses.],
  [`#cite(<key>, form: "prose", supplement: [p. 12])`], [Author in the sentence, with the page.],
  [`#cite(<key>, form: "author")`], [Only the name of the author.],
  [`#cite(<key>, form: "full")`], [Full reference, in the text.],
  [`@key-a @key-b`], [Several works in the same call.],
  [`#apud([Author], 1990, <key>)`], [Citation of a citation (@apud[Section]).],
)

The following example shows the forms of citation in the author-date system, with the works of the list of
references of this manual.

```example
One author @luck2010, with the page @luck2010[p. 12] and in
the sentence:
#cite(<luck2010>, form: "prose", supplement: [p. 12]).

Two authors @oliveira1943, three authors @cruz1998 and
four authors @maciel2019. In the sentence:
#cite(<oliveira1943>, form: "prose") and
#cite(<maciel2019>, form: "prose").

Several works @luck2010 @cruz1998. Works by the same author
and of the same year @freyre1936a @freyre1936b. Authors with
the same surname @barbosaC1958 @barbosaO1958.

Entity @abnt2024 and work without an author
@anteprojeto1987[p. 55].
```

A work without an author is cited by the first word of the title, followed by "[...]". If the title starts with an
article or with a monosyllabic word, the next word is included too. To set another form, give the `shorttitle`
field in the entry of the `.bib` file.

#remark[
  One point of the standard is not implemented #pill("partial"). In the citations of several works by the same
  author, the dates are separated by semicolons, as in "(Dreyfuss, 1989; 1991)", and not by commas.
]

== Citation of a citation <apud>

#norm-box("NBR 10520:2023, 7.3", "required", "implemented")[
  In the citation of a citation, the elements are given in this order: author or first word of the title of the
  original document; date; page of the original document, if any; the expression "apud"; author or first word of
  the title of the source consulted; date; page of the source consulted, if any. Only the source consulted is in
  the list of references.
]

The function `apud` creates the citation of a citation. The author and the date of the original document are
written in the call, because that document is not in the `.bib` file. The source consulted is given by its key and
goes to the list of references. The parameters `page` and `supplement` give the page of the original document and
that of the source consulted. With `form: "prose"`, the author of the original document is part of the sentence,
as in the example below.

```example
In parentheses: #apud([Silva], 1990, <autor2026>,
  page: [p. 5], supplement: [p. 10]).

In the sentence: #apud([Silva], 1990, <autor2026>,
  form: "prose").
```

Its parameters follow those of the function `cite` of Typst. In the numeric systems, the source consulted is given
by its number.

#reference("apud")

== List of references <bibliography>

#norm-box("NBR 6023:2025, 6.3, 6.6, 6.7 and 9; NBR 14724:2024, 5.2", "required", "implemented")[
  The references are drawn up in single spacing, aligned to the left margin and separated from each other by one
  blank line of single spacing. The typographic device used to emphasise the title is uniform in all the
  references; a work without an author is entered by its title, with the first word in capital letters and without
  other emphasis. For online documents, the electronic address is recorded, preceded by "Disponível em:" (Available
  at:), and the date of access, preceded by "Acesso em:" (Accessed:). In the alphabetical system, the references
  are gathered in alphabetical order; in the numeric system, they follow the order in which the works are cited in
  the text.
]

The list of references is created by Typst's `bibliography` function, called after the text:

```typ
#bibliography("refs.bib")
```

The package creates the title "References", centred and without a number, and sets each reference according to the
standard. The title of the work is emphasised in bold. By default, the list contains only the works cited in the
text; with `full: true`, it contains all the works of the file. The list of references of this manual, on page
#context counter(page).at(query(bibliography).first().location()).first(), is created this way.

== References file <bib-file>

The works are recorded in a `.bib` file, in the BibLaTeX format. Each entry has a type (`@book`, `@article`), a key
and the fields of the work. @bib-fields[Table] summarises how to write the most common cases.

#data-table([Fields of the references file], (3.2cm, 1fr), ([Case], [How to write]), label: <bib-fields>,
  [Subtitle], [In the `title` field, after a colon: `title = {Title: subtitle}`. The emphasis ends at the colon.],
  [Entity as author], [With double braces: `author = {{Associação Brasileira de Normas Técnicas}}`.],
  [Thesis and dissertation], [`@phdthesis`, with the type and the degree in `type`, the institution in `publisher`,
    the location in `address` and the year in `year`.],
  [Part of a book], [`@incollection`, with the title of the part in `title` and that of the book in `booktitle`.
    The author of the book goes in `bookauthor`; the organisers, in `editor`, with `editortype = {organizer}`.],
  [Article], [`@article`, with the journal in `journaltitle`, the location in `address` and the fields `volume`,
    `number` and `pages`.],
  [Work in an event], [`@inproceedings`, with the event in `eventtitle`, the number of the event in `edition`, the
    location in `venue` and `booktitle = {Anais [...]}`.],
  [Online document], [The address in `url` and the date of access in `urldate`, in the format `2026-10-01`.],
  [Work without an author], [Without the `author` field. The `shorttitle` field sets the call, if needed.],
)

The examples below show the entry of the `.bib` file and the reference generated, for the most used types of
document. The works are examples from NBR 6023:2025.

=== Book

#bib-example("luck2010")

=== Book by an entity

#bib-example("abnt2024")

=== Thesis

#bib-example("aguiar2009")

=== Dissertation in electronic form

#bib-example("coelho2009")

=== Part of a book

#bib-example("santos1994")

=== Part of a book with organisers

#bib-example("romano1996")

=== Journal article

#bib-example("delucca2009")

=== Newspaper article in electronic form

#bib-example("verissimo2010")

=== Work presented at an event

#bib-example("brayner1994")

=== Work without an author

#bib-example("anteprojeto1987")

#remark[
  Some types of document of NBR 6023:2025 are not set according to the standard #pill("partial"): the event as a
  whole, legislation and case law, patents, the issue of a periodical and cartographic documents in periodicals.
  Some elements also have no field of their own, such as the approximate date in brackets and the numbering of the
  year of a periodical ("ano 3"). In these cases, check the reference generated against the text of the standard.
]

= Index of functions <api-index>

This chapter lists the functions and the variables of the package, in alphabetical order, with the page on which
each one is described. The package also exports the same functions with Portuguese names, described in the
Portuguese version of this manual.

#api-index()

// the works the examples cite, as the package sets the list of references of a work
#bibliography("examples/refs.bib")
