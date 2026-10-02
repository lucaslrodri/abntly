#import "../prelude.typ": *
#show: chapter.with(title: [Elementos além da norma], id: <extras>)

Este capítulo descreve os elementos que as normas da ABNT não definem, mas que são comuns em trabalhos acadêmicos:
algoritmos, subfiguras, partes, figuras deitadas e carimbos. O algoritmo e as subfiguras são ilustrações e seguem
as regras da @figures[Seção]. Para os demais, a apresentação é uma decisão do pacote #pill("decision").

== Algoritmos <algorithms>

#norm-box("NBR 14724:2024, 5.8", "decision")[
  A norma não trata de algoritmos, mas a lista de palavras designativas das ilustrações é aberta. Como qualquer
  ilustração, o algoritmo tem a palavra designativa, o número, o travessão e o título acima, e a fonte abaixo.
]

A função `algoritmo` gera uma ilustração de código ou de pseudocódigo, com a palavra "Algoritmo" e numeração
própria. Ela aceita os mesmos argumentos de `figure`. O código é escrito em um bloco de código do Typst, e a fonte
é indicada com `fonte`, como no exemplo a seguir. Um algoritmo longo continua na página seguinte.

````example
#algoritmo(caption: [Média de uma lista de números])[
  ```python
  def media(valores):
      total = 0
      for v in valores:
          total = total + v
      return total / len(valores)
  ```
  #fonte()
]
````

Para gerar a lista de algoritmos, use `lista-de(raw, titulo: [Lista de algoritmos])` (@lists[Seção]).

#reference("algoritmo")

== Subfiguras <subfigures>

#norm-box("NBR 14724:2024, 5.8", "decision")[
  A norma não trata de figuras compostas por partes. O conjunto segue as regras das ilustrações: o título acima e a
  fonte, a legenda e as notas abaixo.
]

A função `subfiguras` gera uma figura composta por partes. Cada parte é uma `figure`, seguida do seu rótulo. O
título do conjunto fica acima, e o título de cada parte, abaixo dela, precedido de uma letra. A fonte do conjunto
é informada depois das partes. A remissão a uma parte gera o número do conjunto e a letra, como no
exemplo a seguir. A função não pode ser usada dentro de `ajustada`.

```example
#subfiguras(
  figure(rect(width: 5cm, height: 2.5cm, fill: luma(200)),
    caption: [Região Norte]), <sub-norte>,
  figure(rect(width: 5cm, height: 2.5cm, fill: luma(200)),
    caption: [Região Sul]), <sub-sul>,
  titulo: [Trabalhos defendidos em duas regiões],
  rotulo: <sub-regioes>,
)[
  #fonte[IBGE (2025).]
]

A Figura @sub-regioes compara a Região Norte (Figura
@sub-norte) com a Região Sul (Figura @sub-sul).
```

#reference("subfiguras")

== Partes <parts>

A função `parte` gera a página de abertura de uma parte, uma divisão do texto acima das seções primárias. A
página não tem cabeçalho nem número e exibe a palavra "Parte", o número em algarismos romanos e o título. A seção
primária seguinte começa em uma página nova, e a numeração das seções continua de uma parte para a outra, como no
exemplo a seguir.

#page-example("part", pages: (1, 2))

#reference("parte")

== Figuras e tabelas deitadas <sideways>

A função `deitada` gira uma figura ou uma tabela em 90°, em uma página própria. Ela é indicada para o conteúdo
mais largo que a mancha gráfica. A página permanece em pé, com as mesmas margens e o mesmo cabeçalho, e o texto
continua na página seguinte, como no exemplo a seguir.

#page-example("sideways", pages: (2,))

#reference("deitada")

== Carimbos <stamps>

A função `carimbo` gera uma marca-d'água para o fundo da página, como "RASCUNHO". Ela é usada no parâmetro
`background` da página: com `#set page(background: ...)`, o carimbo aparece em todas as páginas seguintes, como no
exemplo a seguir.

#page-example("stamp")

A ficha catalográfica e a folha de aprovação têm carimbos próprios, controlados pelo parâmetro `provisoria`
(@catalog-card[Seção] e @approval-page[Seção]).

#reference("carimbo")
