# abntly

<p align="center">
  <a href="https://github.com/lucaslrodri/abntly/blob/v0.1.0/README.md">Português</a> · <strong>English</strong>
</p>

<p align="center">
  <a href="https://typst.app/universe/package/abntly"><img src="https://img.shields.io/badge/dynamic/toml?url=https%3A%2F%2Fraw.githubusercontent.com%2Flucaslrodri%2Fabntly%2Fmain%2Ftypst.toml&amp;query=%24.package.version&amp;label=Typst%20Universe&amp;logo=typst&amp;color=239dad" alt="Version on Typst Universe"></a>
  <a href="https://github.com/lucaslrodri/abntly/blob/v0.1.0/docs/manual-en.pdf"><img src="https://img.shields.io/badge/manual-English-orange" alt="Manual in English (PDF)"></a>
  <a href="https://github.com/lucaslrodri/abntly/blob/v0.1.0/docs/manual-pt.pdf"><img src="https://img.shields.io/badge/manual-portugu%C3%AAs-orange" alt="Manual in Portuguese (PDF)"></a>
  <a href="https://typst.app/"><img src="https://img.shields.io/badge/dynamic/toml?url=https%3A%2F%2Fraw.githubusercontent.com%2Flucaslrodri%2Fabntly%2Fmain%2Ftypst.toml&amp;query=%24.package.compiler&amp;prefix=%E2%89%A5%20&amp;label=Typst&amp;logo=typst&amp;color=239dad" alt="Minimum Typst version"></a>
  <a href="https://github.com/lucaslrodri/abntly/blob/v0.1.0/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green" alt="License: MIT"></a>
</p>

<p align="center">
  <em><a href="https://typst.app/">Typst</a> template for academic works (final course works, dissertations and
  theses) that follow the standards of the Brazilian Association of Technical Standards (ABNT), especially
  ABNT NBR 14724:2024.</em>
</p>

## What the package is

**abntly** formats an academic work written in Typst according to the ABNT standards. The main function, `abntly`,
is called once at the top of the file and applies the formatting to the whole document. Each element of the
structure of the work has its own function.

- **General rules:** A4 page and margins, font, spacing, pagination, section numbering, lettered items and
  footnotes.
- **Structure:** cover, title page, catalog card, errata, approval sheet, dedication, acknowledgments, epigraph,
  abstracts, lists, table of contents, glossary, appendices, annexes and index.
- **Elements of the text:** illustrations with source, legend and notes, frames (quadros), tables in the IBGE
  pattern, equations and cross-references.
- **Citations and references:** author-date and numeric systems, citation of a citation and the list of references,
  from a `.bib` file.
- **Two languages:** every function has an English name and a Portuguese one (`cover` and `capa`), and the work can
  be written in Portuguese or in English.

The package covers academic works only. Articles, technical reports and research projects are out of its scope (see
[ABNTyp](#see-also)).

## Usage

To create a new work from the [template](https://github.com/lucaslrodri/abntly/blob/v0.1.0/template/main.typ), in which each element is commented as required or
optional (the comments are in Portuguese):

```sh
typst init @preview/abntly:0.1.0 my-work
```

To use the package in a file that already exists, import it at the top:

```typst
#import "@preview/abntly:0.1.0": *
```

The fonts *New Computer Modern Sans*, *Mono* and *08* must be installed (see [Dependencies](#dependencies)).

## Basic example

The example below has only the required elements of NBR 14724:2024, in the order of the standard. The default
language of a work is Portuguese, so the example passes `lang: "en"`. The file
[`refs.bib`](https://github.com/lucaslrodri/abntly/blob/v0.1.0/examples/en/refs.bib) holds the works cited in the text.

<!-- basic:begin (generated from examples/en/basic.typ by scripts/readme.sh: do not edit by hand) -->
```typst
// Minimal academic work: only the required elements of ABNT NBR 14724:2024, in the order of the standard.
#import "@preview/abntly:0.1.0": *

#show: abntly.with(
  lang: "en",
  info: config-info(
    title: [Title of the work],
    author: "Name of the Author",
    advisor: "Prof. Dr. Name of the Advisor",
    institution: [University of Brazil],
    location: [Rio Branco],
    year: 2026,
  ),
)

// Pre-textual elements
#cover()
#title-page[
  Dissertation presented to the University of Brazil, in partial fulfilment of the requirements for the degree of
  Master.
]
#catalog-card()
#approval-page(
  (title: [Prof. Dr.], name: [Name of the Advisor], institution: [University of Brazil]),
  (title: [Prof. Dr.], name: [Name of the Examiner], institution: [Another University]),
)
#abstract[
  Abstract text, in a single paragraph.

  #keywords[first][second][third]
]
#abstract(lang: "pt")[
  Texto do resumo, em um único parágrafo.

  #keywords[primeira][segunda][terceira]
]
#outline()

// Textual elements
= Introduction

Text of the introduction, with a citation @luck2010.

= Development

Text of the development.

= Conclusion

Text of the conclusion.

// Post-textual elements
#bibliography("refs.bib")
```

![The 11 pages of examples/en/basic.typ](https://raw.githubusercontent.com/lucaslrodri/abntly/v0.1.0/docs/readme/basic.png)
<!-- basic:end -->

## Full example

- [`examples/en/main.typ`](https://github.com/lucaslrodri/abntly/blob/v0.1.0/examples/en/main.typ) ([PDF](https://github.com/lucaslrodri/abntly/blob/v0.1.0/docs/example-en.pdf)): a work in English
  with every element of the structure and its chapters in separate files, written with the English names.
- [`examples/pt/main.typ`](https://github.com/lucaslrodri/abntly/blob/v0.1.0/examples/pt/main.typ) ([PDF](https://github.com/lucaslrodri/abntly/blob/v0.1.0/docs/example-pt.pdf)): the same work in
  Portuguese, with the Portuguese names.

## Documentation

The manual describes each function together with what the standard asks of each element, with the code and its
result. It works as a guide to the package and as a quick reference of the standards.

- [Manual in English](https://github.com/lucaslrodri/abntly/blob/v0.1.0/docs/manual-en.pdf) (PDF), with the English names.
- [Manual in Portuguese](https://github.com/lucaslrodri/abntly/blob/v0.1.0/docs/manual-pt.pdf) (PDF), with the Portuguese names.

## Standards implemented

| Standard | Subject |
| -------- | ------- |
| ABNT NBR 14724:2024 | Academic works: structure and general presentation rules |
| ABNT NBR 6024:2012 | Progressive numbering of sections, items and subitems |
| ABNT NBR 6027:2012 | Table of contents |
| ABNT NBR 6028:2021 | Abstract and keywords |
| ABNT NBR 10520:2023 | Citations |
| ABNT NBR 6023:2025 | References |
| ABNT NBR 6034:2004 | Index |
| ABNT NBR 6033:1989 | Alphabetical order |
| IBGE (1993) | Tabular presentation standards |

## Dependencies

| Dependency | Version | Role |
| ---------- | ------- | ---- |
| [Typst](https://typst.app/) | ≥ 0.15.0 | compiler |
| [equate](https://typst.app/universe/package/equate) | 0.3.3 | numbering of the equations |
| [glossarium](https://typst.app/universe/package/glossarium) | 0.5.10 | acronyms, symbols and glossary terms cited in the text |
| [linguify](https://typst.app/universe/package/linguify) | 0.5.0 | terms of the package in the language of the work |
| [subpar](https://typst.app/universe/package/subpar) | 0.2.2 | subfigures |
| *New Computer Modern* | | fonts of the text, the headings, the code and the equations |

Typst fetches the packages automatically. The fonts it does not: *New Computer Modern* and *New Computer Modern
Math* are bundled with Typst, but the *Sans* (headings), the *Mono* (code) and the *08* (superscripts) must be
installed. They belong to the [New Computer Modern](https://ctan.org/pkg/newcomputermodern) family: download the
archive from CTAN and install, from its `otf` folder, the files `NewCM10-*`, `NewCM08-*`, `NewCMSans10-*`,
`NewCMSans08-*`, `NewCMMono10-*` and `NewCMMath-*` (those with `Book` in the name are not used). In
[typst.app](https://typst.app/), upload those files to the project.

## See also

abntly was inspired by these projects:

- [ABNTyp](https://typst.app/universe/package/abntyp): Typst package for documents in the ABNT standards. Besides
  academic works, it has templates for articles, technical reports, research projects, books, posters and slides.
- [abnTeX2](https://www.abntex.net.br/): LaTeX classes and packages for documents in the ABNT standards. abntly
  follows abnTeX2's model of an academic work where the standards leave a point open.
- [csl-abnt](https://github.com/virgilinojuca/csl-abnt): CSL style in the ABNT NBR 6023 and NBR 10520 standards for
  Zotero, by [@virgilinojuca](https://github.com/virgilinojuca) and [@AAguiarCAM](https://github.com/AAguiarCAM), in the
  public domain (CC0). abntly's `src/csl/abnt-6023.csl` was adapted from it.

## License

The package is distributed under the [MIT license](https://github.com/lucaslrodri/abntly/blob/v0.1.0/LICENSE).
