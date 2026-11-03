---
name: converter-form-delphi
description: >-
  Converte uma tela Delphi (.dfm + .pas) em componente React (JavaScript) com CSS,
  montada com a biblioteca de componentes de @pfc/ui, separando interface de regra de
  negócio e listando o que não foi convertido.
  Use quando o usuário pedir para converter, migrar ou portar um formulário/tela Delphi
  (ex.: "converter fCategory", "migrar a tela de Gerenciar movimentações").
---

# Converter tela Delphi → React

Entrada: o nome da tela (ex.: `fCategory`, "Categorias") ou o caminho do `.pas`/`.dfm`.

## Antes de começar

1. Leia o [CLAUDE.md](../../../CLAUDE.md): regras invioláveis, glossário e convenções da versão nova (pastas, CSS, testes).
2. Leia a skill [tipos-legado-delphi](../tipos-legado-delphi/SKILL.md): datas, dinheiro, booleanos e IDs seguem aquele guia. As funções ficam em `@pfc/domain/legacy-types`.
3. Leia o catálogo de componentes no [README do @pfc/ui](../../../packages/ui/README.md#componentes). Ele diz quais componentes já existem, as props de cada um e as **diferenças em relação ao Delphi já aprovadas** pelo usuário. Para ver os componentes funcionando: `npm run storybook`.
4. Confirme que o pacote `packages/ui/` existe e tem React configurado (`packages/ui/package.json`). **Se não existir, pare e pergunte ao usuário**: criar o esqueleto do projeto é uma decisão à parte.
5. **Não altere** os arquivos Delphi; eles são só leitura.

## Passo 1: Entender a tela

1. Encontre a tela em [docs/SCREENS.md](../../../docs/SCREENS.md) (catálogo §4 e detalhe §5) e anote as regras RN-xx e divergências D-xx citadas.
2. Leia o `.pas` com `iconv -f cp1252 -t utf-8`.
3. Leia o `.dfm` com `grep -a`, ignorando blocos de imagem (`Picture.Data`, `Glyph`). Decodifique acentos (`'Usu'#225'rio'` → "Usuário").
4. Se a tela herda de `TfrmMasterRegister` ou `TfrmBase`, o `.dfm` traz só as diferenças (`inherited`). Leia também o template em `templates/`.
5. Monte uma lista de **todos** os componentes e **todos** os eventos (`On… = …`). Ela é a base do relatório final; nenhum item pode sumir sem explicação.
6. Para cada componente VCL da lista, anote o componente da biblioteca que o substitui ([tabela de equivalência](#tabela-de-equivalência-vcl--react)) e confira no catálogo se ele já existe. **Se faltar algum, pare e pergunte ao usuário** se o cria agora (ver [Componente que falta](#componente-que-falta)) ou se a conversão espera por ele.

## Passo 2: Classificar cada evento e método

| Categoria | Como reconhecer | Destino |
|---|---|---|
| **Interface** | Cor/hover (`SetButtonColors`), mostrar/ocultar abas e painéis, foco, larguras de coluna, títulos | Componentes da biblioteca (`packages/ui/src/components/`) + estado e JSX da tela + CSS de layout |
| **Regra de negócio** | Cálculo, validação, geração de dados, decisão (ex.: `InstallmentsGenerate`, `SumMovements`) | Função pura em `packages/domain/src/rules/`, importada pelo componente como `@pfc/domain/rules/<área>/<nome>` |
| **Acesso a dados** | `TMyQuery`, `FRegisterObject.Insert/Update/Delete/Search/GetById` | Serviço obtido com `useServices()` (`@pfc/ui/services/ServicesContext.js`), conforme o contrato `packages/ui/src/services/<entidade>Service.js` (a implementação fica em cada app) |

- Para **regra de negócio**, procure a RN correspondente no status de migração ([BUSINESS_RULES.md §11](../../../docs/BUSINESS_RULES.md#11-status-da-migração)):
  - **Já migrada:** importe a função.
  - **Ainda não migrada:** crie a chamada para a função esperada, deixe `// TODO(migração): RN-xx pendente` e recomende a skill `migrar-regra-de-negocio`. **Não implemente regra de negócio dentro do componente.**
  - Alguns componentes já cumprem parte de uma regra de entrada. Por exemplo, o `MoneyField` faz o filtro e a formatação da RN-25. Use o componente e não repita a regra na tela.
- Para **acesso a dados**, se o serviço não existir, crie em `packages/ui/src/services/<entidade>Service.js` o contrato: JSDoc com a chave do objeto `Services` (ex.: `category`) e as funções e assinaturas usadas, todas retornando `Promise`, com `// TODO(migração): implementar no desktop (IPC) e na web`. A tela usa `const { category } = useServices()` e nunca importa uma implementação. Nada de SQL, IPC ou `fetch` dentro de `packages/ui/`: a tela roda nas duas aplicações.
- Se um evento envolve uma **divergência D-xx** sem decisão registrada, não replique nem corrija: pergunte ao usuário (regra inviolável 4). Decisões já tomadas ficam na coluna **Decisão** de [BUSINESS_RULES.md §8](../../../docs/BUSINESS_RULES.md#8-divergências-conhecidas) (ex.: D-12) e na tabela de decisões do README do `@pfc/ui`.

## Passo 3: Gerar os arquivos

```
packages/ui/src/screens/<Tela>/<Tela>.jsx   componente (PascalCase, nome em inglês sem o prefixo "f": fCategory → Category)
packages/ui/src/screens/<Tela>/<Tela>.css   layout da tela
packages/ui/src/services/<entidade>Service.js   (contrato, se ainda não existir)
```

- **Componente funcional** com hooks. Estado de formulário em `useState`; efeitos de carga em `useEffect`.
- **Textos da interface em pt-BR**, iguais aos do Delphi, salvo erro registrado (ex.: D-17) ou decisão do usuário (ex.: os textos de Situação, unificados no `SituationSelect`). Identificadores em inglês.

### Montar a tela com a biblioteca

- **Toda peça que tem componente na biblioteca usa o componente.** Não recrie com HTML cru (`<input>`, `<select>`, `<button>`) nem copie o CSS dele. Importe por caminho relativo, porque a tela fica no mesmo pacote: `import TextField from '../../components/TextField/TextField.jsx'`.
- **Os campos são controlados** e já trazem o rótulo (`label`), por isso a tela não usa `<label>` à parte. O `onChange` recebe o valor já tratado, e não o evento: o texto no `TextField`, os centavos no `MoneyField`, `'YYYY-MM-DD'` no `DateField`, o `value` com o tipo original no `Select`.
- **Aplique as diferenças aprovadas** da tabela de decisões do README, sem perguntar de novo. Alguns exemplos:
  - O `DateField` pode chegar vazio (`''`). Se a tela precisa de uma data, ela trata o vazio. Como o Delphi não tem regra para isso, pergunte ao usuário o que fazer (avisar, bloquear o Salvar…).
  - O `IconButton` entra na ordem do Tab.
  - Filtros de situação e mês são só lista (`SituationSelect`, `MonthSelect`).
- **Variação visual é responsabilidade do componente.** Se a tela precisa de uma aparência que o componente não oferece, por exemplo outro tamanho ou outra cor, isso é uma prop ou variante nova no componente, com story. Não sobrescreva o estilo do componente no CSS da tela.

### CSS da tela

- Um arquivo por tela, com todas as classes prefixadas pelo nome da tela (`.category-…`).
- **Só layout:** posição e agrupamento (flexbox/grid), larguras das colunas de campos e espaçamento entre os componentes. Cor, borda, fonte e estados (hover, foco) dos componentes ficam no CSS deles.
- Estilos pelos tokens de `packages/ui/src/styles/` ([como usar](../../../packages/ui/README.md#design-tokens); de onde vem cada valor: [SCREENS.md §3.5](../../../docs/SCREENS.md#35-tema-visual)):
  - Cores **sempre** pelos papéis de `theme.css` (`--color-title-bg`, `--color-revenue`…). Nunca hexadecimal nem `--palette-*` na tela.
  - Espaços, fontes e alturas pela escala de `tokens.css` (`--space-*`, `--font-size-*`, `--size-*`) ou pelo papel, quando houver (`--font-size-control`, `--font-size-title`). Converta o `Font.Height` e as distâncias do `.dfm` pelas tabelas do §3.5.4 e §3.5.5.
  - Se faltar um papel, crie-o em `theme.css` apontando para um token, e registre no §3.5.
- **Não copie** `Left`/`Top`/`Width`/`Height` do `.dfm`: reproduza a organização com flexbox/grid. Respeite a ordem visual e o agrupamento.

### Componente que falta

Só crie um componente depois de o usuário confirmar (Passo 1, item 6). Os nomes previstos estão na [tabela de equivalência](#tabela-de-equivalência-vcl--react). Ao criar:

1. **Pasta e arquivos:** `packages/ui/src/components/<Nome>/`, com:
   - `<Nome>.jsx`;
   - `<Nome>.css`, se tiver estilo próprio, com classes prefixadas pelo nome em kebab-case (`.icon-button`);
   - `<Nome>.stories.jsx`.
2. **JSDoc** no componente: a origem no Delphi (classe e propriedades), o que ele faz e todas as props. O React 19 ignora `propTypes`.
3. **Sem regra de negócio e sem acesso a dados**, como as telas. Conversões de tipos vêm de `@pfc/domain/legacy-types`.
4. **Story:**
   - `title` pela camada: `Controles/…` (campos e botões), `Estrutura/…` (faixa de título, abas, grade, barras) ou `Compostos/…` (lookup, diálogos, layout de cadastro).
   - JSDoc no `export default` com a origem no Delphi, e uma story por variação usada nas telas, com um comentário dizendo onde aparece.
   - Eventos com `fn()` de `storybook/test`. Campos controlados com um `render` que guarda o estado (veja `TextField.stories.jsx`).
   - **Dados de exemplo inventados.** Nunca copie dados do banco real: ele tem as finanças verdadeiras do usuário.
5. **Constantes e funções compartilhadas** ficam em arquivo separado do `.jsx` (ex.: `Icon/icons.js`), porque a regra `react-refresh/only-export-components` do ESLint não aceita outra exportação junto com o componente.
6. **Ícone novo:** extraia o PNG do `Picture.Data` do `.dfm`, em vez de usar `images/`, que tem versões parecidas mas não iguais. Salve em `packages/ui/src/assets/icons/` e registre em `Icon/icons.js`.
7. **Diferença em relação ao Delphi:** se o comportamento web não puder ser igual (foco, campo vazio, digitação), pergunte ao usuário antes de decidir. Depois, registre a decisão no JSDoc e na tabela de decisões do README.
8. **Catálogo:** acrescente uma linha na tabela de componentes do README do `@pfc/ui`, e atualize a lista de componentes em "Situação" e na árvore de pastas do CLAUDE.md.

## Tabela de equivalência VCL → React

Confira no [catálogo](../../../packages/ui/README.md#componentes) se o componente já existe. Os que ainda não existem estão previstos no mapeamento da biblioteca.

**Controles**

| VCL | Componente | Observações |
|---|---|---|
| `TPanel` usado como botão (`OnClick` + `SetButtonColors`) | `Button` | `size="lg"` para os de 46–51 px (`fMovement`). Hover e foco já estão no CSS do componente |
| `TButton` (nativo) | `Button` | No Delphi, ele não segue o tema (Gráficos, Utilitários). Pergunte antes de deixá-lo com o tema |
| `TLabel` que rotula um campo | `label` do campo (`FormField`) | |
| `TLabel` solto | `<span>` / `<p>` | |
| `TEdit` | `TextField` | `TextHint` → `placeholder`; `CharCase = ecLowerCase` → `lowercase`; `NumbersOnly` → `numbersOnly`; `PasswordChar` → `type="password"` |
| `TEdit` de valor monetário | `MoneyField` | Valor em centavos (RN-25, D-12 corrigida) |
| `TComboBox` (`csDropDownList`) | `Select` | `ItemIndex` → `value`; `Items.Objects` (IDs) → `value` numérico; `ItemIndex = -1` → `placeholder` |
| `TComboBox` de situação (Todas / Não Pagas / Pagas) | `SituationSelect` | `null` / `0` / `1` |
| `TComboBox` de mês | `MonthSelect` | `includeAll` para "Todos" (Gerenciar) |
| `TComboBox` sem `csDropDownList` | `Select` | Decidido para os filtros. Em outros casos, pergunte |
| `TDateTimePicker` | `DateField` | `'YYYY-MM-DD'`; pode chegar vazio |
| `TImage` clicável (lupa, limpar) | `IconButton` | `label` = `Hint` do Delphi |
| `TImage` decorativo | `Icon` | |
| `TEdit` + limpar + lupa (+ F12) | `LookupField` | Abre o `LookupDialog`. D-06, D-07, D-08, D-09 e D-11 passam por ele |

**Estrutura**

| VCL | Componente | Observações |
|---|---|---|
| `pnlTitle` | `TitleBar` | Cor trocável (Receita/Despesa em `fMovement`) |
| `TPageControl` + `TTabSheet` | `Tabs` | `TabVisible := False` → não renderizar a aba |
| `pnlSearch` ("Opções de pesquisa") | `SearchBar` | Enter pesquisa; ↑/↓ movem a seleção da grade; espaço para filtros extras |
| `pnlMain` (barra lateral de botões) | `ActionSidebar` | |
| `pnlMainRegister` / `pnlBottom` (Salvar, Cancelar) | `ButtonBar` | Botões à direita |
| `TDBGrid` | `DataGrid` | `Columns[i].Visible := False` → não renderizar; `OnDblClick` → duplo clique na linha; seleção com ↑/↓ |
| `TPopupMenu` + `TMenuItem` | `ContextMenu` | Itens também acessíveis pela barra de botões |
| `pnlSum` (totais) | `TotalsBar` | |
| Menus coloridos de `fMain` | `MenuTile` | Sem hover, como no Delphi |
| `pnlDetail` (logotipo e nome do sistema) | `BrandPanel` | |
| Painel centralizado (`TFunctions.CenterPanel`) | `Overlay` | |

**Compostos**

| VCL | Componente | Observações |
|---|---|---|
| `TfrmMasterRegister` | `RegisterLayout` | Estados Consulta/Cadastro, barra Incluir/Alterar/Excluir/Imprimir/Fechar, pesquisa, grade, menu de contexto |
| `TfrmGeneralSearch` | `LookupDialog` | Prop `entity`; devolve o registro escolhido ou `null` ao cancelar |
| `TfrmMessage.ShowMessageBox` | `MessageDialog` | Tipos success/warning/error/information |
| `Application.MessageBox` (Sim/Não) | `ConfirmDialog` | Foco padrão em **Não** |
| `TChart` / `TDBChart` (TeeChart) | `PieChartCard` | **Biblioteca de gráficos a definir.** Não escolha sozinho: liste como não convertido |
| Listas "Entradas/Saídas por…" de Gráficos | `GroupTotalsList` | |

**Sem componente**

| VCL | React | Observações |
|---|---|---|
| `TForm` modal (`ShowModal`) | Rota/tela ou `<dialog>` modal | `ModalResult = mrOk` → callback `onConfirm(valor)`; fechar → `onCancel()` |
| `TPanel` (contêiner) | `<div>` / `<section>` | |
| `TDataSource` / `TFDQuery` / `TFDMemTable` | Array de objetos em estado (`useState`) | Dados vêm do serviço; tabela em memória vira array local |
| FastReport (`.fr3`) | **A definir** | Liste como não convertido |
| `OnShow` / `FormCreate` | `useEffect(() => …, [])` | |
| `OnKeyDown`/`OnKeyPress` (F12, Enter, Esc, ↑/↓) | `onKeyDown` | Esc fecha; F12 abre o lookup; Enter executa a pesquisa |
| `KeyPreview` + `Perform(WM_NEXTDLGCTL)` (Enter como Tab) | Handler que move o foco para o próximo campo | Só onde o Delphi faz isso (`fMovement`, que tem o próprio `FormKeyPress`; o `ChangeEnterToTab` do `TfrmBase` nunca é ligado). O Enter vai de **campo em campo**, sem passar pelos `IconButton` |
| `WindowState := wsMaximized` | Tela ocupando a janela | |
| `Caption` da janela | `document.title` ou título da tela | |

## Passo 4: Verificar

Na raiz do repositório:

- `npm run lint` e `npm test`.
- `npm run build:desktop`, para confirmar que a tela compila dentro do app.
- `npm run build:storybook`, se algum componente foi criado ou alterado. Depois, apague `packages/ui/storybook-static/` (está fora do git, mas não precisa ficar).
- Confira, item por item, a lista do Passo 1: cada componente e evento foi convertido **ou** está no relatório como não convertido.

## Passo 5: Relatório final (obrigatório)

Responda ao usuário com:

1. **Arquivos criados/alterados.**
2. **Componentes da biblioteca:** quais a tela usa, e quais foram criados ou alterados nesta conversão (cada um com sua story e sua linha no catálogo).
3. **Mapeamento:** tabela `evento/método Delphi → destino` (componente, função de domínio ou serviço).
4. **Regras de negócio:** RN-xx usadas, indicando quais já estavam migradas e quais ficaram como `TODO`.
5. **Não convertido:** tudo o que ficou de fora e o motivo (dependência não decidida, componente ainda não criado, recurso sem equivalente, divergência aguardando decisão, botão sem ação no Delphi…). Cada item também aparece como `// TODO(migração): …` no código.
6. **Divergências D-xx** encontradas na tela e o que precisa de decisão.

Não marque nada como migrado na documentação: isso é feito pela skill `migrar-regra-de-negocio` (regras) ou a pedido do usuário (telas).
