// What the unit tests share. A unit test is a case of Tytanic without a reference (`tests/unit/<module>/test.typ`,
// compile-only): it imports a module of src/ by its path, private functions and all, and checks what they return
// with `assert`; the case passes when the document compiles. What only the layout knows (a state, a counter, the
// words of the language) is checked inside a `context`.
//
// The errors of the package are checked with Tytanic's `catch`, which only Tytanic has: `fails` calls it when the
// case runs under Tytanic, and does nothing when the case is compiled by hand, which says so with the input
// `runner` (`typst compile --input runner=typst`).

#let under-tytanic = sys.inputs.at("runner", default: "tytanic") == "tytanic"

// `f`, a function without arguments, fails, and the message of its error has `message`
#let fails(f, message) = if under-tytanic {
  let got = catch(f)
  assert(got != none, message: "expected an error with " + repr(message) + ", and there was none")
  assert(got.contains(message), message: "expected an error with " + repr(message) + "; got " + repr(got))
}

// content as the text it prints, a line break as "\n", so that a comparison does not depend on how the content is
// nested (`[a b]` is three elements, and a string beside content is a sequence)
#let text-of(c) = {
  if c == none { return "" }
  if type(c) != content { return str(c) }
  if c.has("text") { return c.text }
  if c.func() == [ ].func() { return " " }
  if c.func() == linebreak { return "\n" }
  if c.func() == smartquote { return if c.double { "\"" } else { "'" } }
  if c.has("children") { return c.children.map(text-of).join("") }
  if c.has("body") { return text-of(c.body) }
  if c.has("child") { return text-of(c.child) }
  ""
}

// content without the `set` rules a function puts around it
#let bare(c) = {
  while c.has("child") { c = c.child }
  c
}

// What a show rule writes takes the room of what it must write: the way to check a reference or an entry, which no
// query reads. A check of the size, not of the letters: the figures of the font are all as wide as each other.
#let same-room(got, expected) = context {
  let (a, b) = (measure(got), measure(expected))
  assert(b.width > 0pt, message: repr(expected) + " takes no room")
  assert.eq(a, b, message: repr(got) + " takes " + repr(a) + ", and " + repr(expected) + " takes " + repr(b))
}
