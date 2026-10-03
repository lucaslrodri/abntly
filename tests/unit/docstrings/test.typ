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

// The functions with one name in both languages (`auto-ref`, `errata`, `apud`) have their help in Portuguese in
// docs/manual/pt/extra.typ, which the manual in Portuguese shows: each one there has the parameters of the function
// itself, with the same defaults.
#let extra = tidy.parse-module(read("../../../docs/manual/pt/extra.typ"), name: "extra", old-syntax: true)
#let signature(f) = f.args.pairs().map(((name, info)) => (name, info.at("default", default: none)))
#assert.eq(extra.functions.map(f => f.name).sorted(), ("apud", "auto-ref", "errata"))
#for stub in extra.functions {
  let real = parsed.map(docs => docs.functions).flatten().find(f => f.name == stub.name)
  assert(real != none, message: "docs/manual/pt/extra.typ: no function " + stub.name + " in src/")
  assert.eq(signature(stub), signature(real), message: "docs/manual/pt/extra.typ: the parameters of " + stub.name
    + " are not those of the function")
}
