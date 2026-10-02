#import "../prelude.typ": *
#show: chapter.with(title: [Citações e referências], id: <references>)

As citações seguem a ABNT NBR 10520:2023, e a lista de referências, a ABNT NBR 6023:2025. O autor registra as
obras em um arquivo `.bib` e as cita no texto pela chave. O pacote compõe as chamadas e a lista com as funções
`cite` e `bibliography` do Typst.

== Sistemas de chamada <citation-systems>

#norm-box("NBR 10520:2023, 6", "required", "implemented")[
  As citações são indicadas no texto por um sistema de chamada: autor-data ou numérico. O sistema adotado deve ser
  seguido ao longo de todo o trabalho. No sistema numérico, a numeração das fontes é consecutiva, em algarismos
  arábicos, e remete à lista de referências, na ordem em que as fontes aparecem no texto. A numeração pode ser
  indicada entre parênteses, alinhada ao texto, ou em expoente. O sistema numérico não pode ser usado em um
  trabalho com notas.
]

O sistema de chamada é definido no parâmetro `sistema-de-citacao` da função principal. A @systems[Tabela] lista os
valores aceitos. O sistema define a forma das chamadas e a ordem da lista de referências.

#data-table([Sistemas de chamada], (2.4cm, 3.4cm, 4cm, 1fr),
  ([Valor], [Sistema], [Chamada], [Lista de referências]), label: <systems>,
  [`"alf"`], [Autor-data (padrão)], [(Luck, 2010, p. 12)], [Em ordem alfabética.],
  [`"num"`], [Numérico, entre parênteses], [(1, p. 12)], [Na ordem das citações, com o número antes de cada
    referência.],
  [`"overcite"`], [Numérico, em expoente], [#super[1, p. 12]], [Como em `"num"`.],
  [`"ieee"`], [Numérico, entre colchetes], [[1, p. 12]], [Como em `"num"`. Os colchetes não estão previstos na
    norma #pill("decision").],
)

O exemplo a seguir mostra um parágrafo no sistema numérico, com o início da página do texto e da página das
referências.

#page-example("citations-num", pages: (1, 2), crop: (0, 0.22))

O mesmo parágrafo, com as chamadas em expoente:

#page-example("citations-overcite", crop: (0, 0.22))

E com as chamadas entre colchetes:

#page-example("citations-ieee", crop: (0, 0.22))

== Citações no texto <citations>

#norm-box("NBR 10520:2023, 6.1", "required", "partial")[
  No sistema autor-data, a fonte é indicada pelo sobrenome do autor ou pelo nome da entidade, em letras maiúsculas
  e minúsculas, seguido da data. Nas citações diretas, acrescenta-se a página. Quando o autor faz parte da frase,
  a data e a página ficam entre parênteses. Uma fonte com quatro ou mais autores pode ser citada pelo primeiro
  autor, seguido de "et al.". Autores com o mesmo sobrenome e a mesma data são distinguidos pelas iniciais dos
  prenomes, e obras do mesmo autor e do mesmo ano, por letras minúsculas após a data. Várias obras em uma mesma
  chamada são separadas por ponto e vírgula, de preferência em ordem alfabética. Uma fonte sem autoria é citada
  pela primeira palavra do título, seguida de "[...]".
]

Uma obra é citada pela chave que ela tem no arquivo `.bib`. A @cite-forms[Tabela] lista as formas de citação. A
página, ou outra localização, é informada entre colchetes, depois da chave.

#data-table([Formas de citação], (7.4cm, 1fr), ([Código], [Uso]), label: <cite-forms>,
  [`@chave`], [Chamada entre parênteses.],
  [`@chave[p. 12]`], [Chamada com a página, para as citações diretas.],
  [`#cite(<chave>, form: "prose")`], [Autor na frase, com a data entre parênteses.],
  [`#cite(<chave>, form: "prose", supplement: [p. 12])`], [Autor na frase, com a página.],
  [`#cite(<chave>, form: "author")`], [Apenas o nome do autor.],
  [`#cite(<chave>, form: "full")`], [Referência completa, no texto.],
  [`@chave-a @chave-b`], [Várias obras em uma mesma chamada.],
  [`#apud([Autor], 1990, <chave>)`], [Citação de citação (@apud[Seção]).],
)

O exemplo a seguir mostra as formas de citação no sistema autor-data, com as obras da lista de
referências deste manual.

```example
Um autor @luck2010, com a página @luck2010[p. 12] e na
frase: #cite(<luck2010>, form: "prose", supplement: [p. 12]).

Dois autores @oliveira1943, três autores @cruz1998 e
quatro autores @maciel2019. Na frase:
#cite(<oliveira1943>, form: "prose") e
#cite(<maciel2019>, form: "prose").

Várias obras @luck2010 @cruz1998. Obras do mesmo autor e
do mesmo ano @freyre1936a @freyre1936b. Autores com o
mesmo sobrenome @barbosaC1958 @barbosaO1958.

Entidade @abnt2024 e obra sem autoria
@anteprojeto1987[p. 55].
```

Uma obra sem autoria é citada pela primeira palavra do título, seguida de "[...]". Se o título começa por artigo
ou por palavra monossilábica, a palavra seguinte também é incluída. Para definir outra forma, informe o campo
`shorttitle` na entrada do arquivo `.bib`.

#remark[
  Um ponto da norma não é atendido #pill("partial"). Nas citações de várias obras do mesmo autor, as datas são
  separadas por ponto e vírgula, como em "(Dreyfuss, 1989; 1991)", e não por vírgula.
]

== Citação de citação <apud>

#norm-box("NBR 10520:2023, 7.3", "required", "implemented")[
  Na citação de citação, os elementos são indicados nesta ordem: autoria ou primeira palavra do título do documento
  original; data; página do documento original, se houver; a expressão "apud"; autoria ou primeira palavra do título
  da fonte consultada; data; página da fonte consultada, se houver. Na lista de referências, consta apenas a fonte
  consultada.
]

A função `apud` gera a citação de citação. O autor e a data do documento original são escritos na chamada, porque
esse documento não está no arquivo `.bib`. A fonte consultada é informada pela chave e entra na lista de
referências. Os parâmetros `page` e `supplement` informam a página do documento original e a da fonte consultada.
Com `form: "prose"`, o autor do documento original faz parte da frase, como no exemplo a seguir.

```example
Entre parênteses: #apud([Silva], 1990, <autor2026>,
  page: [p. 5], supplement: [p. 10]).

Na frase: #apud([Silva], 1990, <autor2026>, form: "prose").
```

A função tem o mesmo nome nas duas línguas do pacote, e os seus parâmetros são escritos em inglês, como os da
função `cite` do Typst. Nos sistemas numéricos, a fonte consultada é indicada pelo número.

#reference("apud")

== Lista de referências <bibliography>

#norm-box("NBR 6023:2025, 6.3, 6.6, 6.7 e 9; NBR 14724:2024, 5.2", "required", "implemented")[
  As referências são elaboradas em espaço simples, alinhadas à margem esquerda e separadas entre si por uma linha
  em branco de espaço simples. O recurso tipográfico usado para destacar o título é uniforme em todas as
  referências; a obra sem autoria entra pelo título, com a primeira palavra em letras maiúsculas e sem outro
  destaque. Para os documentos online, registram-se o endereço eletrônico, precedido de "Disponível em:", e a data
  de acesso, precedida de "Acesso em:". No sistema alfabético, as referências são reunidas em ordem alfabética; no
  sistema numérico, seguem a ordem em que as obras são citadas no texto.
]

A lista de referências é gerada pela função `bibliography` do Typst, chamada depois do texto:

```typ
#bibliography("refs.bib")
```

O pacote gera o título "Referências", centralizado e sem número, e compõe cada referência conforme a norma. O
título da obra é destacado em negrito. Por padrão, a lista contém apenas as obras citadas no texto; com
`full: true`, contém todas as obras do arquivo. A lista de referências deste manual, na página
#context counter(page).at(query(bibliography).first().location()).first(), é gerada dessa forma.

== Arquivo de referências <bib-file>

As obras são registradas em um arquivo `.bib`, no formato do BibLaTeX. Cada entrada tem um tipo (`@book`,
`@article`), uma chave e os campos da obra. A @bib-fields[Tabela] resume como escrever os casos mais comuns.

#data-table([Campos do arquivo de referências], (3.2cm, 1fr), ([Caso], [Como escrever]), label: <bib-fields>,
  [Subtítulo], [No campo `title`, depois de dois-pontos: `title = {Título: subtítulo}`. O destaque termina nos
    dois-pontos.],
  [Entidade como autor], [Com chaves duplas: `author = {{Associação Brasileira de Normas Técnicas}}`.],
  [Tese e dissertação], [`@phdthesis`, com o tipo e o grau em `type`, a instituição em `publisher`, o local em
    `address` e o ano em `year`.],
  [Parte de livro], [`@incollection`, com o título da parte em `title` e o do livro em `booktitle`. O autor do
    livro vai em `bookauthor`; os organizadores, em `editor`, com `editortype = {organizer}`.],
  [Artigo], [`@article`, com o periódico em `journaltitle`, o local em `address` e os campos `volume`, `number` e
    `pages`.],
  [Trabalho em evento], [`@inproceedings`, com o evento em `eventtitle`, o número do evento em `edition`, o local
    em `venue` e `booktitle = {Anais [...]}`.],
  [Documento online], [O endereço em `url` e a data de acesso em `urldate`, no formato `2026-10-01`.],
  [Obra sem autoria], [Sem o campo `author`. O campo `shorttitle` define a chamada, se necessário.],
)

Os exemplos a seguir mostram a entrada do arquivo `.bib` e a referência gerada, para os tipos de documento mais
usados. As obras são exemplos da NBR 6023:2025.

=== Livro

#bib-example("luck2010")

=== Livro de entidade

#bib-example("abnt2024")

=== Tese

#bib-example("aguiar2009")

=== Dissertação em meio eletrônico

#bib-example("coelho2009")

=== Parte de livro

#bib-example("santos1994")

=== Parte de livro com organizadores

#bib-example("romano1996")

=== Artigo de periódico

#bib-example("delucca2009")

=== Artigo de jornal em meio eletrônico

#bib-example("verissimo2010")

=== Trabalho apresentado em evento

#bib-example("brayner1994")

=== Obra sem autoria

#bib-example("anteprojeto1987")

#remark[
  Alguns tipos de documento da NBR 6023:2025 não são compostos conforme a norma #pill("partial"): o evento no todo,
  a legislação e a jurisprudência, as patentes, o fascículo de periódico e os documentos cartográficos em
  periódicos. Alguns elementos também não têm campo próprio, como a data aproximada entre colchetes e a numeração
  do ano de um periódico ("ano 3"). Nesses casos, confira a referência gerada com o texto da norma.
]
