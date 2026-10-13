# CLAUDE.md

Instruções para trabalhar neste repositório. Leia antes de qualquer tarefa.

## Contexto do sistema

**Personal Financial Control** é um sistema desktop de finanças pessoais: receitas e despesas (com parcelamento), baixa de pagamento, consulta com totais e gráficos por forma de pagamento, categoria e subcategoria. É um projeto pessoal do Vagner, usado para estudo e **para controlar as finanças reais dele**: o banco contém dados verdadeiros.

A versão atual é **Delphi (VCL) + FireDAC + SQLite**, Win32, RAD Studio 12. O objetivo é **migrar para Electron/JavaScript**, preservando os dados e as funcionalidades.

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
| Plataforma | Electron |
| Linguagem | JavaScript (ES modules), sem TypeScript (decidido em 05/10/2026) |
| Interface | React, com um arquivo CSS por tela (decidido em 05/10/2026) |
| Regras de negócio | JavaScript puro, sem dependência de React/Electron/banco |
| Testes | Vitest (`vitest run`), com `describe`/`test`/`expect` importados de `'vitest'`, sem globais (decidido em 09/10/2026; substituiu `node:test`) |
| Banco | SQLite, reaproveitando os dados atuais (**manter o esquema como está ou evoluí-lo: a definir**) |
| Driver SQLite, empacotamento/build, biblioteca de gráficos, relatórios/PDF | **A definir** |

Enquanto uma decisão estiver "a definir", pergunte antes de assumir. Ao ser decidida, atualize esta tabela.

### Convenções da versão nova

O projeto novo fica na pasta `electron/`, separado do Delphi. **O esqueleto ainda não foi criado**: criá-lo é uma tarefa própria, a pedido do usuário.

```
electron/
  src/domain/legacy-types.js        conversões de tipos do legado (skill tipos-legado-delphi)
  src/domain/rules/<área>/*.js      regras de negócio (RN-xx) + *.test.js ao lado
  src/renderer/screens/<Tela>/      componentes de tela (.jsx + .css)
  src/renderer/components/          componentes compartilhados (RegisterLayout, LookupDialog, MessageDialog, ConfirmDialog)
  src/renderer/services/            acesso a dados pelo renderer (via IPC; sem SQL no renderer)
  src/renderer/styles/theme.css     cores do tema como variáveis CSS
```

Testes da lógica de domínio (dentro de `electron/`): `npx vitest run src/domain/`.

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
| 2. Decisões de stack e de esquema do banco | 🔄 Em andamento: linguagem, interface e testes definidos; esquema do banco e demais itens pendentes |
| 3. Decisão sobre cada divergência D-01 a D-17 (corrigir ou manter) | ⏳ Pendente |
| 4. Implementação da versão Electron | ⬜ Não iniciada |

Nenhum código da versão nova foi escrito ainda. O status de cada regra está em [BUSINESS_RULES.md §11](docs/BUSINESS_RULES.md#11-status-da-migração). Ao concluir uma fase ou parte dela, atualize esta tabela.

## Dicas práticas sobre o código Delphi

- Os `.pas` e `.dfm` estão em **Windows-1252**. Para ler com acentos corretos no terminal: `iconv -f cp1252 -t utf-8 arquivo.pas`.
- Nos `.dfm`, acentos aparecem como códigos (`'Usu'#225'rio'` = "Usuário").
- O banco SQLite está em **UTF-8**.
- `fMain.dfm` tem ~1 MB por causa de imagens embutidas; use `grep -a` em vez de ler o arquivo inteiro.
