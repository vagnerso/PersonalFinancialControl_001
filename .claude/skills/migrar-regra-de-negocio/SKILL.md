---
name: migrar-regra-de-negocio
description: >-
  Migra uma regra de negócio do sistema Delphi (identificada por RN-xx em docs/BUSINESS_RULES.md)
  para JavaScript puro, cria os testes com Vitest e marca a regra como migrada na documentação.
  Use quando o usuário pedir para migrar/implementar uma regra
  (ex.: "migrar RN-22", "implementar a regra de parcelamento").
argument-hint: RN-xx
---

# Migrar regra de negócio

Entrada: o identificador da regra (`RN-22`, `rn22`, `RN-022`…). Normalize para `RN-` + 2 dígitos, como na documentação. Se o usuário descrever a regra em vez de dar o número, encontre o RN correspondente e confirme com ele.

## Antes de começar

1. Leia o [CLAUDE.md](../../../CLAUDE.md): regras invioláveis, glossário e convenções da versão nova.
2. Leia a skill [tipos-legado-delphi](../tipos-legado-delphi/SKILL.md). Datas, dinheiro, booleanos e IDs **devem** usar `packages/domain/src/legacy-types.js`. Se ele ainda não existir, copie-o de `.claude/skills/tipos-legado-delphi/legacy-types.js`.
3. Confirme que existe `packages/domain/package.json` com `"type": "module"` e `vitest` em `devDependencies`. **Se não existir, pare e pergunte ao usuário**: criar o esqueleto do projeto é uma decisão à parte.

## Passo 1: Entender a regra

1. Leia a seção da regra em [docs/BUSINESS_RULES.md](../../../docs/BUSINESS_RULES.md) e a linha dela em §11 (status).
   - Se já estiver **✅ Migrada**, avise o usuário e pergunte se deve refazer.
2. Abra a implementação Delphi indicada em *Implementação* (`iconv -f cp1252 -t utf-8`) e confirme que o documento descreve o código. Se houver diferença, **o código Delphi é a verdade**: aponte a diferença ao usuário e corrija o documento.
3. Leia as regras relacionadas citadas no texto (ex.: RN-23 depende de RN-22).

## Passo 2: Divergências

Procure em [BUSINESS_RULES.md §8](../../../docs/BUSINESS_RULES.md#8-divergências-conhecidas) as divergências D-xx ligadas à regra (citadas no texto da RN ou na mesma tela/rotina).

- Coluna **Decisão** preenchida: siga a decisão.
- Coluna **Decisão** vazia (`—`): **pare e pergunte ao usuário** se o comportamento deve ser mantido ou corrigido. Registre a resposta na coluna Decisão (`Manter` ou `Corrigir: …`, com a data) antes de implementar.

## Passo 3: Delimitar o que é "regra"

Implemente **só a lógica de decisão**, como funções puras:

- Sem acesso a banco, arquivos, DOM, React ou Electron.
- O que vem de fora entra por **parâmetro**: data de hoje, gerador de `UNIQUE_ID`, registros já lidos do banco, usuário logado.
- A função **retorna** o resultado (ex.: a lista de parcelas a gravar), em vez de gravar.

Se a regra for essencialmente de interface ou infraestrutura (ex.: RN-02 encerrar o sistema, RN-61 tipos de mensagem, RN-51 verificação do banco), diga isso ao usuário. Implemente a parte pura, se houver, e indique onde o restante deve ficar (tela, serviço ou processo principal). Não force uma função artificial.

## Passo 4: Implementar

```
packages/domain/src/rules/<área>/<nome-em-kebab-case>.js
packages/domain/src/rules/<área>/<nome-em-kebab-case>.test.js
```

Áreas (seções do BUSINESS_RULES): `access`, `registers`, `movements`, `payment`, `queries`, `charts`, `maintenance`, `formatting`.

- JavaScript puro, **ES modules**, exportações nomeadas, nomes em inglês seguindo o glossário (`generateInstallments`, `sumMovements`).
- JSDoc em pt-BR em cada função exportada, com a tag `@rule RN-xx` (e `@see D-xx` quando houver).
- Valores monetários em **centavos inteiros**; datas como string `'YYYY-MM-DD'`; constantes nomeadas para os códigos (`TYPE_MOVEMENT`, `SITUATION`…).
- Se a função já existir para outra RN, estenda-a em vez de duplicar.

## Passo 5: Testes

Use Vitest, importando explicitamente o que for usado: `import { describe, test, expect } from 'vitest';` (sem globais). Nenhuma outra dependência de teste.

- **Nome de cada teste começa pelo ID:** `test('RN-22: segunda parcela vence um mês depois', …)`.
- Cubra, no mínimo:
  - **cada afirmação** do texto da regra (cada linha das tabelas da RN vira pelo menos um teste);
  - **os exemplos** do documento (ex.: a tabela de vencimentos de fim de mês da RN-22);
  - **limites:** zero, vazio, valores inválidos, viradas de mês e de ano, ano bissexto;
  - **a decisão sobre cada D-xx** ligada (comportamento mantido ou corrigido).
- Os testes não podem depender do banco real nem da data do sistema (injete a data).
- Rode `npm test` na raiz (ou `npx vitest run` dentro de `packages/domain/`) e mostre o resultado ao usuário. **Todos devem passar** antes do Passo 6. Se algum falhar, corrija a implementação, não o teste (a menos que o teste contradiga a regra).

## Passo 6: Marcar como migrada

Só depois dos testes passarem:

1. Em [BUSINESS_RULES.md](../../../docs/BUSINESS_RULES.md), logo abaixo do título da regra (`### RN-xx …`), adicione:

   ```markdown
   > ✅ **Migrada** em AAAA-MM-DD · `packages/domain/src/rules/<área>/<arquivo>.js` · testes: `<arquivo>.test.js`
   ```

2. Em **§11 Status da migração**, atualize a linha da regra: status `✅ Migrada`, data e arquivo.
3. Se a implementação mudou o comportamento (divergência corrigida), atualize o texto da RN para descrever o comportamento novo e mencione a D-xx.
4. Se esta foi a primeira regra migrada, atualize a fase 4 na tabela "Estado atual da migração" do [CLAUDE.md](../../../CLAUDE.md) para "Em andamento".

## Relatório final

Responda ao usuário com:

- Arquivos criados/alterados.
- Funções exportadas e o que cada uma faz.
- Resultado dos testes (quantos, todos passando).
- Divergências envolvidas e a decisão aplicada.
- O que ficou fora da função pura e onde deve ser implementado.
