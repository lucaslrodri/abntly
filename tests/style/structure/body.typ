/// Subject: Estrutura do trabalho
// The pages of the structure that print the data of the work (src/structure.typ): the cover, with the institution and
// the programme above the author; the title page, with the nature of the work and the area of concentration from the
// middle of the text block to the right margin and the two advisors; the catalog card on its verso; the approval
// sheet, with the board of three; the card and the sheet final (`draft: false`), without the stamp of a draft. The
// data are those of info.typ, which the case gives to `setup`. A first chapter after them, as in a work.
#import "../../../src/lib.typ": cover, title-page, catalog-card, approval-page

#cover()
#title-page[Tese apresentada ao Programa de Pós-Graduação da Universidade do Brasil, como requisito parcial para a
  obtenção do título de Doutor.]
#catalog-card(draft: false)
#approval-page(draft: false, date: [30 de setembro de 2026],
  (title: [Prof. Dr.], name: [Nome do Orientador], role: [Orientador], institution: [Universidade do Brasil]),
  (title: [Prof. Dr.], name: [Nome do Convidado 1], role: [Convidado 1], institution: [Instituição do convidado]),
  (title: [Prof. Dr.], name: [Nome do Convidado 2], role: [Convidado 2], institution: [Instituição do convidado]))

= Introdução

#lorem(30)
