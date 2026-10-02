/// Subject: Tipografia
// A mock section with every element src/fonts.typ sets: the five levels of heading; the body in regular, italic, bold
// and bold italic; footnotes; superscripts and subscripts in the body, in a note and in a 12 pt heading; equations,
// one of them inside bold text; code; a long quote. A case includes it after `#show: setup`.

#set heading(numbering: "1.1")
// the displayed formula of the section has no number
#set math.equation(numbering: none)

= Fundamentação teórica

A normalização de trabalhos acadêmicos no Brasil segue a ABNT NBR 14724:2024, que recomenda a fonte tamanho 12 para
todo o texto, _inclusive a capa_, mas não define a família tipográfica.#footnote[A norma pede um tamanho menor e
  uniforme para as citações longas, as notas de rodapé, a paginação e as legendas; o pacote usa 10 pt.] A escolha
fica com quem compõe o documento.

== Normalização e tipografia

O coração da questão está na legibilidade: *a fonte precisa ser confortável em textos longos*, com acentuação correta
(ã, õ, ç, é, ê, à, ü). _A ênfase com *negrito dentro do itálico*_ testa a combinação dos dois, e fórmulas como
H#sub[2]O, o 1#super[o] lugar e o m#super[3] testam os índices do texto.

=== Medidas da página

Para estimar quantas páginas um texto ocupa, considere a largura útil da linha, $L = 16 "cm"$, e a largura média
$overline(w)$ de um caractere. Um texto de $N$ caracteres ocupa
$ P = N / (n ell) = sum_(i=1)^k N_i / (L ell) $
páginas, em que *$ell$ depende só da entrelinha*.#footnote[Na mancha da NBR 14724 cabem 39 linhas; a nota testa a
  chamada em 7 pt e o m#super[2] dentro dela.]

==== Emissões de CO#sub[2] por m#super[3]

Em código, a conta cabe em duas linhas. A função `paginas()` recebe o número de caracteres:

```
def paginas(N, w):
    return N * w / (453.5 * 39)
```

===== O cálculo em código

#quote(block: true)[Nenhuma norma resolve sozinha a questão da legibilidade: é a combinação entre o corpo, a
  entrelinha e o desenho das letras que determina se um texto longo cansa o leitor.]
