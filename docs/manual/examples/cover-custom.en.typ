#import "/src/lib.typ": *
#show: abntly.with(
  lang: "en",
  info: config-info(
    title: [Title of the work],
    subtitle: [subtitle],
    author: "Name of the Author",
    institution: [University of Brazil],
    program: [Graduate Programme],
    location: [Rio Branco],
    year: 2026,
  ),
)
// --- example ---
#cover(
  top: with-info(d => [
    #upper(d.institution) \
    #d.program
    #v(3cm)
    #d.author
  ]),
  middle-height: 60%,
)
