# Regras de negócio: Personal Financial Control

Regras de negócio implementadas na versão Delphi, extraídas do código-fonte. Serve de referência para manutenção e para a migração para Electron/JavaScript.

> Este documento **descreve o comportamento atual**, inclusive o que parece não intencional. Cada regra indica onde está implementada. Comportamentos que divergem do esperado estão reunidos em [Divergências conhecidas](#8-divergências-conhecidas), para decidir na migração se serão mantidos ou corrigidos.
> Documentos relacionados: [SCREENS.md](SCREENS.md) (telas e rotinas) e [DATABASE.md](DATABASE.md) (banco de dados).

## Sumário

1. [Conceitos](#1-conceitos)
2. [Acesso e usuários](#2-acesso-e-usuários)
3. [Cadastros de apoio](#3-cadastros-de-apoio)
4. [Lançamento de movimentações](#4-lançamento-de-movimentações)
5. [Pagamento](#5-pagamento)
6. [Consulta, edição e totais](#6-consulta-edição-e-totais)
7. [Análise gráfica](#7-análise-gráfica)
8. [Divergências conhecidas](#8-divergências-conhecidas)
9. [Manutenção da base](#9-manutenção-da-base)
10. [Formatos e mensagens](#10-formatos-e-mensagens)
11. [Status da migração](#11-status-da-migração)

---

## 1. Conceitos

| Termo | Significado no sistema |
|---|---|
| **Movimentação** | Um lançamento financeiro. Cada registro corresponde a **uma parcela** |
| **Receita** (Entrada) | Dinheiro que entra. `TYPE_MOVEMENT = 0` |
| **Despesa** (Saída) | Dinheiro que sai. `TYPE_MOVEMENT = 1` |
| **Parcela** | Uma das N partes de um lançamento; tem número, valor e vencimento próprios. Um lançamento à vista é uma parcela única (nº 1) |
| **Vencimento** | Data em que a parcela deve ser paga ou recebida (`ISSUE_DATE`). Todas as consultas por período usam essa data |
| **Situação** | Não pago (0) ou Pago (1). Vale tanto para despesas (paga) quanto para receitas (recebida) |
| **Categoria / Subcategoria** | Classificação em dois níveis. A movimentação aponta para a subcategoria, e a categoria vem por meio dela |
| **Tipo de pagamento** | Meio genérico: Dinheiro, Pix, Cartão de Crédito… |
| **Forma de pagamento** | Meio concreto, ligado a um tipo: "Cartão de Crédito NuBank", "Pix SICREDI CPF"… |
| **Pessoa** | Fornecedor (contraparte de despesas) ou Cliente (contraparte de receitas) |
| **Saldo** | Total de receitas − total de despesas, dentro do filtro aplicado |

---

## 2. Acesso e usuários

### RN-01 Autenticação
- O acesso exige login e senha que coincidam **exatamente** com um registro de `USER`; a comparação diferencia maiúsculas de minúsculas.
- Login válido: o usuário passa a ser o **usuário logado** da sessão, e o nome dele aparece na tela principal.
- Login inválido: mensagem "Usuário e/ou senha inválidos" e nova tentativa, sem limite de tentativas.
- *Implementação:* `TUser.ValidateLogin`, `TfrmLogin.pnlButtonConfirmClick`.

### RN-02 Cancelar o login encerra o sistema
- *Implementação:* `TfrmLogin.pnlButtonCancelClick` → `Application.Terminate`.

### RN-03 Cadastro de usuários
- Cada usuário tem nome, login e senha.
- O cadastro de usuários é aberto **a partir da tela de login, sem autenticação**.
- Não há perfis nem permissões: todo usuário logado tem acesso a todas as funções.
- *Implementação:* `TfrmLogin.pnButtonUserRegisterClick`, `forms/fUser`.

### RN-04 Autoria dos registros
- Toda inclusão (exceto de usuários) grava o `ID_USER` do usuário logado.
- Esse campo **não restringe a visualização**: todos os usuários veem e alteram todos os dados.
- *Implementação:* `InsertRegister` de cada classe em `class/`.

---

## 3. Cadastros de apoio

### RN-10 Categorias e subcategorias
- Toda subcategoria pertence a **uma** categoria (`ID_CATEGORY` obrigatório no banco).
- A movimentação é classificada pela **subcategoria**; a categoria é derivada dela nos relatórios e gráficos.

### RN-11 Tipos de pagamento
- Cada tipo indica se **permite parcelamento** (Sim/Não; padrão Não).
- O indicador é **apenas informativo**: não é verificado ao lançar parcelas (ver RN-27).

### RN-12 Formas de pagamento
- Toda forma de pagamento pertence a **um** tipo de pagamento, escolhido em lista.
- Cada forma registra o **número máximo de parcelas** (apenas números; vazio = 0).
- O limite é **apenas informativo** (ver RN-27).

### RN-13 Pessoas: fornecedores e clientes
- O papel (Fornecedor ou Cliente) é definido pela tela onde a pessoa é cadastrada e **não pode ser alterado** depois.
- Dados: nome, telefone, e-mail, endereço, número, bairro e cidade (opcional, escolhida no cadastro de cidades).
- As listagens de fornecedores e clientes mostram **apenas pessoas com cidade válida** (ver D-10).

### RN-14 Cidades
- Dados: nome, código do município (numérico) e UF, escolhida entre as 27 unidades da federação (padrão RS).

### RN-15 Pesquisa nos cadastros
- A pesquisa procura o texto digitado **em qualquer parte do nome** (descrição, no caso de movimentações).
- Para letras sem acento, a pesquisa ignora maiúsculas/minúsculas; para letras acentuadas, diferencia (comportamento do `LIKE` do SQLite).
- Os caracteres `%` e `_` digitados funcionam como curingas.
- Resultado ordenado em **ordem alfabética decrescente** (Z → A).
- Campo vazio lista todos os registros.

### RN-16 Exclusão de cadastros
- Toda exclusão pede confirmação ("Deseja realmente excluir o registro?"), com **Não** como opção padrão.
- A exclusão é **definitiva**.
- **Não há verificação de uso:** é possível excluir uma categoria, forma de pagamento, pessoa ou cidade que ainda esteja ligada a outros registros (ver D-14).

### RN-17 Campos obrigatórios
- **As telas não validam campos obrigatórios.** Um nome em branco é aceito e gravado como texto vazio.
- Exceção indireta: em Formas de Pagamento, salvar sem escolher o tipo gera erro não tratado (ver D-13).

---

## 4. Lançamento de movimentações

Tela: Cadastrar Receitas / Cadastrar Despesas (`forms/fMovement`).

### RN-20 Tipo da movimentação
- O tipo (Receita ou Despesa) é definido pelo botão usado no menu e **não pode ser alterado** depois, nem na tela de gerenciamento.

### RN-21 Pessoa conforme o tipo
- **Receita** → a pessoa é escolhida entre os **clientes**.
- **Despesa** → a pessoa é escolhida entre os **fornecedores**.
- *Implementação:* `TfrmMovement.SearchPerson`.

### RN-22 Geração de parcelas
Dados informados: descrição, forma de pagamento, pessoa, subcategoria, **quantidade de parcelas**, **valor da parcela** e **data do primeiro vencimento**.

| Item | Regra |
|---|---|
| Quantidade | Padrão `1`. Texto não numérico ou vazio é tratado como `1` |
| Valor | É o valor **de cada parcela**, não o total. Todas as parcelas recebem o mesmo valor; não há divisão nem ajuste de centavos |
| Numeração | Parcelas numeradas de 1 a N |
| Descrição | A mesma em todas as parcelas |
| 1º vencimento | Data informada (padrão: hoje) |
| Vencimentos seguintes | **Data da parcela anterior + 1 mês** |
| Situação | Todas nascem como **Não pago** |

**Vencimentos no fim do mês.** Cada vencimento é calculado a partir da parcela anterior (`IncMonth`), não da primeira. Quando o dia não existe no mês seguinte, ele vira o último dia daquele mês, e esse dia menor **é mantido nas parcelas seguintes**:

| Primeiro vencimento | Parcelas seguintes |
|---|---|
| 30/09 | 30/10 · 30/11 · 30/12 · 30/01 · **28/02** · 28/03 · 28/04 … |
| 31/01 | **28/02** · 28/03 · 28/04 … |

*Implementação:* `TfrmMovement.InstallmentsGenerate`.

### RN-23 Fluxo de gravação
- **1 parcela:** a parcela é gerada automaticamente ao clicar em **Salvar**.
- **Mais de 1 parcela:** é preciso clicar em **Gerar Parcelas** antes de salvar. A lista gerada aparece na aba "Parcelas" e **pode ser editada na grade** (valores, datas, descrição) antes de salvar.
- Ao salvar, cada parcela da lista vira um registro e o sistema mostra "Parcelas geradas com sucesso.".
- O que é gravado é **a lista gerada**, não os campos da tela: alterações feitas nos campos depois de gerar não são aplicadas (ver D-03).
- *Implementação:* `TfrmMovement.pnlButtonSaveClick`.

### RN-24 Independência das parcelas
- Cada parcela é gravada como um registro independente, com identificador próprio.
- **Não existe vínculo** entre as parcelas de um mesmo lançamento. Edição, exclusão e pagamento são sempre feitos **parcela por parcela**.

### RN-25 Entrada de valores
- O campo de valor aceita apenas dígitos e **um** separador decimal; `.` e `,` são convertidos para o separador do Windows (`,` em pt-BR).
- Ao sair do campo, o valor é formatado como `#,##0.00` (ex.: `1.500,00`).
- Texto inválido vira `0`.

### RN-26 Campos não obrigatórios
- Nenhum campo é validado: é possível salvar sem descrição, sem forma de pagamento, sem pessoa, sem subcategoria e com valor zero. Ligações não informadas são gravadas como `0`.

### RN-27 Limites de parcelamento não aplicados
- O indicador "permite parcelamento" do tipo (RN-11) e o "número máximo de parcelas" da forma de pagamento (RN-12) **não limitam** a quantidade de parcelas.

---

## 5. Pagamento

### RN-30 Realizar pagamento
- Feito no Gerenciar movimentações, pelo menu de contexto **Realizar Pagamento**, sobre a parcela selecionada.
- Pede confirmação ("Deseja realmente efetuar o pagamento?"), com **Não** como padrão.
- Efeito: a parcela passa para **Pago** (`SITUATION = 1`).
- Vale igualmente para receitas (marca como recebida).
- *Implementação:* `TfrmManageMovements.MakePayment` → `TMovement.MakePayment`.

### RN-31 Limitações do pagamento
- **Não registra** data de pagamento, valor pago, juros, desconto nem conta de saída.
- Não há pagamento parcial: a parcela inteira é dada como paga.
- Pode ser executado sobre uma parcela **já paga**, sem aviso.
- **Não há estorno:** nenhuma tela permite voltar uma parcela para Não pago. A edição preserva a situação.

---

## 6. Consulta, edição e totais

Tela: Gerenciar movimentações (`forms/fManageMovements`).

### RN-40 Filtros
Os filtros são combinados (todos precisam ser atendidos):

| Filtro | Regra |
|---|---|
| Pesquisar | Descrição contém o texto (RN-15) |
| Situação | Todas · Não Pagas · Pagas |
| Mês | Vencimento no mês escolhido **e no ano corrente** (ver D-01). "Todos" = sem filtro de data, de **todos os anos** |

- **Ao abrir:** mês atual, todas as situações.
- **Ordenação:** descrição decrescente (Z → A).

### RN-41 Totais
Calculados sobre **as linhas exibidas** (ou seja, respeitando os filtros):

| Indicador | Cálculo |
|---|---|
| Total de Receitas | Soma do valor das linhas do tipo Entrada |
| Total de Despesas | Soma do valor das linhas do tipo Saída |
| Saldo | Total de Receitas − Total de Despesas |

- Os totais **somam parcelas pagas e não pagas** quando a situação é "Todas". Por isso, o saldo é **previsto**, não realizado, a menos que se filtre por "Pagas".
- O tipo vem da consulta (`TMovement.Search`) como `CASE TYPE_MOVEMENT WHEN 0 THEN "Entrada" ELSE "Saída"`: **todo valor diferente de 0** (inclusive `NULL`) conta como despesa.
- *Implementação:* `TfrmManageMovements.SumMovements`.

### RN-42 Edição de uma parcela
- Campos editáveis: descrição, fornecedor, subcategoria, forma de pagamento, valor e vencimento.
- **Preservados:** tipo (receita/despesa), número da parcela e situação.
- A alteração afeta **somente a parcela selecionada**, não as demais do mesmo lançamento.
- Nesta tela a pessoa é sempre escolhida entre **fornecedores**, mesmo em receitas (ver D-07).

### RN-43 Exclusão de uma parcela
- Exclui **somente a parcela selecionada**, após confirmação (RN-16).

---

## 7. Análise gráfica

Tela: Gráficos de movimentações (`forms/fMovementGraphics`).

### RN-45 Agrupamentos
- São apresentados 6 totais (soma do valor das parcelas), cada um separado em receitas e despesas:
  - por **forma de pagamento**;
  - por **categoria** (através da subcategoria);
  - por **subcategoria**.
- Parcelas **sem** a classificação correspondente (forma de pagamento, categoria ou subcategoria ausente ou inexistente) **ficam fora** daquele agrupamento.
- Cada agrupamento aparece em ordem alfabética.
- *Implementação:* `TMovement.GetQuery…`.

### RN-46 Filtros

| Filtro | Regra |
|---|---|
| Situação | Todas · Não Pagos · Pagos |
| Mês | Vencimento no mês escolhido **e no ano corrente** |
| Ano | Vencimento no ano escolhido (lista fixa de 2020 a 2030) |
| Período | Selecionável na tela, mas **não é aplicado** à consulta (ver D-02) |

- **Ao abrir:** situação "Todas", filtro por Mês, mês atual. Os gráficos são carregados automaticamente.
- Depois disso, os filtros só são aplicados ao clicar em **Atualizar pesquisa**.

---

## 8. Divergências conhecidas

Comportamentos atuais que provavelmente não são intencionais. **Nenhum foi corrigido**; ficam registrados para decisão na migração.

A coluna **Decisão** registra, para a versão nova, se o comportamento será mantido ou corrigido (`Manter` ou `Corrigir: …`, com a data). `—` = ainda sem decisão.

| ID | Onde | Comportamento atual | Efeito | Decisão |
|---|---|---|---|---|
| D-01 | Gerenciar, Gráficos | O filtro de mês sempre usa o **ano corrente** | Não é possível ver, por exemplo, janeiro do ano passado | — |
| D-02 | Gráficos | Os filtros de mês e de ano ficam guardados entre as pesquisas: trocar de "Mês" para "Ano" (ou vice-versa) mantém o filtro anterior. O filtro "Período" nunca chega à consulta | Ao filtrar por um ano diferente do atual, os gráficos ficam vazios; "Período" mostra os dados do último mês ou ano filtrado | — |
| D-03 | Cadastro de movimentos | Com mais de 1 parcela, salvar sem clicar em "Gerar Parcelas" não grava nada, mas mostra **sucesso**. Mudanças nos campos depois de gerar não entram na lista | Lançamentos perdidos ou gravados com dados antigos sem o usuário perceber | — |
| D-04 | Todas as gravações | Erros de banco são exibidos, mas não interrompem o fluxo | No lançamento de parcelas, a mensagem "sucesso" aparece mesmo que alguma parcela tenha falhado | Manter em Categorias (12/10/2026): mostra o erro e volta para a Consulta. Demais telas: sem decisão |
| D-05 | Gerenciar | **Incluir → Salvar** não lê os campos da tela | Grava uma receita em branco, com valor 0 e vencimento em 30/12/1899 | — |
| D-06 | Gerenciar | Nos lookups de fornecedor, subcategoria e forma de pagamento, **cancelar** a busca apaga a ligação atual | Ao salvar, a parcela perde a ligação (fica com `0`) | — |
| D-07 | Gerenciar | O lookup de pessoa é sempre de **fornecedores** | Receitas acabam ligadas a fornecedores; há 5 casos assim na base | — |
| D-08 | Cadastro de movimentos, Gerenciar | Os botões de "limpar" ao lado dos lookups não fazem nada | Não é possível remover uma ligação, só trocar | — |
| D-09 | Fornecedores, Clientes | Ao **alterar** uma pessoa, a cidade é perdida se não for escolhida de novo; o campo mostra o ID da cidade em vez do nome | Pessoas ficam sem cidade após qualquer edição | — |
| D-10 | Fornecedores, Clientes, Busca | A listagem só mostra pessoas **com cidade válida** | 15 das 27 pessoas atuais não aparecem para consulta, edição ou seleção | — |
| D-11 | Sub-Categorias, Fornecedores, Clientes | O botão de limpar a categoria ou cidade apaga só o texto; a ligação anterior continua e é gravada | O usuário pensa que removeu a ligação, mas ela continua | — |
| D-12 | Cadastro de movimentos | **Suspeita, a confirmar em teste:** o campo de valor é formatado como `1.500,00` ao sair, e a conversão (`StrToCurrDef`) pode não aceitar o separador de milhar | Valores a partir de R$ 1.000 poderiam ser gravados como 0. Na base, todos os valores ≥ R$ 1.000 são de 2023 | — |
| D-13 | Formas de Pagamento | Salvar sem escolher o tipo de pagamento | Erro não tratado (índice de lista inválido) | — |
| D-14 | Todos os cadastros | Exclusão sem verificar se o registro está em uso | Registros órfãos (ver diagnóstico em [DATABASE.md](DATABASE.md#9-diagnóstico-dos-dados-atuais)) | Manter em Categorias (12/10/2026): exclui mesmo com subcategorias ligadas. Demais telas: sem decisão |
| D-15 | Login, Usuários | A tela de usuários é acessível sem login e carrega a senha dos usuários existentes no campo de edição | Qualquer pessoa com acesso ao computador vê e altera senhas | — |
| D-16 | Utilitários | Ver RN-50: a sessão continua com um usuário que foi apagado, e os dados padrão são gravados com o ID dele | Dados padrão ficam sem dono válido | — |
| D-17 | Cadastro de movimentos | O título da janela diz "Receitas" também no modo Despesa | Apenas visual | — |

---

## 9. Manutenção da base

### RN-50 Apagar todos os dados
Tela Utilitários → **Apagar todos os dados**, após confirmação ("Deseja realmente apagar todos os dados do sistema?", padrão Não):

1. **Exclui** todas as movimentações, formas de pagamento, pessoas, subcategorias, usuários, tipos de pagamento e categorias.
   - **Cidades são mantidas.**
   - A numeração dos IDs **não é reiniciada**.
2. **Recria o usuário padrão:** `Administrador`, login `admin`, senha `admin`.
3. **Recria os tipos de pagamento:**

   | Tipo | Permite parcelamento |
   |---|:-:|
   | Dinheiro | Não |
   | Cartão de Crédito | Sim |
   | Cartão de Débito | Não |
   | Pix | Não |
   | Vale | Não |

4. **Recria as categorias:** Salário, Diversos.
5. A sessão **continua aberta** com o usuário que estava logado, embora ele tenha sido apagado (ver D-16).

*Implementação:* `TfrmUtilities.btnDeleteAllClick`, `TDataBaseScripts`.

### RN-51 Verificação do banco na inicialização
- Ao iniciar, o sistema cria a tabela de cidades se ela não existir.
- Se essa verificação falhar, o sistema mostra uma mensagem de erro e **não abre**.
- *Implementação:* `TDataBaseScripts.ExecuteScripts`.

---

## 10. Formatos e mensagens

### RN-60 Formatos de exibição

| Dado | Formato |
|---|---|
| Valores monetários | `#,##0.00` com o separador do Windows; nos totais, prefixo `R$` (ex.: `R$ 1.234,56`) |
| Datas | Formato de data curta do Windows (`dd/mm/aaaa` em pt-BR) |
| Tipo da movimentação | "Entrada" (receita) / "Saída" (despesa) |
| Situação | "Não Pago" / "Pago" |
| Permite parcelamento | "Não" / "Sim" |

### RN-61 Mensagens
- Avisos de **sucesso, atenção, erro e informação** usam a janela de mensagem própria do sistema, com ícone e título por tipo.
- **Confirmações** (excluir, pagar, apagar tudo) usam a caixa Sim/Não do Windows, sempre com **Não** como padrão.
- As mensagens de erro de banco são genéricas por entidade ("Erro ao tentar incluir uma categoria.") e **não mostram o detalhe técnico**.
- Exceção: pessoas (fornecedores e clientes) não mostram mensagem nenhuma em caso de erro ao incluir, alterar ou excluir.
- Os textos estão em `class/uAppConstants.pas`.

---

## 11. Status da migração

Situação de cada regra na versão Electron. Atualizada pela skill `migrar-regra-de-negocio`.

Legenda: ⬜ Pendente · ✅ Migrada

| Regra | Descrição | Status | Data | Implementação |
|---|---|---|---|---|
| [RN-01](#rn-01-autenticação) | Autenticação | ⬜ Pendente | — | — |
| [RN-02](#rn-02-cancelar-o-login-encerra-o-sistema) | Cancelar o login encerra o sistema | ⬜ Pendente | — | — |
| [RN-03](#rn-03-cadastro-de-usuários) | Cadastro de usuários | ⬜ Pendente | — | — |
| [RN-04](#rn-04-autoria-dos-registros) | Autoria dos registros | ⬜ Pendente | — | — |
| [RN-10](#rn-10-categorias-e-subcategorias) | Categorias e subcategorias | ⬜ Pendente | — | — |
| [RN-11](#rn-11-tipos-de-pagamento) | Tipos de pagamento | ⬜ Pendente | — | — |
| [RN-12](#rn-12-formas-de-pagamento) | Formas de pagamento | ⬜ Pendente | — | — |
| [RN-13](#rn-13-pessoas-fornecedores-e-clientes) | Pessoas: fornecedores e clientes | ⬜ Pendente | — | — |
| [RN-14](#rn-14-cidades) | Cidades | ⬜ Pendente | — | — |
| [RN-15](#rn-15-pesquisa-nos-cadastros) | Pesquisa nos cadastros | ⬜ Pendente | — | — |
| [RN-16](#rn-16-exclusão-de-cadastros) | Exclusão de cadastros | ⬜ Pendente | — | — |
| [RN-17](#rn-17-campos-obrigatórios) | Campos obrigatórios | ⬜ Pendente | — | — |
| [RN-20](#rn-20-tipo-da-movimentação) | Tipo da movimentação | ⬜ Pendente | — | — |
| [RN-21](#rn-21-pessoa-conforme-o-tipo) | Pessoa conforme o tipo | ⬜ Pendente | — | — |
| [RN-22](#rn-22-geração-de-parcelas) | Geração de parcelas | ⬜ Pendente | — | — |
| [RN-23](#rn-23-fluxo-de-gravação) | Fluxo de gravação | ⬜ Pendente | — | — |
| [RN-24](#rn-24-independência-das-parcelas) | Independência das parcelas | ⬜ Pendente | — | — |
| [RN-25](#rn-25-entrada-de-valores) | Entrada de valores | ⬜ Pendente | — | — |
| [RN-26](#rn-26-campos-não-obrigatórios) | Campos não obrigatórios | ⬜ Pendente | — | — |
| [RN-27](#rn-27-limites-de-parcelamento-não-aplicados) | Limites de parcelamento não aplicados | ⬜ Pendente | — | — |
| [RN-30](#rn-30-realizar-pagamento) | Realizar pagamento | ⬜ Pendente | — | — |
| [RN-31](#rn-31-limitações-do-pagamento) | Limitações do pagamento | ⬜ Pendente | — | — |
| [RN-40](#rn-40-filtros) | Filtros | ⬜ Pendente | — | — |
| [RN-41](#rn-41-totais) | Totais | ⬜ Pendente | — | — |
| [RN-42](#rn-42-edição-de-uma-parcela) | Edição de uma parcela | ⬜ Pendente | — | — |
| [RN-43](#rn-43-exclusão-de-uma-parcela) | Exclusão de uma parcela | ⬜ Pendente | — | — |
| [RN-45](#rn-45-agrupamentos) | Agrupamentos | ⬜ Pendente | — | — |
| [RN-46](#rn-46-filtros) | Filtros | ⬜ Pendente | — | — |
| [RN-50](#rn-50-apagar-todos-os-dados) | Apagar todos os dados | ⬜ Pendente | — | — |
| [RN-51](#rn-51-verificação-do-banco-na-inicialização) | Verificação do banco na inicialização | ⬜ Pendente | — | — |
| [RN-60](#rn-60-formatos-de-exibição) | Formatos de exibição | ⬜ Pendente | — | — |
| [RN-61](#rn-61-mensagens) | Mensagens | ⬜ Pendente | — | — |
