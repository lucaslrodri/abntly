# Changelog

[Português](CHANGELOG.md) · **English**

The changes of each version of abntly. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and the versions, [semantic versioning](https://semver.org/).

## [0.1.1] — 2026-10-03

### Added

- `ibge-table` (`tabela-ibge`): a table in the pattern of the IBGE for a plain `figure`, with the horizontal rules
  and the reduced text that `fitted` (`ajustada`) gives a table with a header. The title, the source and the notes
  keep the width of the text block, and the figure may float with `placement`.
- `no-indent` (`sem-recuo`): the paragraph without the indent of its first line, for the text that goes on after a
  displayed equation, a long quote or a list ("where…").

### Fixed

- A table with a label of its own inside `fitted` (`ajustada`) no longer stops the compilation ("unexpected argument:
  label").

## [0.1.0] — 2026-10-02

First release: the package, the template, the examples, the manuals in Portuguese and in English and the test suite.

[0.1.1]: https://github.com/lucaslrodri/abntly/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/lucaslrodri/abntly/releases/tag/v0.1.0
