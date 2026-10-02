/// Subject: Elementos do texto
// The displayed equations numbered through the work, "(1)", the example of NBR 14724 (5.7), as the option
// `equation-numbering: "(1)"` of `abntly` sets them: two chapters, the numbers going on from one to the other; an
// equation without a label without a number, and in one of several lines only the line with a label; references in
// the second chapter to the equations of both. The case style/elements/global-equations sets it.
#set heading(numbering: "1.1")

= Equações numeradas no trabalho todo

Numa numeração global, as equações seguem uma sequência só, do primeiro ao último capítulo, como no exemplo da
norma. Uma equação sem rótulo não tem número:
$ E = m c^2 $
#par(first-line-indent: (amount: 0pt, all: true))[com rótulo, ela é numerada:]
$ F = m a $ <newton>
#par(first-line-indent: (amount: 0pt, all: true))[e, em várias linhas, só a linha com rótulo:]
$ (a + b)^2 &= (a + b)(a + b) \
            &= a^2 + 2 a b + b^2 #<quadrado> $

= O capítulo seguinte

A numeração não recomeça no capítulo seguinte:
$ p = m v $ <momento>
#par(first-line-indent: (amount: 0pt, all: true))[Como mostram a @newton, a @quadrado e a @momento.]
