// Contact sheet of a small work, for the README: its pages, six per row, on a transparent page (the README is read on
// light and on dark backgrounds). scripts/readme.sh renders the pages of the work into `dir` and compiles this file:
// typst compile --root . --input name=basico --input pages=11 --input dir=.tmp docs/readme/sheet.typ docs/readme/basico.png
#let name = sys.inputs.name
#let pages = int(sys.inputs.pages)
#let dir = sys.inputs.dir

#let gap = 12pt
#set page(width: auto, height: auto, margin: gap, fill: none)

#grid(
  columns: calc.min(pages, 6),
  gutter: gap,
  ..range(1, pages + 1).map(p => box(
    fill: white,
    stroke: 0.8pt + luma(150),
    image(dir + "/" + name + "-" + str(p) + ".svg", width: 240pt),
  )),
)
