# Personal Financial Control

Sistema desktop para controle de finanças pessoais. Permite registrar receitas e despesas (inclusive parceladas), acompanhar o que está pago e o que está em aberto, e visualizar para onde o dinheiro está indo por meio de gráficos.

É um projeto pessoal, desenvolvido para estudos e também usado no controle das minhas próprias finanças.

> **🚧 Migração de tecnologia planejada**
> A versão atual é escrita em **Delphi (VCL)**. O projeto será migrado para **Electron / JavaScript**, mantendo o banco de dados SQLite e as funcionalidades existentes. Este README descreve a versão Delphi e será atualizado conforme a migração avançar.

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

## Autor

Desenvolvido por **Vagner Silva de Oliveira**.
