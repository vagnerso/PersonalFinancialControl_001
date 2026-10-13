---
name: tipos-legado-delphi
description: Guia de conversão dos tipos gravados pelo sistema Delphi no SQLite (datas, valores monetários, booleanos, IDs de ligação, UNIQUE_ID) para JavaScript. Use sempre que código JS ler, gravar, calcular ou exibir dados do banco legado; as skills converter-form-delphi e migrar-regra-de-negocio dependem desta.
---

# Tipos do legado Delphi → JavaScript

Regras de conversão baseadas no que **está gravado no banco** (verificado em 05/10/2026; detalhes em [docs/DATABASE.md §3](../../../docs/DATABASE.md#3-convenções) e §9).

Implementação de referência, já testada contra os dados reais: [legacy-types.js](legacy-types.js).
**Não reescreva essas funções.** Na primeira vez que precisar, copie o arquivo para `electron/src/domain/legacy-types.js` e importe dali.

## Datas

| No banco | Em JS | Exibição |
|---|---|---|
| Texto `'YYYY-MM-DD'`, sem hora (coluna declarada `DATETIME`) | **String ISO** `'YYYY-MM-DD'` | `DD/MM/AAAA` (`isoToBr`) |

- Mantenha a data como **string**: compare com `<`/`>` (ISO ordena corretamente) e extraia mês/ano com `monthOf`/`yearOf`.
- **Nunca** use `new Date('2023-08-16')`: o JS interpreta como UTC e, no Brasil, mostra o dia anterior. Também não use `toISOString()` para "hoje"; use `todayIso()`.
- Somar meses: `addMonths(iso, n)`, que replica o `IncMonth` do Delphi (dia inexistente → último dia do mês). Em parcelas, o Delphi soma **a partir da parcela anterior**, então o dia reduzido se mantém nas seguintes (RN-22).
- `'1899-12-30'` é a data zero do Delphi (nenhuma data informada, ver D-05). `fromDbDate` a converte em `null`.

## Valores monetários

| No banco | Em JS | Exibição |
|---|---|---|
| `DOUBLE` em reais, até 2 casas (`INSTALLMENT_VALUE`) | **Centavos inteiros** (`toCents`) | `1.234,56`; nos totais, `R$ 1.234,56` (`formatMoney`) |

- Converta para centavos **ao ler**, faça todas as somas e comparações em centavos e só volte para reais ao gravar (`centsToDb`) ou exibir. Somar floats direto gera erro (`0.1 + 0.2 ≠ 0.3`).
- Texto digitado → `parseMoneyInput`: aceita `1.500,00`, `1500`, `1500,5` e `10.5` (sem vírgula, o ponto é decimal, como no campo Delphi). Retorna `null` se inválido; o Delphi trata inválido como 0 (RN-25), e quem chama decide.
- Valores ≥ R$ 1.000 têm uma suspeita em aberto (D-12): não use isso como base de comportamento sem confirmar.

## Booleanos

| No banco | Em JS |
|---|---|
| `INTEGER` 0/1 (`ALLOWS_INSTALLMENT`) | `boolean` |

- Ler com `fromDbBool`: `NULL` → `false`; valores diferentes de 0/1 lançam erro, como o `IntegerToBoolean` do Delphi.
- Gravar com `toDbBool`. Drivers SQLite em geral não aceitam `true`/`false` como parâmetro.

## Ligações entre tabelas (`ID_*`)

- "Sem ligação" está gravado como **`0`**, e em `PERSON.ID_CITY` também como **`''`**. **Nunca como `NULL`.**
- Ler com `fromDbFk` (0, `''` e `NULL` → `null`); gravar com `toDbFk` (`null` → `0`, para manter compatibilidade enquanto o esquema não mudar).
- Um ID diferente de zero **pode não existir** na tabela de destino (registros órfãos, DATABASE.md §9). Trate com `LEFT JOIN` e não presuma que a ligação é válida.

## Valores codificados

`TYPE_MOVEMENT`, `SITUATION`, `TYPE_PERSON`: use constantes nomeadas, nunca números soltos. Os valores estão em [DATABASE.md §4](../../../docs/DATABASE.md#4-valores-codificados-domínios).

## Textos e identificadores

- O banco está em UTF-8. Campos de texto não preenchidos estão como `''`, não `NULL`: trate ambos como vazio.
- `UNIQUE_ID`: UUID v4 **em maiúsculas, sem chaves**. Gerar com `newUniqueId()`.
- Os fontes Delphi (`.pas`/`.dfm`) estão em Windows-1252: leia com `iconv -f cp1252 -t utf-8`.
