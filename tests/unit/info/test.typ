/// Synopsis: Os dados do trabalho (src/info.typ): as pessoas, os nomes, config-info, o texto dos metadados
#import "../common.typ": *
#import "../../../src/info.typ": *
#import "../../../src/words.typ": names

// --- a person ---------------------------------------------------------------------------------------------------------
#assert.eq(person(none, "author"), none)
#assert.eq(person("Nome do Autor", "author"), (name: "Nome do Autor", surname: none, gender: "m", label: none))
#assert.eq(person([Nome do Autor], "author"), (name: [Nome do Autor], surname: none, gender: "m", label: none))
#assert.eq(person((name: "Lucas Lima", surname: "Rodrigues"), "author"),
  (name: "Lucas Lima", surname: "Rodrigues", gender: "m", label: none))
// the keys in Portuguese
#assert.eq(person((nome: "Ana", sobrenome: "Souza", genero: "f", rotulo: [Supervisora]), "advisor"),
  (name: "Ana", surname: "Souza", gender: "f", label: [Supervisora]))
#fails(() => person(3, "author"), "author is a name, as a string or content, or a dictionary")
#fails(() => person((nme: "x"), "advisor"), "advisor takes the keys name, surname, gender and label")
#fails(() => person((surname: "x"), "author"), "author has no name")
#fails(() => person((name: "x", gender: "x"), "co-advisor"), "the gender of co-advisor is \"m\" or \"f\"")

// --- the forms of a name ----------------------------------------------------------------------------------------------
#let named(name, surname: none) = (name: name, surname: surname, gender: "m", label: none)
#assert.eq(full-name(named("Nome do Autor")), "Nome do Autor")
#assert.eq(text-of(full-name(named("Lucas Lima", surname: "Rodrigues"))), "Lucas Lima Rodrigues")

// the surname the author gave; the last word of a string; with the one before it for a degree of kinship; none for
// content and for a single word
#assert.eq(name-parts(named("Lucas Lima", surname: "Rodrigues")), ("Rodrigues", "Lucas Lima"))
#assert.eq(name-parts(named("Nome do Autor")), ("Autor", "Nome do"))
#assert.eq(name-parts(named("Alexandre Assaf Neto")), ("Assaf Neto", "Alexandre"))
#assert.eq(name-parts(named("Waldyr  Grisard Filho")), ("Grisard Filho", "Waldyr"))
// two words with a degree of kinship: the last one alone is the surname
#assert.eq(name-parts(named("João Neto")), ("Neto", "João"))
#assert.eq(name-parts(named([Nome do Autor])), none)
#assert.eq(name-parts(named("Platão")), none)

#assert.eq(inverted-name(named("Nome do Autor")), "Autor, Nome do")
#assert.eq(text-of(inverted-name(named("Lucas Lima", surname: "Rodrigues"))), "Rodrigues, Lucas Lima")
#assert.eq(inverted-name(named([Nome do Autor])), [Nome do Autor])
#assert.eq(inverted-name(named("Platão")), "Platão")

#assert.eq(text-of(reference-name(named("Nome do Autor"))), "AUTOR, Nome do")
#assert.eq(text-of(reference-name(named("Lucas Lima", surname: "Rodrigues"))), "RODRIGUES, Lucas Lima")
#assert.eq(reference-name(named("Platão")), "Platão")

// the label of an advisor: the author's own needs no context; the word of the package by the gender
#assert.eq(role-label((label: [Supervisor], gender: "f"), "advisor"), [Supervisor])
#context {
  set text(lang: "pt")
  context {
    assert.eq(role-label((label: none, gender: "m"), "advisor"), "Orientador")
    assert.eq(role-label((label: none, gender: "f"), "advisor"), "Orientadora")
    assert.eq(role-label((label: none, gender: "f"), "co-advisor"), "Coorientadora")
  }
}

// --- config-info ------------------------------------------------------------------------------------------------------
#let empty = config-info()
#assert.eq(empty.keys(), ("title", "subtitle", "author", "advisor", "co-advisor", "institution", "program", "area",
  "year", "location", "version", "volume", "work-type", "logo"))
#assert.eq(empty.year, datetime.today().year())
#assert(empty.pairs().all(((key, value)) => key == "year" or value == none))

#let data = config-info(title: [Título], subtitle: "subtítulo", author: "Nome do Autor",
  advisor: (name: "Prof. Dr. Nome", surname: "Orientador", gender: "f"), institution: [Universidade], year: 2026,
  volume: 2, work-type: "tese", logo: [marca])
#assert.eq(data.author.name, "Nome do Autor")
#assert.eq(data.advisor.gender, "f")
#assert.eq(data.co-advisor, none)
#assert.eq(data.year, 2026)
// the type of the work: its Portuguese name, its English name, content, and no other string
#assert.eq(data.work-type, "thesis")
#assert.eq(config-info(work-type: "thesis").work-type, "thesis")
#assert.eq(config-info(work-type: "qualificacao-mestrado").work-type, "master-qualification")
#assert.eq(config-info(work-type: [Monografia]).work-type, [Monografia])
#assert.eq(config-info(year: "2026").year, "2026")

#fails(() => config-info([Título]), "config-info: takes only named fields")
#fails(() => config-info(titulo: [Título]), "config-info: unknown field \"titulo\"")
#fails(() => config-info(title: 3), "config-info: title is a string or content")
#fails(() => config-info(location: 3), "config-info: location is a string or content")
#fails(() => config-info(year: none), "config-info: year is a number, a string or content, or auto")
#fails(() => config-info(volume: 2.5), "config-info: volume is a number, a string or content")
#fails(() => config-info(logo: "marca.svg"), "config-info: logo is content")
#fails(() => config-info(work-type: "monografia"), "config-info: work-type is one of tcc, dissertation, thesis")
#fails(() => config-info(author: 3), "config-info: author is a name")

// the data again through config-info: its own result comes back the same; the empty dictionary is no data
#assert.eq(resolve((:)), none)
#assert.eq(resolve(data), data)
#assert.eq(resolve((title: [Título])).title, [Título])
#fails(() => resolve(none), "abntly: info comes from config-info(...)")
#fails(() => resolve((titulo: [T])), "config-info: unknown field \"titulo\"")

// --- what the pages print ---------------------------------------------------------------------------------------------
#assert.eq(full-title(config-info(title: [Título])), [Título])
#assert.eq(text-of(full-title(data)), "Título: subtítulo")
#assert.eq(text-of(year-volume(config-info(year: 2026))), "2026")
#assert.eq(text-of(year-volume(data)), "2026, v. 2")
#assert.eq(text-of(year-volume(config-info(year: 2026, volume: [tomo II]))), "2026, tomo II")

// the data in the state, with the fields a page asks for
#work.update(data)
#context {
  assert.eq(get("cover"), data)
  assert.eq(get("cover", "title", "author").title, [Título])
}

// the keywords of each language at the end of the work
#keywords.update(k => k + (pt: ("um", "dois")))
#context {
  assert.eq(keywords-of("pt"), ("um", "dois"))
  assert.eq(keywords-of("en"), ())
}

// --- content as plain text --------------------------------------------------------------------------------------------
#assert.eq(plain("texto"), "texto")
#assert.eq(plain(3), none)
#assert.eq(plain([texto]), "texto")
#assert.eq(plain([um dois]), "um dois")
#assert.eq(plain([um \ dois]), "um   dois")
#assert.eq(plain(["aspas" e 'aspas']), "\"aspas\" e 'aspas'")
#assert.eq(plain([*negrito* e _itálico_]), "negrito e itálico")
#assert.eq(plain(text(fill: red)[cor]), "cor")
#assert.eq(plain([]), "")
// what does not reduce to text: a box, a formula, alone or among text
#assert.eq(plain(box[caixa]), none)
#assert.eq(plain([texto #box[caixa]]), none)
#assert.eq(plain($x$), none)

// --- the metadata of the PDF ------------------------------------------------------------------------------------------
#assert.eq(metadata-of(none, none, (:), "pt"), (:))
#assert.eq(metadata-of(config-info(year: 2026), none, (:), "pt"), (:))
#let fields = metadata-of(data, [natureza], (en: ("one", "two"), pt: ("um", [dois \ dois], "um")), "pt")
#assert.eq(fields.keys(), ("title", "author", "description", "keywords"))
#assert.eq(text-of(fields.title), "Título: subtítulo")
#assert.eq(fields.author, "Nome do Autor")
#assert.eq(fields.description, [natureza])
// those of the language of the work first, once each, the spaces collapsed, then the institution
#assert.eq(fields.keywords, ("um", "dois dois", "one", "two", "Universidade"))
// the author with the surname apart; the name that is not text is left out
#assert.eq(metadata-of(config-info(author: (name: [Lucas Lima], surname: "Rodrigues")), none, (:), "pt"),
  (author: "Lucas Lima Rodrigues"))
#assert.eq(metadata-of(config-info(author: box[Autor]), none, (:), "pt"), (:))
#assert.eq(metadata-of(config-info(author: (name: box[Lucas], surname: "Rodrigues")), none, (:), "pt"), (:))
#assert.eq(metadata-of(config-info(program: "Programa", institution: box[x]), none, (:), "en"),
  (keywords: ("Programa",)))
