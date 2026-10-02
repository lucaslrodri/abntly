/// Synopsis: Os nomes em português (src/aliases.typ): cada função devolve o mesmo que a função em inglês, e recusa em português
#import "../common.typ": *
#import "../../../src/lib.typ": *
#import "../../../src/aliases.typ": translated, positional, number-modes

// a function in Portuguese gives what the English one gives with the same arguments
#let same(pt, en) = assert.eq(pt, en)

// --- the values and the collectors ------------------------------------------------------------------------------------
#assert.eq(translated(number-modes, "rotulo", "campo"), "label")
#assert.eq(translated(number-modes, "linha", "campo"), "line")
#fails(() => translated(number-modes, "label", "trabalho-academico: modo"),
  "trabalho-academico: modo deve ser \"rotulo\" ou \"linha\"; recebido: \"label\"")
#let collect(..args) = positional(args, "funcao", "as entradas")
#assert.eq(collect(1, 2), none)
#fails(() => collect(1, nome: 2), "funcao: recebe as entradas; recebido: (nome: 2)")

// --- the main function and the data -----------------------------------------------------------------------------------
#assert.eq(indigo-escuro, dark-indigo)
#same(config-nomes(chapter: "Unidade"), config-names(chapter: "Unidade"))
#same(
  config-dados(titulo: [T], subtitulo: [S], autor: "Nome do Autor", orientador: (nome: "Ana", genero: "f"),
    coorientador: "Beto", instituicao: [U], programa: [P], area: [A], ano: 2026, local: [L], versao: [V], volume: 2,
    tipo: "tese", marca: [M]),
  config-info(title: [T], subtitle: [S], author: "Nome do Autor", advisor: (name: "Ana", gender: "f"),
    co-advisor: "Beto", institution: [U], program: [P], area: [A], year: 2026, location: [L], version: [V],
    volume: 2, work-type: "thesis", logo: [M]))
#fails(() => config-dados(title: [T]), "config-dados: campo desconhecido")
#fails(() => config-dados([T]), "config-dados: campo desconhecido")

#assert.eq(type(trabalho-academico(dados: config-dados(titulo: [T]), idioma: "en", nomes: config-nomes(),
  frente-e-verso: true, hiperlink: none, tamanho-da-fonte-da-tabela: 1em, numeracao-das-equacoes: "(1)",
  modo-de-numeracao-das-equacoes: "linha", sistema-de-citacao: "num")[corpo]), content)
#fails(() => trabalho-academico(modo-de-numeracao-das-equacoes: "label")[corpo],
  "trabalho-academico: modo-de-numeracao-das-equacoes deve ser \"rotulo\" ou \"linha\"")
#fails(() => trabalho-academico(idioma: "es")[corpo], "abntly: lang must be")

// --- the parts of the work and the elements of the text ---------------------------------------------------------------
#same(pretextual[corpo], front-matter[corpo])
#same(textual[corpo], main-matter[corpo])
#same(postextual[corpo], back-matter[corpo])
#same(fonte[IBGE.], source[IBGE.])
#same(fonte(), source())
#same(legenda[Azul.], legend[Azul.])
#same(nota[Uma.], note[Uma.])
#same(nota(palavra: [Notas], chamada: 1)[Duas.], note(word: [Notas], call: 1)[Duas.])
#same(quadro(caption: [Q])[corpo], frame(caption: [Q])[corpo])
#same(preambulo[Tese.], preamble[Tese.])
#same(algoritmo(caption: [A])[corpo], algorithm(caption: [A])[corpo])
#same(carimbo(nota: [n], cor: blue, angulo: 30deg, tamanho: 2em)[R], stamp(note: [n], color: blue, angle: 30deg,
  size: 2em)[R])
#let member = (title: [Dr.], name: [Fulano], institution: [U])
#same(assinatura(member), signature(member))
#fails(() => assinatura(membro: member), "assinatura: recebe os membros da banca")

#same(chamada(1), call(1))
// (the box of a `fitted` measures inside a function of the layout, which is never equal to another: by what they
// are written as)
#same(repr(ajustada(largura: 5cm, rotulo: <a>, caption: [F], rect())),
  repr(fitted(width: 5cm, label: <a>, caption: [F], rect())))
#same(parte[Título], part[Título])
#same(deitada[corpo], sideways[corpo])
#same(subfiguras(figure(rect(), caption: [a]), colunas: 1, espaco: 2em, titulo: [S], rotulo: <s>),
  subfigures(figure(rect(), caption: [a]), columns: 1, gutter: 2em, caption: [S], label: <s>))

// --- the pages of the structure ---------------------------------------------------------------------------------------
#same(capa(topo: [T], meio: [M], pe: [P], altura-do-meio: 50%), cover(top: [T], middle: [M], bottom: [P],
  middle-height: 50%))
#same(capa(), cover())
#same(folha-de-rosto(topo: [T], meio: [M], pe: [P], altura-do-meio: 80%)[Tese.],
  title-page(top: [T], middle: [M], bottom: [P], middle-height: 80%)[Tese.])
#same(folha-de-aprovacao(member, data: [1º de outubro], topo: [T], meio: [M], pe: [P], altura-do-meio: 83%,
    provisoria: false),
  approval-page(member, date: [1º de outubro], top: [T], middle: [M], bottom: [P], middle-height: 83%, draft: false))
#same(ficha-catalografica(ficha: [F], provisoria: false), catalog-card(card: [F], draft: false))
#same(ficha-catalografica(), catalog-card())
#same(dedicatoria[corpo], dedication[corpo])
#same(agradecimentos[corpo], acknowledgments[corpo])
#same(epigrafe[corpo], epigraph[corpo])
#same(resumo(idioma: "en", titulo: [Abstract])[corpo], abstract(lang: "en", title: [Abstract])[corpo])
#same(palavras-chave("a", "b", separador: ", ", fim: "!", rotulo: [Rótulo]),
  keywords("a", "b", sep: ", ", end: "!", label: [Rótulo]))
#same(lista-de(raw, titulo: [Lista de algoritmos]), list-of(raw, title: [Lista de algoritmos]))
#same(lista-de-figuras(), list-of-figures())
#same(lista-de-tabelas(), list-of-tables())
#same(lista-de-quadros(), list-of-frames())
#same(lista-de-siglas(("ABNT", [Associação])), list-of-acronyms(("ABNT", [Associação])))
#same(lista-de-simbolos(($a$, [cateto])), list-of-symbols(($a$, [cateto])))
#same(apendice(divisoria: false)[corpo], appendix(divider: false)[corpo])
#same(anexo[corpo], annex[corpo])
#same(glossario(("Typst", [sistema])), glossary(("Typst", [sistema])))
#same(indice(("Termo", 1), colunas: 1, ordenar: false), index(("Termo", 1), columns: 1, sort: false))
#let reads = d => d.title
#same(com-dados(reads), with-info(reads))
// a named argument a collector would swallow is refused in Portuguese
#fails(() => folha-de-aprovacao(membro: member), "folha-de-aprovacao: recebe os membros da banca")
#fails(() => palavras-chave("a", sep: ","), "palavras-chave: recebe as palavras, e separador, fim e rotulo")
#fails(() => lista-de-siglas(sigla: "ABNT"), "lista-de-siglas: recebe as siglas")
#fails(() => lista-de-simbolos(simbolo: "a"), "lista-de-simbolos: recebe os símbolos")
#fails(() => glossario(termo: "a"), "glossario: recebe os termos")
#fails(() => indice(("Termo", 1), columns: 1), "indice: recebe as entradas, e colunas e ordenar")
// and the English function refuses its own, in English
#fails(() => capa(altura-do-meio: 3), "cover: middle-height is a ratio or a length")
#fails(() => apendice(divisoria: 1)[corpo], "appendix: divider is true or false")
