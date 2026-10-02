/// Synopsis: As chamadas e as referências (src/citations.typ): o CSL de cada sistema e a obra sem autor
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
