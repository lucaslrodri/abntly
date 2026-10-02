/// Synopsis: O manual em português compila: os capítulos, os exemplos avaliados, a referência gerada dos doc-comments e as imagens dos exemplos de página
// Compile-only: the manual must build, that is, every chapter, every example evaluated in it, the reference tidy
// generates from the `///` comments of src/ and the pictures of the page examples (`sh scripts/manual.sh` renders
// them; they are committed).
#include "/docs/manual/pt/manual.typ"
