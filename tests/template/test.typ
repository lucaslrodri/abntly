/// Synopsis: O modelo do pacote (template/main.typ), como um autor o recebe, página a página
// The template of the package, what an author gets from `typst init`. Its reference pictures are not in the
// repository: `sh scripts/examples.sh` renders them, and then each page is compared with its picture, so that the
// template does not change without notice; without them the case only compiles, as Tytanic's own `@template`. The
// template imports the package by its name (`sh scripts/link.sh` makes it resolve to this working copy).
#include "/template/main.typ"
