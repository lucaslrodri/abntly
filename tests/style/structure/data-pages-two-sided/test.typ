/// Synopsis: As mesmas páginas em frente e verso: a capa e a folha de rosto no anverso, a ficha no verso da folha de rosto
#import "../../../common.typ": *
#import "../info.typ": info
#show: setup.with(info: info, two-sided: true)
#include "../body.typ"
