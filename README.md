# Personal Financial Control

Sistema desktop para controle de finanças pessoais. Permite registrar receitas e despesas (inclusive parceladas), acompanhar o que está pago e o que está em aberto, e visualizar para onde o dinheiro está indo por meio de gráficos.

É um projeto pessoal, desenvolvido para estudos e também usado no controle das minhas próprias finanças.

> **🚧 Migração de tecnologia em andamento**
> A versão atual é escrita em **Delphi (VCL)**. O projeto está sendo migrado para **JavaScript**, em duas aplicações: uma **desktop (Electron)** e uma **web**, que compartilham as regras de negócio e a interface. O banco de dados SQLite e as funcionalidades existentes serão mantidos. A maior parte deste README descreve a versão Delphi; a [versão nova](#versão-nova-em-desenvolvimento) tem uma seção própria no fim.

## Funcionalidades

- **Login** com cadastro de usuários
- **Receitas e despesas** com geração automática de parcelas (valor por parcela, data da primeira parcela e quantidade; as demais vencem mês a mês)
- **Gerenciar movimentações**: busca por descrição, filtros por situação (pago / não pago) e mês, totais de receitas, despesas e saldo, edição, exclusão e baixa de pagamento
- **Gráficos de movimentações**: receitas e despesas agrupadas por forma de pagamento, categoria e subcategoria, com filtros por situação e por mês ou ano
- **Cadastros de apoio**:
  - Categorias e subcategorias
  - Tipos de pagamento (ex.: Dinheiro, Pix, Cartão de Crédito), indicando se permitem parcelamento
  - Formas de pagamento (ex.: "Cartão de Crédito NuBank"), com número máximo de parcelas
  - Fornecedores e clientes
  - Cidades (com UF e código SEFAZ)
- **Utilitários**: limpeza completa da base, recriando os dados padrão (usuário `admin`/`admin`, tipos de pagamento e categorias iniciais)

## Documentação

Documentação detalhada da versão atual, na pasta [`docs/`](docs/):

| Documento | Conteúdo |
|---|---|
| [Banco de dados](docs/DATABASE.md) | Tabelas, campos, relacionamentos, valores codificados, carga inicial e diagnóstico dos dados |
| [Telas e rotinas](docs/SCREENS.md) | Mapa de navegação, padrões de interface, detalhe de cada tela e das classes que acessam o banco |
| [Regras de negócio](docs/BUSINESS_RULES.md) | Regras de cadastro, parcelamento, pagamento, consultas e gráficos, e divergências conhecidas |

## Tecnologia atual

| Item | Tecnologia |
|---|---|
| Linguagem / IDE | Delphi (Object Pascal), RAD Studio 12 |
| Interface | VCL (Windows, Win32) |
| Banco de dados | SQLite (arquivo local) |
| Acesso a dados | FireDAC |
| Gráficos | TeeChart (`VCLTee`) |
| Relatórios | FastReport (layout em `reports/`) |

O código é orientado a objetos: cada entidade tem uma classe com suas operações de banco (inserir, alterar, excluir, buscar). As telas usam herança visual: um formulário base de cadastro (`templates/fMasterRegister`) define a grade, a busca e os botões, e as telas de cadastro herdam dele.

### Estrutura de pastas

```
PersonalFinancialControl.dpr   Ponto de entrada da aplicação
fMain.pas / .dfm               Tela principal (menu)
class/                         Classes de domínio e acesso a dados, utilitários e scripts do banco
interfaces/                    Interface comum de CRUD
templates/                     Formulários base (herança visual)
forms/                         Telas da aplicação
dataModules/                   Data modules (conexão e consulta do relatório)
reports/                       Layout do relatório (FastReport)
database/                      Banco SQLite (PersonalFinancialControl)
images/                        Ícones da interface
```

### Banco de dados

O banco fica em `database/PersonalFinancialControl`, ao lado do executável. Na inicialização, a aplicação verifica a estrutura e cria as tabelas que estiverem faltando.

| Tabela | Conteúdo |
|---|---|
| `USER` | Usuários do sistema |
| `CATEGORY` / `SUB_CATEGORY` | Categorias e subcategorias das movimentações |
| `TYPE_PAYMENT` / `FORM_PAYMENT` | Tipos e formas de pagamento |
| `PERSON` | Fornecedores e clientes |
| `CITY` | Cidades |
| `MOVEMENT` | Receitas e despesas (uma linha por parcela) |

### Como executar

1. Abra `PersonalFinancialControl.dproj` no RAD Studio (com TeeChart e FastReport instalados).
2. Compile para a plataforma **Win32**.
3. Mantenha as pastas `database/` e `images/` ao lado do executável gerado e execute.

## Versão nova (em desenvolvimento)

A versão nova fica no mesmo repositório, num monorepo com **npm workspaces**. As regras de negócio e as telas ficam em pacotes compartilhados. Cada aplicação guarda só o que é dela: janela, ponto de entrada e acesso aos dados.

| Item | Tecnologia |
|---|---|
| Linguagem | JavaScript (ES modules) |
| Interface | React 19, com um arquivo CSS por tela |
| Desktop | Electron 44 + electron-vite (Vite 8) |
| Testes | Vitest |
| Web, driver SQLite, gráficos e relatórios | A definir |

```
packages/domain/   @pfc/domain: regras de negócio em JavaScript puro, com testes
packages/ui/       @pfc/ui: App (componente raiz), telas, componentes, tema e contratos de serviço
apps/desktop/      aplicação Electron: processo principal, preload e a entrada que monta o App
apps/web/          aplicação web (ainda só a estrutura de pastas)
```

**Ordem:** primeiro o desktop é construído por inteiro; a web vem depois e reaproveita tudo o que está em `packages/`.

**Situação:** o desktop abre a janela com o `App` de `@pfc/ui` (faixa de título e área vazia, com as cores do sistema). Nenhuma tela ou regra foi migrada até agora. O andamento de cada regra está em [BUSINESS_RULES.md §11](docs/BUSINESS_RULES.md#11-status-da-migração).

### Como executar

Requer Node.js 22 ou superior. Todos os comandos rodam na raiz do repositório:

```bash
npm install            # instala as dependências de todos os pacotes
npm run dev:desktop    # abre o app desktop em modo de desenvolvimento
npm run build:desktop  # gera o build de produção do desktop
npm run lint           # verifica o código de todo o monorepo (ESLint)
npm run format         # formata apps/ e packages/ (Prettier)
npm test               # roda os testes das regras de negócio
```

## Autor

Desenvolvido por **Vagner Silva de Oliveira**.
