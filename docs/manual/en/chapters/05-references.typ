#import "../prelude.typ": *
#show: chapter.with(title: [Citations and references], id: <references>)

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

The function has the same name in both languages of the package, and its parameters follow those of the function
`cite` of Typst. In the numeric systems, the source consulted is given by its number.

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
