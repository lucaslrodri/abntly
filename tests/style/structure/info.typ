// The data of the cases of the subject structure, generic ones (a title and a subtitle, an author, two advisors, an
// institution, a programme, an area, a year and a place, of a thesis): a case gives them to `setup`
// (`#show: setup.with(info: info)`).
#import "../../../src/lib.typ": config-info

#let info = config-info(
  title: [Título do trabalho],
  subtitle: [subtítulo],
  author: "Nome do Autor",
  advisor: "Prof. Dr. Nome do Orientador",
  co-advisor: "Prof. Dr. Nome do Coorientador",
  institution: [Universidade do Brasil],
  program: [Programa de Pós-Graduação],
  area: [Nome da área],
  year: 2026,
  location: [Brasil],
  work-type: "thesis",
)
