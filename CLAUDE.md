# CLAUDE.md

Instruções para trabalhar neste repositório. Leia antes de qualquer tarefa.

## Contexto do sistema

**Personal Financial Control** é um sistema desktop de finanças pessoais: receitas e despesas (com parcelamento), baixa de pagamento, consulta com totais e gráficos por forma de pagamento, categoria e subcategoria. É um projeto pessoal do Vagner, usado para estudo e **para controlar as finanças reais dele**: o banco contém dados verdadeiros.

A versão atual é **Delphi (VCL) + FireDAC + SQLite**, Win32, RAD Studio 12. O objetivo é **migrar para JavaScript**, com uma aplicação desktop (Electron) e uma web que compartilham regras e interface, preservando os dados e as funcionalidades.

## Documentação

A documentação em [`docs/`](docs/) é a **fonte de verdade** sobre o sistema atual. Consulte antes de ler o código Delphi.

| Documento | Use para |
|---|---|
| [docs/DATABASE.md](docs/DATABASE.md) | Tabelas, campos, ligações, valores codificados, diagnóstico dos dados |
| [docs/SCREENS.md](docs/SCREENS.md) | Telas, navegação, padrões de interface, classes e métodos |
| [docs/BUSINESS_RULES.md](docs/BUSINESS_RULES.md) | Regras (RN-xx), glossário, divergências conhecidas (D-xx) e status de migração de cada regra |
| [README.md](README.md) | Visão geral do produto |

## Regras invioláveis

1. **Nunca escrever no banco original** (`database/PersonalFinancialControl`). Ele costuma estar bloqueado pelo app Delphi aberto. Para inspecionar, copie o arquivo para o scratchpad e abra a cópia. Qualquer script que altere dados roda **só em cópia**, até o usuário autorizar explicitamente o contrário.
2. **Não alterar o projeto Delphi** (`*.pas`, `*.dfm`, `*.dpr`, `*.dproj`) sem pedido explícito. Ele é a referência de comportamento e continua em uso.
3. **Os dados existentes precisam sobreviver à migração.** Toda mudança de esquema na versão nova deve vir acompanhada de um caminho de migração dos dados atuais.
4. **Divergências (D-xx) não se resolvem por conta própria.** Não corrija e não replique um comportamento listado em [BUSINESS_RULES.md §8](docs/BUSINESS_RULES.md#8-divergências-conhecidas) sem decisão do usuário. Registre a decisão no documento.
5. **A documentação acompanha o comportamento.** Se uma regra mudar na versão nova, atualize o RN-xx correspondente; se descobrir algo novo no sistema atual, inclua nos docs.
6. **Não afirmar o que não foi verificado.** Comportamento deduzido do código e ainda não testado é marcado como suspeita (ver D-12 como exemplo).
7. **SQL sempre parametrizado** na versão nova; nada de concatenar valores digitados.
8. **Commits só quando o usuário pedir.**

## Glossário

Use os termos do [glossário (BUSINESS_RULES.md §1)](docs/BUSINESS_RULES.md#1-conceitos) em textos, telas e conversas, sem criar sinônimos. No código, use os nomes em inglês já existentes:

| Termo (pt-BR) | Código / classe | Tabela |
|---|---|---|
| Movimentação (uma parcela) | `Movement` | `MOVEMENT` |
| Receita / Despesa | `TYPE_MOVEMENT` 0 / 1 (`tmRevenues` / `tmExpenses`) | — |
| Parcela, número da parcela | `NumberParcel` | `NUMBER_PARCEL` |
| Vencimento | `IssueDate` | `ISSUE_DATE` |
| Situação: Não pago / Pago | `Situation` 0 / 1 | `SITUATION` |
| Categoria / Subcategoria | `Category` / `SubCategory` | `CATEGORY` / `SUB_CATEGORY` |
| Tipo de pagamento | `TypePayment` | `TYPE_PAYMENT` |
| Forma de pagamento | `FormPayment` | `FORM_PAYMENT` |
| Pessoa: Fornecedor / Cliente | `Person`: `Provider` / `Customer` (`TYPE_PERSON` 0 / 1) | `PERSON` |
| Cidade | `City` | `CITY` |
| Usuário | `User` | `USER` |

- "Lançamento" = o conjunto de parcelas criado de uma vez. **Não existe no banco** (ver RN-24).
- Cite regras e divergências pelo identificador (RN-22, D-03) ao discutir comportamento.

## Idioma

- Conversa, documentação e textos de interface em **português (pt-BR)**.
- Identificadores de código, tabelas e colunas em **inglês**, seguindo o padrão atual.

## Stack de destino

| Camada | Decisão |
|---|---|
| Plataforma | Duas aplicações: desktop (Electron) e web, que compartilham regras de negócio e interface (decidido em 15/10/2026) |
| Ordem de construção | **Desktop primeiro, web depois**: o desktop é construído por inteiro antes de começar `apps/web`. Tudo o que não for específico do Electron vai para `packages/`, para a web reaproveitar (decidido em 15/10/2026) |
| Linguagem | JavaScript (ES modules), sem TypeScript (decidido em 05/10/2026) |
| Interface | React, com um arquivo CSS por tela (decidido em 05/10/2026) |
| Regras de negócio | JavaScript puro, sem dependência de React/Electron/banco |
| Testes | Vitest (`vitest run`), com `describe`/`test`/`expect` importados de `'vitest'`, sem globais (decidido em 09/10/2026; substituiu `node:test`) |
| Banco | SQLite, reaproveitando os dados atuais (**manter o esquema como está ou evoluí-lo: a definir**) |
| Build e dev do desktop | electron-vite (template `@quick-start/electron`, variante `react` em JS), com Electron 44, React 19 e Vite 8 (decidido em 15/10/2026) |
| Empacotamento (instalador) | O template trouxe o electron-builder (`electron-builder.yml`, scripts `build:win` etc.), mas a escolha **ainda precisa ser confirmada** |
| Driver SQLite do desktop | `better-sqlite3` 13, usado só no processo principal do Electron (decidido em 03/11/2026) |
| Biblioteca de gráficos, relatórios/PDF | **A definir** |
| Navegação entre telas (rotas, menu) | **A definir**. Por enquanto, o `App` de `@pfc/ui` é só o esqueleto (faixa de título e área vazia) |
| Lint e formatação | ESLint 9 (configuração do template electron-vite) e Prettier, com uma configuração única na raiz que vale para `apps/*` e `packages/*` (decidido em 15/10/2026) |
| Catálogo de componentes | Storybook 10 (`@storybook/react-vite` + `@storybook/addon-docs`), em `packages/ui`, com versões exatas e telemetria desligada (decidido em 24/10/2026) |
| Web: onde ficam os dados e como o navegador os acessa (API, servidor, autenticação) | **A definir** |
| Gerenciador do monorepo | npm workspaces, com um único `package-lock.json` e `node_modules/` na raiz (decidido em 15/10/2026) |

Enquanto uma decisão estiver "a definir", pergunte antes de assumir. Ao ser decidida, atualize esta tabela.

### Convenções da versão nova

A versão nova é um monorepo separado do Delphi. As regras de negócio e a interface ficam em `packages/` e são **compartilhadas** pelas duas aplicações em `apps/`. Cada aplicação guarda só o que é dela: janela, ponto de entrada e acesso a dados.

Situação em 15/10/2026:
- `@pfc/ui` tem o componente raiz `App` (esqueleto: faixa de título e um botão "Testar" que exibe "Olá mundo", só para validar a organização), os controles compartilhados do nível 1 do mapeamento (`Button`, `FormField`, `TextField`, `Icon`, `IconButton`, `Select`, `DateField`, `MoneyField`, `SituationSelect` e `MonthSelect`), cada um com sua story no Storybook, com origem no Delphi e decisões no [README do pacote](packages/ui/README.md#componentes), os design tokens (`styles/`: primitivos em `tokens.css`, papéis em `theme.css`, globais em `base.css`, levantados do Delphi em SCREENS.md §3.5) e o padrão de serviços (`ServicesProvider` + `useServices()`). Nenhuma tela convertida.
- `apps/desktop/` monta o `App` de `@pfc/ui`, passando `createServices()` (ainda vazio: nenhum contrato de serviço implementado). A demonstração do template foi removida. `npm run build:desktop`, `npm run lint` e `npm test` passam, e `npm run dev:desktop` abre a janela, desde que a cópia do banco exista.
- Conexão com o banco (03/11/2026): `apps/desktop/src/main/database.js` abre o banco ao iniciar o app e fecha ao sair. As telas ainda não leem dados: faltam os handlers IPC, o preload e os serviços. Também falta remover o `window.electron` do template e ligar `sandbox: true`.
  - Em desenvolvimento, o app usa a cópia em `apps/desktop/dev-data/` (fora do git e do instalador), criada por `npm run db:dev-copy`, e nunca o `database/PersonalFinancialControl`. Empacotado, procura o arquivo na pasta de dados do usuário (`%APPDATA%\desktop\`). Como levar os dados reais para lá **ainda não foi definido**.
  - Sem o arquivo, o app mostra uma mensagem de erro e encerra: o banco nunca é criado vazio (`fileMustExist`).
  - O `better-sqlite3` liga a verificação de FK por padrão. A conexão a desliga (`foreign_keys = OFF`) para manter o comportamento do legado (D-14). Não ligue sem decisão do usuário.
  - A versão 13 traz binários Node-API prontos em `prebuilds/`, que servem para o Node e para o Electron. Não é preciso recompilar ao atualizar o Electron.
- `@pfc/domain` tem Vitest configurado e o `legacy-types.js` (cópia da skill `tipos-legado-delphi`, com testes das funções de dinheiro). Nenhuma regra RN-xx migrada ainda. `apps/web/` tem só as pastas.
- Electron fixado na versão exata `44.7.2`: o electron-builder exige isso quando o Electron fica no `node_modules` da raiz. Atualize a versão de propósito, não por faixa.
- O ESLint também está fixado em `^9` na raiz, como no template. O `eslint-plugin-react` não aceita o ESLint 10, e o `@electron-toolkit/eslint-config` puxa o `@eslint/js` 10. O `npm ls` acusa esse peer inválido, mas o lint funciona (é a combinação do template).
- Storybook `10.6.3` instalado em `@pfc/ui` em 24/10/2026, com configuração em `packages/ui/.storybook/`. Os pacotes `storybook` e `@storybook/*` ficam na **mesma versão exata**: atualize todos juntos. A configuração está em `.storybook/main.js` e `.storybook/preview.jsx`, que põe o fundo do app atrás das stories. Em 24/10/2026, o `npm audit` acusava 2 alertas que **não vinham do Storybook**: `electron` (alta, corrigida a partir da 44.9.3) e `fast-uri` (moderada, via `electron-builder` → `ajv`). Em 03/11/2026, acusa 30 (29 moderados e 1 alto, o `electron`), nenhum no `better-sqlite3`.

Instale e rode tudo **a partir da raiz**:

| Comando | O que faz |
|---|---|
| `npm install` | Instala as dependências de todos os workspaces |
| `npm run dev:desktop` | Abre o desktop em modo de desenvolvimento |
| `npm run build:desktop` | Build de produção do desktop (`apps/desktop/out/`) |
| `npm run db:dev-copy` | Copia o banco de `database/` para `apps/desktop/dev-data/`, a cópia usada em desenvolvimento. Só substitui uma cópia existente com `npm run db:dev-copy -- --force` |
| `npm run storybook` | Abre o catálogo de componentes do `@pfc/ui` em `http://localhost:6006` |
| `npm run build:storybook` | Gera o catálogo estático (`packages/ui/storybook-static/`, fora do git) |
| `npm run lint` | ESLint em todo o monorepo (`apps/*` e `packages/*`) |
| `npm run format` | Prettier em `apps/` e `packages/` (não toca em `docs/` nem no Delphi) |
| `npm test` | Roda o script `test` de cada workspace que o tiver (hoje, só `@pfc/domain`) |

Para adicionar uma dependência a um pacote: `npm install <pacote> -w <workspace>` (ex.: `-w @pfc/domain`, `-w desktop`). Ferramentas usadas por todo o monorepo (ESLint, Prettier) ficam nas `devDependencies` da raiz.

Configurações de ferramenta ficam **na raiz** e valem para todos os workspaces: `eslint.config.mjs`, `.prettierrc.yaml`, `.prettierignore`, `.editorconfig` e `.vscode/` (inclui a depuração do desktop, "Debug All"). O `.editorconfig` vale só para `apps/`, `packages/` e as configurações da raiz, para não converter os arquivos Delphi (Windows-1252, CRLF). Os apps não têm configuração própria dessas ferramentas.

O código Delphi vai para `legado/` mais tarde, com o app e o RAD Studio fechados. Por enquanto, ele continua na raiz (decidido em 15/10/2026).

```
packages/
  domain/src/legacy-types.js        conversões de tipos do legado (skill tipos-legado-delphi)
  domain/src/rules/<área>/*.js      regras de negócio (RN-xx) + *.test.js ao lado
  ui/src/App.jsx + App.css          componente raiz da aplicação, montado pelo desktop e pela web
  ui/src/screens/<Tela>/            telas (.jsx + .css), usadas pelo desktop e pela web
  ui/.storybook/                    configuração do Storybook (main.js, preview.jsx, que importa styles/index.css)
  ui/src/components/<Nome>/         componentes compartilhados (.jsx + .css + .stories.jsx): Button, FormField, TextField, Icon, IconButton, Select, DateField, MoneyField, SituationSelect, MonthSelect (já existem); RegisterLayout, LookupDialog, MessageDialog, ConfirmDialog (planejados)
  ui/src/services/                  ServicesContext.js (useServices), ServicesProvider.jsx e contratos <entidade>Service.js
  ui/src/styles/index.css           entrada dos estilos globais, importada só pelo App
  ui/src/styles/tokens.css          tokens primitivos: paleta, tipografia, espaços, tamanhos, bordas (SCREENS.md §3.5)
  ui/src/styles/theme.css           papéis do tema (--color-title-bg, --color-revenue…): a única origem de cores nas telas
  ui/src/styles/base.css            estilos globais (html/body, fonte padrão)
apps/
  desktop/src/main/                 processo principal do Electron (janela, handlers IPC)
  desktop/src/main/database.js      conexão única com o banco (openDatabase, getDatabase, closeDatabase)
  desktop/src/preload/              ponte segura entre main e renderer (contextBridge)
  desktop/src/renderer/             index.html + src/main.jsx (monta o App de @pfc/ui)
  desktop/src/renderer/src/services/  createServices(): implementa os contratos via IPC
  desktop/scripts/copy-dev-database.mjs  cria a cópia do banco para desenvolvimento (npm run db:dev-copy)
  desktop/dev-data/                 cópia do banco para desenvolvimento, com dados reais (fora do git e do instalador)
  desktop/electron.vite.config.mjs, electron-builder.yml, build/, resources/   build, empacotamento e ícones (só do desktop)
  web/src/                          entrada React do navegador; services/ implementa os contratos (forma a definir)
```

Regras de dependência:
- `packages/domain` não importa nada de React, Electron, navegador ou banco.
- `packages/ui` importa `packages/domain`, mas não acessa dados diretamente: nada de SQL, IPC (`window.api`) ou `fetch`.
- `apps/*` importam `packages/*`, nunca o contrário. `desktop` e `web` não importam um do outro.

Acesso a dados (padrão de serviços):
- Cada contrato fica em `packages/ui/src/services/<entidade>Service.js`. Ele documenta, com JSDoc, a chave do objeto `Services` (ex.: `category`) e as funções, todas retornando `Promise`.
- A tela obtém os serviços com `const { category } = useServices()`. Nunca importa uma implementação.
- Cada app cria as implementações (`createServices()`) e as entrega ao `App`: `<App services={createServices()} />`. O `App` as repassa pelo `ServicesProvider`.
- Testes de componentes do `@pfc/ui` (jsdom, Testing Library) ainda não estão configurados.

Como importar entre pacotes:
- Entre pacotes diferentes, sempre pelo nome, nunca por caminho relativo (`../../packages/...`). Dentro do mesmo pacote, use caminho relativo.
- `@pfc/domain` é importado **sem** extensão, porque o `exports` acrescenta `.js`. Exemplos: `import { … } from '@pfc/domain/legacy-types'` e `'@pfc/domain/rules/<área>/<nome>'`.
- `@pfc/ui` é importado **com** extensão, porque tem `.jsx` e `.css`. Exemplos: `import App from '@pfc/ui/App.jsx'` e `import Category from '@pfc/ui/screens/Category/Category.jsx'`.
- Nos apps, `@pfc/*` fica em `devDependencies`. Assim o electron-vite embute o código no bundle do `main`, do `preload` e do `renderer`, em vez de deixá-lo como dependência externa que o instalador teria de copiar.

Testes da lógica de domínio: `npm test` na raiz, ou `npx vitest run` dentro de `packages/domain/`.

## Skills do projeto

| Skill | Quando usar |
|---|---|
| `tipos-legado-delphi` | Ler, gravar, calcular ou exibir datas, dinheiro, booleanos e IDs do banco legado. Base das outras duas |
| `converter-form-delphi` | Converter uma tela Delphi (`.dfm` + `.pas`) em componente React + CSS |
| `migrar-regra-de-negocio` | Implementar uma RN-xx em JS puro, com testes, e marcá-la como migrada |

## Subagentes do projeto

| Subagente | Quando usar |
|---|---|
| `revisor-de-regras` | Revisar código migrado comparando cada RN-xx com `BUSINESS_RULES.md`, o código Delphi de origem, testes e conversões do legado. É somente leitura e aponta divergências sem sugerir funcionalidades. |
| `revisor-de-tela` | Revisar uma tela convertida para React (por exemplo, depois da skill `converter-form-delphi`), comparando com `SCREENS.md` e com o `.dfm`/`.pas` de origem: campos e tipos de entrada, botões e ações, validações, navegação, regras de negócio fora do componente e nomes do glossário. É somente leitura, não avalia estética (o CSS é provisório) e aponta divergências sem sugerir funcionalidades. |

## Estado atual da migração

| Fase | Situação |
|---|---|
| 1. Mapeamento e documentação do sistema Delphi | ✅ Concluída (README, DATABASE, SCREENS, BUSINESS_RULES) |
| 2. Decisões de stack e de esquema do banco | 🔄 Em andamento: linguagem, interface, testes, build do desktop (electron-vite), monorepo (npm workspaces), lint/formatação, driver SQLite do desktop (`better-sqlite3`) e ordem "desktop primeiro, web depois" definidos; esquema do banco, navegação e demais itens pendentes |
| 3. Decisão sobre cada divergência D-01 a D-17 (corrigir ou manter) | ⏳ Pendente |
| 4. Implementação da versão nova (desktop primeiro, web depois) | 🔄 Iniciada: monorepo reorganizado. O desktop monta o `App` de `@pfc/ui`, que já tem tema e padrão de serviços (`useServices`), e abre a conexão com o banco no processo principal. Ainda sem telas nem regras migradas |

A versão nova ainda não tem telas nem regras, só a estrutura e a conexão com o banco. O status de cada regra está em [BUSINESS_RULES.md §11](docs/BUSINESS_RULES.md#11-status-da-migração). Ao concluir uma fase ou parte dela, atualize esta tabela.

## Dicas práticas sobre o código Delphi

- Os `.pas` e `.dfm` estão em **Windows-1252**. Para ler com acentos corretos no terminal: `iconv -f cp1252 -t utf-8 arquivo.pas`.
- Nos `.dfm`, acentos aparecem como códigos (`'Usu'#225'rio'` = "Usuário").
- O banco SQLite está em **UTF-8**.
- `fMain.dfm` tem ~1 MB por causa de imagens embutidas; use `grep -a` em vez de ler o arquivo inteiro.

## Dicas práticas sobre a versão nova

- Se `npm run dev` falhar com `Cannot read properties of undefined (reading 'isPackaged')`, a variável `ELECTRON_RUN_AS_NODE=1` foi herdada do ambiente (o Claude Code no VS Code a define) e o Electron está rodando como Node puro. Rode `unset ELECTRON_RUN_AS_NODE` (bash) ou `Remove-Item Env:ELECTRON_RUN_AS_NODE` (PowerShell) antes do `npm run dev`. A configuração "Debug All" do `.vscode/launch.json` já remove essa variável.
- O React 19 ignora `propTypes`, por isso a regra `react/prop-types` está desligada no ESLint. Documente as props com JSDoc.
