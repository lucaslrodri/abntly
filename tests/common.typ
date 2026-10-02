// What every case shares: the package, imported by path so that the tests run on the working copy. The package sets
// the page itself: A4, 3 cm at the left and the top, 2 cm at the right and the bottom (NBR 14724, 5.1), in Portuguese,
// with the running header and the number of the page. A case is `#show: setup` (or `setup.with(two-sided: true)`, the
// arguments going to `abntly`) followed by the body of its subject.
#import "../src/lib.typ": abntly

#let setup(body, ..args) = {
  show: abntly.with(..args)
  body
}
