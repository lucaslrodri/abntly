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
| [gotpm](https://github.com/npikall/gotpm) 0.8.0 | instalar o pacote na pasta de pacotes do Typst |

Os scripts são `sh` e rodam no macOS e no Linux. No Windows, só o `scripts/fonts.ps1` tem versão própria; os demais
precisam do WSL ou do Git Bash. O gotpm roda nos três sistemas (`brew install npikall/tap/gotpm`, ou o instalador do
README dele).

## Ambiente

```sh
git clone https://github.com/lucaslrodri/abntly
cd abntly
gotpm install -e      # @local/abntly:<versão>, um link para esta cópia (editável)
sh scripts/fonts.sh   # baixa a New Computer Modern para fonts/ e a instala (Windows: scripts/fonts.ps1)
```

No desenvolvimento, o pacote é instalado sempre em `@local`, e nunca em `@preview` na pasta de pacotes do sistema. Um
`@preview/abntly:<versão>` instalado ali passaria à frente da versão publicada no Typst Universe, em todo trabalho da
máquina. Com o `gotpm install -e`, `#import "@local/abntly:<versão>": *` leva à cópia de trabalho no `typst compile`
e no editor.

O modelo, os exemplos e os READMEs importam o pacote pelo nome publicado, `@preview/abntly:0.1.1`, como um autor faz
(o Typst Universe exige isso do modelo). Os scripts que os compilam (`check.sh`, `examples.sh`, `readme.sh`,
`thumbnail.sh`) ligam esse nome à cópia de trabalho só enquanto rodam, numa pasta de pacotes temporária, a do
`TYPST_PACKAGE_PATH`, que o `typst`, o `tt` e o gotpm leem. Uma versão nova não pede passo próprio. Os demais testes
importam `src/lib.typ` pelo caminho.

### Instalação local com o gotpm

O gotpm instala o pacote na pasta de pacotes do Typst, com os mesmos comandos no macOS, no Linux e no Windows:

```sh
gotpm install -e                                  # @local/abntly:<versão>, um link para esta cópia (editável)
gotpm install                                     # @local/abntly:<versão>, uma cópia só com os arquivos do pacote
gotpm install -r github.com/lucaslrodri/abntly    # a maior tag v<versão> do GitHub, sem esta cópia (-t HEAD: a main)
```

A cópia leva o que vai para o Typst Universe: o `exclude` do `typst.toml` e o `.gitignore` ficam de fora, como no
`scripts/package.sh`. O `-f` substitui uma instalação da mesma versão (de um link, só o link é apagado), `gotpm list`
mostra o que está instalado e `gotpm uninstall abntly -V <versão>` remove. Assim, `#import "@local/abntly:<versão>": *`
funciona antes de a versão chegar ao Typst Universe. Dois cuidados:

- o modelo importa `@preview/abntly:<versão>`, e o gotpm não reescreve essa importação. Um trabalho criado com
  `typst init @local/abntly:<versão>` compila com a versão do Typst Universe; para usar a cópia local, troque nele
  `@preview` por `@local`;
- no Windows, o `-e` (um link simbólico) pede o Modo de Desenvolvedor ou um terminal de administrador; sem isso,
  use `gotpm install`, que copia.

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

Rodado direto, o `tt` precisa do nome `@preview/abntly:<versão>` nos casos que compilam o modelo e os exemplos. Ligue-o
antes, numa pasta de pacotes temporária da sessão do terminal, como os scripts fazem:

```sh
export TYPST_PACKAGE_PATH=$(mktemp -d) && gotpm install -e -n preview
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

Toda a publicação passa pelo gotpm: o `gotpm bump` muda a versão, e o `gotpm publish` leva o pacote ao Typst Universe.
Os READMEs apontam para o que está no repositório (manuais, exemplos e seus PDFs, modelo, licença, o README no outro
idioma, imagens) pelo endereço da tag da versão (`v0.1.1`); só as âncoras são relativas, porque o `README.md` é
mostrado no Typst Universe sem o repositório em volta. Para uma versão nova:

1. `gotpm bump patch` (ou `minor`, `major`, ou a versão, como `gotpm bump 0.2.0`) muda a versão do `typst.toml`, e
   só ela;
2. troque a versão nas importações (`@preview/abntly:<versão>`) do modelo, dos exemplos, do manual e dos READMEs, e
   nos links dos READMEs; `git grep -n "abntly:<versão anterior>\|v<versão anterior>"` mostra os lugares;
3. rode `gotpm install -e` (o `@local` da versão nova), `sh scripts/manual.sh`, `sh scripts/readme.sh` e
   `sh scripts/thumbnail.sh`;
4. faça o commit e crie e envie a tag: `git tag v<versão> && git push origin main v<versão>`. A tag faz os links e
   as imagens dos READMEs funcionarem e dispara o [`release.yml`](.github/workflows/release.yml), que roda os
   testes, publica pelo `gotpm publish` (abaixo) e cria a GitHub Release, com o zip do pacote, os manuais e os
   exemplos;
5. abra o pull request `abntly:<versão>` em typst/packages pelo link do resumo do workflow, com o checklist do
   modelo preenchido (o `gotpm publish` sugere outro título, `release: abntly <versão>`; o typst/packages pede
   `abntly:<versão>`). Depois da integração, a versão aparece no [Typst Universe](https://typst.app/universe/) em
   minutos. Versões publicadas são imutáveis: uma correção é uma versão nova.

Enquanto o pull request não é integrado, a versão pode ser refeita: apague a release e a tag
(`gh release delete v<versão> --cleanup-tag` e `git tag -d v<versão>`), corrija, faça o commit e crie a tag de novo. O
`gotpm publish` acrescenta um commit ao branch que já está no fork, e o pull request se atualiza sozinho; sem
nenhuma mudança no pacote, ele falha, porque não há o que publicar.

## Publicação

O `gotpm publish` faz, nesta ordem:

1. roda o portão do `typst.toml` (`[tool.gotpm] pre-publish-hook`), `sh scripts/package.sh --check`, e para se ele
   falhar. O portão monta os arquivos publicados em `dist/` e confere:
   - a tag (`RELEASE_TAG`, na CI) contra a versão do `typst.toml`;
   - as importações do pacote e os links dos READMEs na versão certa;
   - um trabalho criado pelo `typst init` só com os arquivos publicados, que precisa compilar;
   - a versão ainda fora do Typst Universe;
   - o verificador dos pull requests do typst/packages (`ghcr.io/typst/package-check`), pelo Docker. Sem Docker, o
     verificador é pulado com um aviso; na CI, ele é obrigatório;
2. clona o fork do typst/packages (o `fork.url` da configuração do gotpm) e cria o branch `abntly-<versão>` a
   partir da `main` do fork;
3. copia o pacote para `packages/preview/abntly/<versão>/`, com as mesmas regras da instalação: ficam de fora o
   `exclude` do `typst.toml` e o que o `.gitignore` ignora (os arquivos do `scripts/package.sh`);
4. faz o commit e o push do branch para o fork. O pull request fica para o autor.

O fork e o token são configurados uma vez:

1. um fork de [typst/packages](https://github.com/typst/packages). Se o fork não se chamar `<dono>/packages`, defina
   a variável de repositório `REGISTRY_FORK` (Settings > Secrets and variables > Actions > Variables) como `dono/nome`;
2. um token pessoal *fine-grained* restrito ao fork, com **Contents: read and write**, salvo como o segredo de
   repositório `REGISTRY_TOKEN`. O `release.yml` o entrega ao git do `gotpm publish`.

Para publicar desta máquina, sem a CI, configure o fork uma vez e rode o gotpm na raiz da cópia de trabalho limpa,
na tag da versão:

```sh
gotpm config set fork.url https://github.com/<dono>/packages
gotpm publish --local -m "abntly:<versão>"   # ensaio: o commit no clone do fork, sem push
gotpm publish -m "abntly:<versão>"           # o push, com as credenciais do git desta máquina
```

O clone do fork fica na pasta de dados do gotpm (`gotpm locate` mostra as pastas). O `gotpm publish` copia a cópia
de trabalho, e não a tag: publique de uma árvore limpa, na tag. A GitHub Release, nesse caso, sai à mão:
`sh scripts/package.sh dist` e `gh release create v<versão> --verify-tag --generate-notes` com o zip e os PDFs.

Para ensaiar o workflow nesta máquina, com o Docker aberto: `act push -W .github/workflows/release.yml -e
.github/act/release.json`. Sob o act, o `gotpm publish` roda com `--local`, e a release e o verificador do
typst/packages são pulados.
