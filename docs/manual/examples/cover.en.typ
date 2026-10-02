#import "/src/lib.typ": *
// --- example ---
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

#cover()
