// The summary and the post-textual part (src/structure.typ, src/layout.typ): the summary of a work with three
// chapters, sections and a subsection; the references, written here by hand after `back-matter`; the glossary; two
// appendices and an annex, each group after its page. The cases postextual and postextual-two-sided include it after
// `setup`, and each writes the index (src/index.typ) after it, with the pages of its version, as the author of a work
// does: plain entries, one with a sub-heading, one on two pages apart, one with "ver".
#import "../../../src/lib.typ": back-matter, appendix, annex, glossary

#outline()

= Introdução

#lorem(30)

= Desenvolvimento

== As ilustrações

#lorem(20)

== As tabelas

#lorem(20)

=== As tabelas do IBGE

#lorem(20)#footnote[Uma nota com uma marca.]

= Conclusão

#lorem(30)

#show: back-matter

= Referências

AUTOR, N. do. *Título da obra*: subtítulo da obra consultada. Rio Branco: Editora, 2026.

#glossary(
  ("Typst", [sistema de composição tipográfica por marcação, com uma linguagem de programação própria]),
  ("imagem de referência", [página guardada de um caso de teste, com a qual a página de hoje é comparada]),
  ("mancha gráfica", [área da página dentro das margens, onde vai o texto]),
)

#show: appendix

= Roteiro das medidas

#lorem(30)

= Lista dos casos de teste

#lorem(20)

#show: annex

= Esquema 1 da NBR 14724

#lorem(20)
