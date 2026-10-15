---
name: converter-form-delphi
description: >-
  Converte uma tela Delphi (.dfm + .pas) em componente React (JavaScript) com CSS,
  separando interface de regra de negócio e listando o que não foi convertido.
  Use quando o usuário pedir para converter, migrar ou portar um formulário/tela Delphi
  (ex.: "converter fCategory", "migrar a tela de Gerenciar movimentações").
---

# Converter tela Delphi → React

Entrada: o nome da tela (ex.: `fCategory`, "Categorias") ou o caminho do `.pas`/`.dfm`.

## Antes de começar

1. Leia o [CLAUDE.md](../../../CLAUDE.md): regras invioláveis, glossário e convenções da versão nova (pastas, CSS, testes).
2. Leia a skill [tipos-legado-delphi](../tipos-legado-delphi/SKILL.md): datas, dinheiro, booleanos e IDs seguem aquele guia.
3. Confirme que o pacote `packages/ui/` existe e tem React configurado (`packages/ui/package.json`). **Se não existir, pare e pergunte ao usuário**: criar o esqueleto do projeto é uma decisão à parte.
4. **Não altere** os arquivos Delphi; eles são só leitura.

## Passo 1: Entender a tela

1. Encontre a tela em [docs/SCREENS.md](../../../docs/SCREENS.md) (catálogo §4 e detalhe §5) e anote as regras RN-xx e divergências D-xx citadas.
2. Leia o `.pas` com `iconv -f cp1252 -t utf-8`.
3. Leia o `.dfm` com `grep -a`, ignorando blocos de imagem (`Picture.Data`, `Glyph`). Decodifique acentos (`'Usu'#225'rio'` → "Usuário").
4. Se a tela herda de `TfrmMasterRegister` ou `TfrmBase`, o `.dfm` traz só as diferenças (`inherited`). Leia também o template em `templates/`.
5. Monte uma lista de **todos** os componentes e **todos** os eventos (`On… = …`). Ela é a base do relatório final; nenhum item pode sumir sem explicação.

## Passo 2: Classificar cada evento e método

| Categoria | Como reconhecer | Destino |
|---|---|---|
| **Interface** | Cor/hover (`SetButtonColors`), mostrar/ocultar abas e painéis, foco, larguras de coluna, títulos | Componente React (estado + JSX + CSS) |
| **Regra de negócio** | Cálculo, validação, geração de dados, decisão (ex.: `InstallmentsGenerate`, `SumMovements`) | Função pura em `packages/domain/src/rules/`, importada pelo componente como `@pfc/domain/rules/<área>/<nome>` |
| **Acesso a dados** | `TMyQuery`, `FRegisterObject.Insert/Update/Delete/Search/GetById` | Serviço obtido com `useServices()` (`@pfc/ui/services/ServicesContext.js`), conforme o contrato `packages/ui/src/services/<entidade>Service.js` (a implementação fica em cada app) |

- Para **regra de negócio**, procure a RN correspondente no status de migração ([BUSINESS_RULES.md §11](../../../docs/BUSINESS_RULES.md#11-status-da-migração)):
  - **Já migrada:** importe a função.
  - **Ainda não migrada:** crie a chamada para a função esperada, deixe `// TODO(migração): RN-xx pendente` e recomende a skill `migrar-regra-de-negocio`. **Não implemente regra de negócio dentro do componente.**
- Para **acesso a dados**, se o serviço não existir, crie em `packages/ui/src/services/<entidade>Service.js` o contrato: JSDoc com a chave do objeto `Services` (ex.: `category`) e as funções e assinaturas usadas, todas retornando `Promise`, com `// TODO(migração): implementar no desktop (IPC) e na web`. A tela usa `const { category } = useServices()` e nunca importa uma implementação. Nada de SQL, IPC ou `fetch` dentro de `packages/ui/`: a tela roda nas duas aplicações.
- Se um evento envolve uma **divergência D-xx** sem decisão registrada, não replique nem corrija: pergunte ao usuário (regra inviolável 4).

## Passo 3: Gerar os arquivos

```
packages/ui/src/screens/<Tela>/<Tela>.jsx   componente (PascalCase, nome em inglês sem o prefixo "f": fCategory → Category)
packages/ui/src/screens/<Tela>/<Tela>.css   estilos da tela
packages/ui/src/services/<entidade>Service.js   (contrato, se ainda não existir)
```

- **Componente funcional** com hooks. Estado de formulário em `useState`; efeitos de carga em `useEffect`.
- **Textos da interface em pt-BR**, iguais aos do Delphi (salvo erro registrado, ex.: D-17). Identificadores em inglês.
- **CSS:**
  - Um arquivo por tela, com todas as classes prefixadas pelo nome da tela (`.category-…`).
  - Cores **sempre** pelas variáveis de `packages/ui/src/styles/theme.css`. Se o arquivo não existir, crie-o a partir de [SCREENS.md §3.5](../../../docs/SCREENS.md#35-tema-visual) (`--color-title: #40A67D`, `--color-background: #242424`, …).
  - **Não copie** `Left`/`Top`/`Width`/`Height` do `.dfm`: reproduza a organização com flexbox/grid. Respeite a ordem visual e o agrupamento.
- **Componentes compartilhados** (crie na primeira tela que precisar, em `packages/ui/src/components/`, e reaproveite depois):

| Delphi | Componente React |
|---|---|
| `TfrmMasterRegister` | `RegisterLayout`: estados Consulta/Cadastro, barra Incluir/Alterar/Excluir/Imprimir/Fechar, pesquisa, grade, menu de contexto |
| `TfrmGeneralSearch` | `LookupDialog`: prop `entity`, retorna o registro escolhido ou `null` ao cancelar |
| `TfrmMessage.ShowMessageBox` | `MessageDialog`: tipos success/warning/error/information |
| `Application.MessageBox` (Sim/Não) | `ConfirmDialog`: foco padrão em **Não** |

## Tabela de equivalência VCL → React

| VCL | React / HTML | Observações |
|---|---|---|
| `TForm` modal (`ShowModal`) | Rota/tela ou `<dialog>` modal | `ModalResult = mrOk` → callback `onConfirm(valor)`; fechar → `onCancel()` |
| `TPanel` (contêiner) | `<div>` / `<section>` | |
| `TPanel` usado como botão (`OnClick` + hover) | `<button>` | Hover e foco via CSS (`:hover`, `:focus-visible`), não via eventos |
| `TButton` | `<button>` | |
| `TLabel` | `<label htmlFor>` (se rotula campo) ou `<span>` | |
| `TEdit` | `<input type="text">` controlado | `TextHint` → `placeholder`; `NumbersOnly` → `inputMode="numeric"` + filtro |
| `TEdit` com `PasswordChar` | `<input type="password">` | |
| `TEdit` de valor monetário | `<input inputMode="decimal">` | Converter com `parseMoneyInput`/`formatMoney` (tipos-legado) |
| `TComboBox` (`csDropDownList`) | `<select>` | `ItemIndex` → `value`; `Items.Objects` (IDs) → `value` da `<option>` |
| `TDateTimePicker` | `<input type="date">` | Já trabalha em `'YYYY-MM-DD'`, compatível com o banco |
| `TDBGrid` | `<table>` com linha selecionável | `Columns[i].Visible := False` → não renderizar; `OnDblClick` → `onDoubleClick` da linha; seleção com ↑/↓ |
| `TDataSource` / `TFDQuery` / `TFDMemTable` | Array de objetos em estado (`useState`) | Dados vêm do serviço; tabela em memória vira array local |
| `TPageControl` + `TTabSheet` | Abas (botões + painel) | `TabVisible := False` → não renderizar a aba |
| `TPopupMenu` + `TMenuItem` | Menu de contexto (`onContextMenu`) | Itens também acessíveis pela barra de botões |
| `TImage` (ícone clicável: lupa, limpar) | `<button>` com `<img>` de `images/` e `aria-label` | |
| `TChart` / `TDBChart` (TeeChart) | **Biblioteca de gráficos a definir** | Não escolha sozinho: liste como não convertido |
| FastReport (`.fr3`) | **A definir** | Liste como não convertido |
| `OnShow` / `FormCreate` | `useEffect(() => …, [])` | |
| `OnKeyDown`/`OnKeyPress` (F12, Enter, Esc, ↑/↓) | `onKeyDown` | Esc fecha; F12 abre o lookup; Enter executa a pesquisa |
| `KeyPreview` + `Perform(WM_NEXTDLGCTL)` (Enter como Tab) | Handler que move o foco para o próximo campo | Só onde o Delphi faz isso (`fMovement`) |
| `WindowState := wsMaximized` | Tela ocupando a janela | |
| `Caption` da janela | `document.title` ou título da tela | |

## Passo 4: Verificar

- Rode o lint/build do projeto, se configurado, e corrija os erros.
- Confira, item por item, a lista do Passo 1: cada componente e evento foi convertido **ou** está no relatório como não convertido.

## Passo 5: Relatório final (obrigatório)

Responda ao usuário com:

1. **Arquivos criados/alterados.**
2. **Mapeamento:** tabela `evento/método Delphi → destino` (componente, função de domínio ou serviço).
3. **Regras de negócio:** RN-xx usadas, indicando quais já estavam migradas e quais ficaram como `TODO`.
4. **Não convertido:** tudo o que ficou de fora e o motivo (dependência não decidida, recurso sem equivalente, divergência aguardando decisão, botão sem ação no Delphi…). Cada item também aparece como `// TODO(migração): …` no código.
5. **Divergências D-xx** encontradas na tela e o que precisa de decisão.

Não marque nada como migrado na documentação: isso é feito pela skill `migrar-regra-de-negocio` (regras) ou a pedido do usuário (telas).
