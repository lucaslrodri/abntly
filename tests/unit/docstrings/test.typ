/// Synopsis: Os doc-comments de src/ lidos pelo tidy: cada bloco `///` é marcação válida e cada parâmetro documentado existe
// Every `///` block of src/ must be read by tidy (its old syntax, `/// - name (type): ...`, the one the editor reads
// too): a documented parameter that is not in the signature, or a description that is not valid markup, fails here.
// The manual (docs/manual) shows these blocks.
#import "@preview/tidy:0.4.3"
#import "../../../src/lib.typ" as lib

// the examples of a description are evaluated with `eval`, which sees no file scope
#let scope = dictionary(lib)
// tidy's default example layout measures the preview and refuses relative widths
#let style = dictionary(tidy.styles.default) + (
  show-example: tidy.show-example.show-example.with(layout: (code, preview, ..options) => { code; preview }),
)

#let modules = ("abntly", "aliases", "elements", "index", "info", "layout", "spacing", "structure", "words",
  "citations")
#let parsed = modules.map(name => tidy.parse-module(read("../../../src/" + name + ".typ"), name: name, scope: scope,
  old-syntax: true))
#for docs in parsed {
  assert(docs.functions.len() + docs.variables.len() > 0, message: "nothing documented in " + docs.name)
  tidy.show-module(docs, style: style, omit-private-definitions: false, show-outline: false)
}

// The description of each public definition ends with its name in the other language: "In Portuguese: `capa`." in
// the modules in English, "Em inglês: `cover`." in src/aliases.typ (the manual shows it beside the name), and the
// two name each other.
#let public = dictionary(lib).keys()
#let twin(definition, lead) = {
  let found = definition.description.match(regex("(?:^|\n)[ \t]*" + lead + ": `([a-z-]+)`\\.\\s*$"))
  if found != none { found.captures.first() }
}
#let twins = (:)
#for docs in parsed {
  let lead = if docs.name == "aliases" { "Em inglês" } else { "In Portuguese" }
  for definition in docs.functions + docs.variables {
    if definition.name not in public { continue }
    let other = twin(definition, lead)
    assert(other != none, message: definition.name + " (src/" + docs.name + ".typ): its description does not end with \""
      + lead + ": `...`.\"")
    twins.insert(definition.name, other)
  }
}
#assert.eq(twins.keys().sorted(), public.sorted(), message: "every public definition is documented")
#for (name, other) in twins {
  assert(other in twins, message: name + ": " + repr(other) + " is not a public definition")
  assert.eq(twins.at(other), name, message: name + " names " + other + ", and " + other + " names "
    + twins.at(other))
}
