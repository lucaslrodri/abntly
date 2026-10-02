// The help in Portuguese of the three functions that have one name in both languages (src/aliases.typ gives the
// others): only their signatures and their `///` comments, which the manual in Portuguese shows; the functions
// themselves are in src/elements.typ, src/structure.typ and src/citations.typ, and the case tests/unit/docstrings
// checks that the parameters here are theirs.

/// Gera uma remissão com o nome do elemento e o número dele, como em "Figura 1", com um único link sobre os dois. Uma
/// remissão comum (`@fig`) gera apenas o número.
///
/// O nome vem do tipo do elemento, no idioma do texto: "Figura", "Tabela", "Quadro" e "Algoritmo" para as
/// ilustrações; "Capítulo", "Seção", "Subseção" e "Subsubseção" para os títulos, conforme o nível; "Apêndice" e
/// "Anexo"; "Equação". Com `form: "page"`, gera a página do elemento, como em "p. 5". A remissão a uma nota de rodapé
/// gera o número da nota. Os nomes podem ser substituídos no parâmetro `nomes` de `trabalho-academico`.
///
/// Um ponto e vírgula logo após a chamada encerra a expressão na marcação e não é impresso. Escreva
/// `#auto-ref(<fig>)\;`.
///
/// - target (label): Rótulo do elemento.
/// - form (str): Forma da remissão: `"normal"`, para o nome e o número, ou `"page"`, para a página.
/// -> content
#let auto-ref(target, form: "normal") = none

/// Gera a errata (NBR 14724:2024, seção 4.2.1.2): o título "Errata", centralizado e sem número, seguido do conteúdo.
/// O conteúdo é escrito pelo autor: a referência do trabalho e a tabela das correções.
///
/// - body (content): Referência do trabalho e tabela das correções.
/// -> content
#let errata(body) = none

/// Gera uma citação de citação (NBR 10520:2023, seção 7.3): o documento original, que não foi consultado, seguido da
/// expressão "apud" e da chamada da fonte consultada, como em "(Cagliari, 1986, p. 104 apud Suassuna, 1995, p. 55)".
/// Apenas a fonte consultada está no arquivo `.bib` e entra na lista de referências; o autor e a data do documento
/// original são escritos na chamada.
///
/// ```typ
/// #apud([Cagliari], 1986, <suassuna1995>, page: [p. 104], supplement: [p. 55])
/// #apud([Freire], 1994, <streck2017>, form: "prose")
/// ```
///
/// Nos sistemas numéricos de chamada, a fonte consultada é indicada pelo número, como em "(Cagliari, 1986 apud 5)".
///
/// - author (str, content): Autor do documento original, como é escrito na chamada: o sobrenome ou a primeira palavra
///   do título.
/// - date (int, str, content): Data do documento original.
/// - key (label): Chave da fonte consultada no arquivo `.bib`.
/// - page (none, str, content): Página do documento original, como em `[p. 104]`.
/// - supplement (none, content): Página da fonte consultada, como em `[p. 55]`.
/// - form (str): Forma da chamada: `"normal"`, para a chamada inteira entre parênteses, ou `"prose"`, para o autor na
///   frase, como em "Freire (1994 apud Streck, 2017)".
/// -> content
#let apud(author, date, key, page: none, supplement: none, form: "normal") = none
