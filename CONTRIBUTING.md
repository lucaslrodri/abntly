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
| [gotpm](https://github.com/npikall/gotpm) 0.8.0 (opcional) | instalar o pacote na pasta de pacotes do Typst |

Os scripts são `sh` e rodam no macOS e no Linux. No Windows, só o `scripts/fonts.ps1` e o `scripts/install.ps1` têm
versão própria; os demais precisam do WSL ou do Git Bash.

## Ambiente

```sh
git clone https://github.com/lucaslrodri/abntly
cd abntly
sh scripts/link.sh     # faz @preview/abntly:<versão> apontar para esta cópia (--remove desfaz)
sh scripts/fonts.sh    # baixa a New Computer Modern para fonts/ e a instala (Windows: scripts/fonts.ps1)
```

O modelo, os exemplos e os READMEs importam o pacote pelo nome, `@preview/abntly:0.1.1`, como um autor faz. O
`scripts/link.sh` liga o repositório à pasta de pacotes locais do Typst, de modo que esse nome leve à cópia de
trabalho no `typst compile`, no `tt` e no editor. Os demais testes importam `src/lib.typ` pelo caminho.

### Instalação local com o gotpm

O [gotpm](https://github.com/npikall/gotpm) instala o pacote na pasta de pacotes do Typst a partir desta cópia, com os
mesmos comandos no macOS, no Linux e no Windows (`brew install npikall/tap/gotpm`, ou o instalador do README dele):

```sh
gotpm install -e                                  # @local/abntly:<versão>, um link para esta cópia (editável)
gotpm install                                     # @local/abntly:<versão>, uma cópia só com os arquivos do pacote
gotpm install -e -n preview                       # @preview/abntly:<versão>, o mesmo que o scripts/link.sh
gotpm install -r github.com/lucaslrodri/abntly    # a maior tag v<versão> do GitHub, sem esta cópia (-t HEAD: a main)
```

A cópia leva o que vai para o Typst Universe: o `exclude` do `typst.toml` e o `.gitignore` ficam de fora, como no
`scripts/package.sh`. O `-f` substitui uma instalação da mesma versão (de um link, só o link é apagado), `gotpm list`
mostra o que está instalado e `gotpm uninstall abntly -V <versão>` remove. O `scripts/link.sh --check`, que os
scripts e os testes usam, aceita o link do `gotpm install -e -n preview`. Duas diferenças em relação aos scripts:

- o gotpm não reescreve a importação do modelo (`@preview/abntly:<versão>`), como os scripts `install` fazem. Um
  `typst init @local/abntly:<versão>` cria um trabalho que só compila com a versão no Typst Universe ou com
  `gotpm install -n preview`;
- no Windows, o `-e` (um link simbólico) pede o Modo de Desenvolvedor ou um terminal de administrador; sem isso,
  use `gotpm install`, que copia.

Como alternativa, para ter a versão local sem a cópia de trabalho, os scripts `install` baixam a tag de versão mais
recente do GitHub (a maior `v<versão>`) e instalam os arquivos que ela publica no Typst Universe na pasta de pacotes
locais do Typst, como `@local/abntly:<versão>`:

```sh
sh scripts/install.sh                                          # macOS e Linux
powershell -ExecutionPolicy Bypass -File scripts\install.ps1   # Windows
```

Assim, `#import "@local/abntly:<versão>": *` e `typst init @local/abntly:<versão> <pasta>` funcionam antes de a versão
chegar ao Typst Universe; na cópia instalada, o modelo importa o pacote de `@local`, para que o trabalho criado dele
compile. A cópia não acompanha as mudanças do repositório (rodar o script de novo a substitui) e não serve aos testes
nem aos exemplos, que importam `@preview/abntly` e pedem o `scripts/link.sh`. Os scripts não dependem do repositório e
rodam também direto do GitHub, no terminal (macOS e Linux) ou no PowerShell (Windows):

```sh
curl -fsSL https://raw.githubusercontent.com/lucaslrodri/abntly/main/scripts/install.sh | sh
irm https://raw.githubusercontent.com/lucaslrodri/abntly/main/scripts/install.ps1 | iex
```

## Pastas

| Pasta | Conteúdo |
| ----- | -------- |
| [`src/`](src/) | o pacote; `src/lib.typ` é o ponto de entrada |
| [`template/`](template/) | o modelo de um trabalho novo |
| [`examples/`](examples/) | o exemplo básico e o exemplo completo, em português e em inglês |
| [`docs/manual/`](docs/manual/) | as fontes dos manuais, em português (`manual-pt.typ`) e em inglês (`manual-en.typ`), e os pequenos trabalhos dos seus exemplos |
| [`docs/readme/`](docs/readme/) | as imagens dos READMEs |
| [`tests/`](tests/) | a suíte de testes |
| [`scripts/`](scripts/) | os scripts de instalação, de geração e de verificação |

O código, os comentários e os scripts são escritos em inglês. Os manuais, os READMEs e este arquivo têm uma versão em
português e uma em inglês. No Typst Universe entram só `src/`, `template/`, o `typst.toml`, o `LICENSE`, o `README.md`
e a `thumbnail.png` (o `exclude` do `typst.toml` e o `scripts/package.sh` listam o resto); o `README.en.md` fica no
repositório, e o `README.md` chega a ele pelo endereço da tag.

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

O `scripts/check.sh` roda a suíte e confere também que os READMEs mostram o exemplo básico como ele é, que os PDFs
dos exemplos completos e as imagens e os PDFs do manual são os que as fontes dão hoje, e que os dois manuais têm as
mesmas coisas na mesma ordem. A CI ([`.github/workflows/tests.yml`](.github/workflows/tests.yml)) roda o mesmo script a cada push.

## Geração

| Script | O que gera |
| ------ | ---------- |
| `sh scripts/manual.sh` | as imagens dos exemplos do manual e os dois PDFs, `docs/manual-pt.pdf` e `docs/manual-en.pdf` |
| `sh scripts/readme.sh` | o exemplo básico e a imagem dele nos dois READMEs, e os PDFs dos exemplos completos, `docs/example-pt.pdf` e `docs/example-en.pdf` |
| `sh scripts/thumbnail.sh` | `thumbnail.png`, a capa do modelo |
| `sh scripts/examples.sh` | as imagens de referência dos exemplos completos e do modelo |
| `sh scripts/package.sh` | os arquivos publicados no Typst Universe, em `dist/preview/abntly/<versão>/` |

Os PDFs dos manuais e dos exemplos completos, as imagens dos exemplos do manual, as imagens dos READMEs e a
`thumbnail.png` são commitados. Depois de mudar o pacote, rode `sh scripts/manual.sh` e `sh scripts/readme.sh`: o
`check.sh` falha quando um deles fica desatualizado.

## Nova versão

Os READMEs apontam para o que está no repositório (manuais, exemplos e seus PDFs, modelo, licença, o README no outro
idioma, imagens) pelo endereço da tag da versão (`v0.1.1`); só as âncoras são relativas, porque o `README.md` é
mostrado no Typst Universe sem o repositório em volta. Ao mudar a versão no `typst.toml`:

1. troque a versão nas importações (`@preview/abntly:<versão>`) do modelo, dos exemplos, do manual e dos READMEs, e
   nos links dos READMEs;
2. rode `sh scripts/link.sh`, `sh scripts/manual.sh`, `sh scripts/readme.sh` e `sh scripts/thumbnail.sh`;
3. faça o commit e crie e envie a tag: `git tag v<versão> && git push origin main v<versão>`. A tag faz os links e
   as imagens dos READMEs funcionarem e dispara o [`release.yml`](.github/workflows/release.yml), que roda os
   testes, monta o pacote com `scripts/package.sh` (ele recusa uma tag diferente da versão), cria um trabalho do
   pacote montado e o compila, roda o verificador do typst/packages, publica a GitHub Release (zip e manuais) e
   envia o branch `abntly-<versão>` ao fork do typst/packages;
4. abra o pull request `abntly:<versão>` em typst/packages pelo link do resumo do workflow, com o checklist do
   modelo preenchido. Depois da integração, a versão aparece no [Typst Universe](https://typst.app/universe/) em
   minutos. Versões publicadas são imutáveis: uma correção é uma versão nova.

Enquanto o pull request não é integrado, a versão pode ser refeita: apague a release e a tag
(`gh release delete v<versão> --cleanup-tag` e `git tag -d v<versão>`), corrija, faça o commit e crie a tag de novo. O
workflow força o push do branch e o pull request se atualiza sozinho.

## Publicação

O `release.yml` chega ao typst/packages por um fork e um token, configurados uma vez:

1. um fork de [typst/packages](https://github.com/typst/packages). Se o fork não se chamar `<dono>/packages`, defina
   a variável de repositório `REGISTRY_FORK` (Settings > Secrets and variables > Actions > Variables) como `dono/nome`;
2. um token pessoal *fine-grained* restrito ao fork, com **Contents: read and write**, salvo como o segredo de
   repositório `REGISTRY_TOKEN`. Se o push for recusado por falta do escopo `workflow`, sincronize a `main` do fork
   com o typst/packages: o branch nasce da `main` atual deles, que pode trazer workflows que o fork ainda não tem.

O `gotpm publish` também leva o pacote a um fork do typst/packages (o commit e o push de um branch; o pull request
fica para o autor), mas não substitui o `release.yml`: ele não confere se a versão já está no Typst Universe, não roda
o verificador do typst/packages nem testa o `typst init`, copia da cópia de trabalho e não da tag, e usa o mesmo
nome de branch do workflow (`abntly-<versão>`). O lançamento continua pelo `release.yml`.

Para ensaiar o workflow nesta máquina, com o Docker aberto: `act push -W .github/workflows/release.yml -e
.github/act/release.json`. Os passos externos (verificador, release, push) são pulados; `sh scripts/package.sh` dá os
mesmos arquivos em `dist/`.
