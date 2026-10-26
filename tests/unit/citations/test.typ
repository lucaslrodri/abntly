/// Synopsis: As chamadas e as referências (src/citations.typ): o CSL de cada sistema, a obra sem autor e a obra sem local, editora ou data
#import "../common.typ": *
#import "../../../src/citations.typ": *

// --- the CSL of each system and form ----------------------------------------------------------------------------------
#assert.eq(citation-systems, ("alf", "num", "overcite", "ieee"))
// one replacement, and only one
#assert.eq(swap("um dois três", "dois", "2"), "um 2 três")
#fails(() => swap("um um", "um", "1"), "abntly: the CSL has 2 of \"um\", expected one")
#fails(() => swap("um", "dois", "2"), "abntly: the CSL has 0 of \"dois\", expected one")

// the author-date call is the one of the file; the others have a block of their own
#assert.eq(citation("alf", "normal"), none)
#assert(citation("alf", "prose").contains("<text macro=\"sentence-names\"/><group prefix=\"(\" suffix=\")\""))
#assert(citation("alf", "author").ends-with("<text macro=\"sentence-names\"/></layout></citation>"))
#assert(citation("num", "normal").contains("<layout prefix=\"(\" suffix=\")\" delimiter=\", \">"))
#assert(citation("overcite", "normal").contains("<layout vertical-align=\"sup\" delimiter=\", \">"))
#assert(citation("ieee", "normal").contains("<layout prefix=\"[\" suffix=\"]\" delimiter=\", \">"))
#assert(citation("ieee", "prose").contains("<group prefix=\"[\" suffix=\"]\">"))
#assert(citation("num", "author").starts-with("<citation><layout delimiter=\"; \">"))
// the call without its parentheses, for the source consulted of an `apud`: the names, the year and the page in the
// author-date system, the number and the page in the numeric ones
#assert(citation("alf", "bare").contains("<layout delimiter=\"; \"><group delimiter=\", \"><text macro=\"call-names\"/>"))
#assert(not citation("alf", "bare").contains("prefix"))
#for system in ("num", "overcite", "ieee") {
  assert.eq(citation(system, "bare"), "<citation><layout delimiter=\", \"><group delimiter=\", \">"
    + "<text variable=\"citation-number\"/><text macro=\"citation-locator\"/></group></layout></citation>")
}

// every system and form gives a CSL; the numeric ones sort the list by the number of the call and open each entry
// with it
#for system in citation-systems {
  for form in ("normal", "prose", "author", "bare") {
    let style = str(style-of(system, form))
    assert(style.starts-with("<?xml"), message: system + " " + form)
    assert.eq(style.contains("<key variable=\"citation-number\"/>"), system != "alf", message: system + " " + form)
    assert.eq(style.contains("<text variable=\"citation-number\" suffix=\" \"/>"), system != "alf")
  }
}
#assert.eq(str(style-of("alf", "normal")), base)

// --- a work without an author -----------------------------------------------------------------------------------------
// how many words open the title: two after an article or a monosyllable
#assert.eq(lead(("Anteprojeto", "de", "lei")), 1)
#assert.eq(lead(("A", "flor", "do", "campo")), 2)
#assert.eq(lead(("Nos", "canaviais")), 2)
#assert.eq(lead(("The", "book")), 2)
#assert.eq(lead(("A",)), 1)

// the title in a call: its opening words and "[...]", without the subtitle; a short title whole; one already cut
#assert.eq(title-call("Anteprojeto de lei"), "Anteprojeto [...]")
#assert.eq(title-call("A flor do campo: um estudo"), "A flor [...]")
#assert.eq(title-call("Nos canaviais, mutilação"), "Nos canaviais [...]")
#assert.eq(title-call("Brasil"), "Brasil")
#assert.eq(title-call("O Brasil"), "O Brasil")
#assert.eq(title-call("Pequena [...]"), "Pequena [...]")
#assert.eq(title-call(""), "")

// the title that opens an entry: its opening words in capitals
#assert.eq(title-entry("Anteprojeto de lei"), "ANTEPROJETO de lei")
#assert.eq(title-entry("Os grandes clássicos"), "OS GRANDES clássicos")
#assert.eq(title-entry("Brasil"), "BRASIL")

// the highlight of a title ends at its subtitle
#assert.eq(title-split(strong("Título: subtítulo")), strong("Título") + ": subtítulo")
#assert.eq(title-split(emph("Título: subtítulo: mais")), emph("Título") + ": subtítulo: mais")
#assert.eq(title-split(strong("Título")), strong("Título"))
#assert.eq(title-split(strong[Título: #box[subtítulo]]), strong[Título: #box[subtítulo]])

// --- the citation of a citation ---------------------------------------------------------------------------------------
// what `apud` refuses; the case tests/unit/apud sets what it writes
#fails(() => apud([Cagliari], 1986, "suassuna1995"), "apud: the source consulted is a key of the .bib")
#fails(() => apud([Cagliari], 1986, <suassuna1995>, form: "author"), "apud: form is \"normal\" or \"prose\"")

// --- a work without place, publisher or date --------------------------------------------------------------------------
// "[S. l.]", "[s. n.]", "[s. d.]" and their combinations, "[S. l.: s. n.]": each abbreviation in italics, with a
// non-breaking space inside it, so that a line never breaks between its letters; the brackets, the colon and the comma
// upright. hayagriva writes the affixes of a `text` inside its italics, and the rule that ends the highlight of a title
// at its subtitle (`title-split`, above) then ended the italics at the ": " of "[S. l.: s. n.]", and "s. n." came out
// upright; so no text in italics has affixes, and the brackets and the separators belong to a `group`
#let italics = base.matches(regex("<text [^>]*font-style=\"italic\"[^>]*/>")).map(m => m.text)
#assert(italics.len() > 0)
#for t in italics { assert(not t.contains("prefix=") and not t.contains("suffix="), message: t) }
#assert.eq(base.matches(regex("[Ss]\\. [lnd]\\.")).len(), 0)

// what the list writes, read by a rule on `emph` that notes, for each work, every piece in italics: a reference in
// the form "full" (the entry of the list) and a call in the author-date system, of the work without a date
#show: citations
#let missing = bytes(```yaml
sem-local-editora:
  type: book
  title: Livro sem local nem editora
  author: Almeida, Ana
  date: 2020
sem-local:
  type: book
  title: Livro sem local
  author: Barros, Bruno
  publisher: Editora Exemplo
  date: 2020
sem-editora:
  type: book
  title: Livro sem editora
  author: Costa, Carla
  publisher:
    location: Rio Branco
  date: 2020
sem-data:
  type: book
  title: Livro sem data
  author: Dias, Daniel
  publisher:
    name: Editora Exemplo
    location: Rio Branco
artigo-sem-local:
  type: article
  title: Artigo sem local
  author: Esteves, Elisa
  date: 2020
  page-range: 10-20
  parent:
    type: periodical
    title: Revista Exemplo
    volume: 2
    issue: 3
postagem-sem-local:
  type: article
  title: Postagem sem local
  author: Farias, Fábio
  date: 2020-03-05
  parent:
    type: blog
    title: Blog Exemplo
postagem-sem-local-data:
  type: article
  title: Postagem sem local nem data
  author: Gomes, Gabriela
  parent:
    type: blog
    title: Blog Exemplo
documento-sem-local-editora-data:
  type: misc
  title: Documento sem local, editora nem data
  author: Horta, Hugo
manuscrito-sem-local:
  type: manuscript
  title: Manuscrito sem local
  author: Isidoro, Irene
  date: 1890
```.text)
#let noted(name, body) = {
  show emph: it => [#metadata((name, text-of(it.body)))<missing>#it]
  body
}
#for key in str(missing).matches(regex("(?m)^([a-z-]+):$")).map(m => m.captures.first()) {
  noted(key, par(cite(label(key), form: "full")))
}
#noted("chamada", par(cite(<sem-data>)))
#bibliography(missing)

#context {
  let got = (:)
  for note in query(<missing>) {
    let (name, piece) = note.value
    got.insert(name, got.at(name, default: ()) + (piece,))
  }
  let (sl, Sl, sn, sd) = ("s.\u{A0}l.", "S.\u{A0}l.", "s.\u{A0}n.", "s.\u{A0}d.")
  assert.eq(got, (
    // "[S. l.: s. n.], 2020"
    sem-local-editora: (Sl, sn),
    // "[S. l.]: Editora Exemplo, 2020", one space before the bracket
    sem-local: (Sl,),
    // "Rio Branco: [s. n.], 2020"
    sem-editora: (sn,),
    // "Rio Branco: Editora Exemplo, [s. d.]"
    sem-data: (sd,),
    // "Revista Exemplo, [s. l.], v. 2"
    artigo-sem-local: (sl,),
    // "In: Blog Exemplo. [S. l.], 5 mar. 2020"
    postagem-sem-local: ("In", Sl),
    // "In: Blog Exemplo. [S. l., s. d.]"
    postagem-sem-local-data: ("In", Sl, sd),
    // "[S. l.: s. n., s. d.]"
    documento-sem-local-editora-data: (Sl, sn, sd),
    // "[S. l.], 1890"
    manuscrito-sem-local: (Sl,),
    // "(Dias, [s. d.])"
    chamada: (sd,),
  ))
}
