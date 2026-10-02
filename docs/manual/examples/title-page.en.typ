#import "/src/lib.typ": *
// --- example ---
#show: abntly.with(
  lang: "en",
  info: config-info(
    title: [Title of the work],
    subtitle: [subtitle],
    author: "Name of the Author",
    advisor: (
      name: "Prof. Dr. Name Surname",
      gender: "f",
    ),
    co-advisor: "Prof. Dr. Another Name",
    area: [Power systems],
    location: [Rio Branco],
    year: 2026,
  ),
)

#title-page[Thesis presented to the
  Graduate Programme of the University of
  Brazil, as a partial requirement for the
  degree of Doctor.]
