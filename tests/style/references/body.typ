/// Subject: Remissões
// Every form of a reference: to a figure, a table (a `fitted` with its label as a parameter), a section, an equation,
// a footnote and a page; only the number, the word written in the text (`Figura~@fig`) or given to the reference
// (`@fig[Figura]`), or found by `auto-ref`; the call of a note of a table (`call`). The cases of the subject set it
// with the links and without them.
#import "../../../src/lib.typ": fitted, source, note, call, auto-ref

= Remissões <cap>

Um texto com uma nota de rodapé.#footnote[A nota à qual o texto remete adiante.] <nota> A figura e a tabela vêm a
seguir.

#figure(rect(width: 6cm, height: 2cm, fill: black), caption: [Uma figura]) <fig>

#fitted(label: <tab>, caption: [Uma tabela])[
  #table(columns: (3cm, 3cm), align: (left, right),
    table.header([Região], [Valor]),
    [Sul #call(1)], [10],
    [Norte], [20])
  #source[IBGE (2025).]
  #note(call: 1)[Inclui o Paraná.]
]

Uma equação com rótulo:
$ E = m c^2 $ <eq>

== Uma seção <sec>

As remissões: a figura @fig, a Figura~@fig e a @fig[Figura]; a Tabela~@tab; a Seção~@sec e a @sec[Seção]; a
@eq e a @eq[Equação]; a nota @nota; com o nome, pela #auto-ref(<fig>), pela #auto-ref(<tab>), pelo #auto-ref(<cap>),
pela #auto-ref(<sec>), pela #auto-ref(<eq>), na nota #auto-ref(<nota>) e na #auto-ref(<fig>, form: "page")\; a figura
está na página #ref(<fig>, form: "page"), e a equação na página #ref(<eq>, form: "page").
