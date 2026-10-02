/// Synopsis: As palavras do pacote (src/words.typ): config-names, o idioma do texto e as palavras trocadas
#import "../common.typ": *
#import "../../../src/words.typ": *

// the keys are those of the Portuguese table of src/lang.toml, and the English table has them all
#assert.eq(keys, database.lang.pt.keys())
#assert.eq(database.lang.en.keys().sorted(), keys.sorted())
#assert("chapter" in keys and "own-work" in keys)

// --- config-names -----------------------------------------------------------------------------------------------------
#assert.eq(config-names(), (:))
#assert.eq(config-names(chapter: "Unidad", source: [Fuente]), (chapter: "Unidad", source: [Fuente]))
#fails(() => config-names("Unidad"), "config-names: takes only the words to replace, by key")
#fails(() => config-names(capitulo: "Unidad"), "config-names: unknown word \"capitulo\"; the words are chapter")

// --- the word of the language of the text -----------------------------------------------------------------------------
#let in-lang(lang, body) = {
  set text(lang: lang)
  context body()
}
#in-lang("pt", () => {
  assert.eq(word-raw("chapter"), "Capítulo")
  assert.eq(word-raw("own-work"), "Elaboração própria.")
})
#in-lang("en", () => {
  assert.eq(word-raw("chapter"), "Chapter")
  assert.eq(word-raw("contents"), "Contents")
})
// a language the package does not have falls back to Portuguese
#in-lang("fr", () => assert.eq(word-raw("chapter"), "Capítulo"))

// the words the author replaced win in any language; the others stay
#names.update(config-names(chapter: "Unidad", source: [Fuente]))
#in-lang("en", () => {
  assert.eq(word-raw("chapter"), "Unidad")
  assert.eq(word-raw("source"), [Fuente])
  assert.eq(word-raw("legend"), "Legend")
})

// `word` is content that reads the language where it lands
#assert.eq(word("chapter").func(), (context none).func())
