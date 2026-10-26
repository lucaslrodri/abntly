/// Synopsis: Uma cor para cada tipo de link (`config-hyperlinks`): o endereço sem link, a sigla em preto, os outros tipos cada um numa cor
// The kinds of link of src/layout.typ, each in a colour of its own, one with no link at all: the address without a
// link (`none`), the cross-reference in olive, the citation in purple, the summary in orange, the call of the footnote
// and its way back in red, the page of the index in teal, the acronym cited by key in black (still a link, to its line
// of the list).
#import "../../../common.typ": *
#import "../../../../src/lib.typ": config-hyperlinks, list-of-acronyms, index

#show: setup.with(hyperlink: config-hyperlinks(address: none, reference: olive, citation: purple, outline: orange,
  note: red, index: teal, glossary: black))

#outline()

#list-of-acronyms((key: "abnt", short: "ABNT", long: [Associação Brasileira de Normas Técnicas]))

= Introdução <intro>

Um endereço, #link("https://typst.app")[typst.app], sai sem link. Uma remissão à seção @intro, em verde-oliva; uma
citação, @almeida2020, em roxo; uma nota de rodapé#footnote[O número da nota volta à chamada, em vermelho.], em
vermelho; e as normas da @abnt, em preto, ainda com link para a linha da sigla na lista.

#bibliography(bytes(```yaml
almeida2020:
  type: book
  title: Um livro
  author: Almeida, Ana
  date: 2020
  publisher:
    name: Editora
    location: Rio Branco
```.text))

#index(("Remissão", 3))
