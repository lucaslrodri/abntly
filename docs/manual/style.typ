// The manual of abntly: the style of the API reference, for tidy (`tidy.show-module(style:)`): the signature in a
// frame, one parameter per line with its default and its types in chips; then the description; then each parameter in a
// thin box with a legend on its border, `name: default` on the left and the types on the right. The frames take the
// colour of the links of the package (`dark-indigo`); the colours of the types are tidy's, those of the documentation
// of Typst.
//
// The manual is set by the package itself, whose rules reach everything inside it: the reference undoes those that
// are for the text of a work (the indent of the paragraphs, the 1.5 between the lines, the numbers of the headings).
#import "@preview/tidy:0.4.3"
#import "../../src/layout.typ": dark-indigo
#import "../../src/fonts.typ": families
#import "../../src/spacing.typ": single-spacing

#let mono = families.mono
#let sans = families.sans
#let accent = dark-indigo
#let frame-stroke = 0.75pt + accent
#let frame-radius = 4pt
// code and examples: a light border
#let code-frame = (stroke: 0.8pt + luma(225), radius: 3pt)
// the colour of a default value
#let default-color = rgb(181, 2, 86)
#let type-colors = tidy.styles.default.colors
// the size of what the reference sets in the mono: the reduced body of the package (10 pt in a body of 12)
#let small = 10em / 12

// The line box of the package goes from 1 em above the baseline down to the baseline (src/spacing.typ): a box with a
// fill around a word takes the height of the capitals and its descent back, so that the word stands in its middle.
#let boxed(body) = {
  set text(top-edge: "cap-height", bottom-edge: "baseline")
  body
}

// the paragraphs of the reference: no indent, not justified, single spacing
#let plain(body) = {
  set par(first-line-indent: 0pt, justify: false, leading: single-spacing - 1em, spacing: single-spacing - 1em + 0.5em)
  body
}

/// The frame of a signature; with `..code-frame`, of a block of code and of an example.
#let frame(body, ..args) = block(width: 100%, stroke: frame-stroke, radius: frame-radius, inset: 8pt, ..args, body)

/// A type, in a filled chip. Plain text, not `raw`, which the package sets in the size of the body.
#let show-type(type, style-args: (:)) = {
  let palette = if style-args.at("colors", default: auto) == auto { type-colors } else { style-args.colors }
  box(fill: palette.at(type, default: palette.at("default")), radius: 2pt, inset: (x: 3pt), outset: (y: 3pt),
    boxed(text(font: mono, size: 0.85em, fill: black, type)))
}
#let _types(types, style-args, sep: h(0.45em)) = types.map(t => show-type(t, style-args: style-args)).join(sep)
#let _default(value) = text(font: mono, fill: default-color, value)

/// The signature: the name, a parameter per line (a link to its box) with its default and its types, what returns.
#let show-parameter-list(fn, style-args: (:)) = frame(breakable: false, above: 1em, below: 1em, {
  set text(font: mono, size: small)
  set par(first-line-indent: 0pt, justify: false, leading: 0.55em, spacing: 0.55em)
  let lines = (text(fill: accent, weight: "bold", fn.name) + "(",)
  for (name, info) in fn.args {
    let documented = info.at("description", default: "") != "" or not style-args.omit-empty-param-descriptions
    let shown = strong(name)
    if style-args.enable-cross-references and documented {
      shown = link(label(style-args.label-prefix + fn.name + "." + name.trim(".")), shown)
    }
    // a paragraph per parameter, so that a long default goes on under itself, not back at the margin
    lines.push(pad(left: 1.2em, par(hanging-indent: 1.2em, {
      shown
      if "default" in info { ": " + text(fill: default-color, info.default) }
      if "types" in info { h(0.8em); _types(info.types, style-args) }
    })))
  }
  lines.push(")" + if fn.at("return-types", default: none) != none { " -> " + _types(fn.return-types, style-args) })
  stack(spacing: 0.75em, ..lines)
})

/// A parameter: a thin box with its legend ("Parâmetro", "Argument") over its top border.
#let show-parameter-block(function-name: none, name, types, content, style-args, show-default: false, default: none) = {
  let word = style-args.local-names.at("argument", default: [Argument])
  let legend = box(fill: white, inset: (x: 3pt), boxed(text(font: sans, size: 0.7em, fill: luma(90), word)))
  block(width: 100%, stroke: 0.6pt + luma(60), radius: 3pt, inset: (x: 8pt, top: 9pt, bottom: 8pt), above: 1.2em,
    below: 1.2em, breakable: style-args.break-param-descriptions, plain({
      place(top + left, dx: 4pt, dy: -9pt - 0.25em, legend)
      grid(columns: (1fr, auto), column-gutter: 1em, align: (left + horizon, right + horizon),
        [#text(font: mono, size: small, name)#if function-name != none and style-args.enable-cross-references { label(function-name + "." + name.trim(".")) }#if show-default { text(font: mono, size: small)[: #_default(default)] }],
        text(size: small, _types(types, style-args, sep: text(fill: luma(90))[ | ])))
      pad(left: 0.8em, top: 0.5em, text(size: small, content))
    }))
}

/// A function, in the parts the manual shows it in (a block each, so that its columns break between them): with no
/// `part`, its name as a heading (for the cross-references and the index; without a number and out of the summary)
/// and the signature; with `part: auto`, the description with its examples; with the name of a parameter, its box.
#let show-function(fn, style-args, part: none) = plain(if part == none {
  [#heading(level: style-args.first-heading-level + 1, numbering: none, outlined: false, bookmarked: true,
    text(font: mono, fn.name + "()"))#if style-args.enable-cross-references { label(style-args.label-prefix + fn.name + "()") }]
  (style-args.style.show-parameter-list)(fn, style-args: style-args)
} else if part == auto {
  tidy.utilities.eval-docstring(fn.description, style-args)
} else {
  let info = fn.args.at(part)
  (style-args.style.show-parameter-block)(
    part, info.at("types", default: ()), tidy.utilities.eval-docstring(info.at("description", default: ""), style-args),
    style-args, show-default: "default" in info, default: info.at("default", default: none),
    function-name: style-args.label-prefix + fn.name,
  )
})

/// A variable: its name and its type on a line, then the description.
#let show-variable(var, style-args) = plain({
  grid(columns: (1fr, auto), align: (left + bottom, right + bottom),
    [#heading(level: style-args.first-heading-level + 1, numbering: none, outlined: false, bookmarked: true,
      text(font: mono, var.name))#if style-args.enable-cross-references { label(style-args.label-prefix + var.name) }],
    if "type" in var { show-type(var.type, style-args: style-args) })
  tidy.utilities.eval-docstring(var.description, style-args)
})

/// The style, for `tidy.show-module(style:)`; the template adds `show-example`, since it has the layout of the
/// examples.
#let style = dictionary(tidy.styles.default) + (
  show-type: show-type, show-parameter-list: show-parameter-list, show-parameter-block: show-parameter-block,
  show-function: show-function, show-variable: show-variable,
)
