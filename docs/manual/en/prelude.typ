// The manual in English: the helpers of the template with their language. Every chapter starts with
// `#import "../prelude.typ": *` and `#show: chapter`.
#import "../template.typ": *

#let lang = "en"
#let project = project.with(lang: lang)
#let chapter = chapter.with(lang: lang)
#let pill = pill.with(lang: lang)
#let norm-box = norm-box.with(lang: lang)
#let remark = remark.with(lang: lang)
#let page-example = page-example.with(lang: lang)
#let bib-example = bib-example.with(lang: lang)
#let reference = reference.with(lang: lang)
#let api-index = api-index.with(lang: lang)
