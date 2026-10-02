/// Subject: Elementos fora da norma
// The stamp, the nature of the work and the signature: a page of its own stamped "FOLHA PROVISÓRIA", with a note,
// an approval sheet with the nature of the work (`preamble`, NBR 14724, 4.2.1.3 and 5.2) and three signatures on it
// with what NBR 14724 (4.2.1.3) asks of each member of the board (the name, the title, the institution) and the role,
// one of them with the keys in Portuguese; then a chapter over two pages, every page from there
// stamped "RASCUNHO" (`set page(background: ...)`). The case stamp-signature includes it after `#show: setup`.
#import "../../../src/lib.typ": stamp, preamble, signature

#page(background: stamp(note: [A folha definitiva é assinada pela banca após a defesa])[FOLHA PROVISÓRIA])[
  #preamble[Tese apresentada ao Programa de Pós-Graduação da Universidade do Brasil, como requisito parcial para a
    obtenção do título de Doutor. Área de concentração: Nome da área.]

  Trabalho aprovado. Brasil, 30 de setembro de 2026.

  #signature(
    (title: [Prof. Dr.], name: [Fulano de Tal], role: [Orientador], institution: [Universidade do Brasil]),
    (titulação: [Prof. Dr.], nome: [Beltrano de Tal], papel: [Convidado], instituição: [Instituição do convidado]),
    (title: [Profa. Dra.], name: [Sicrana de Tal], role: [Convidada], institution: [Instituição da convidada]),
  )
]

#set page(background: stamp[RASCUNHO])

= Um capítulo em rascunho

#lorem(150)

#lorem(150)

#lorem(150)

#lorem(150)

#lorem(150)
