# Desenvolvimento

<p align="center">
  <strong>Português</strong> · <a href="CONTRIBUTING.en.md">English</a>
</p>

Este arquivo descreve o ambiente de desenvolvimento do pacote: as ferramentas, as pastas, os testes e os scripts de
geração. Para usar o pacote, veja o [README](README.md) e o [manual](docs/manual-pt.pdf).

## Ferramentas

| Ferramenta | Para quê |
| ---------- | -------- |
| [Typst](https://typst.app/) ≥ 0.15.0 | compilar o pacote, o manual e os exemplos |
| [Tytanic](https://typst-community.github.io/tytanic/) 0.4.1 (`tt`) | os casos de teste |

Os scripts são `sh` e rodam no macOS e no Linux. No Windows, só o `scripts/fonts.ps1` tem versão própria; os demais
precisam do WSL ou do Git Bash.

## Ambiente

```sh
git clone https://github.com/lucaslrodri/abntly
cd abntly
sh scripts/link.sh     # faz @preview/abntly:<versão> apontar para esta cópia (--remove desfaz)
sh scripts/fonts.sh    # baixa a New Computer Modern para fonts/ e a instala (Windows: scripts/fonts.ps1)
```

O modelo, os exemplos e os READMEs importam o pacote pelo nome, `@preview/abntly:0.1.0`, como um autor faz. O
`scripts/link.sh` liga o repositório à pasta de pacotes locais do Typst, de modo que esse nome leve à cópia de
trabalho no `typst compile`, no `tt` e no editor. Os demais testes importam `src/lib.typ` pelo caminho.

## Pastas

| Pasta | Conteúdo |
| ----- | -------- |
| [`src/`](src/) | o pacote; `src/lib.typ` é o ponto de entrada |
| [`template/`](template/) | o modelo de um trabalho novo |
| [`examples/`](examples/) | o exemplo básico e o exemplo completo, em português e em inglês |
| [`docs/manual/`](docs/manual/) | as fontes dos manuais, em português (`pt/`) e em inglês (`en/`), e os pequenos trabalhos dos seus exemplos |
| [`docs/readme/`](docs/readme/) | as imagens dos READMEs |
| [`tests/`](tests/) | a suíte de testes |
| [`scripts/`](scripts/) | os scripts de instalação, de geração e de verificação |

O código, os comentários e os scripts são escritos em inglês. Os manuais, os READMEs e este arquivo têm uma versão em
português e uma em inglês. No Typst Universe entram só `src/`, `template/`, o `typst.toml`, o `LICENSE`, os READMEs e
a `thumbnail.png` (o `exclude` do `typst.toml` lista o resto).

## Testes

```sh
sh scripts/check.sh                                    # tudo o que a CI roda
tt run --font-path fonts --warnings promote            # só a suíte do Tytanic
tt run --font-path fonts -e 'regex:^unit/'              # só os testes unitários
tt update --font-path fonts style/typography/section   # regrava a referência de um caso
```

Os casos ficam em `tests/<categoria>/.../test.typ`:

| Categoria | O que confere |
| --------- | ------------- |
| `style/` | as páginas de cada caso contra as imagens de referência (`ref/`) |
| `unit/` | cada módulo de `src/`, com `assert` sobre o que as funções devolvem; o caso passa quando compila |
| `docs/` | os dois manuais compilam |
| `examples/` e `template/` | os dois exemplos completos e o modelo |

As imagens de referência dos exemplos completos e do modelo (103 páginas, 4 MB) ficam fora do repositório. Sem
elas, esses três casos só compilam. O `sh scripts/examples.sh` gera as imagens, e a partir daí cada página é
comparada; rode-o de novo quando uma mudança nas páginas for intencional (`--remove` apaga as imagens).

O `scripts/check.sh` roda a suíte e confere também que os READMEs mostram o exemplo básico como ele é, que as
imagens e os PDFs do manual são os que as fontes dão hoje, e que os dois manuais têm as mesmas coisas na mesma
ordem. A CI ([`.github/workflows/tests.yml`](.github/workflows/tests.yml)) roda o mesmo script a cada push.

## Geração

| Script | O que gera |
| ------ | ---------- |
| `sh scripts/manual.sh` | as imagens dos exemplos do manual e os dois PDFs, `docs/manual-pt.pdf` e `docs/manual-en.pdf` |
| `sh scripts/readme.sh` | o exemplo básico e a imagem dele nos dois READMEs |
| `sh scripts/thumbnail.sh` | `thumbnail.png`, a capa do modelo |
| `sh scripts/examples.sh` | as imagens de referência dos exemplos completos e do modelo |

Os PDFs dos manuais, as imagens dos seus exemplos, as imagens dos READMEs e a `thumbnail.png` são commitados. Depois
de mudar o pacote, rode `sh scripts/manual.sh` e `sh scripts/readme.sh`: o `check.sh` falha quando um deles fica
desatualizado.

## Nova versão

Os READMEs apontam para o manual, os exemplos e as imagens pelo endereço da tag da versão (`v0.1.0`). Ao mudar a
versão no `typst.toml`:

1. troque a versão nas importações (`@preview/abntly:<versão>`) do modelo, dos exemplos, do manual e dos READMEs, e
   nos links dos READMEs;
2. rode `sh scripts/link.sh`, `sh scripts/manual.sh`, `sh scripts/readme.sh` e `sh scripts/thumbnail.sh`;
3. depois do commit, crie e envie a tag `v<versão>`: é ela que faz os links e as imagens dos READMEs funcionarem.
