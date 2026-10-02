// The manual of abntly: its template. The manual is a work set by the package itself (`project` applies `abntly`),
// so it has the page, the fonts, the spacing and the elements of the works it describes, and the examples of the
// elements of the text are evaluated where they stand, in the style of the package; only its body is smaller. It
// has two versions, in Portuguese (`pt/`, which teaches the Portuguese names of the API) and in English (`en/`, the
// English names), with the same chapters: `pt/prelude.typ` and `en/prelude.typ` give the language to the helpers
// below.
//
// A chapter (`<lang>/chapters/NN-name.typ`) starts with `#import "../prelude.typ": *` and `#show: chapter.with(title:
// [...], id: <label>)` and holds content only: no rule of the page, no absolute position, not even its own title,
// which `chapter` sets. So the same files feed the PDF (`<lang>/manual.typ` includes them) and, later, a page each
// of a site (shiroa): `chapter` and the helpers are the only places that would look at the target. The helpers have
// English names that are not names of the package (`nota`, `index` and `frame` are); the package is not imported
// with `*`, and the examples get it through the scope of `eval`.
//
// The helpers:
// - `norm-box(reference, ..pills)[...]`: what a norm asks for, in our words, with its name and its section;
// - `remark[...]`: a remark;
// - `pill(kind)`: "Obrigatório", "Opcional", "Recomendado" (the norm), "Atendido", "Atendido em parte", "Não
//   implementado", "Decisão de projeto" (the package), by a key that is the same in both languages;
// - a block of code: set by the package codly, with its lines numbered;
// - ```` ```example ````: Typst code shown and evaluated, the result under the code, at the width of the text block
//   of a work, so that its lines break as the author will see them;
// - `page-example(name, pages:, crop:)`: the pages of a small work of `examples/`, rendered by scripts/manual.sh: one
//   page beside its code, several under it, parts of pages under it too;
// - `data-table(caption, columns, header, ..cells)`: a table of the manual itself, as the package sets a table;
// - `bib-example(key)`: an entry of the `.bib` of the manual (`examples/refs.bib`) and the reference it gives;
// - `dependencies`: the packages the sources import, with their versions;
// - `reference(..names)`: the reference of functions of the API, from their `///` comments, by tidy;
// - `api-index()`: every public definition with the page of its reference.
// Each one leaves a mark in the document (`<manual-mark>`): `sh scripts/manual.sh --check` lists the marks of the two
// versions (`typst query`) and checks that they hold the same things in the same order.
#import "@preview/tidy:0.4.3"
#import "@preview/codly:1.3.0": codly, codly-init, no-codly
#import "../../src/lib.typ" as package-lib
#import "../../src/fonts.typ": families, elements as work-styles
#import "../../src/spacing.typ": single-spacing, line-spacing, paragraph-skip, indent, heading-after
#import "style.typ" as api

#let package = toml("../../typst.toml").package
// the body of the manual: smaller than the 12 pt of a work, whose proportions it keeps, since every size of the
// package is in em of the body (`--input manual-body=11` tries another one)
#let body-size = float(sys.inputs.at("manual-body", default: "10")) * 1pt
// a work, for the examples: its body of 12 pt and its text block, 16 cm wide (A4 less the margins of 3 cm and 2 cm)
#let work-body = 12pt
#let work-width = 16cm
// code, signatures and the text of the boxes: the reduced body of the package (10 pt in a body of 12)
#let small = api.small
#let accent = api.accent

// ---------- words ----------
#let words = (
  pt: (
    norm: "O que a norma pede", remark: "Observação", result: "Resultado", argument: "Parâmetro",
    contents: "Sumário",
    parameters: "Parâmetros", default: "Padrão", variables: "Variáveis", page: "p.",
    required: "Obrigatório", optional: "Opcional", recommended: "Recomendado", implemented: "Atendido",
    partial: "Atendido em parte", missing: "Não implementado", decision: "Decisão de projeto",
  ),
  en: (
    norm: "What the standard asks for", remark: "Remark", result: "Result", argument: "Argument",
    contents: "Contents",
    parameters: "Parameters", default: "Default", variables: "Variables", page: "p.",
    required: "Required", optional: "Optional", recommended: "Recommended", implemented: "Implemented",
    partial: "Partly implemented", missing: "Not implemented", decision: "Design decision",
  ),
)

// a mark of the document, for the check that the two versions hold the same things (scripts/manual.sh)
#let mark(kind, value) = [#metadata((kind: kind, value: value))<manual-mark>]

// ---------- pills and boxes ----------
// the colours of the pills: what the norm says of an element, and what the package does about it
#let pill-colors = (
  required: rgb("#b42318"), optional: rgb("#475467"), recommended: rgb("#026aa2"),
  implemented: rgb("#067647"), partial: rgb("#b54708"), missing: rgb("#344054"), decision: accent,
)

/// A pill: the status of an element in the norm (`"required"`, `"optional"`, `"recommended"`) or in the package
/// (`"implemented"`, `"partial"`, `"missing"`, `"decision"`).
#let pill(kind, lang: "pt") = {
  assert(kind in pill-colors, message: "pill: unknown kind " + repr(kind))
  let color = pill-colors.at(kind)
  mark("pill", kind)
  box(fill: color.lighten(88%), stroke: 0.5pt + color.lighten(40%), radius: 1em, inset: (x: 0.6em),
    outset: (y: 0.3em), api.boxed(text(font: api.sans, size: 0.72em, weight: "bold", fill: color,
      words.at(lang).at(kind))))
  // a letter of no width after it: alone in a cell of a table, the pill stands on the line of a text, with the
  // height of that line, and not in the middle of the cell, where it would reach the rule above it
  sym.zws
}

// a box with a coloured bar at its left, a heading line and a body in the reduced size, single-spaced
#let _box(color, head, body) = block(width: 100%, fill: color.lighten(94%), stroke: (left: 2.5pt + color),
  radius: (right: 3pt), inset: (left: 10pt, right: 9pt, top: 8pt, bottom: 9pt), above: 1.4em, below: 1.4em,
  breakable: false, api.plain({
    set text(size: small)
    block(below: 0.75em, head)
    body
  }))

/// What a norm asks for, in our words (the norms are not transcribed): the name of the norm and its section, the
/// pills, and the paraphrase.
#let norm-box(reference, ..pills, lang: "pt") = {
  let args = pills.pos()
  let body = args.pop()
  mark("norm", reference)
  _box(accent, grid(columns: (1fr, auto), column-gutter: 1em, align: (left + horizon, right + horizon),
    [#text(font: api.sans, weight: "bold", fill: accent, words.at(lang).norm) #h(0.5em) #text(font: api.sans,
      fill: luma(70), reference)],
    args.map(k => pill(k, lang: lang)).join(h(0.4em))), body)
}

/// A remark.
#let remark(body, title: auto, lang: "pt") = {
  let color = rgb("#b54708")
  mark("remark", none)
  _box(color, text(font: api.sans, weight: "bold", fill: color, if title == auto { words.at(lang).remark } else {
    title }), body)
}

/// A table of the manual itself, set as the package sets the table of a work (`fitted` with a header: its rules,
/// the title above it, and "(continua)", "(continuação)" and "(conclusão)" when it goes on over pages): its title,
/// its columns, its header and its cells.
#let data-table(caption, columns, header, label: none, ..cells) = {
  counter("manual-table").step()
  package-lib.fitted(caption: caption, label: label,
    table(columns: columns, align: left + horizon, table.header(..header.map(strong)), ..cells))
}

/// The packages the sources of the package import, with their versions, read from src/: `(name, version)` pairs.
#let dependencies = {
  let sources = ("abntly", "elements", "structure", "words").map(f => read("../../src/" + f + ".typ")).join()
  sources.matches(regex("@preview/([a-z0-9-]+):([0-9.]+)")).map(m => m.captures).dedup().sorted()
}

// ---------- examples ----------
/// What the examples can use (`eval` does not see the scope of a file): the package, in both languages.
#let example-scope = dictionary(package-lib)

// Inside an example, or inside the frame of a block of code, the rule of the code of the manual stands back: the code
// of an example is set by `_code-part`, and what the example gives, a block of code too, as the package sets it
#let _in-example = state("manual-in-example", false)
#let _inside(body) = {
  _in-example.update(true)
  body
  _in-example.update(false)
}

// The counters of the manual itself, which an example leaves as it found them: its tables (`data-table`) and its
// headings (`chapter` counts them). They are counted apart, only by steps: an example that read the counters of the
// figures and of the headings to put them back would depend on the example before it, and so on up the manual,
// which the compiler does not follow beyond five steps.
#let _tables = counter("manual-table")
#let _headings = counter("manual-heading")

// The body of a work again, inside an example: tidy evaluates the preview inside the `raw` of the example, which
// sets the mono, its size, no hyphenation and the English of code. The counters start again, so that every example
// has its "Figura 1", and the example stands in the first chapter of its work, so that an equation numbered by
// chapter is "(1.1)"; after it, the counters of the manual are back.
#let _as-text(lang, body) = context {
  set text(font: families.serif, size: work-body, lang: lang, region: if lang == "pt" { "br" } else { none },
    hyphenate: auto, top-edge: 1em, bottom-edge: "baseline")
  set par(leading: line-spacing - 1em, spacing: line-spacing - 1em + paragraph-skip, justify: true,
    first-line-indent: (amount: indent, all: true))
  for kind in (image, table, raw, "quadro") { counter(figure.where(kind: kind)).update(0) }
  counter(math.equation).update(0)
  counter(footnote).update(0)
  counter(heading).update(1)
  // (a code block in the result is the one the package gives, without the numbered lines of the manual)
  no-codly(body)
  counter(heading).update(_headings.get())
  counter(figure.where(kind: table)).update(_tables.get())
}

// The frame of an example and its parts, the code and what it gives. With a long code (`_long`) the frame breaks
// over pages, the code line by line, what it gives as a whole; a short one stays whole, the code with what it
// gives.
#let _long(code) = code.text.split("\n").len() > 20
#let _example(..parts) = api.frame(..api.code-frame, inset: 0pt, clip: true, above: 1.4em, below: 1.4em,
  breakable: true, ..parts)
#let _part(body, ..args) = block(width: 100%, inset: 8pt, above: 0pt, below: 0pt, breakable: false, ..args, body)
// the code fills its part edge to edge, with its numbered lines, in the reduced body, single-spaced
#let _code-part(code) = block(width: 100%, above: 0pt, below: 0pt, {
  set text(size: small)
  set par(leading: single-spacing - 1em, justify: false, first-line-indent: 0pt)
  set block(above: 0pt, below: 0pt)
  code
})

/// The layout of an example evaluated in the manual: the code, and under it the result, set at the width of the
/// text block of a work, so that its lines break as the author will see them, and reduced to the frame.
// (tidy sets the example a third larger: the code takes that factor back, so that it has the size of every code)
#let example-layout(lang: "pt", code, preview, ..options) = _example(breakable: _long(code), _inside({
  _code-part(text(size: 0.75em, code))
  _part(stroke: (top: api.code-frame.stroke), inset: (x: 8pt, y: 10pt), layout(size => {
    let factor = calc.min(1, size.width / work-width)
    scale(factor * 100%, origin: top + left, reflow: true, block(width: work-width, _as-text(lang, preview)))
  }))
}))

// The rules of the code of the manual: a block of code in a frame, with its lines numbered by the package codly; a
// short block stays whole, a long one breaks over pages; an example (a block marked `example`) is evaluated where
// it stands.
#let _code-rules(lang, body) = {
  show raw.where(block: true): it => context if _in-example.get() { it } else {
    _example(breakable: _long(it), _inside(_code-part(it)))
  }
  show: tidy.render-examples.with(scope: example-scope, layout: example-layout.with(lang: lang))
  body
}

/// The pages of a small work with its code: `examples/<name>.<lang>.typ` is compiled by scripts/manual.sh to
/// `examples/out/<name>.<lang>-<n>.svg`. Only what follows the marker line is shown, so the code and the pages
/// cannot drift apart. One whole page stands beside the code, whose lines have half the frame (43 letters);
/// several pages go in a row under the code; a part of each page (`crop`: the fractions of its height where the
/// part starts and ends, `(0, 0.4)` for the top of the page) goes under the code too, as wide as the frame, so that
/// its text can be read, the parts one under the other.
// (The examples have no number and no title: the text introduces the example that follows it.)
#let _marker = "// --- example ---"
#let page-example(name, pages: (1,), crop: none, lang: "pt") = {
  let source = read("examples/" + name + "." + lang + ".typ")
  let shown = source.slice(source.position(_marker) + _marker.len()).trim("\n")
  let beside = pages.len() == 1 and crop == none
  let width = if beside { 43 } else { 92 }
  let long = shown.split("\n").filter(line => line.clusters().len() > width)
  assert(long.len() == 0, message: "page-example: " + name + "." + lang + ".typ has lines of more than "
    + str(width) + " letters: " + repr(long))
  let code = raw(shown, lang: "typ", block: true)
  let picture(n, ..size) = image("examples/out/" + name + "." + lang + "-" + str(n) + ".svg", ..size)
  // a page, or the part of it between two fractions of its height (an A4 page: its height from its width; the
  // picture with both, or it would shrink to the height of the part)
  let sheet(n) = if crop == none { box(stroke: 0.5pt + luma(170), picture(n, width: 100%)) } else {
    layout(size => {
      let height = size.width * 297 / 210
      box(stroke: 0.5pt + luma(170), clip: true, width: size.width, height: height * (crop.last() - crop.first()),
        place(top + left, dy: -height * crop.first(), picture(n, width: size.width, height: height)))
    })
  }
  mark("page-example", (name, pages))
  if beside {
    _example(_inside(grid(columns: (1fr, 1fr), stroke: (x, _) => if x == 1 { (left: api.code-frame.stroke) },
      _code-part(code), grid.cell(fill: luma(245), align: horizon, _part(sheet(pages.first()))))))
  } else {
    _example(breakable: _long(code), _inside({
      _code-part(code)
      // whole pages in a row; parts of pages one under the other, each as wide as the frame
      _part(fill: luma(245), stroke: (top: api.code-frame.stroke), grid(
        columns: if crop == none { (1fr,) * pages.len() } else { 1 }, gutter: 8pt, ..pages.map(sheet)))
    }))
  }
}

/// An entry of the `.bib` of the manual and the reference it gives in the list, in a frame as an example: the entry
/// as it is written in the file, and under it the reference (`cite` in its full form, which also puts the work in
/// the list of references at the end of the manual).
#let bib-file = read("examples/refs.bib")
#let bib-example(key, lang: "pt") = {
  let found = bib-file.match(regex("(?m)^@\\w+\\{" + key + ",[\\s\\S]*?^\\}"))
  assert(found != none, message: "bib-example: no entry " + key + " in docs/manual/examples/refs.bib")
  mark("bib-example", key)
  _example(breakable: false, _inside({
    _code-part(raw(found.text, lang: "bib", block: true))
    _part(stroke: (top: api.code-frame.stroke), inset: (x: 8pt, y: 10pt), {
      set par(leading: single-spacing - 1em, justify: false, first-line-indent: 0pt)
      set text(size: small * 1.08)
      // (the reference in black, as in the list: the call is a link, in the colour of the links)
      show text: set text(fill: black)
      cite(label(key), form: "full")
    })
  }))
}

// ---------- the reference of the API ----------
// The documented definitions of each language, parsed once, in one module: in Portuguese, the names of
// src/aliases.typ and the two functions with one name in both languages (`pt/extra.typ` has their help in
// Portuguese); in English, the modules of src/. tidy reads the syntax of the comments the editor reads too
// (`/// - name (type): ...`).
#let _parse(lang, sources) = {
  let docs = tidy.parse-module(sources.join("\n"), name: "abntly", label-prefix: "api-", scope: example-scope,
    old-syntax: true)
  // only what the package exports
  let public = dictionary(package-lib).keys()
  docs.functions = docs.functions.filter(f => f.name in public)
  docs.variables = docs.variables.filter(v => v.name in public)
  docs
}
#let modules = (
  pt: _parse("pt", (read("../../src/aliases.typ"), read("pt/extra.typ"))),
  en: _parse("en", ("abntly", "info", "words", "layout", "elements", "structure", "index", "citations").map(name =>
    read("../../src/" + name + ".typ"))),
)

#let _api-style(lang) = api.style + (
  show-example: tidy.show-example.show-example.with(layout: example-layout.with(lang: lang)),
)

/// The reference of the given definitions, in the given order, shown where the chapter introduces them: the
/// signature with the type of every parameter, and the parameters, a block each. The description of the function
/// (its `///` comment, the help of the editor) is left out by default: the text of the section has just said what
/// the function does, and the two would repeat each other; `description: true` shows it, for what
/// only the help has (the fields `with-info` gives, the keys of `config-names`).
#let reference(..names, description: false, lang: "pt") = {
  let names = names.pos()
  let docs = modules.at(lang)
  let show-part(definition, part: none, variable: false) = tidy.show-module(
    docs + (functions: if variable { () } else { (definition,) }, variables: if variable { (definition,) } else { () }),
    style: _api-style(lang) + (show-function: api.show-function.with(part: part)), first-heading-level: 2,
    show-module-name: false, show-outline: false, sort-functions: none, break-param-descriptions: true,
    local-names: (parameters: words.at(lang).parameters, default: words.at(lang).default,
      variables: words.at(lang).variables, argument: words.at(lang).argument))
  mark("reference", names)
  for name in names {
    let function = docs.functions.find(d => d.name == name)
    let variable = docs.variables.find(d => d.name == name)
    assert(function != none or variable != none, message: "reference: not documented: " + name)
    parbreak()
    if variable != none { show-part(variable, variable: true) } else {
      show-part(function)
      if description {
        parbreak()
        show-part(function, part: auto)
      }
      for (parameter, info) in function.args {
        if info.at("description", default: "") == "" { continue }
        parbreak()
        show-part(function, part: parameter)
      }
    }
    parbreak()
  }
}

/// Every public definition with the page of its reference. A definition no chapter documents has no label, so
/// leaving one out is an error of the compilation.
#let api-index(lang: "pt") = {
  let docs = modules.at(lang)
  let entries = (docs.functions.map(f => f.name + "()") + docs.variables.map(v => v.name)).sorted()
  api.plain(grid(columns: (1fr,) * 2, row-gutter: 0.8em, column-gutter: 1em, ..entries.map(shown => {
    let target = label("api-" + shown)
    link(target, text(font: api.mono, size: small, shown)) + context [ #h(0.3em) #text(fill: luma(110), size: small)[#words.at(lang).page #counter(page).at(target).first()]]
  })))
}

// ---------- shells ----------
/// The first line of every chapter, with its title and its label: the title, then the chapter, with the frames of
/// the code and the examples evaluated where they stand.
#let chapter(body, title: none, id: none, lang: "pt") = {
  // code: by the package codly, with its lines numbered; the frame and the examples are rules after codly's, so
  // that they take the `raw` first
  show: codly-init.with()
  codly(display-name: false, display-icon: false, languages: (:), fill: luma(250), zebra-fill: luma(243),
    stroke: none, radius: 0pt, inset: (x: 0.6em, y: 0.28em), smart-indent: true, breakable: true,
    number-format: n => text(fill: luma(140), size: 0.85em, str(n)))
  show: _code-rules.with(lang)
  // the headings of the manual, counted apart for the examples (`_headings`)
  show heading: it => {
    if it.numbering != none { _headings.step(level: it.level) }
    it
  }
  [#heading(level: 1, title)#id]
  body
}

// The summary of the first page: the chapters and their sections, each a link, with its page, in two columns of
// the same number of entries; compact, where the summary of a work (`outline`, as the package sets it) would take a
// page of its own.
#let _contents(lang) = context {
  // (the references, a primary heading without a number, among them)
  let entries = query(heading).filter(h => h.outlined and (h.level == 1 or (h.level == 2 and h.numbering != none)))
  let entry(head) = {
    let at = head.location()
    let number = if head.numbering != none { numbering(head.numbering, ..counter(heading).at(at)); h(0.6em) }
    let line = { number; head.body; h(0.4em); box(width: 1fr, repeat[.]); h(0.4em)
      str(counter(page).at(at).first()) }
    if head.level == 1 {
      block(above: 0.9em, below: 0.62em, link(at, text(font: api.sans, weight: "bold", fill: black, line)))
    } else {
      block(above: 0.62em, below: 0.62em, pad(left: 1.2em, link(at, text(size: small, fill: black, line))))
    }
  }
  let half = calc.ceil(entries.len() / 2)
  api.plain(grid(columns: (1fr, 1fr), column-gutter: 1cm,
    entries.slice(0, half).map(entry).join(), entries.slice(half).map(entry).join()))
}

/// The shell of the PDF: the work the package sets, with a smaller body; on its first page, what identifies the
/// package (its name, what it is for, the version and its date, the repository, the author), then the presentation,
/// centred, without a title of its own, and the summary; then the chapters.
#let project(title: "", subtitle: none, author: "", date: none, abstract: none, lang: "pt", body) = {
  show: package-lib.abntly.with(lang: lang, info: package-lib.config-info(title: title, subtitle: subtitle,
    author: author))
  set text(size: body-size)
  v(3em)
  api.plain(align(center, {
    set text(font: api.sans)
    block(text(weight: "bold", size: 2em, fill: accent, title))
    block(text(size: 1.1em, subtitle))
    v(2.5em, weak: true)
    [v#package.version #h(1.2cm) #date]
    block(link(package.repository))
    block(strong(author))
  }))
  v(2.5em, weak: true)
  api.plain(pad(x: 3.8em, align(center, abstract)))
  v(3em, weak: true)
  block(above: 1.6em, below: 0.9em, text(font: api.sans, size: 1.3em, weight: "bold", words.at(lang).contents))
  _contents(lang)
  body
}
