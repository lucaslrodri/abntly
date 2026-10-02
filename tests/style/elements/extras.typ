/// Subject: Elementos fora da norma
// The elements that no norm has but academic works use, as abntly sets them (src/elements.typ): the part (`part`),
// algorithms (`algorithm`, a figure of code) and subfigures (`subfigures`, over subpar). A short algorithm, one with a
// title of two lines, a long one over two pages; two equal parts with the source of the set, two parts of different
// heights, four parts with a long title, two parts with a source each; equations with and without a number (equate);
// a figure and a table lying down, turned 90° on an upright page. A case includes it after `#show: setup`.
#import "../../../src/lib.typ": source, legend, note, algorithm, subfigures, part, fitted, sideways

#set heading(numbering: "1.1")

#part[Elementos fora da norma]

= Algoritmos e subfiguras

Um algoritmo é uma ilustração como as outras: o título em cima, com a palavra designativa e o número, e a fonte
embaixo. O Algoritmo 1 calcula a média, como mostra o @media[Algoritmo].

#algorithm(caption: [Média de uma lista de números])[
  ```
def media(valores):
    """Devolve a média de uma lista de números."""
    total = 0
    for v in valores:
        total = total + v
    return total / len(valores)
  ```
  #source()
] <media>

Um título comprido quebra a linha e continua sob a primeira letra do texto.

#algorithm(caption: [Contagem dos trabalhos acadêmicos defendidos entre 2020 e 2024 por região do país e por área do conhecimento, a partir da base de dados])[
  ```
para cada trabalho t da base de dados:
    se t foi defendido entre 2020 e 2024:
        conte t na região e na área de t
devolva as contagens por região e por área
  ```
  #source()
]

// the long algorithm starts a page, so that where it breaks does not depend on the text before it
#pagebreak()
#algorithm(caption: [Contagem por região])[
  ```
def contagens(base):
    regioes = {}
    regioes["R01"] = contar(base, "R01")
    regioes["R02"] = contar(base, "R02")
    regioes["R03"] = contar(base, "R03")
    regioes["R04"] = contar(base, "R04")
    regioes["R05"] = contar(base, "R05")
    regioes["R06"] = contar(base, "R06")
    regioes["R07"] = contar(base, "R07")
    regioes["R08"] = contar(base, "R08")
    regioes["R09"] = contar(base, "R09")
    regioes["R10"] = contar(base, "R10")
    regioes["R11"] = contar(base, "R11")
    regioes["R12"] = contar(base, "R12")
    regioes["R13"] = contar(base, "R13")
    regioes["R14"] = contar(base, "R14")
    regioes["R15"] = contar(base, "R15")
    regioes["R16"] = contar(base, "R16")
    regioes["R17"] = contar(base, "R17")
    regioes["R18"] = contar(base, "R18")
    regioes["R19"] = contar(base, "R19")
    regioes["R20"] = contar(base, "R20")
    regioes["R21"] = contar(base, "R21")
    regioes["R22"] = contar(base, "R22")
    regioes["R23"] = contar(base, "R23")
    regioes["R24"] = contar(base, "R24")
    regioes["R25"] = contar(base, "R25")
    regioes["R26"] = contar(base, "R26")
    regioes["R27"] = contar(base, "R27")
    regioes["R28"] = contar(base, "R28")
    regioes["R29"] = contar(base, "R29")
    regioes["R30"] = contar(base, "R30")
    regioes["R31"] = contar(base, "R31")
    regioes["R32"] = contar(base, "R32")
    regioes["R33"] = contar(base, "R33")
    regioes["R34"] = contar(base, "R34")
    regioes["R35"] = contar(base, "R35")
    regioes["R36"] = contar(base, "R36")
    regioes["R37"] = contar(base, "R37")
    regioes["R38"] = contar(base, "R38")
    regioes["R39"] = contar(base, "R39")
    regioes["R40"] = contar(base, "R40")
    regioes["R41"] = contar(base, "R41")
    regioes["R42"] = contar(base, "R42")
    regioes["R43"] = contar(base, "R43")
    return regioes
  ```
  #source()
]

// the subfigures start a page
#pagebreak()
Duas partes do mesmo tamanho, com a fonte, a legenda e a nota do conjunto: a Figura~@norte e a Figura~@sul.

#subfigures(
  figure(rect(width: 5cm, height: 2.5cm, fill: black), caption: [Região Norte]), <norte>,
  figure(rect(width: 5cm, height: 2.5cm, fill: black), caption: [Região Sul]), <sul>,
  caption: [Trabalhos defendidos em duas regiões], label: <regioes>,
)[
  #source[IBGE (2025).]
  #legend[Barras: número de trabalhos.]
  #note[Os dados foram coletados durante o segundo semestre de 2024.]
]

Duas partes de alturas diferentes: os títulos ficam na mesma linha.

#subfigures(
  figure(rect(width: 5cm, height: 2cm, fill: black), caption: [Parte baixa]), <baixa>,
  figure(rect(width: 5cm, height: 3.5cm, fill: black), caption: [Parte alta]), <alta>,
  caption: [Partes de alturas diferentes], label: <alturas>,
)[
  #source()
]

// four parts and parts with a source each on a page of their own
#pagebreak()
Quatro partes, uma com um título comprido, que quebra na largura da parte.

#subfigures(
  figure(rect(width: 4cm, height: 2cm, fill: black), caption: [Uma parte com um título comprido que passa de uma
    linha]), <longa>,
  figure(rect(width: 4cm, height: 2cm, fill: black), caption: [Parte B]), <b>,
  figure(rect(width: 4cm, height: 2cm, fill: black), caption: [Parte C]), <c>,
  figure(rect(width: 4cm, height: 2cm, fill: black), caption: [Parte D]), <d>,
  columns: (4cm, 4cm), caption: [Quatro partes], label: <quatro>,
)[
  #source()
]

Duas partes, cada uma com a sua fonte.

#subfigures(
  figure([#rect(width: 4.5cm, height: 2cm, fill: black) #source[IBGE (2025).]], caption: [Parte com fonte]), <pa>,
  figure([#rect(width: 4.5cm, height: 2cm, fill: black) #source[INEP (2024), com uma fonte mais longa que a
    parte.]], caption: [Outra parte com fonte]), <pb>,
  columns: (4.5cm, 4.5cm), caption: [Uma fonte por parte], label: <fontes>,
)

// the equations and the pages lying down after a page break
#pagebreak()
== Equações com e sem número

Uma equação sem rótulo não tem número:
$ E = m c^2 $
#par(first-line-indent: (amount: 0pt, all: true))[com rótulo, ela é numerada por capítulo:]
$ F = m a $ <newton>
#par(first-line-indent: (amount: 0pt, all: true))[e, em várias linhas, só a linha com rótulo:]
$ (a + b)^2 &= (a + b)(a + b) \
            &= a^2 + 2 a b + b^2 #<quadrado> $
#par(first-line-indent: (amount: 0pt, all: true))[Como mostram a @newton e a @quadrado.]

== Figuras deitadas

Uma figura larga e uma tabela larga, deitadas: giradas 90° numa página em pé.

#sideways[
  #figure(caption: [Distribuição dos trabalhos por região e por ano, deitada])[
    #rect(width: 22cm, height: 8cm, fill: black)
    #source[IBGE (2025).]
  ]
]

#sideways[
  #fitted(caption: [Trabalhos defendidos por região e por ano, deitada])[
    #table(columns: (2cm, 1.4cm, 1.4cm, 1.4cm, 1.4cm, 1.4cm), align: (left, right, right, right, right, right),
      table.header([Região], [2020], [2021], [2022], [2023], [2024]),
      [Norte], [210], [230], [250], [260], [280],
      [Sul], [410], [420], [440], [450], [470])
    #source[IBGE (2025).]
  ]
]

O texto termina aqui.
