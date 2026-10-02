#import "/src/lib.typ": *
#import "common/pt.typ": setup
#show: setup
#folha-de-rosto[Tese apresentada ao Programa de Pós-Graduação da Universidade do Brasil, como requisito
  parcial para a obtenção do título de Doutor.]
// --- example ---
#errata[
  AUTOR, Nome do. *Título do trabalho*: subtítulo. 2026. 120 f. Tese (Doutorado) --
  Universidade do Brasil, Rio Branco, 2026.

  #align(center, table(columns: 4, align: left, stroke: 0.4pt,
    table.header([*Folha*], [*Linha*], [*Onde se lê*], [*Leia-se*]),
    [16], [10], [auto-clavado], [autoclavado],
    [23], [4], [análize], [análise],
  ))
]
