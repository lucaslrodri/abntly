#import "@preview/abntly:0.1.1": *

// um gráfico de barras simples, desenhado com as formas do Typst, para as figuras do exemplo
#let barras(..valores) = box(height: 3cm, stack(dir: ltr, spacing: 6mm, ..valores.pos().map(v => align(bottom,
  rect(width: 1cm, height: v * 1mm, fill: luma(150))))))

= Elementos do texto <cap-elementos>

Este capítulo mostra como os elementos do texto são escritos e como o pacote os apresenta. As regras de cada
elemento estão na seção 5 da @nbr 14724:2024 e nas normas que ela cita.

== Seções

As seções são numeradas progressivamente, até a seção quinária. O título de uma seção primária começa em uma página
nova, e os níveis são destacados pelo tamanho da fonte.

=== Seção terciária

Texto de uma seção terciária.

==== Seção quaternária

Texto de uma seção quaternária.

===== Seção quinária

Texto de uma seção quinária.

== Alíneas

Os assuntos que não têm título próprio são divididos em alíneas:
+ o texto que antecede as alíneas termina em dois-pontos;
+ cada alínea começa por letra minúscula e termina em ponto e vírgula:
  - as subalíneas começam por travessão;
  - a alínea que antecede as subalíneas termina em dois-pontos;
+ a última alínea termina em ponto final.

== Citações

As citações seguem o sistema autor-data. Uma obra pode ser citada entre parênteses @luck2010 ou na frase, como em
#cite(<oliveira1943>, form: "prose"). Nas citações diretas, a chamada inclui a página @luck2010[p. 12]. Uma obra
com três autores é citada com todos os sobrenomes @cruz1998; com quatro ou mais, pelo primeiro autor, seguido de
"et al." @maciel2019. Duas obras podem ser citadas em uma mesma chamada @santos1994 @romano1996. As entidades são
citadas pelo nome @abnt2024, e as obras sem autoria, pela primeira palavra do título @anteprojeto1987[p. 55].

A citação direta de até três linhas fica no texto, "entre aspas duplas" @autor2026[p. 10]. A citação direta com
mais de três linhas é destacada:

#quote(block: true)[
  Texto de uma citação direta com mais de três linhas. A citação é destacada do parágrafo, com recuo de 4 cm em
  relação à margem esquerda, em tamanho menor que o do texto, em espaço simples e sem aspas @autor2026[p. 11].
]

As demais obras da lista de referências mostram outros tipos de documento: uma tese @aguiar2009, uma dissertação
em meio eletrônico @coelho2009, um artigo de periódico @delucca2009, um artigo de jornal @verissimo2010 e um
trabalho apresentado em evento @brayner1994.

== Notas de rodapé

As notas de rodapé são numeradas ao longo de cada capítulo.#footnote[Texto de uma nota de rodapé curta.] Uma nota
com mais de uma linha tem as linhas seguintes alinhadas sob a primeira letra do texto.#footnote[Texto de uma nota
  de rodapé mais longa, com palavras suficientes para ocupar mais de uma linha e mostrar o alinhamento do texto
  da nota em relação ao número.]

== Ilustrações

Toda ilustração tem o título acima dela e a fonte abaixo. A #auto-ref(<fig-defesas>) mostra uma figura com fonte,
legenda e nota.

#figure(caption: [Trabalhos defendidos por ano])[
  #barras(12, 18, 15, 24, 28)
  #fonte()
  #legenda[Barras: número de trabalhos defendidos em cada ano, de 2021 a 2025.]
  #nota[Dados fictícios, usados apenas neste exemplo.]
] <fig-defesas>

Com a função `ajustada`, o título e a fonte ficam limitados à largura da ilustração, como na
#auto-ref(<fig-ajustada>).

#ajustada(rotulo: <fig-ajustada>, caption: [Trabalhos defendidos por ano, com o título limitado à largura da
  ilustração])[
  #barras(12, 18, 15, 24, 28)
  #fonte()
]

O quadro apresenta informações textuais, como o #auto-ref(<qua-tipos>).

#quadro(caption: [Tipos de trabalho acadêmico])[
  #table(columns: 2,
    [*Tipo*], [*Grau*],
    [Trabalho de conclusão de curso], [Graduação],
    [Dissertação], [Mestrado],
    [Tese], [Doutorado])
  #fonte()
] <qua-tipos>

As subfiguras reúnem várias partes em uma figura: a Figura @sub-a e a Figura @sub-b são partes da
#auto-ref(<fig-partes>).

#subfiguras(
  figure(barras(12, 18, 15), caption: [Primeiro triênio]), <sub-a>,
  figure(barras(24, 28, 30), caption: [Segundo triênio]), <sub-b>,
  titulo: [Trabalhos defendidos em dois períodos],
  rotulo: <fig-partes>,
)[
  #fonte()
]

== Tabelas

As tabelas seguem as normas de apresentação tabular do @ibge. A #auto-ref(<tab-defesas>) tem uma nota geral e uma
nota específica.

#ajustada(rotulo: <tab-defesas>, caption: [Trabalhos defendidos, por tipo -- Universidade do Brasil -- 2024-2025])[
  #table(columns: (5cm, 2.5cm, 2.5cm), align: (left, right, right),
    table.header([Tipo], [2024], [2025]),
    [Trabalhos de conclusão de curso], [212], [230],
    [Dissertações], [86], [94],
    [Teses #chamada(1)], [34], [41])
  #fonte()
  #nota[Dados fictícios, usados apenas neste exemplo.]
  #nota(chamada: 1)[Inclui as teses defendidas em cotutela.]
]

== Equações

A média aritmética de $n$ valores é dada pela @eq-media:
$ overline(x) = 1 / n sum_(i = 1)^n x_i $ <eq-media>
Uma equação sem rótulo não é numerada:
$ sigma^2 = 1 / n sum_(i = 1)^n (x_i - overline(x))^2 $
Em uma equação de várias linhas, apenas a linha com rótulo recebe número, como a @eq-quadrado:
$ (a + b)^2 &= (a + b)(a + b) \
            &= a^2 + 2 a b + b^2 #<eq-quadrado> $

== Algoritmos

Um algoritmo é uma ilustração de código, com título e fonte, como o #auto-ref(<alg-media>).

#algoritmo(caption: [Média de uma lista de números])[
  ```python
  def media(valores):
      total = 0
      for v in valores:
          total = total + v
      return total / len(valores)
  ```
  #fonte()
] <alg-media>

== Remissões

As remissões podem ser escritas de três formas. A remissão simples produz apenas o número, como em "figura
@fig-defesas". A remissão com a palavra produz o nome e o número, como em "@tab-defesas[Tabela]". A função
`auto-ref` encontra o nome do elemento: #auto-ref(<fig-defesas>), #auto-ref(<qua-tipos>),
#auto-ref(<tab-defesas>), #auto-ref(<cap-elementos>) e #auto-ref(<eq-media>). Ela também indica a página do
elemento: a #auto-ref(<fig-defesas>) está na #auto-ref(<fig-defesas>, form: "page").
