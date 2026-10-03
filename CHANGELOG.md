# Histórico de versões

**Português** · [English](CHANGELOG.en.md)

As mudanças de cada versão do abntly. O formato segue o [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/),
e as versões, o [versionamento semântico](https://semver.org/lang/pt-BR/).

## [0.1.1] — 2026-10-03

### Adicionado

- `ibge-table` (`tabela-ibge`): uma tabela no padrão do IBGE para uma `figure` comum, com os traços horizontais e o
  texto reduzido que `fitted` (`ajustada`) dá a uma tabela com cabeçalho. O título, a fonte e as notas ficam na largura
  da mancha gráfica, e a figura pode flutuar com `placement`.
- `no-indent` (`sem-recuo`): o parágrafo sem o recuo da primeira linha, para o texto que continua depois de uma equação
  destacada, de uma citação longa ou de uma lista ("em que…").

### Corrigido

- Uma tabela com um rótulo próprio dentro de `fitted` (`ajustada`) não interrompe mais a compilação ("unexpected
  argument: label").

## [0.1.0] — 2026-10-02

Primeira versão: o pacote, o modelo, os exemplos, os manuais em português e em inglês e a suíte de testes.

[0.1.1]: https://github.com/lucaslrodri/abntly/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/lucaslrodri/abntly/releases/tag/v0.1.0
