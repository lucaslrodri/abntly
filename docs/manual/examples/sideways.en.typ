#import "/src/lib.typ": *
#import "common/en.typ": setup
#show: setup
= Results

Text before the table.

// --- example ---
#sideways[
  #fitted(caption: [Works defended
    by region and by year])[
    #table(
      columns: (3cm,) + (2.4cm,) * 6,
      align: (left,) + (right,) * 6,
      table.header([Region],
        [2019], [2020], [2021],
        [2022], [2023], [2024]),
      [North], [190], [210], [230], [250],
      [260], [280],
      [South], [390], [410], [420], [440],
      [450], [470])
    #source()
  ]
]
