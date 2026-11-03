# @pfc/ui

Interface React compartilhada pelo desktop (`apps/desktop`) e pela web (`apps/web`).

```
src/App.jsx + App.css      componente raiz; recebe `services` e os repassa às telas
src/screens/<Tela>/        telas (.jsx + .css), uma pasta por tela
src/components/<Nome>/     componentes compartilhados entre telas (.jsx + .css), ex.: Button
src/services/              ServicesContext.js (useServices), ServicesProvider.jsx e contratos <entidade>Service.js
src/styles/                design tokens e estilos globais (ver "Design tokens" abaixo)
```

## Design tokens

O visual vem do sistema Delphi. O levantamento de cada valor (cores, fontes, espaços, tamanhos e bordas) está em [docs/SCREENS.md §3.5](../../docs/SCREENS.md#35-tema-visual).

| Arquivo | Camada | Conteúdo |
|---|---|---|
| `styles/tokens.css` | Primitivos | Valores brutos: paleta (`--palette-*`), fonte e escala tipográfica (`--font-*`, `--line-height-*`), espaçamento (`--space-*`), tamanhos (`--size-*`), bordas (`--border-width-*`, `--radius-*`) e opacidade |
| `styles/theme.css` | Papéis (semânticos) | O que cada valor significa na interface: `--color-title-bg`, `--color-button-bg-hover`, `--color-revenue`, `--font-size-control`… É o equivalente ao `TLayoutConfiguration` do Delphi |
| `styles/base.css` | Globais | `box-sizing`, `html`/`body`, fonte e cor padrão do documento |
| `styles/index.css` | Entrada | Importa os três na ordem acima. O `App` o importa uma vez; telas e componentes não o importam |

Regras de uso:

- **Cores só pelos papéis** de `theme.css`. Telas e componentes não usam hexadecimal nem `--palette-*`. Assim, mudar o visual (ou criar outro tema) é trocar valores em `theme.css`.
- **Espaços, fontes e tamanhos** pela escala de `tokens.css` (`var(--space-lg)`, `var(--size-control)`) ou pelo papel, quando houver um (`var(--font-size-control)`). Nada de `px` soltos para essas medidas; `1px` de borda vem de `--border-width-thin`.
- **Unidades:** fontes, espaços e tamanhos em `rem` (16 px = 1rem), para acompanhar o zoom e o tamanho de fonte do usuário. Bordas em `px`.
- **Nome dos papéis de cor:** `--color-<elemento>-<bg|text|border>[-<estado>]`, por exemplo `--color-button-text-hover`. Texto sobre uma cor de destaque usa `--color-on-<cor>` (`--color-on-revenue`).
- **Faltou um papel?** Crie-o em `theme.css` apontando para um token (e, se o valor for novo, crie o token em `tokens.css`). Comente a origem no Delphi ou marque como "novo", e registre em SCREENS.md §3.5.
- Valores **aproximados** (bordas e linhas nativas do Windows) estão marcados assim nos comentários. Ajuste-os quando forem medidos no app Delphi.

## Acesso a dados

Este pacote **não acessa dados**: nada de SQL, IPC (`window.api`) ou `fetch`. A tela pede o serviço ao contexto:

```jsx
import { useServices } from '../../services/ServicesContext.js'

const { category } = useServices()
const rows = await category.search(filters)
```

Cada contrato fica documentado (JSDoc) em `src/services/<entidade>Service.js`. Cada aplicação cria as implementações e as entrega ao `App`:

```jsx
import App from '@pfc/ui/App.jsx'

<App services={createServices()} />
```

## Importação

Pelo nome do pacote e **com** extensão, porque há `.jsx` e `.css`: `import App from '@pfc/ui/App.jsx'`.

## Storybook

Catálogo dos componentes, em Storybook 10 (`@storybook/react-vite`). A configuração fica em `.storybook/`. O `preview.jsx` importa `styles/index.css`, como o `App`, e põe o fundo do app (`--color-app-bg`) atrás de cada story, para os rótulos brancos aparecerem também na página Docs.

- Cada componente tem uma story ao lado: `src/components/<Nome>/<Nome>.stories.jsx`.
- O `title` da story segue a camada do mapeamento: `Controles/…`, `Estrutura/…` ou `Compostos/…`.
- Para documentar a origem no Delphi, use um comentário JSDoc no `export default`. A aba Docs é gerada sozinha (`tags: ['autodocs']`).
- Para registrar eventos no painel Actions, use `fn()` de `storybook/test` (ex.: `onClick: fn()`).

## Componentes

| Componente | Origem no Delphi | Observações |
|---|---|---|
| `Button` | `TPanel` + `TFunctions.SetButtonColors` | `size`: `md` (41 px) ou `lg` (46–51 px, `fMovement`) |
| `FormField` | `TLabel` acima do campo | Também guarda a aparência comum dos campos (`.form-field-control`) |
| `TextField` | `TEdit` | `lowercase` (`CharCase`), `numbersOnly` (`NumbersOnly`), `type="password"` (`PasswordChar`). `onChange(texto, evento)` |
| `Icon` | `TImage` | PNGs extraídos dos `.dfm`, em `src/assets/icons/`; a lista fica em `Icon/icons.js` |
| `IconButton` | `TImage` com `OnClick` e `Hint` | 30×30; `label` é a dica e o nome acessível |
| `Select` | `TComboBox` (`csDropDownList`) | `options: [{ value, label }]`; `onChange` devolve o `value` com o tipo original; `placeholder` = `ItemIndex = -1` |
| `DateField` | `TDateTimePicker` | Valor `'YYYY-MM-DD'` |
| `MoneyField` | `TEdit` "Valor das parcelas" (`fMovement`) | RN-25: só dígitos e uma `,`; formata `#,##0.00` ao sair. Valor em **centavos**; `onChange(cents)` (`null` enquanto o texto é inválido, nunca ao sair) |
| `SituationSelect` | `cbxFilterSituation` (Gerenciar, Gráficos) | `null` = Todas, `0` = Não Pagas, `1` = Pagas (valores de `SITUATION`) |
| `MonthSelect` | `cbxFilterMonth` (Gerenciar), modo "Mês" de Gráficos | Mês de 1 a 12; `includeAll` acrescenta "Todos" (`null`) |

Diferenças em relação ao Delphi, aprovadas pelo usuário:

| Data | Componente | Decisão |
|---|---|---|
| 24/10/2026 | `IconButton` | Entra na ordem do Tab, para o lookup abrir pelo teclado em todas as telas. No Delphi, o `TImage` não recebe foco |
| 24/10/2026 | `DateField` | Aceita campo vazio (`onChange` recebe `''`), e a tela valida. No Delphi, o `TDateTimePicker` sempre tem uma data |
| 24/10/2026 | `TextField` | `numbersOnly` também filtra o que é colado. No Delphi, o `NumbersOnly` só bloqueia o que é digitado |
| 24/10/2026 | `MoneyField` | Aceita o separador de milhar que o próprio campo coloca ao formatar (D-12 corrigida) |
| 24/10/2026 | `MoneyField` | Também é usado em "R$ Valor" de Gerenciar movimentações, que no Delphi é um `TEdit` comum |
| 24/10/2026 | `SituationSelect` | Textos unificados em "Todas / Não Pagas / Pagas". No Delphi, Gráficos mostra "Não Pagos / Pagos" |
| 24/10/2026 | `SituationSelect`, `MonthSelect` | Só lista, sem digitação. No Delphi, esses `TComboBox` não são `csDropDownList` |

## Comandos

Os comandos rodam na raiz do repositório: `npm run storybook`, `npm run build:storybook`, `npm run lint` e `npm run format`. Testes de componentes ainda não estão configurados.
