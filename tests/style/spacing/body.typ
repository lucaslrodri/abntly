/// Subject: Espaçamento
// A chapter with every element whose spacing and indents src/spacing.typ sets: the five levels of heading,
// paragraphs, a list, a figure, an equation, a long quote, alíneas, code and footnotes; each block with a paragraph
// after it, so that the space after a block is its own. A case includes it after `#show: setup`.
#import "../../../src/lib.typ": source

// a paragraph that goes on after a display, a quote or a list: no indent on its first line
#let segue(texto) = par(first-line-indent: (amount: 0pt, all: true), texto)

#set heading(numbering: "1.1")

= Fundamentação teórica

A normalização de trabalhos acadêmicos no Brasil segue a ABNT NBR 14724:2024, que recomenda o espaçamento 1,5 entre
as linhas do texto e o espaço simples nas citações longas, nas notas, nas referências e nas legendas.#footnote[A
  nota de rodapé fica em espaço simples, separada do texto por um filete, e esta frase continua até ocupar uma
  segunda linha, para mostrar a entrelinha da nota.]

Um segundo parágrafo mostra o recuo da primeira linha e o espaço que o pacote põe entre os parágrafos.

== Normalização e tipografia: o que a norma pede e o que fica a cargo de quem compõe o documento

O coração da questão está na legibilidade: a entrelinha, a largura da linha e o desenho das letras decidem se um
texto longo cansa o leitor. Os itens a seguir mostram a lista:
- a entrelinha do corpo;
- o espaço entre os parágrafos.
#segue[A lista termina e o texto continua, como em todo bloco deste capítulo.]

=== Ilustrações

A figura tem o título em cima, com a palavra designativa e o número, e a fonte embaixo, em corpo menor.

#figure(caption: [Distribuição dos trabalhos por região])[
  #rect(width: 5cm, height: 2cm, fill: black)
  #source[Elaborada pelo autor (2026).]
]

O texto continua depois da figura. A ilustração deve ser citada no texto e inserida o mais próximo possível do
trecho a que se refere, e o título e a fonte devem respeitar as margens dela, o que a figura acima não faz: o título
e a fonte ficam centrados na largura da mancha. Quando a figura não cabe no resto da página, ela vai inteira para a
página seguinte, e o espaço que sobra fica em branco.

==== Medidas da página

Para estimar quantas páginas um texto ocupa, considere a largura útil da linha e a largura média de um caractere; um
texto de muitos caracteres ocupa um número de páginas dado por
$ P = N / (n ell) $ <paginas>
#segue[em que o número de linhas depende só da entrelinha.]

===== Citações e alíneas

Uma citação direta com mais de três linhas fica em bloco:
#quote(block: true)[Nenhuma norma resolve sozinha a questão da legibilidade: é a combinação entre o corpo, a
  entrelinha, a largura da linha e o desenho das letras que determina se um texto longo cansa ou não o leitor.]
#segue[As alíneas vêm depois:]
+ a primeira alínea;
+ a segunda alínea.
#segue[O código fica em bloco, na fonte mono:]
```
def paginas(N, w):
    return N * w / (453.5 * 39)
```
#segue[E o texto termina aqui.#footnote[Uma segunda nota, para medir a distância entre as notas.]]
